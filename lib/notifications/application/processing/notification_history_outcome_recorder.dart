import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_orchestrator.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';

class NotificationHistoryOutcomeRecorder
    implements NotificationOutcomeRecorder {
  const NotificationHistoryOutcomeRecorder(this._historyStore);

  static final Logger _log = Logger('Notifications.HistoryRecorder');
  final NotificationHistoryStore _historyStore;

  @override
  Future<void> record(
    NotificationContext notification,
    NotificationProcessingOutcome outcome,
  ) async {
    final String? deliveryId = notification.deliveryId;
    if (deliveryId == null || deliveryId.trim().isEmpty) {
      throw ArgumentError.value(
        deliveryId,
        'notification.deliveryId',
        'A listener notification must have a delivery ID.',
      );
    }
    try {
      await _historyStore.record(
        NotificationHistoryEntry(
          id: deliveryId,
          applicationId: notification.applicationId!,
          title: notification.title,
          body: notification.body,
          receivedAt: notification.receivedAt,
          processingOutcome: outcome,
        ),
      );
      _log.finer(
        () =>
            'Recorded ${outcome.status.name} notification history for ${notification.applicationId}.',
      );
    } catch (error, stackTrace) {
      _log.warning(
        'Could not record notification history for ${notification.applicationId}.',
        error,
        stackTrace,
      );
      rethrow;
    }
  }
}
