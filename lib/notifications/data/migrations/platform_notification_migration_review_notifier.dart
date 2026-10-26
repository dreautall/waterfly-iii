import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflyiii/notifications/application/migrations/notification_migration_review_service.dart';

const String notificationMigrationReviewPayload =
    'waterfly:notification-migration-review';

class PlatformNotificationMigrationReviewNotifier
    implements NotificationMigrationReviewNotificationGateway {
  const PlatformNotificationMigrationReviewNotifier();

  static const int _notificationId = 73103;

  @override
  Future<void> show(int reviewCount) => FlutterLocalNotificationsPlugin().show(
    id: _notificationId,
    title: 'Notification settings need review',
    body: reviewCount == 1
        ? 'One notification migration issue needs your input.'
        : '$reviewCount notification migration issues need your input.',
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'notification_migration_review',
        'Notification migration review',
        channelDescription:
            'Alerts when imported notification configurations need review.',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    payload: notificationMigrationReviewPayload,
  );

  @override
  Future<void> cancel() =>
      FlutterLocalNotificationsPlugin().cancel(id: _notificationId);
}

class SharedPreferencesNotificationMigrationReviewAnnouncementStore
    implements NotificationMigrationReviewAnnouncementStore {
  const SharedPreferencesNotificationMigrationReviewAnnouncementStore();

  static const String _fingerprintKey =
      'notification_migration_review_fingerprint';

  @override
  Future<void> clear() async {
    await SharedPreferencesAsync().remove(_fingerprintKey);
  }

  @override
  Future<String?> loadFingerprint() =>
      SharedPreferencesAsync().getString(_fingerprintKey);

  @override
  Future<void> saveFingerprint(String fingerprint) async {
    await SharedPreferencesAsync().setString(_fingerprintKey, fingerprint);
  }
}
