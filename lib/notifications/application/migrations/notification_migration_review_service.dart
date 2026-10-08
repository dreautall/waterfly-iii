import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

abstract interface class NotificationMigrationReviewNotificationGateway {
  Future<void> show(int reviewCount);

  Future<void> cancel();
}

abstract interface class NotificationMigrationReviewAnnouncementStore {
  Future<String?> loadFingerprint();

  Future<void> saveFingerprint(String fingerprint);

  Future<void> clear();
}

class NotificationMigrationReviewService {
  const NotificationMigrationReviewService({
    required NotificationMigrationReviewNotificationGateway notification,
    required NotificationMigrationReviewAnnouncementStore announcements,
  }) : _notification = notification,
       _announcements = announcements;

  final NotificationMigrationReviewNotificationGateway _notification;
  final NotificationMigrationReviewAnnouncementStore _announcements;

  Future<void> refresh(List<NotificationAlert> alerts) async {
    final List<String> fingerprints =
        alerts
            .where(
              (NotificationAlert alert) =>
                  alert.kind == NotificationAlertKind.migrationNeedsReview ||
                  alert.kind == NotificationAlertKind.migrationFailed,
            )
            .map((NotificationAlert alert) => alert.fingerprint)
            .toList()
          ..sort();
    if (fingerprints.isEmpty) {
      await _notification.cancel();
      await _announcements.clear();
      return;
    }

    final String fingerprint = fingerprints.join('|');
    if (await _announcements.loadFingerprint() == fingerprint) return;

    await _notification.show(fingerprints.length);
    await _announcements.saveFingerprint(fingerprint);
  }
}
