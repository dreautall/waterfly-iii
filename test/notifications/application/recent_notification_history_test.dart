import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';

class FixedDefinitionStore implements NotificationDefinitionStore {
  FixedDefinitionStore(this.definitions);

  final List<NotificationDefinition> definitions;

  @override
  Future<List<NotificationDefinition>> load() =>
      Future<List<NotificationDefinition>>.value(definitions);

  @override
  Future<void> save(List<NotificationDefinition> definitions) =>
      Future<void>.value();
}

class FixedAlertStore implements NotificationAlertStore {
  FixedAlertStore(this.alerts);

  final List<NotificationAlert> alerts;

  @override
  Future<void> clearForApplication(String applicationId) =>
      Future<void>.value();

  @override
  Future<void> clearAll() => Future<void>.value();

  @override
  Future<void> dismiss(String fingerprint) => Future<void>.value();

  @override
  Future<List<NotificationAlert>> load() =>
      Future<List<NotificationAlert>>.value(alerts);

  @override
  Future<void> record(NotificationAlert alert) => Future<void>.value();

  @override
  Future<void> restore(NotificationAlert alert) => Future<void>.value();
}

class FixedHistoryStore implements NotificationHistoryStore {
  FixedHistoryStore(this.entries);

  final List<NotificationHistoryEntry> entries;

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearForApplication(String applicationId) =>
      Future<void>.value();

  @override
  Future<void> clearAll() => Future<void>.value();

  @override
  Future<List<NotificationHistoryEntry>> load() =>
      Future<List<NotificationHistoryEntry>>.value(entries);

  @override
  Future<void> record(NotificationHistoryEntry entry) => Future<void>.value();
}

void main() {
  // Ensures a saved failure is shown beside the matching historical input only
  // when that notification belongs to an existing app registration.
  test(
    'correlates a definition failure with its recent notification',
    () async {
      final NotificationHistoryEntry notification = NotificationHistoryEntry(
        id: 'payment',
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 8, 31),
      );
      final NotificationAlert alert = NotificationAlert.failure(
        kind: NotificationAlertKind.actionFailed,
        operation: 'Applying notification definition action',
        message: 'The amount capture could not be resolved.',
        applicationId: 'com.example.bank',
        definitionId: 'bank',
        notification: NotificationContext(
          applicationId: 'com.example.bank',
          deliveryId: notification.id,
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: DateTime(2026, 8, 31),
        ),
      );
      final RecentNotificationHistory history = RecentNotificationHistory(
        FixedDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]),
        FixedAlertStore(<NotificationAlert>[alert]),
        historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
          notification,
        ]),
      );

      final List<RecentNotificationHistoryEntry> entries = await history.load();

      expect(entries.single.processingFailure?.fingerprint, alert.fingerprint);
    },
  );

  test('excludes notifications from unregistered applications', () async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.unregistered',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 8, 31),
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.unregistered',
      definitionId: 'removed-definition',
      notification: NotificationContext(
        applicationId: notification.applicationId,
        title: notification.title,
        body: notification.body,
        receivedAt: notification.receivedAt,
      ),
    );
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[]),
      FixedAlertStore(<NotificationAlert>[alert]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[notification]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries, isEmpty);
  });

  test('keeps distinct metadata-only entries from the same second', () async {
    final List<NotificationHistoryEntry> notifications =
        <NotificationHistoryEntry>[
          NotificationHistoryEntry(
            id: 'first',
            applicationId: 'com.example.bank',
            title: '',
            body: '',
            receivedAt: DateTime(2026, 9, 6, 12),
          ),
          NotificationHistoryEntry(
            id: 'second',
            applicationId: 'com.example.bank',
            title: '',
            body: '',
            receivedAt: DateTime(2026, 9, 6, 12),
          ),
        ];
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(notifications),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(
      entries.map(
        (RecentNotificationHistoryEntry entry) => entry.notification.id,
      ),
      <String>['first', 'second'],
    );
  });

  test('exposes the matching rule for a recent notification', () async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    const NotificationRule rule = NotificationRule(
      id: 'groceries',
      name: 'Groceries',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.category,
          valueSource: LiteralValueSource('Food'),
        ),
      ],
      conditionalActionGroups: <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'merchant-details',
          name: 'Merchant details',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('merchant')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.title,
              valueSource: LiteralValueSource('Card payment'),
            ),
          ],
        ),
        NotificationActionGroup(
          id: 'missing-details',
          name: 'Missing details',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.title,
              valueSource: LiteralValueSource('Missing'),
            ),
          ],
        ),
      ],
    );
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[rule],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[notification]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries.single.matchingRule?.id, rule.id);
    expect(
      entries.single.matchingConditionalActionGroups.map(
        (NotificationActionGroup group) => group.name,
      ),
      <String>['Merchant details'],
    );
  });

  test(
    'keeps the recorded rule after the current definition changes',
    () async {
      final NotificationHistoryEntry notification = NotificationHistoryEntry(
        id: 'payment',
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 26),
        processingOutcome: const NotificationProcessingOutcome(
          status: NotificationProcessingOutcomeStatus.matched,
          definition: NotificationHistoryReference(
            id: 'bank',
            name: 'Example Bank',
          ),
          rule: NotificationHistoryReference(
            id: 'original-rule',
            name: 'Original purchases',
          ),
          hasTransactionIntent: true,
        ),
      );
      const NotificationRule currentRule = NotificationRule(
        id: 'current-rule',
        name: 'Current purchases',
        conditions: <NotificationCondition>[],
        actions: <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Current'),
          ),
        ],
      );
      final RecentNotificationHistory history = RecentNotificationHistory(
        FixedDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Renamed Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[currentRule],
            extractorMode: NotificationExtractorMode.advanced,
          ),
        ]),
        FixedAlertStore(<NotificationAlert>[]),
        historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
          notification,
        ]),
      );

      final RecentNotificationHistoryEntry entry =
          (await history.load()).single;

      expect(entry.matchingRuleName, 'Original purchases');
      expect(entry.matchingRule, isNull);
      expect(entry.currentMatchingRule?.name, 'Current purchases');
      expect(entry.currentCanCreateTransaction, isTrue);
    },
  );

  test('keeps recorded names after the definition is deleted', () async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: '',
      body: '',
      receivedAt: DateTime(2026, 9, 26),
      processingOutcome: const NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
        definition: NotificationHistoryReference(
          id: 'bank',
          name: 'Example Bank',
        ),
        rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
        hasTransactionIntent: true,
      ),
    );
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[notification]),
    );

    final RecentNotificationHistoryEntry entry = (await history.load()).single;

    expect(entry.definition, isNull);
    expect(entry.matchingRuleName, 'Groceries');
    expect(entry.currentCanCreateTransaction, isNull);
  });

  test('exposes an unconditional rule when it is selected', () async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'deposit',
      applicationId: 'com.example.bank',
      title: 'Deposit received',
      body: 'A deposit of 334.96 CAD was made.',
      receivedAt: DateTime(2026, 9, 6),
    );
    const NotificationRule defaultRule = NotificationRule(
      id: 'default',
      name: 'Transaction details',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.category,
          valueSource: LiteralValueSource('Unassigned'),
        ),
      ],
    );
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[defaultRule],
          extractorMode: NotificationExtractorMode.advanced,
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[notification]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries.single.matchingRule?.id, defaultRule.id);
    expect(entries.single.matchingRule?.conditions, isEmpty);
  });

  test(
    'exposes shared-action transaction creation without a matching rule',
    () async {
      final NotificationHistoryEntry notification = NotificationHistoryEntry(
        id: 'deposit',
        applicationId: 'com.example.bank',
        title: 'Deposit received',
        body: 'A deposit of 334.96 CAD was made.',
        receivedAt: DateTime(2026, 9, 6),
      );
      final RecentNotificationHistory history = RecentNotificationHistory(
        FixedDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            sharedActions: <SetTransactionFieldAction>[
              SetTransactionFieldAction(
                target: TransactionField.category,
                valueSource: LiteralValueSource('Income'),
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
            transactionCreationMode: TransactionCreationMode.prompt,
          ),
        ]),
        FixedAlertStore(<NotificationAlert>[]),
        historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
          notification,
        ]),
      );

      final List<RecentNotificationHistoryEntry> entries = await history.load();

      expect(entries.single.matchingRule, isNull);
      expect(entries.single.matchingConditionalActionGroups, isEmpty);
      expect(entries.single.canCreateTransaction, isTrue);
    },
  );

  test('excludes notifications with a blank title or message', () async {
    final DateTime receivedAt = DateTime(2026, 8, 31);
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
        NotificationHistoryEntry(
          id: 'blank-title',
          applicationId: 'com.example.bank',
          title: '',
          body: 'Paid 12 CAD',
          receivedAt: receivedAt,
        ),
        NotificationHistoryEntry(
          id: 'blank-body',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: '   ',
          receivedAt: receivedAt,
        ),
        NotificationHistoryEntry(
          id: 'payment',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12 CAD',
          receivedAt: receivedAt,
        ),
      ]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries, hasLength(1));
    expect(entries.single.notification.title, 'Card payment');
  });

  test('keeps fully redacted metadata-only notifications', () async {
    final DateTime receivedAt = DateTime(2026, 8, 31);
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
        NotificationHistoryEntry(
          id: 'metadata-only',
          applicationId: 'com.example.bank',
          title: '',
          body: '',
          receivedAt: receivedAt,
        ),
      ]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries.single.notification.id, 'metadata-only');
    expect(entries.single.matchingRule, isNull);
    expect(entries.single.canCreateTransaction, isFalse);
  });

  test(
    'does not recreate transactions from redacted recorded outcomes',
    () async {
      final RecentNotificationHistory history = RecentNotificationHistory(
        FixedDefinitionStore(const <NotificationDefinition>[]),
        FixedAlertStore(const <NotificationAlert>[]),
        historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
          NotificationHistoryEntry(
            id: 'metadata-only',
            applicationId: 'com.example.bank',
            title: '',
            body: '',
            receivedAt: DateTime(2026, 8, 31),
            processingOutcome: const NotificationProcessingOutcome(
              status: NotificationProcessingOutcomeStatus.matched,
              definition: NotificationHistoryReference(
                id: 'bank',
                name: 'Example Bank',
              ),
              transactionCreationMode: TransactionCreationMode.prompt,
              hasTransactionIntent: true,
            ),
          ),
        ]),
      );

      final List<RecentNotificationHistoryEntry> entries = await history.load();

      expect(entries.single.canCreateTransaction, isFalse);
    },
  );

  test('excludes repeated deliveries of the same notification', () async {
    final DateTime receivedAt = DateTime(2026, 9, 6, 14, 58);
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
        NotificationHistoryEntry(
          id: 'first-delivery',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: receivedAt,
        ),
        NotificationHistoryEntry(
          id: 'repeat-delivery',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: receivedAt.add(const Duration(milliseconds: 250)),
        ),
        NotificationHistoryEntry(
          id: 'new-notification',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: receivedAt.add(const Duration(seconds: 2)),
        ),
      ]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(
      entries.map(
        (RecentNotificationHistoryEntry entry) => entry.notification.id,
      ),
      <String>['repeat-delivery', 'new-notification'],
    );
  });

  test('shows the latest alert for a coalesced delivery', () async {
    final DateTime receivedAt = DateTime(2026, 9, 6, 14, 58);
    final NotificationHistoryEntry firstDelivery = NotificationHistoryEntry(
      id: 'first-delivery',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: receivedAt,
    );
    final NotificationHistoryEntry latestDelivery = NotificationHistoryEntry(
      id: 'latest-delivery',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: receivedAt.add(const Duration(milliseconds: 250)),
    );
    final NotificationAlert latestAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.bank',
      definitionId: 'bank',
      notification: NotificationContext(
        applicationId: 'com.example.bank',
        deliveryId: latestDelivery.id,
        title: latestDelivery.title,
        body: latestDelivery.body,
        receivedAt: latestDelivery.receivedAt,
      ),
    );
    final RecentNotificationHistory history = RecentNotificationHistory(
      FixedDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
      FixedAlertStore(<NotificationAlert>[latestAlert]),
      historyStore: FixedHistoryStore(<NotificationHistoryEntry>[
        firstDelivery,
        latestDelivery,
      ]),
    );

    final List<RecentNotificationHistoryEntry> entries = await history.load();

    expect(entries, hasLength(1));
    expect(entries.single.notification.id, latestDelivery.id);
    expect(
      entries.single.processingFailure?.fingerprint,
      latestAlert.fingerprint,
    );
  });
}
