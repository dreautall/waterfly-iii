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
typedef NotificationIntentPreparer =
    Future<TransactionIntent> Function(TransactionIntent intent);

class NotificationTransactionIntentExecutor
    implements NotificationIntentExecutor {
  const NotificationTransactionIntentExecutor({
    required AutomaticNotificationIntentHandler automaticHandler,
    required ManualNotificationIntentHandler manualHandler,
    required IntentFailureHandler failureHandler,
    required AutomaticIntentCompletedHandler automaticCompletedHandler,
    NotificationIntentPreparer? intentPreparer,
  }) : _automaticHandler = automaticHandler,
       _manualHandler = manualHandler,
       _failureHandler = failureHandler,
       _automaticCompletedHandler = automaticCompletedHandler,
       _intentPreparer = intentPreparer;

  final AutomaticNotificationIntentHandler _automaticHandler;
  final ManualNotificationIntentHandler _manualHandler;
  final IntentFailureHandler _failureHandler;
  final AutomaticIntentCompletedHandler _automaticCompletedHandler;
  final NotificationIntentPreparer? _intentPreparer;

  @override
  Future<NotificationProcessingOutcome> execute({
    required NotificationContext notification,
    required TransactionIntent intent,
    required NotificationProcessingOutcome outcome,
  }) async {
    try {
      final TransactionIntent preparedIntent = _intentPreparer == null
          ? intent
          : await _intentPreparer(intent);
      final NotificationProcessingOutcome preparedOutcome =
          preparedIntent.patch == intent.patch
          ? outcome
          : outcome.withTransactionPatch(preparedIntent.patch);
      if (preparedIntent.mode == TransactionCreationMode.automatic) {
        final String transactionId = await _automaticHandler(
          notification,
          preparedIntent,
        );
        await _automaticCompletedHandler(notification);
        return preparedOutcome.withTransactionId(
          transactionId,
          origin: NotificationTransactionCreationOrigin.automatic,
        );
      }
      await _manualHandler(notification, preparedIntent);
      return preparedOutcome;
    } catch (error, stackTrace) {
      final NotificationProcessingOutcome failedOutcome = outcome.withFailure(
        error.toString(),
      );
      await _failureHandler(notification, failedOutcome, error, stackTrace);
      return failedOutcome;
    }
  }
}
