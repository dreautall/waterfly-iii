import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

abstract interface class NotificationListenerHealthStore {
  Future<NotificationListenerHealthIssue?> load();

  Future<NotificationListenerHealthIssue> recordFailure(DateTime occurredAt);

  Future<NotificationListenerHealthIssue?> markRecovered(DateTime recoveredAt);

  Future<void> clear();
}
