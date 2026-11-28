import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/debug/notification_debug_seed_service.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

import '../support/in_memory_notification_stores.dart';

class _HistoryStore implements NotificationHistoryStore {
  final List<String> clearedApplicationIds = <String>[];

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplicationIds.add(applicationId);
  }

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<List<NotificationHistoryEntry>> load() async =>
      <NotificationHistoryEntry>[];

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

void main() {
  const String applicationId = 'com.example.bank';
  const NotificationDefinition existing = NotificationDefinition(
    id: 'existing',
    applicationId: applicationId,
    name: 'Existing',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[],
  );

  test('seeds a pending migration and replaces only the target app', () async {
    const NotificationDefinition unrelated = NotificationDefinition(
      id: 'unrelated',
      applicationId: 'com.example.other',
      name: 'Other',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          existing,
          unrelated,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          NotificationAlert.failure(
            kind: NotificationAlertKind.actionFailed,
            operation: 'Old failure',
            message: 'Old failure',
            applicationId: applicationId,
          ),
        ]);
    final _HistoryStore history = _HistoryStore();

    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: definitions,
          alertStore: alerts,
          historyStore: history,
        ).seed(
          scenario: NotificationDebugSeedScenario.sampleMissing,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(
      seeded.id,
      startsWith(NotificationDebugSeedService.definitionIdPrefix),
    );
    expect(seeded.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.sampleMissing,
    });
    expect(
      definitions.definitions.map(
        (NotificationDefinition definition) => definition.id,
      ),
      containsAll(<String>[seeded.id, unrelated.id]),
    );
    expect(definitions.definitions, isNot(contains(existing)));
    expect(
      alerts.alerts.single.migrationIssue,
      NotificationMigrationIssue.sampleMissing,
    );
    expect(history.clearedApplicationIds, <String>[applicationId]);
  });

  test('seeds a repairable unresolved currency action', () async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore();
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: definitions,
          alertStore: InMemoryNotificationAlertStore(),
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.unresolvedCurrency,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(
      seeded.migrationReviewIssues,
      contains(NotificationMigrationIssue.currencyUnresolved),
    );
    final SetTransactionFieldAction currency = seeded.sharedActions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    expect(currency.valueSource, isA<RegExpCaptureValueSource>());
  });

  test('seeds an advanced expression that does not match its sample', () async {
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: InMemoryNotificationAlertStore(),
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.advancedExpressionMismatch,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.extractorMode, NotificationExtractorMode.advanced);
    expect(seeded.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.expressionDoesNotMatchSample,
    });
    expect(seeded.extractors.first.isRequiredForMatch, isTrue);
    expect(seeded.extractors.first.regExpSource, contains('(?<amount>'));
  });

  test('seeds a repairable invalid imported expression', () async {
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: InMemoryNotificationAlertStore(),
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.invalidRegularExpression,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.extractorMode, NotificationExtractorMode.advanced);
    expect(seeded.extractors.first.regExpSource, '[');
    expect(seeded.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.invalidRegularExpression,
    });
  });

  test('seeds missing-title policy scenarios and metadata-only mode', () async {
    final NotificationDebugSeedService service = NotificationDebugSeedService(
      definitionStore: InMemoryNotificationDefinitionStore(),
      alertStore: InMemoryNotificationAlertStore(),
      historyStore: _HistoryStore(),
    );

    final NotificationDefinition attention = await service.seed(
      scenario: NotificationDebugSeedScenario.missingTitleAttention,
      applicationId: applicationId,
      applicationName: 'Example Bank',
    );
    expect(
      attention.missingNotificationDataPolicy,
      MissingNotificationDataPolicy.requiresAttention,
    );
    expect(attention.extractorMode, NotificationExtractorMode.advanced);

    final NotificationDefinition ignored = await service.seed(
      scenario: NotificationDebugSeedScenario.missingTitleIgnored,
      applicationId: applicationId,
      applicationName: 'Example Bank',
    );
    expect(
      ignored.missingNotificationDataPolicy,
      MissingNotificationDataPolicy.ignore,
    );

    final NotificationDefinition metadataOnly = await service.seed(
      scenario: NotificationDebugSeedScenario.metadataOnlyAllowed,
      applicationId: applicationId,
      applicationName: 'Example Bank',
    );
    expect(metadataOnly.canProcessMetadataOnlyNotifications, isTrue);
  });

  test('seeds automatic creation paused without an account mapping', () async {
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: InMemoryNotificationAlertStore(),
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.automaticCreationPaused,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.transactionCreationMode, TransactionCreationMode.prompt);
    expect(seeded.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.automaticCreationPaused,
      NotificationMigrationIssue.missingAutomaticAccount,
    });
  });

  test('seeds a conversion-failed husk with its sample preserved', () async {
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: InMemoryNotificationAlertStore(),
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.conversionFailed,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.extractorMode, NotificationExtractorMode.notConfigured);
    expect(seeded.sampleTitle, 'Card payment');
    expect(seeded.sampleBody, 'Paid 12.50 CAD');
    expect(seeded.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.conversionFailed,
    });
  });

  test('seeds a usable definition with a migration cleanup failure', () async {
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: alerts,
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.migrationFailed,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.status, NotificationDefinitionStatus.ready);
    expect(seeded.migrationReviewIssues, isEmpty);
    expect(alerts.alerts.single.kind, NotificationAlertKind.migrationFailed);
    expect(alerts.alerts.single.migrationIssue, isNull);
  });

  test('stale-alert scenario keeps the definition ready', () async {
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final NotificationDefinition seeded =
        await NotificationDebugSeedService(
          definitionStore: InMemoryNotificationDefinitionStore(),
          alertStore: alerts,
          historyStore: _HistoryStore(),
        ).seed(
          scenario: NotificationDebugSeedScenario.staleMigrationAlert,
          applicationId: applicationId,
          applicationName: 'Example Bank',
        );

    expect(seeded.status, NotificationDefinitionStatus.ready);
    expect(seeded.migrationReviewIssues, isEmpty);
    expect(
      alerts.alerts.single.migrationIssue,
      NotificationMigrationIssue.sampleMissing,
    );
  });

  test(
    'reset removes seeded definitions without deleting ordinary ones',
    () async {
      final InMemoryNotificationDefinitionStore definitions =
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            existing,
          ]);
      final NotificationDebugSeedService service = NotificationDebugSeedService(
        definitionStore: definitions,
        alertStore: InMemoryNotificationAlertStore(),
        historyStore: _HistoryStore(),
      );
      await service.seed(
        scenario: NotificationDebugSeedScenario.sampleMissing,
        applicationId: 'com.example.seeded',
        applicationName: 'Seeded',
      );

      await service.resetAllSeeded();

      expect(definitions.definitions, <NotificationDefinition>[existing]);
    },
  );

  test('reset by ID follows an unknown seed after manual recovery', () async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore();
    final _HistoryStore history = _HistoryStore();
    final NotificationDebugSeedService service = NotificationDebugSeedService(
      definitionStore: definitions,
      alertStore: InMemoryNotificationAlertStore(),
      historyStore: history,
    );
    final NotificationDefinition seeded = await service.seed(
      scenario: NotificationDebugSeedScenario.unknownApplication,
      applicationId: 'debug.migration.unknown',
      applicationName: 'Example Bank',
    );
    definitions.definitions = <NotificationDefinition>[
      seeded.copyWith(
        applicationId: applicationId,
        name: 'Example Bank',
        migrationReviewIssues: const <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingSettings,
        },
      ),
    ];

    await service.resetDefinition(seeded.id);

    expect(definitions.definitions, isEmpty);
    expect(history.clearedApplicationIds.last, applicationId);
  });

  test('unknown seed replaces the intended recovery target', () async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[existing]);
    final _HistoryStore history = _HistoryStore();
    final NotificationDebugSeedService service = NotificationDebugSeedService(
      definitionStore: definitions,
      alertStore: InMemoryNotificationAlertStore(),
      historyStore: history,
    );

    final NotificationDefinition seeded = await service.seed(
      scenario: NotificationDebugSeedScenario.unknownApplication,
      applicationId: 'debug.migration.unknown',
      applicationName: 'Example Bank',
      replacedApplicationId: applicationId,
    );

    expect(definitions.definitions, <NotificationDefinition>[seeded]);
    expect(history.clearedApplicationIds, <String>[
      'debug.migration.unknown',
      applicationId,
    ]);
  });
}
