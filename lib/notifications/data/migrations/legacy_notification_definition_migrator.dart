import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

abstract interface class NotificationDefinitionMigrator {
  Future<List<NotificationDefinition>> migrate();
}

abstract interface class NotificationDefinitionMigrationCleanup {
  Future<void> cleanupMigratedSettings();
}

class LegacyNotificationMigrationResult {
  const LegacyNotificationMigrationResult({
    required this.definition,
    this.reviewIssues = const <LegacyNotificationMigrationIssue>[],
  });

  final NotificationDefinition definition;
  final List<LegacyNotificationMigrationIssue> reviewIssues;

  List<String> get reviewMessages => reviewIssues
      .map((LegacyNotificationMigrationIssue issue) => issue.message)
      .toList(growable: false);
}

class LegacyNotificationMigrationIssue {
  const LegacyNotificationMigrationIssue(this.reason, this.message);

  final NotificationMigrationIssue reason;
  final String message;
}

class LegacyResolvedCurrency {
  const LegacyResolvedCurrency({required this.token, required this.resourceId});

  final String token;
  final String resourceId;
}

class LegacyNotificationDefinitionMigrator {
  LegacyNotificationDefinitionMigrator({
    NotificationDefinitionPresetFactory presetFactory =
        const NotificationDefinitionPresetFactory(),
  }) : _presetFactory = presetFactory;

  final NotificationDefinitionPresetFactory _presetFactory;

  NotificationDefinition createHusk(
    String applicationId, {
    String? applicationName,
    NotificationSample? sample,
  }) => NotificationDefinition(
    id: 'legacy:$applicationId',
    applicationId: applicationId,
    name: applicationName?.trim().isNotEmpty ?? false
        ? applicationName!.trim()
        : applicationId,
    extractors: const <RegExpDefinition>[],
    rules: const <NotificationRule>[],
    sampleTitle: sample?.title,
    sampleBody: sample?.body,
    createdAt: sample?.receivedAt ?? DateTime.now(),
    extractorMode: NotificationExtractorMode.notConfigured,
    transactionCreationMode: TransactionCreationMode.prompt,
  );

  LegacyNotificationMigrationResult? migrate(
    String applicationId,
    Map<String, dynamic> settings, {
    NotificationSample? sample,
    LegacyResolvedCurrency? resolvedCurrency,
  }) {
    final String? appName = settings['appName'] as String?;
    if (appName == null || appName.isEmpty) return null;

    final String? customRegExp = settings['regex'] as String?;
    if (customRegExp?.isNotEmpty ?? false) {
      return _migrateCustom(
        applicationId,
        appName,
        settings,
        customRegExp!,
        sample,
      );
    }
    return _migrateBuiltIn(
      applicationId,
      appName,
      settings,
      sample,
      resolvedCurrency,
    );
  }

  String? currencyToken(String applicationId, NotificationSample sample) {
    final List<RegExpDefinition> extractors = _presetFactory.basicExtractors();
    final NotificationContext context = _context(applicationId, sample);
    final RegExpDefinition amountExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType == PredefinedRegExpDefinition.amount,
    );
    if (amountExtractor.evaluate(context).matches.length != 1) return null;
    return _preferredCurrencyCapture(
      _currencyCaptures(
        extractors.firstWhere(
          (RegExpDefinition extractor) =>
              extractor.predefinedType == PredefinedRegExpDefinition.currency,
        ),
        context,
      ),
    )?.token;
  }

  LegacyNotificationMigrationResult _migrateBuiltIn(
    String applicationId,
    String appName,
    Map<String, dynamic> settings,
    NotificationSample? sample,
    LegacyResolvedCurrency? resolvedCurrency,
  ) {
    final List<RegExpDefinition> extractors = _presetFactory.basicExtractors();
    final RegExpDefinition amountExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType == PredefinedRegExpDefinition.amount,
    );
    final int matchCount = sample == null
        ? 0
        : amountExtractor
              .evaluate(_context(applicationId, sample))
              .matches
              .length;
    final int? amountMatchIndex = matchCount == 1 ? 0 : null;
    final RegExpDefinition currencyExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType == PredefinedRegExpDefinition.currency,
    );
    final List<_LegacyCurrencyCapture> currencyCaptures = sample == null
        ? const <_LegacyCurrencyCapture>[]
        : _currencyCaptures(currencyExtractor, _context(applicationId, sample));
    final _LegacyCurrencyCapture? preferredCurrencyCapture =
        _preferredCurrencyCapture(currencyCaptures);
    final _LegacyCurrencyCapture? currencyActionCapture =
        preferredCurrencyCapture ?? currencyCaptures.firstOrNull;
    final bool hasResolvedCurrency =
        amountMatchIndex != null &&
        preferredCurrencyCapture != null &&
        resolvedCurrency?.token == preferredCurrencyCapture.token;
    final NotificationRule standardRule = _presetFactory
        .standardTransactionRule(extractors);
    final List<NotificationAction> actions = standardRule.actions.map((
      NotificationAction action,
    ) {
      if (action is! SetTransactionFieldAction ||
          action.target != TransactionField.amount) {
        return action;
      }
      return SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: NormalizedAmountCaptureValueSource(
          capture: RegExpCaptureValueSource(
            extractorId: amountExtractor.id,
            captureName: 'amount',
            matchIndex: amountMatchIndex,
          ),
        ),
      );
    }).toList();
    actions.addAll(_legacyFieldActions(settings, extractors));
    if (currencyActionCapture != null) {
      actions.add(
        _currencyAction(
          currencyExtractor,
          currencyActionCapture,
          hasResolvedCurrency ? resolvedCurrency : null,
        ),
      );
    }

    final List<LegacyNotificationMigrationIssue>
    reviewIssues = <LegacyNotificationMigrationIssue>[
      if (sample == null)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.sampleMissing,
          'Enter a sample notification to finish the imported configuration.',
        )
      else if (matchCount == 0)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.amountNotFound,
          'Choose the transaction amount because the imported sample did not contain a supported monetary value.',
        )
      else if (matchCount > 1)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.ambiguousAmount,
          'Choose the transaction amount because the imported sample contains multiple monetary values.',
        ),
      if (amountMatchIndex != null &&
          currencyActionCapture != null &&
          !hasResolvedCurrency)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.currencyUnresolved,
          'Choose the transaction currency because it could not be resolved uniquely from the imported sample.',
        ),
      ..._automaticReviewMessages(settings),
    ];
    return LegacyNotificationMigrationResult(
      definition: NotificationDefinition(
        id: 'legacy:$applicationId',
        applicationId: applicationId,
        name: appName,
        extractors: extractors,
        rules: const <NotificationRule>[],
        sharedActions: actions,
        reviewedSharedActionFields: <TransactionField>{
          if (amountMatchIndex != null) TransactionField.amount,
          if (hasResolvedCurrency) TransactionField.currency,
        },
        sampleTitle: sample?.title,
        sampleBody: sample?.body,
        createdAt: sample?.receivedAt ?? DateTime.now(),
        extractorMode: NotificationExtractorMode.basic,
        transactionCreationMode: TransactionCreationMode.prompt,
        requiresMigrationReview: reviewIssues.isNotEmpty,
        migrationReviewIssues: reviewIssues
            .map((LegacyNotificationMigrationIssue issue) => issue.reason)
            .toSet(),
      ),
      reviewIssues: reviewIssues,
    );
  }

  SetTransactionFieldAction _currencyAction(
    RegExpDefinition extractor,
    _LegacyCurrencyCapture currency,
    LegacyResolvedCurrency? resolvedCurrency,
  ) {
    final RegExpCaptureValueSource capture = RegExpCaptureValueSource(
      extractorId: extractor.id,
      captureName: currency.captureName,
      matchIndex: currency.matchIndex,
    );
    return SetTransactionFieldAction(
      target: TransactionField.currency,
      valueSource: resolvedCurrency == null
          ? capture
          : CurrencyCaptureValueSource(
              capture: capture,
              resourceId: resolvedCurrency.resourceId,
              expectedValue: currency.token,
            ),
    );
  }

  List<_LegacyCurrencyCapture> _currencyCaptures(
    RegExpDefinition extractor,
    NotificationContext context,
  ) {
    final List<RegExpMatch> matches = extractor.evaluate(context).matches;
    if (matches.length != 1) return const <_LegacyCurrencyCapture>[];
    final RegExpMatch match = matches.single;
    final String? preCurrency = match.namedGroup('preCurrency');
    final String? postCurrency = match.namedGroup('postCurrency');
    return <_LegacyCurrencyCapture>[
      if (preCurrency?.trim().isNotEmpty ?? false)
        _LegacyCurrencyCapture(
          captureName: 'preCurrency',
          token: preCurrency!.trim(),
          matchIndex: 0,
        ),
      if (postCurrency?.trim().isNotEmpty ?? false)
        _LegacyCurrencyCapture(
          captureName: 'postCurrency',
          token: postCurrency!.trim(),
          matchIndex: 0,
        ),
    ];
  }

  _LegacyCurrencyCapture? _preferredCurrencyCapture(
    List<_LegacyCurrencyCapture> captures,
  ) {
    if (captures.length == 1) return captures.single;
    final List<_LegacyCurrencyCapture> isoCodes = captures
        .where(
          (_LegacyCurrencyCapture capture) =>
              RegExp(r'^[A-Za-z]{3}$').hasMatch(capture.token),
        )
        .toList(growable: false);
    return isoCodes.length == 1 ? isoCodes.single : null;
  }

  LegacyNotificationMigrationResult _migrateCustom(
    String applicationId,
    String appName,
    Map<String, dynamic> settings,
    String customRegExp,
    NotificationSample? sample,
  ) {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Imported notification matcher',
          customRegExp,
          isRequiredForMatch: true,
        );
    final bool isPatternValid = sample == null
        ? extractor
              .evaluate(_context(applicationId, _emptySample))
              .isPatternValid
        : extractor.evaluate(_context(applicationId, sample)).isPatternValid;
    final int matchCount = sample == null || !isPatternValid
        ? 0
        : extractor.evaluate(_context(applicationId, sample)).matches.length;
    final List<RegExpDefinition> notificationExtractors = _presetFactory
        .basicExtractors()
        .where(
          (RegExpDefinition item) =>
              item.predefinedType ==
                  PredefinedRegExpDefinition.notificationTitle ||
              item.predefinedType ==
                  PredefinedRegExpDefinition.notificationMessage,
        )
        .toList();
    final List<NotificationAction> actions = <NotificationAction>[
      SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: NormalizedAmountCaptureValueSource(
          capture: RegExpCaptureValueSource(
            extractorId: extractor.id,
            captureName: 'amount',
            fallbackCaptureIndex: 1,
            matchIndex: matchCount > 0 ? 0 : null,
          ),
        ),
      ),
      ..._legacyFieldActions(settings, notificationExtractors),
    ];
    final List<LegacyNotificationMigrationIssue>
    reviewIssues = <LegacyNotificationMigrationIssue>[
      if (!isPatternValid)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.invalidRegularExpression,
          'The imported regular expression is invalid. Update or replace it before using this configuration.',
        )
      else if (sample == null)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.sampleMissing,
          'Enter a sample notification to finish the imported configuration.',
        )
      else if (matchCount == 0)
        const LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.expressionDoesNotMatchSample,
          'Update the imported regular expression because it does not match the imported sample.',
        ),
      ..._automaticReviewMessages(settings),
    ];
    return LegacyNotificationMigrationResult(
      definition: NotificationDefinition(
        id: 'legacy:$applicationId',
        applicationId: applicationId,
        name: appName,
        extractors: <RegExpDefinition>[extractor, ...notificationExtractors],
        rules: <NotificationRule>[
          NotificationRule(
            id: 'legacy:$applicationId:transaction',
            name: 'Imported transaction plan',
            conditions: const <NotificationCondition>[],
            actions: actions,
          ),
        ],
        sampleTitle: sample?.title,
        sampleBody: sample?.body,
        createdAt: sample?.receivedAt ?? DateTime.now(),
        extractorMode: NotificationExtractorMode.advanced,
        transactionCreationMode: TransactionCreationMode.prompt,
        requiresMigrationReview: reviewIssues.isNotEmpty,
        migrationReviewIssues: reviewIssues
            .map((LegacyNotificationMigrationIssue issue) => issue.reason)
            .toSet(),
      ),
      reviewIssues: reviewIssues,
    );
  }

  static final NotificationSample _emptySample = NotificationSample(
    title: '',
    body: '',
    receivedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  NotificationContext _context(
    String applicationId,
    NotificationSample sample,
  ) => NotificationContext(
    applicationId: applicationId,
    title: sample.title,
    body: sample.body,
    receivedAt: sample.receivedAt,
  );

  List<NotificationAction> _legacyFieldActions(
    Map<String, dynamic> settings,
    List<RegExpDefinition> extractors,
  ) {
    final List<NotificationAction> actions = <NotificationAction>[];
    final String? defaultAccountId = settings['defaultAccountId'] as String?;
    if (defaultAccountId != null && defaultAccountId.isNotEmpty) {
      actions.add(
        SetTransactionFieldAction(
          target: TransactionField.sourceAccount,
          valueSource: FireflyResourceValueSource(
            resourceKind: FireflyResourceKind.account,
            resourceId: defaultAccountId,
          ),
        ),
      );
    }
    final RegExpDefinition titleExtractor = extractors.firstWhere(
      (RegExpDefinition item) =>
          item.predefinedType == PredefinedRegExpDefinition.notificationTitle,
    );
    final RegExpDefinition messageExtractor = extractors.firstWhere(
      (RegExpDefinition item) =>
          item.predefinedType == PredefinedRegExpDefinition.notificationMessage,
    );
    final RegExpCaptureValueSource titleCapture = RegExpCaptureValueSource(
      extractorId: titleExtractor.id,
      captureName: 'title',
    );
    final RegExpCaptureValueSource messageCapture = RegExpCaptureValueSource(
      extractorId: messageExtractor.id,
      captureName: 'message',
    );
    final bool autoAdd = settings['autoAdd'] as bool? ?? false;
    final bool includeTitle =
        autoAdd || (settings['includeTitle'] as bool? ?? true);
    final bool emptyNote =
        !autoAdd && (settings['emptyNote'] as bool? ?? false);
    if (includeTitle) {
      actions.add(
        SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: titleCapture,
        ),
      );
    }
    if (!includeTitle || !emptyNote) {
      actions.add(
        SetTransactionFieldAction(
          target: TransactionField.notes,
          valueSource: includeTitle
              ? messageCapture
              : ComposedValueSource(<ValueSource>[
                  titleCapture,
                  const LiteralValueSource(' - '),
                  if (!emptyNote)
                    messageCapture
                  else
                    const LiteralValueSource(''),
                ]),
        ),
      );
    }
    return actions;
  }

  List<LegacyNotificationMigrationIssue> _automaticReviewMessages(
    Map<String, dynamic> settings,
  ) {
    if (!(settings['autoAdd'] as bool? ?? false)) {
      return const <LegacyNotificationMigrationIssue>[];
    }
    final bool hasTitle =
        (settings['autoAdd'] as bool? ?? false) ||
        (settings['includeTitle'] as bool? ?? true);
    final String? accountId = settings['defaultAccountId'] as String?;
    final List<String> missingMappings = <String>[
      if (!hasTitle) 'a title mapping',
      if (accountId == null || accountId.isEmpty) 'an account mapping',
    ];
    return <LegacyNotificationMigrationIssue>[
      const LegacyNotificationMigrationIssue(
        NotificationMigrationIssue.automaticCreationPaused,
        'Automatic creation was changed to prompt mode until the imported currency behavior is reviewed.',
      ),
      if (missingMappings.isNotEmpty)
        LegacyNotificationMigrationIssue(
          NotificationMigrationIssue.missingAutomaticAccount,
          'The imported automatic configuration is missing ${missingMappings.join(' and ')}. Review its shared actions before enabling automatic creation.',
        ),
    ];
  }
}

class _LegacyCurrencyCapture {
  const _LegacyCurrencyCapture({
    required this.captureName,
    required this.token,
    required this.matchIndex,
  });

  final String captureName;
  final String token;
  final int matchIndex;
}
