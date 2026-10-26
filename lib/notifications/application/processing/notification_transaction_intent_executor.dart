import 'package:waterflyiii/notifications/application/listeners/notification_listener_orchestrator.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';

typedef AutomaticNotificationIntentHandler =
    Future<String> Function(
      NotificationContext notification,
      TransactionIntent intent,
    );
typedef ManualNotificationIntentHandler =
    Future<void> Function(
      NotificationContext notification,
      TransactionIntent intent,
    );
typedef AutomaticIntentCompletedHandler =
    Future<void> Function(NotificationContext notification);
typedef IntentFailureHandler =
    Future<void> Function(
      NotificationContext notification,
      NotificationProcessingOutcome outcome,
      Object error,
      StackTrace stackTrace,
    );

class NotificationTransactionIntentExecutor
    implements NotificationIntentExecutor {
  const NotificationTransactionIntentExecutor({
    required AutomaticNotificationIntentHandler automaticHandler,
    required ManualNotificationIntentHandler manualHandler,
    required IntentFailureHandler failureHandler,
    required AutomaticIntentCompletedHandler automaticCompletedHandler,
  }) : _automaticHandler = automaticHandler,
       _manualHandler = manualHandler,
       _failureHandler = failureHandler,
       _automaticCompletedHandler = automaticCompletedHandler;

  final AutomaticNotificationIntentHandler _automaticHandler;
  final ManualNotificationIntentHandler _manualHandler;
  final IntentFailureHandler _failureHandler;
  final AutomaticIntentCompletedHandler _automaticCompletedHandler;

  @override
  Future<NotificationProcessingOutcome> execute({
    required NotificationContext notification,
    required TransactionIntent intent,
    required NotificationProcessingOutcome outcome,
  }) async {
    try {
      if (intent.mode == TransactionCreationMode.automatic) {
        final String transactionId = await _automaticHandler(
          notification,
          intent,
        );
        await _automaticCompletedHandler(notification);
        return outcome.withTransactionId(
          transactionId,
          origin: NotificationTransactionCreationOrigin.automatic,
        );
      }
      await _manualHandler(notification, intent);
      return outcome;
    } catch (error, stackTrace) {
      final NotificationProcessingOutcome failedOutcome = outcome.withFailure(
        error.toString(),
      );
      await _failureHandler(notification, failedOutcome, error, stackTrace);
      return failedOutcome;
    }
  }
}
