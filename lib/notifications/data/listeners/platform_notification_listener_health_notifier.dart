import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_notifier.dart';

const String notificationListenerHealthPayload =
    'waterfly:notification-listener-health';

class PlatformNotificationListenerHealthNotifier
    implements NotificationListenerHealthNotifier {
  const PlatformNotificationListenerHealthNotifier();

  static const int _notificationId = 73102;

  @override
  Future<void> showActive(
    int occurrenceCount,
  ) => FlutterLocalNotificationsPlugin().show(
    id: _notificationId,
    title: 'Notification processing paused',
    body: occurrenceCount == 1
        ? 'Waterfly could not load your notification setup. One notification was skipped.'
        : 'Waterfly could not load your notification setup. $occurrenceCount notifications were skipped.',
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'notification_processing_status',
        'Notification processing status',
        channelDescription:
            'Persistent status alerts when notification processing is unavailable.',
        importance: Importance.high,
        priority: Priority.high,
        ongoing: true,
        autoCancel: false,
      ),
    ),
    payload: notificationListenerHealthPayload,
  );

  @override
  Future<void> clearActive() =>
      FlutterLocalNotificationsPlugin().cancel(id: _notificationId);
}
