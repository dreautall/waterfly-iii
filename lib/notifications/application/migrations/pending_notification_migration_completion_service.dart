import 'dart:async';

import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/application/migrations/legacy_notification_currency_mapper.dart';
import 'package:waterflyiii/notifications/application/migrations/notification_migration_alert_reconciler.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class PendingNotificationMigrationCompletionResult {
  const PendingNotificationMigrationCompletionResult({
    this.definition,
    this.attempted = false,
  });

  final NotificationDefinition? definition;
  final bool attempted;
}

class PendingNotificationMigrationCompletionService {
  const PendingNotificationMigrationCompletionService({
    required NotificationDefinitionStore definitionStore,
    required NotificationAlertStore alertStore,
    NotificationDefinitionPresetFactory presetFactory =
        const NotificationDefinitionPresetFactory(),
    LegacyNotificationCurrencyMapper currencyMapper =
        const LegacyNotificationCurrencyMapper(),
    FireflyCurrencyResolver? currencyResolver,
  }) : _definitionStore = definitionStore,
       _alertStore = alertStore,
       _presetFactory = presetFactory,
       _currencyMapper = currencyMapper,
       _currencyResolver = currencyResolver;

  final NotificationDefinitionStore _definitionStore;
  final NotificationAlertStore _alertStore;
  final NotificationDefinitionPresetFactory _presetFactory;
  final LegacyNotificationCurrencyMapper _currencyMapper;
  final FireflyCurrencyResolver? _currencyResolver;

  static Future<void> _previousCompletion = Future<void>.value();
  static final Logger _log = Logger('Notifications.PendingMigrationCompletion');

  Future<PendingNotificationMigrationCompletionResult> complete(
    NotificationContext notification,
  ) async {
    final Future<void> previous = _previousCompletion;
    final Completer<void> completion = Completer<void>();
    _previousCompletion = completion.future;
    await previous;
    try {
      return await _complete(notification);
    } finally {
      completion.complete();
    }
  }

  Future<PendingNotificationMigrationCompletionResult> _complete(
    NotificationContext notification,
  ) async {
    final String? applicationId = notification.applicationId;
    if (applicationId == null) {
      return const PendingNotificationMigrationCompletionResult();
    }

    final List<NotificationDefinition> matchingDefinitions =
        (await _definitionStore.load())
            .where(
              (NotificationDefinition definition) =>
                  definition.applicationId == applicationId,
            )
            .toList(growable: false);
    await _synchronizeAlerts(matchingDefinitions);

    final NotificationDefinition? candidate = matchingDefinitions
        .where(isPendingAutomaticCompletion)
        .firstOrNull;
    if (candidate == null) {
      return const PendingNotificationMigrationCompletionResult();
    }
    final _CurrencyCompletion? currencyCompletion =
        await _resolveCurrencyCompletion(candidate, notification);
    final PendingNotificationMigrationCompletionResult result =
        await mutateNotificationDefinitions(_definitionStore, (
          List<NotificationDefinition> definitions,
        ) {
          final int index = definitions.indexWhere(
            (NotificationDefinition definition) =>
                definition.id == candidate.id &&
                isPendingAutomaticCompletion(definition),
          );
          if (index < 0) {
            return const NotificationDefinitionMutation<
              PendingNotificationMigrationCompletionResult
            >.unchanged(PendingNotificationMigrationCompletionResult());
          }
          final NotificationDefinition updated = _completeDefinition(
            definitions[index],
            notification,
            currencyCompletion,
          );
          definitions[index] = updated;
          return NotificationDefinitionMutation<
            PendingNotificationMigrationCompletionResult
          >.changed(
            PendingNotificationMigrationCompletionResult(
              definition: updated,
              attempted: true,
            ),
          );
        });
    if (result.definition case final NotificationDefinition updated) {
      await _synchronizeAlerts(<NotificationDefinition>[updated]);
    }
    return result;
  }

  NotificationDefinition _completeDefinition(
    NotificationDefinition previous,
    NotificationContext notification,
    _CurrencyCompletion? currencyCompletion,
  ) {
    final bool createDefaultSetup = previous.migrationReviewIssues.contains(
      NotificationMigrationIssue.missingSettings,
    );
    final List<RegExpDefinition> extractors = createDefaultSetup
        ? _presetFactory.basicExtractors()
        : previous.extractors;
    final NotificationRule? standardRule = createDefaultSetup
        ? _presetFactory.standardTransactionRule(
            extractors,
            includeNotificationText: true,
          )
        : null;
    final bool usesBasicSetup =
        createDefaultSetup ||
        previous.extractorMode == NotificationExtractorMode.basic;
    final RegExpDefinition? amountExtractor = usesBasicSetup
        ? extractors
              .where(
                (RegExpDefinition extractor) =>
                    extractor.predefinedType ==
                    PredefinedRegExpDefinition.amount,
              )
              .firstOrNull
        : null;
    final int? amountMatchCount = amountExtractor
        ?.evaluate(notification)
        .matches
        .length;
    final Set<NotificationMigrationIssue> blockingIssues =
        <NotificationMigrationIssue>{};
    final NotificationMigrationIssue? amountOrExpressionIssue = usesBasicSetup
        ? switch (amountMatchCount) {
            0 => NotificationMigrationIssue.amountNotFound,
            final int count when count > 1 =>
              NotificationMigrationIssue.ambiguousAmount,
            _ => null,
          }
        : _advancedBlockingIssue(extractors, notification);
    if (amountOrExpressionIssue != null) {
      blockingIssues.add(amountOrExpressionIssue);
    }
    if (currencyCompletion != null && !currencyCompletion.isResolved) {
      blockingIssues.add(NotificationMigrationIssue.currencyUnresolved);
    }
    final Set<NotificationMigrationIssue> remainingIssues =
        Set<NotificationMigrationIssue>.of(previous.migrationReviewIssues)
          ..remove(NotificationMigrationIssue.sampleMissing)
          ..remove(NotificationMigrationIssue.missingSettings)
          ..remove(NotificationMigrationIssue.amountNotFound)
          ..remove(NotificationMigrationIssue.ambiguousAmount)
          ..remove(NotificationMigrationIssue.expressionDoesNotMatchSample)
          ..remove(NotificationMigrationIssue.currencyUnresolved)
          ..addAll(blockingIssues);
    final List<NotificationAction> baseSharedActions =
        standardRule?.actions ?? previous.sharedActions;
    final List<NotificationAction> sharedActions = currencyCompletion == null
        ? baseSharedActions
        : <NotificationAction>[
            ...baseSharedActions.where(
              (NotificationAction action) =>
                  action is! SetTransactionFieldAction ||
                  action.target != TransactionField.currency,
            ),
            _currencyMapper.currencyAction(
              extractors.firstWhere(
                (RegExpDefinition extractor) =>
                    extractor.predefinedType ==
                    PredefinedRegExpDefinition.currency,
              ),
              currencyCompletion.capture,
              currencyCompletion.resolvedCurrency,
            ),
          ];

    return previous.copyWith(
      extractors: extractors,
      rules: createDefaultSetup ? const <NotificationRule>[] : previous.rules,
      sharedActions: sharedActions,
      reviewedSharedActionFields: <TransactionField>{
        ...previous.reviewedSharedActionFields,
        if (amountMatchCount == 1) TransactionField.amount,
        if (currencyCompletion?.isResolved ?? false) TransactionField.currency,
      },
      sampleTitle: notification.title,
      sampleBody: notification.body,
      createdAt: notification.receivedAt,
      extractorMode: createDefaultSetup
          ? NotificationExtractorMode.basic
          : previous.extractorMode,
      basicView: createDefaultSetup
          ? NotificationBasicView.simple
          : previous.basicView,
      requiresMigrationReview: blockingIssues.isNotEmpty,
      migrationReviewIssues: remainingIssues,
    );
  }

  Future<_CurrencyCompletion?> _resolveCurrencyCompletion(
    NotificationDefinition definition,
    NotificationContext notification,
  ) async {
    final bool createDefaultSetup = definition.migrationReviewIssues.contains(
      NotificationMigrationIssue.missingSettings,
    );
    if (!createDefaultSetup &&
        definition.extractorMode != NotificationExtractorMode.basic) {
      return null;
    }
    final List<RegExpDefinition> extractors = createDefaultSetup
        ? _presetFactory.basicExtractors()
        : definition.extractors;
    final List<LegacyCurrencyCapture> captures = _currencyMapper
        .currencyCaptures(extractors, notification);
    if (captures.isEmpty) return null;
    final LegacyCurrencyCapture? preferredCapture = _currencyMapper
        .preferredCurrencyCapture(captures);
    final LegacyCurrencyCapture actionCapture =
        preferredCapture ?? captures.first;
    LegacyResolvedCurrency? resolvedCurrency;
    if (preferredCapture != null) {
      try {
        final FireflyCurrency? currency = (await _currencyResolver?.inspect(
          preferredCapture.token,
        ))?.currency;
        if (currency != null) {
          resolvedCurrency = LegacyResolvedCurrency(
            token: preferredCapture.token,
            resourceId: currency.id,
          );
        }
      } catch (error, stackTrace) {
        _log.warning(
          'Could not resolve the first notification currency for ${definition.applicationId}.',
          error,
          stackTrace,
        );
      }
    }
    return _CurrencyCompletion(
      capture: actionCapture,
      resolvedCurrency: resolvedCurrency,
    );
  }

  static bool isPendingAutomaticCompletion(NotificationDefinition definition) {
    if (!definition.requiresMigrationReview ||
        ((definition.sampleTitle?.trim().isNotEmpty ?? false) &&
            (definition.sampleBody?.trim().isNotEmpty ?? false))) {
      return false;
    }
    return definition.migrationReviewIssues.any(
      (NotificationMigrationIssue issue) =>
          issue == NotificationMigrationIssue.sampleMissing ||
          issue == NotificationMigrationIssue.missingSettings,
    );
  }

  NotificationMigrationIssue? _advancedBlockingIssue(
    List<RegExpDefinition> extractors,
    NotificationContext notification,
  ) {
    for (final RegExpDefinition extractor in extractors.where(
      (RegExpDefinition extractor) => extractor.isRequiredForMatch,
    )) {
      final RegExpEvaluationResult result = extractor.evaluate(notification);
      if (!result.isPatternValid) {
        return NotificationMigrationIssue.invalidRegularExpression;
      }
      if (!result.hasMatches) {
        return NotificationMigrationIssue.expressionDoesNotMatchSample;
      }
    }
    return null;
  }

  Future<void> _synchronizeAlerts(
    Iterable<NotificationDefinition> definitions,
  ) async {
    try {
      for (final NotificationDefinition definition in definitions) {
        await _updateAlerts(definition);
      }
    } catch (error, stackTrace) {
      _log.warning(
        'Could not synchronize notification migration alerts.',
        error,
        stackTrace,
      );
    }
  }

  Future<void> _updateAlerts(NotificationDefinition updated) async {
    await NotificationMigrationAlertReconciler(
      _alertStore,
    ).reconcile(<NotificationDefinition>[updated]);
    final List<NotificationAlert> alerts = await _alertStore.load();
    for (final NotificationMigrationIssue blockingIssue
        in updated.migrationReviewIssues.where(_isAutomaticBlockingIssue)) {
      if (alerts.any(
        (NotificationAlert alert) =>
            alert.kind == NotificationAlertKind.migrationNeedsReview &&
            alert.migrationIssue == blockingIssue &&
            (alert.definitionId == updated.id ||
                alert.applicationId == updated.applicationId),
      )) {
        continue;
      }
      await _alertStore.record(
        NotificationAlert.failure(
          kind: NotificationAlertKind.migrationNeedsReview,
          operation: 'Completing imported notification settings',
          message: switch (blockingIssue) {
            NotificationMigrationIssue.amountNotFound =>
              'Choose the transaction amount because the first notification did not contain a supported monetary value.',
            NotificationMigrationIssue.ambiguousAmount =>
              'Choose the transaction amount because the first notification contains multiple monetary values.',
            NotificationMigrationIssue.expressionDoesNotMatchSample =>
              'Update the imported regular expression because it does not match the first notification.',
            NotificationMigrationIssue.invalidRegularExpression =>
              'The imported regular expression is invalid. Update or replace it before using this configuration.',
            NotificationMigrationIssue.currencyUnresolved =>
              'Choose the transaction currency because it could not be resolved uniquely from the first notification.',
            _ => throw StateError(
              'Unsupported automatic migration issue: $blockingIssue',
            ),
          },
          applicationId: updated.applicationId,
          definitionId: updated.id,
          notification: notificationContext(updated),
          migrationIssue: blockingIssue,
        ),
      );
    }
  }

  bool _isAutomaticBlockingIssue(NotificationMigrationIssue issue) =>
      issue == NotificationMigrationIssue.amountNotFound ||
      issue == NotificationMigrationIssue.ambiguousAmount ||
      issue == NotificationMigrationIssue.expressionDoesNotMatchSample ||
      issue == NotificationMigrationIssue.invalidRegularExpression ||
      issue == NotificationMigrationIssue.currencyUnresolved;

  NotificationContext notificationContext(NotificationDefinition definition) =>
      NotificationContext(
        applicationId: definition.applicationId,
        applicationName: definition.name,
        title: definition.sampleTitle ?? '',
        body: definition.sampleBody ?? '',
        receivedAt: definition.sampleReceivedAt,
      );
}

class _CurrencyCompletion {
  const _CurrencyCompletion({required this.capture, this.resolvedCurrency});

  final LegacyCurrencyCapture capture;
  final LegacyResolvedCurrency? resolvedCurrency;

  bool get isResolved => resolvedCurrency != null;
}
