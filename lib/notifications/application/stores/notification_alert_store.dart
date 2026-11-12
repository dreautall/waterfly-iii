import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

abstract interface class NotificationAlertStore {
  Future<List<NotificationAlert>> load();

  Future<void> record(NotificationAlert alert);

  Future<void> dismiss(String fingerprint);

  Future<void> restore(NotificationAlert alert);
  Future<void> clearForApplication(String applicationId);

  Future<void> clearAll();
}
