import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/notification_transaction_intent_executor.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

void main() {
  final NotificationContext notification = NotificationContext(
    applicationId: 'com.example.bank',
    deliveryId: 'delivery',
    title: 'Card payment',
    body: r'Paid $12.50',
    receivedAt: DateTime(2026, 9, 28),
  );
  const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
    status: NotificationProcessingOutcomeStatus.matched,
    definition: NotificationHistoryReference(
      id: 'definition',
      name: 'Example Bank',
    ),
  );

  test('returns transaction id and invokes automatic completion', () async {
    bool completed = false;
    final NotificationTransactionIntentExecutor
    executor = NotificationTransactionIntentExecutor(
      automaticHandler:
          (NotificationContext actualNotification, TransactionIntent intent) {
            expect(actualNotification, same(notification));
            expect(intent.mode, TransactionCreationMode.automatic);
            return Future<String>.value('transaction');
          },
      manualHandler:
          (NotificationContext notification, TransactionIntent intent) =>
              Future<void>.error(StateError('manual handler should not run')),
      automaticCompletedHandler: (NotificationContext actualNotification) {
        expect(actualNotification, same(notification));
        completed = true;
        return Future<void>.value();
      },
      failureHandler:
          (
            NotificationContext notification,
            NotificationProcessingOutcome outcome,
            Object error,
            StackTrace stackTrace,
          ) => Future<void>.error(StateError('failure handler should not run')),
    );

    final NotificationProcessingOutcome result = await executor.execute(
      notification: notification,
      intent: const TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{}),
      ),
      outcome: outcome,
    );

    expect(result.transactionId, 'transaction');
    expect(
      result.transactionCreationOrigin,
      NotificationTransactionCreationOrigin.automatic,
    );
    expect(completed, isTrue);
  });

  test('invokes manual handler without changing the outcome', () async {
    bool handled = false;
    final NotificationTransactionIntentExecutor
    executor = NotificationTransactionIntentExecutor(
      automaticHandler:
          (NotificationContext notification, TransactionIntent intent) =>
              Future<String>.error(
                StateError('automatic handler should not run'),
              ),
      manualHandler:
          (NotificationContext actualNotification, TransactionIntent intent) {
            expect(actualNotification, same(notification));
            expect(intent.mode, TransactionCreationMode.prompt);
            handled = true;
            return Future<void>.value();
          },
      automaticCompletedHandler: (NotificationContext notification) =>
          Future<void>.error(StateError('completion handler should not run')),
      failureHandler:
          (
            NotificationContext notification,
            NotificationProcessingOutcome outcome,
            Object error,
            StackTrace stackTrace,
          ) => Future<void>.error(StateError('failure handler should not run')),
    );

    final NotificationProcessingOutcome result = await executor.execute(
      notification: notification,
      intent: const TransactionIntent(
        mode: TransactionCreationMode.prompt,
        patch: TransactionPatch(<TransactionField, String>{}),
      ),
      outcome: outcome,
    );

    expect(handled, isTrue);
    expect(result, same(outcome));
  });

  test('records execution failure and returns a failed outcome', () async {
    NotificationProcessingOutcome? recordedOutcome;
    Object? recordedError;
    final NotificationTransactionIntentExecutor executor =
        NotificationTransactionIntentExecutor(
          automaticHandler:
              (NotificationContext notification, TransactionIntent intent) =>
                  Future<String>.error(
                    const FormatException('Not authenticated'),
                  ),
          manualHandler:
              (NotificationContext notification, TransactionIntent intent) =>
                  Future<void>.value(),
          automaticCompletedHandler: (NotificationContext notification) =>
              Future<void>.value(),
          failureHandler:
              (
                NotificationContext actualNotification,
                NotificationProcessingOutcome failedOutcome,
                Object error,
                StackTrace stackTrace,
              ) {
                expect(actualNotification, same(notification));
                recordedOutcome = failedOutcome;
                recordedError = error;
                return Future<void>.value();
              },
        );

    final NotificationProcessingOutcome result = await executor.execute(
      notification: notification,
      intent: const TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{}),
      ),
      outcome: outcome,
    );

    expect(result.status, NotificationProcessingOutcomeStatus.failed);
    expect(result.definition, same(outcome.definition));
    expect(result.failureMessage, contains('Not authenticated'));
    expect(recordedOutcome, same(result));
    expect(recordedError, isA<FormatException>());
  });
}
