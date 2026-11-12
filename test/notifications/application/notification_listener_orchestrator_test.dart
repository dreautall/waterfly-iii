import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_orchestrator.dart';
import 'package:waterflyiii/notifications/application/processing/notification_history_outcome_recorder.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class _FakeDefinitionProcessing implements NotificationDefinitionProcessing {
  _FakeDefinitionProcessing(this.result);

  final NotificationDefinitionProcessingResult result;
  final List<NotificationContext> notifications = <NotificationContext>[];

  @override
  Future<NotificationDefinitionProcessingResult> process(
    NotificationContext notification,
  ) async {
    notifications.add(notification);
    return result;
  }
}

class _FakeIntentExecutor implements NotificationIntentExecutor {
  _FakeIntentExecutor(this.result);

  final NotificationProcessingOutcome result;
  int calls = 0;
  NotificationContext? notification;
  TransactionIntent? intent;
  NotificationProcessingOutcome? inputOutcome;

  @override
  Future<NotificationProcessingOutcome> execute({
    required NotificationContext notification,
    required TransactionIntent intent,
    required NotificationProcessingOutcome outcome,
  }) async {
    calls += 1;
    this.notification = notification;
    this.intent = intent;
    inputOutcome = outcome;
    return result;
  }
}

class _FakeOutcomeRecorder implements NotificationOutcomeRecorder {
  int calls = 0;
  NotificationContext? notification;
  NotificationProcessingOutcome? outcome;

  @override
  Future<void> record(
    NotificationContext notification,
    NotificationProcessingOutcome outcome,
  ) async {
    calls += 1;
    this.notification = notification;
    this.outcome = outcome;
  }
}

class _FakeHistoryStore implements NotificationHistoryStore {
  NotificationHistoryEntry? recordedEntry;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {
    recordedEntry = entry;
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async =>
      <NotificationHistoryEntry>[];

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {}
}

void main() {
  final NotificationContext notification = NotificationContext(
    applicationId: 'com.example.bank',
    deliveryId: 'delivery',
    title: 'Card payment',
    body: r'Paid $12.50',
    receivedAt: DateTime(2026, 9, 28),
  );
  const NotificationProcessingOutcome matchedOutcome =
      NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
      );
  const TransactionIntent intent = TransactionIntent(
    mode: TransactionCreationMode.automatic,
    patch: TransactionPatch(<TransactionField, String>{}),
  );

  test('stops when definitions cannot be loaded', () async {
    final _FakeDefinitionProcessing processing = _FakeDefinitionProcessing(
      const NotificationDefinitionProcessingResult(
        loadFailed: true,
        outcome: NotificationProcessingOutcome(
          status: NotificationProcessingOutcomeStatus.failed,
        ),
      ),
    );
    final _FakeIntentExecutor executor = _FakeIntentExecutor(matchedOutcome);
    final _FakeOutcomeRecorder recorder = _FakeOutcomeRecorder();

    await NotificationListenerOrchestrator(
      definitionProcessing: processing,
      intentExecutor: executor,
      outcomeRecorder: recorder,
    ).process(notification);

    expect(processing.notifications, <NotificationContext>[notification]);
    expect(executor.calls, 0);
    expect(recorder.calls, 0);
  });

  test('reports and stops for an unregistered application', () async {
    final _FakeDefinitionProcessing processing = _FakeDefinitionProcessing(
      const NotificationDefinitionProcessingResult(
        outcome: NotificationProcessingOutcome(
          status: NotificationProcessingOutcomeStatus.noMatch,
        ),
      ),
    );
    final _FakeIntentExecutor executor = _FakeIntentExecutor(matchedOutcome);
    final _FakeOutcomeRecorder recorder = _FakeOutcomeRecorder();
    NotificationContext? unregistered;

    await NotificationListenerOrchestrator(
      definitionProcessing: processing,
      intentExecutor: executor,
      outcomeRecorder: recorder,
      onUnregistered: (NotificationContext value) => unregistered = value,
    ).process(notification);

    expect(unregistered, same(notification));
    expect(executor.calls, 0);
    expect(recorder.calls, 0);
  });

  test('records processing outcome when there is no intent', () async {
    final _FakeDefinitionProcessing processing = _FakeDefinitionProcessing(
      const NotificationDefinitionProcessingResult(
        isRegistered: true,
        outcome: matchedOutcome,
      ),
    );
    final _FakeIntentExecutor executor = _FakeIntentExecutor(matchedOutcome);
    final _FakeOutcomeRecorder recorder = _FakeOutcomeRecorder();

    await NotificationListenerOrchestrator(
      definitionProcessing: processing,
      intentExecutor: executor,
      outcomeRecorder: recorder,
    ).process(notification);

    expect(executor.calls, 0);
    expect(recorder.notification, same(notification));
    expect(recorder.outcome, same(matchedOutcome));
  });

  test('records the outcome returned by intent execution', () async {
    final NotificationProcessingOutcome executedOutcome = matchedOutcome
        .withTransactionId(
          'transaction',
          origin: NotificationTransactionCreationOrigin.automatic,
        );
    final _FakeDefinitionProcessing processing = _FakeDefinitionProcessing(
      const NotificationDefinitionProcessingResult(
        isRegistered: true,
        intent: intent,
        outcome: matchedOutcome,
      ),
    );
    final _FakeIntentExecutor executor = _FakeIntentExecutor(executedOutcome);
    final _FakeOutcomeRecorder recorder = _FakeOutcomeRecorder();

    await NotificationListenerOrchestrator(
      definitionProcessing: processing,
      intentExecutor: executor,
      outcomeRecorder: recorder,
    ).process(notification);

    expect(executor.calls, 1);
    expect(executor.notification, same(notification));
    expect(executor.intent, same(intent));
    expect(executor.inputOutcome, same(matchedOutcome));
    expect(recorder.outcome, same(executedOutcome));
  });

  test(
    'records notification fields and processing outcome in history',
    () async {
      final _FakeHistoryStore historyStore = _FakeHistoryStore();

      await NotificationHistoryOutcomeRecorder(
        historyStore,
      ).record(notification, matchedOutcome);

      expect(historyStore.recordedEntry?.id, notification.deliveryId);
      expect(
        historyStore.recordedEntry?.applicationId,
        notification.applicationId,
      );
      expect(historyStore.recordedEntry?.title, notification.title);
      expect(historyStore.recordedEntry?.body, notification.body);
      expect(historyStore.recordedEntry?.receivedAt, notification.receivedAt);
      expect(
        historyStore.recordedEntry?.processingOutcome,
        same(matchedOutcome),
      );
    },
  );

  test('rejects history recording without a delivery ID', () {
    final NotificationContext missingDeliveryId = NotificationContext(
      applicationId: notification.applicationId,
      title: notification.title,
      body: notification.body,
      receivedAt: notification.receivedAt,
    );

    expect(
      () => NotificationHistoryOutcomeRecorder(
        _FakeHistoryStore(),
      ).record(missingDeliveryId, matchedOutcome),
      throwsArgumentError,
    );
  });
}
