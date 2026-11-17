import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/application/migrations/pending_notification_migration_completion_service.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

import '../../support/in_memory_notification_stores.dart';

class _CurrencyGateway implements FireflyCurrencyGateway {
  const _CurrencyGateway({this.currencies = const <FireflyCurrency>[]});

  final List<FireflyCurrency> currencies;

  @override
  Future<List<FireflyCurrency>> search(String query) async => currencies;
}

class _DelayedCurrencyGateway implements FireflyCurrencyGateway {
  final Completer<void> started = Completer<void>();
  final Completer<List<FireflyCurrency>> result =
      Completer<List<FireflyCurrency>>();

  @override
  Future<List<FireflyCurrency>> search(String query) {
    if (!started.isCompleted) started.complete();
    return result.future;
  }
}

class _FailingAlertStore extends InMemoryNotificationAlertStore {
  _FailingAlertStore(super.alerts);

  bool failNextDismiss = true;

  @override
  Future<void> dismiss(String fingerprint) async {
    if (failNextDismiss) {
      failNextDismiss = false;
      throw StateError('Alert storage unavailable');
    }
    await super.dismiss(fingerprint);
  }
}

class _FailingRecordAlertStore extends InMemoryNotificationAlertStore {
  _FailingRecordAlertStore(super.alerts);

  bool failNextRecord = true;

  @override
  Future<void> record(NotificationAlert alert) async {
    if (failNextRecord) {
      failNextRecord = false;
      throw StateError('Alert storage unavailable');
    }
    await super.record(alert);
  }
}

void main() {
  const NotificationDefinitionPresetFactory presets =
      NotificationDefinitionPresetFactory();

  NotificationAlert reviewAlert(
    NotificationDefinition definition,
    NotificationMigrationIssue issue,
  ) => NotificationAlert.failure(
    kind: NotificationAlertKind.migrationNeedsReview,
    operation: 'Reviewing imported notification settings',
    message: issue.name,
    applicationId: definition.applicationId,
    definitionId: definition.id,
    migrationIssue: issue,
  );

  PendingNotificationMigrationCompletionService service(
    InMemoryNotificationDefinitionStore definitions,
    InMemoryNotificationAlertStore alerts, {
    FireflyCurrencyResolver currencyResolver = const FireflyCurrencyResolver(
      _CurrencyGateway(
        currencies: <FireflyCurrency>[
          FireflyCurrency(
            id: 'cad',
            name: 'Canadian Dollar',
            code: 'CAD',
            symbol: r'$',
          ),
        ],
      ),
    ),
  }) => PendingNotificationMigrationCompletionService(
    definitionStore: definitions,
    alertStore: alerts,
    currencyResolver: currencyResolver,
  );

  NotificationContext notification(String body) => NotificationContext(
    applicationId: 'com.example.bank',
    applicationName: 'Example Bank',
    title: 'Card payment',
    body: body,
    receivedAt: DateTime(2026, 11, 16, 12, 30),
    deliveryId: 'delivery-1',
  );

  test('completes a migrated setup from its first notification', () async {
    final List<RegExpDefinition> extractors = presets.basicExtractors();
    final NotificationRule rule = presets.standardTransactionRule(
      extractors,
      includeNotificationText: true,
    );
    final NotificationDefinition definition = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: rule.actions,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.sampleMissing,
      },
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          reviewAlert(definition, NotificationMigrationIssue.sampleMissing),
        ]);

    final NotificationContext firstNotification = notification(
      'Paid 12.50 CAD',
    );
    final PendingNotificationMigrationCompletionResult result = await service(
      definitions,
      alerts,
    ).complete(firstNotification);

    expect(result.attempted, isTrue);
    expect(result.definition?.status, NotificationDefinitionStatus.ready);
    expect(result.definition?.sampleBody, 'Paid 12.50 CAD');
    expect(
      result.definition?.reviewedSharedActionFields,
      contains(TransactionField.amount),
    );
    final SetTransactionFieldAction currencyAction = result
        .definition!
        .sharedActions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    expect(
      (currencyAction.valueSource as CurrencyCaptureValueSource).resourceId,
      'cad',
    );
    expect(
      result.definition
          ?.evaluate(firstNotification)
          ?.effectiveTransactionIntent,
      isNotNull,
    );
    expect(alerts.alerts, isEmpty);
  });

  test(
    'creates a default Basic setup when legacy settings are missing',
    () async {
      const NotificationDefinition definition = NotificationDefinition(
        id: 'legacy:com.example.bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        requiresMigrationReview: true,
        migrationReviewIssues: <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingSettings,
        },
      );
      final InMemoryNotificationDefinitionStore definitions =
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            definition,
          ]);
      final InMemoryNotificationAlertStore alerts =
          InMemoryNotificationAlertStore(<NotificationAlert>[
            reviewAlert(definition, NotificationMigrationIssue.missingSettings),
          ]);

      final PendingNotificationMigrationCompletionResult result = await service(
        definitions,
        alerts,
      ).complete(notification('Paid 12.50 CAD'));

      expect(result.definition?.extractorMode, NotificationExtractorMode.basic);
      expect(result.definition?.basicView, NotificationBasicView.simple);
      expect(result.definition?.sharedActions, isNotEmpty);
      expect(result.definition?.migrationReviewIssues, isEmpty);
      expect(result.definition?.hasIncompleteActions, isFalse);
      expect(result.definition?.hasUnreviewedPredefinedMappings, isFalse);
      expect(result.definition?.status, NotificationDefinitionStatus.ready);
      expect(alerts.alerts, isEmpty);
    },
  );

  test('keeps an ambiguous first amount pending review', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      requiresMigrationReview: true,
      migrationReviewIssues: <NotificationMigrationIssue>{
        NotificationMigrationIssue.missingSettings,
      },
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          reviewAlert(definition, NotificationMigrationIssue.missingSettings),
        ]);

    final PendingNotificationMigrationCompletionResult result = await service(
      definitions,
      alerts,
    ).complete(notification('Paid 25 CAD and 35 CAD'));

    expect(result.definition?.status, NotificationDefinitionStatus.needsReview);
    expect(
      result.definition?.migrationReviewIssues,
      contains(NotificationMigrationIssue.ambiguousAmount),
    );
    expect(
      alerts.alerts.single.migrationIssue,
      NotificationMigrationIssue.ambiguousAmount,
    );
  });

  test('keeps an unavailable first currency pending review', () async {
    final List<RegExpDefinition> extractors = presets.basicExtractors();
    final NotificationDefinition definition = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: presets.standardTransactionRule(extractors).actions,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.sampleMissing,
      },
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          reviewAlert(definition, NotificationMigrationIssue.sampleMissing),
        ]);

    final PendingNotificationMigrationCompletionResult result = await service(
      definitions,
      alerts,
      currencyResolver: const FireflyCurrencyResolver(_CurrencyGateway()),
    ).complete(notification('Paid 12.50 USD'));

    expect(result.definition?.status, NotificationDefinitionStatus.needsReview);
    expect(
      result.definition?.migrationReviewIssues,
      contains(NotificationMigrationIssue.currencyUnresolved),
    );
    final SetTransactionFieldAction currencyAction = result
        .definition!
        .sharedActions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    expect(currencyAction.valueSource, isA<RegExpCaptureValueSource>());
    expect(
      alerts.alerts.single.migrationIssue,
      NotificationMigrationIssue.currencyUnresolved,
    );
  });

  test('completes a matching advanced legacy expression', () async {
    final NotificationDefinition definition =
        const LegacyNotificationDefinitionMigrator().migrate(
          'com.example.bank',
          <String, dynamic>{
            'appName': 'Example Bank',
            'regex': r'Paid (?<amount>\d+\.\d{2}) CAD',
          },
        )!.definition;
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          reviewAlert(definition, NotificationMigrationIssue.sampleMissing),
        ]);

    final PendingNotificationMigrationCompletionResult result = await service(
      definitions,
      alerts,
    ).complete(notification('Paid 12.50 CAD'));

    expect(
      result.definition?.extractorMode,
      NotificationExtractorMode.advanced,
    );
    expect(result.definition?.status, NotificationDefinitionStatus.ready);
    expect(alerts.alerts, isEmpty);
  });

  test('serializes competing first notifications', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      requiresMigrationReview: true,
      migrationReviewIssues: <NotificationMigrationIssue>{
        NotificationMigrationIssue.missingSettings,
      },
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final PendingNotificationMigrationCompletionService completion = service(
      definitions,
      alerts,
    );

    final List<PendingNotificationMigrationCompletionResult> results =
        await Future.wait(
          <Future<PendingNotificationMigrationCompletionResult>>[
            completion.complete(notification('Paid 12.50 CAD')),
            completion.complete(notification('Paid 25.00 CAD')),
          ],
        );

    expect(
      results.where(
        (PendingNotificationMigrationCompletionResult result) =>
            result.attempted,
      ),
      hasLength(1),
    );
    expect(definitions.definitions.single.sampleBody, 'Paid 12.50 CAD');
  });

  test('retries stale alert cleanup on the next notification', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      requiresMigrationReview: true,
      migrationReviewIssues: <NotificationMigrationIssue>{
        NotificationMigrationIssue.missingSettings,
      },
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final _FailingAlertStore alerts = _FailingAlertStore(<NotificationAlert>[
      reviewAlert(definition, NotificationMigrationIssue.missingSettings),
    ]);
    final PendingNotificationMigrationCompletionService completion = service(
      definitions,
      alerts,
    );

    final PendingNotificationMigrationCompletionResult first = await completion
        .complete(notification('Paid 12.50 CAD'));
    expect(first.attempted, isTrue);
    expect(alerts.alerts, isNotEmpty);

    final PendingNotificationMigrationCompletionResult second = await completion
        .complete(notification('Paid 15.00 CAD'));
    expect(second.attempted, isFalse);
    expect(alerts.alerts, isEmpty);
  });

  test(
    'retries missing review alert creation on the next notification',
    () async {
      const NotificationDefinition definition = NotificationDefinition(
        id: 'legacy:com.example.bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        requiresMigrationReview: true,
        migrationReviewIssues: <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingSettings,
        },
      );
      final InMemoryNotificationDefinitionStore definitions =
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            definition,
          ]);
      final _FailingRecordAlertStore alerts = _FailingRecordAlertStore(
        <NotificationAlert>[
          reviewAlert(definition, NotificationMigrationIssue.missingSettings),
        ],
      );
      final PendingNotificationMigrationCompletionService completion = service(
        definitions,
        alerts,
      );

      final PendingNotificationMigrationCompletionResult first =
          await completion.complete(notification('Card settings updated'));
      expect(first.attempted, isTrue);
      expect(alerts.alerts, isEmpty);

      final PendingNotificationMigrationCompletionResult second =
          await completion.complete(notification('Paid 15.00 CAD'));
      expect(second.attempted, isFalse);
      expect(alerts.alerts, hasLength(1));
      expect(
        alerts.alerts.single.migrationIssue,
        NotificationMigrationIssue.amountNotFound,
      );
    },
  );

  test('preserves a concurrent edit while resolving currency', () async {
    final List<RegExpDefinition> extractors = presets.basicExtractors();
    final NotificationDefinition pending = NotificationDefinition(
      id: 'legacy:com.example.bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: extractors,
      rules: const <NotificationRule>[],
      sharedActions: presets.standardTransactionRule(extractors).actions,
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.prompt,
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.sampleMissing,
      },
    );
    const NotificationDefinition other = NotificationDefinition(
      id: 'other',
      applicationId: 'com.example.other',
      name: 'Original name',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          pending,
          other,
        ]);
    final _DelayedCurrencyGateway gateway = _DelayedCurrencyGateway();
    final Future<PendingNotificationMigrationCompletionResult> completion =
        service(
          definitions,
          InMemoryNotificationAlertStore(),
          currencyResolver: FireflyCurrencyResolver(gateway),
        ).complete(notification('Paid 12.50 CAD'));

    await gateway.started.future;
    definitions.definitions = <NotificationDefinition>[
      pending,
      other.copyWith(name: 'Edited concurrently'),
    ];
    gateway.result.complete(const <FireflyCurrency>[
      FireflyCurrency(
        id: 'cad',
        name: 'Canadian Dollar',
        code: 'CAD',
        symbol: r'$',
      ),
    ]);
    await completion;

    expect(
      definitions.definitions
          .singleWhere(
            (NotificationDefinition definition) => definition.id == 'other',
          )
          .name,
      'Edited concurrently',
    );
  });
}
