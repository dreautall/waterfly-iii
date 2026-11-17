import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/application/migrations/legacy_notification_currency_mapper.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

enum NotificationDebugSeedScenario {
  sampleMissing(
    'Waiting for first notification',
    'Imported Basic setup without a saved sample.',
  ),
  missingSettings(
    'Missing legacy settings',
    'Imported registration with no usable configuration.',
  ),
  unknownApplication(
    'Unknown application',
    'Missing settings whose application name is still the package ID.',
  ),
  unresolvedCurrency(
    'Unresolved currency',
    'Completed sample with an unresolved XYZ currency mapping.',
  ),
  advancedExpressionMismatch(
    'Advanced expression mismatch',
    'Imported Advanced expression that does not match its saved sample.',
  ),
  invalidRegularExpression(
    'Invalid imported expression',
    'Imported Advanced setup whose regular expression is invalid.',
  ),
  automaticCreationPaused(
    'Automatic creation paused',
    'Imported automatic setup downgraded to Prompt with no account mapping.',
  ),
  conversionFailed(
    'Conversion failed',
    'Registration and sample preserved after its legacy settings could not be converted.',
  ),
  migrationFailed(
    'Migration cleanup failed',
    'Ready migrated definition with a failure alert for legacy cleanup.',
  ),
  staleMigrationAlert(
    'Stale migration alert',
    'Ready definition with an obsolete sample-missing alert.',
  );

  const NotificationDebugSeedScenario(this.label, this.description);

  final String label;
  final String description;
}

class NotificationDebugSeedService {
  const NotificationDebugSeedService({
    required NotificationDefinitionStore definitionStore,
    required NotificationAlertStore alertStore,
    required NotificationHistoryStore historyStore,
    NotificationDefinitionPresetFactory presetFactory =
        const NotificationDefinitionPresetFactory(),
    LegacyNotificationCurrencyMapper currencyMapper =
        const LegacyNotificationCurrencyMapper(),
    LegacyNotificationDefinitionMigrator definitionMigrator =
        const LegacyNotificationDefinitionMigrator(),
  }) : _definitionStore = definitionStore,
       _alertStore = alertStore,
       _historyStore = historyStore,
       _presetFactory = presetFactory,
       _currencyMapper = currencyMapper,
       _definitionMigrator = definitionMigrator;

  static const String definitionIdPrefix = 'debug:migration:';

  final NotificationDefinitionStore _definitionStore;
  final NotificationAlertStore _alertStore;
  final NotificationHistoryStore _historyStore;
  final NotificationDefinitionPresetFactory _presetFactory;
  final LegacyNotificationCurrencyMapper _currencyMapper;
  final LegacyNotificationDefinitionMigrator _definitionMigrator;

  Future<NotificationDefinition> seed({
    required NotificationDebugSeedScenario scenario,
    required String applicationId,
    required String applicationName,
    String? replacedApplicationId,
  }) async {
    _ensureDebugBuild();
    final NotificationDefinition definition = _definition(
      scenario,
      applicationId: applicationId,
      applicationName: applicationName,
    );
    await mutateNotificationDefinitions(_definitionStore, (
      List<NotificationDefinition> definitions,
    ) {
      definitions
        ..removeWhere(
          (NotificationDefinition candidate) =>
              candidate.applicationId == applicationId ||
              candidate.applicationId == replacedApplicationId,
        )
        ..add(definition);
      return const NotificationDefinitionMutation<void>.changed(null);
    });
    final Set<String> clearedApplicationIds = <String>{
      applicationId,
      ?replacedApplicationId,
    };
    for (final String clearedApplicationId in clearedApplicationIds) {
      await _alertStore.clearForApplication(clearedApplicationId);
      await _historyStore.clearForApplication(clearedApplicationId);
    }
    for (final NotificationAlert alert in _alertsFor(scenario, definition)) {
      await _alertStore.record(alert);
    }
    return definition;
  }

  Future<void> resetApplication(String applicationId) async {
    _ensureDebugBuild();
    await mutateNotificationDefinitions(_definitionStore, (
      List<NotificationDefinition> definitions,
    ) {
      final int previousLength = definitions.length;
      definitions.removeWhere(
        (NotificationDefinition definition) =>
            definition.applicationId == applicationId &&
            definition.id.startsWith(definitionIdPrefix),
      );
      return previousLength == definitions.length
          ? const NotificationDefinitionMutation<void>.unchanged(null)
          : const NotificationDefinitionMutation<void>.changed(null);
    });
    await _alertStore.clearForApplication(applicationId);
    await _historyStore.clearForApplication(applicationId);
  }

  Future<void> resetDefinition(String definitionId) async {
    _ensureDebugBuild();
    String? applicationId;
    await mutateNotificationDefinitions(_definitionStore, (
      List<NotificationDefinition> definitions,
    ) {
      final int index = definitions.indexWhere(
        (NotificationDefinition definition) =>
            definition.id == definitionId &&
            definition.id.startsWith(definitionIdPrefix),
      );
      if (index < 0) {
        return const NotificationDefinitionMutation<void>.unchanged(null);
      }
      applicationId = definitions.removeAt(index).applicationId;
      return const NotificationDefinitionMutation<void>.changed(null);
    });
    if (applicationId case final String seededApplicationId) {
      await _alertStore.clearForApplication(seededApplicationId);
      await _historyStore.clearForApplication(seededApplicationId);
    }
  }

  Future<void> resetAllSeeded() async {
    _ensureDebugBuild();
    final Set<String> seededApplicationIds = (await _definitionStore.load())
        .where(
          (NotificationDefinition definition) =>
              definition.id.startsWith(definitionIdPrefix),
        )
        .map((NotificationDefinition definition) => definition.applicationId)
        .toSet();
    if (seededApplicationIds.isEmpty) return;
    await mutateNotificationDefinitions(_definitionStore, (
      List<NotificationDefinition> definitions,
    ) {
      definitions.removeWhere(
        (NotificationDefinition definition) =>
            definition.id.startsWith(definitionIdPrefix),
      );
      return const NotificationDefinitionMutation<void>.changed(null);
    });
    for (final String applicationId in seededApplicationIds) {
      await _alertStore.clearForApplication(applicationId);
      await _historyStore.clearForApplication(applicationId);
    }
  }

  NotificationDefinition _definition(
    NotificationDebugSeedScenario scenario, {
    required String applicationId,
    required String applicationName,
  }) {
    final DateTime createdAt = DateTime.now();
    final String id = '$definitionIdPrefix${scenario.name}:$applicationId';
    return switch (scenario) {
      NotificationDebugSeedScenario.sampleMissing => _pendingBasic(
        id: id,
        applicationId: applicationId,
        applicationName: applicationName,
        issues: const <NotificationMigrationIssue>{
          NotificationMigrationIssue.sampleMissing,
        },
        createdAt: createdAt,
      ),
      NotificationDebugSeedScenario.missingSettings => NotificationDefinition(
        id: id,
        applicationId: applicationId,
        name: applicationName,
        extractors: const <RegExpDefinition>[],
        rules: const <NotificationRule>[],
        createdAt: createdAt,
        transactionCreationMode: TransactionCreationMode.prompt,
        requiresMigrationReview: true,
        migrationReviewIssues: const <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingSettings,
        },
      ),
      NotificationDebugSeedScenario.unknownApplication =>
        NotificationDefinition(
          id: id,
          applicationId: applicationId,
          name: applicationId,
          extractors: const <RegExpDefinition>[],
          rules: const <NotificationRule>[],
          createdAt: createdAt,
          transactionCreationMode: TransactionCreationMode.prompt,
          requiresMigrationReview: true,
          migrationReviewIssues: const <NotificationMigrationIssue>{
            NotificationMigrationIssue.missingApplicationName,
            NotificationMigrationIssue.missingSettings,
          },
        ),
      NotificationDebugSeedScenario.unresolvedCurrency => _unresolvedCurrency(
        id: id,
        applicationId: applicationId,
        applicationName: applicationName,
        createdAt: createdAt,
      ),
      NotificationDebugSeedScenario.advancedExpressionMismatch =>
        _migratedDefinition(
          id: id,
          applicationId: applicationId,
          applicationName: applicationName,
          settings: <String, dynamic>{
            'appName': applicationName,
            'regex': r'Paid (?<amount>\d+\.\d{2}) CAD',
          },
          sample: NotificationSample(
            title: 'Card payment',
            body: 'Card purchase for 12.50 CAD',
            receivedAt: createdAt,
          ),
        ),
      NotificationDebugSeedScenario.invalidRegularExpression =>
        _migratedDefinition(
          id: id,
          applicationId: applicationId,
          applicationName: applicationName,
          settings: <String, dynamic>{'appName': applicationName, 'regex': '['},
          sample: NotificationSample(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: createdAt,
          ),
        ),
      NotificationDebugSeedScenario.automaticCreationPaused =>
        _migratedDefinition(
          id: id,
          applicationId: applicationId,
          applicationName: applicationName,
          settings: <String, dynamic>{
            'appName': applicationName,
            'autoAdd': true,
            'regex': r'Paid (?<amount>\d+\.\d{2}) CAD',
          },
          sample: NotificationSample(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: createdAt,
          ),
        ),
      NotificationDebugSeedScenario.conversionFailed => _conversionFailed(
        id: id,
        applicationId: applicationId,
        applicationName: applicationName,
        createdAt: createdAt,
      ),
      NotificationDebugSeedScenario.migrationFailed => _readyBasic(
        id: id,
        applicationId: applicationId,
        applicationName: applicationName,
        createdAt: createdAt,
      ),
      NotificationDebugSeedScenario.staleMigrationAlert => _readyBasic(
        id: id,
        applicationId: applicationId,
        applicationName: applicationName,
        createdAt: createdAt,
      ),
    };
  }

  NotificationDefinition _pendingBasic({
    required String id,
    required String applicationId,
    required String applicationName,
    required Set<NotificationMigrationIssue> issues,
    required DateTime createdAt,
  }) {
    final List<RegExpDefinition> extractors = _presetFactory.basicExtractors();
    return NotificationDefinition(
      id: id,
      applicationId: applicationId,
      name: applicationName,
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: _presetFactory
          .standardTransactionRule(extractors, includeNotificationText: true)
          .actions,
      createdAt: createdAt,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
      requiresMigrationReview: true,
      migrationReviewIssues: issues,
    );
  }

  NotificationDefinition _migratedDefinition({
    required String id,
    required String applicationId,
    required String applicationName,
    required Map<String, dynamic> settings,
    required NotificationSample sample,
  }) {
    final LegacyNotificationMigrationResult result = _definitionMigrator
        .migrate(applicationId, settings, sample: sample)!;
    return result.definition.copyWith(id: id);
  }

  NotificationDefinition _conversionFailed({
    required String id,
    required String applicationId,
    required String applicationName,
    required DateTime createdAt,
  }) => _definitionMigrator
      .createHusk(
        applicationId,
        applicationName: applicationName,
        sample: NotificationSample(
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: createdAt,
        ),
      )
      .copyWith(
        id: id,
        requiresMigrationReview: true,
        migrationReviewIssues: const <NotificationMigrationIssue>{
          NotificationMigrationIssue.conversionFailed,
        },
      );

  NotificationDefinition _readyBasic({
    required String id,
    required String applicationId,
    required String applicationName,
    required DateTime createdAt,
  }) {
    final List<RegExpDefinition> extractors = _presetFactory.basicExtractors();
    return NotificationDefinition(
      id: id,
      applicationId: applicationId,
      name: applicationName,
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: _presetFactory
          .standardTransactionRule(extractors, includeNotificationText: true)
          .actions,
      reviewedSharedActionFields: const <TransactionField>{
        TransactionField.amount,
        TransactionField.date,
        TransactionField.time,
        TransactionField.title,
        TransactionField.notes,
      },
      sampleTitle: 'Card payment',
      sampleBody: 'Paid 12.50 CAD',
      createdAt: createdAt,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
    );
  }

  NotificationDefinition _unresolvedCurrency({
    required String id,
    required String applicationId,
    required String applicationName,
    required DateTime createdAt,
  }) {
    final List<RegExpDefinition> extractors = _presetFactory.basicExtractors();
    final NotificationContext sample = NotificationContext(
      applicationId: applicationId,
      applicationName: applicationName,
      title: 'Card payment',
      body: 'Paid 12.50 XYZ',
      receivedAt: createdAt,
    );
    final LegacyCurrencyCapture capture = _currencyMapper.currencyCapture(
      extractors,
      sample,
    )!;
    final List<NotificationAction> actions = <NotificationAction>[
      ..._presetFactory
          .standardTransactionRule(extractors, includeNotificationText: true)
          .actions,
      _currencyMapper.currencyAction(
        extractors.firstWhere(
          (RegExpDefinition extractor) =>
              extractor.predefinedType == PredefinedRegExpDefinition.currency,
        ),
        capture,
        null,
      ),
    ];
    return NotificationDefinition(
      id: id,
      applicationId: applicationId,
      name: applicationName,
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: actions,
      reviewedSharedActionFields: const <TransactionField>{
        TransactionField.amount,
      },
      sampleTitle: sample.title,
      sampleBody: sample.body,
      createdAt: createdAt,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.currencyUnresolved,
      },
    );
  }

  Iterable<NotificationAlert> _alertsFor(
    NotificationDebugSeedScenario scenario,
    NotificationDefinition definition,
  ) sync* {
    if (scenario == NotificationDebugSeedScenario.migrationFailed) {
      yield NotificationAlert.failure(
        kind: NotificationAlertKind.migrationFailed,
        operation: 'Migrating legacy notification settings',
        message:
            'The imported setup is usable, but its legacy settings could not be removed.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
      );
      return;
    }
    final Iterable<NotificationMigrationIssue> issues =
        scenario == NotificationDebugSeedScenario.staleMigrationAlert
        ? const <NotificationMigrationIssue>[
            NotificationMigrationIssue.sampleMissing,
          ]
        : definition.migrationReviewIssues;
    for (final NotificationMigrationIssue issue in issues) {
      yield NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Debug migration test scenario',
        message: _messageFor(issue),
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: issue,
      );
    }
  }

  String _messageFor(NotificationMigrationIssue issue) => switch (issue) {
    NotificationMigrationIssue.sampleMissing =>
      'Enter a sample notification to finish the imported configuration.',
    NotificationMigrationIssue.missingSettings =>
      'No saved configuration was found for this application.',
    NotificationMigrationIssue.missingApplicationName =>
      'Waterfly could not identify the application for this imported setup.',
    NotificationMigrationIssue.currencyUnresolved =>
      'Choose the transaction currency because it could not be resolved uniquely.',
    NotificationMigrationIssue.expressionDoesNotMatchSample =>
      'Update the imported regular expression because it does not match the imported sample.',
    NotificationMigrationIssue.invalidRegularExpression =>
      'The imported regular expression is invalid. Update or replace it before using this configuration.',
    NotificationMigrationIssue.automaticCreationPaused =>
      'Automatic creation was changed to prompt mode until the imported currency behavior is reviewed.',
    NotificationMigrationIssue.missingAutomaticAccount =>
      'The imported automatic configuration is missing an account mapping.',
    NotificationMigrationIssue.conversionFailed =>
      'The previous notification settings could not be converted. Complete this configuration manually.',
    NotificationMigrationIssue.amountNotFound =>
      'Choose the transaction amount because the notification did not contain a supported monetary value.',
    NotificationMigrationIssue.ambiguousAmount =>
      'Choose the transaction amount because the notification contains multiple monetary values.',
  };

  void _ensureDebugBuild() {
    if (!kDebugMode) {
      throw StateError('Notification debug seeds require a debug build.');
    }
  }
}
