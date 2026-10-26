import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';

class NotificationDefinitionProcessingResult {
  const NotificationDefinitionProcessingResult({
    required this.outcome,
    this.intent,
    this.isRegistered = false,
    this.loadFailed = false,
  });

  final NotificationProcessingOutcome outcome;
  final TransactionIntent? intent;
  final bool isRegistered;
  final bool loadFailed;
}

abstract interface class NotificationDefinitionProcessing {
  Future<NotificationDefinitionProcessingResult> process(
    NotificationContext notification,
  );
}

abstract interface class NotificationIntentExecutor {
  Future<NotificationProcessingOutcome> execute({
    required NotificationContext notification,
    required TransactionIntent intent,
    required NotificationProcessingOutcome outcome,
  });
}

abstract interface class NotificationOutcomeRecorder {
  Future<void> record(
    NotificationContext notification,
    NotificationProcessingOutcome outcome,
  );
}

class NotificationListenerOrchestrator {
  const NotificationListenerOrchestrator({
    required NotificationDefinitionProcessing definitionProcessing,
    required NotificationIntentExecutor intentExecutor,
    required NotificationOutcomeRecorder outcomeRecorder,
    void Function(NotificationContext notification)? onUnregistered,
  }) : _definitionProcessing = definitionProcessing,
       _intentExecutor = intentExecutor,
       _outcomeRecorder = outcomeRecorder,
       _onUnregistered = onUnregistered;

  final NotificationDefinitionProcessing _definitionProcessing;
  final NotificationIntentExecutor _intentExecutor;
  final NotificationOutcomeRecorder _outcomeRecorder;
  final void Function(NotificationContext notification)? _onUnregistered;

  Future<void> process(NotificationContext notification) async {
    final NotificationDefinitionProcessingResult processing =
        await _definitionProcessing.process(notification);
    if (processing.loadFailed) return;
    if (!processing.isRegistered) {
      _onUnregistered?.call(notification);
      return;
    }

    NotificationProcessingOutcome outcome = processing.outcome;
    final TransactionIntent? intent = processing.intent;
    if (intent != null) {
      outcome = await _intentExecutor.execute(
        notification: notification,
        intent: intent,
        outcome: outcome,
      );
    }
    await _outcomeRecorder.record(notification, outcome);
  }
}
