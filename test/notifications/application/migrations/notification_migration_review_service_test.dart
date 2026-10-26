import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/migrations/notification_migration_review_service.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

class _Notification implements NotificationMigrationReviewNotificationGateway {
  int? shownCount;
  int cancelCount = 0;

  @override
  Future<void> cancel() async {
    cancelCount += 1;
  }

  @override
  Future<void> show(int reviewCount) async {
    shownCount = reviewCount;
  }
}

class _Announcements implements NotificationMigrationReviewAnnouncementStore {
  String? fingerprint;

  @override
  Future<void> clear() async {
    fingerprint = null;
  }

  @override
  Future<String?> loadFingerprint() async => fingerprint;

  @override
  Future<void> saveFingerprint(String fingerprint) async {
    this.fingerprint = fingerprint;
  }
}

void main() {
  NotificationAlert review(String applicationId) => NotificationAlert.failure(
    kind: NotificationAlertKind.migrationNeedsReview,
    operation: 'Review import',
    message: 'Enter a sample notification.',
    applicationId: applicationId,
  );

  test('announces a changed set of migration review alerts once', () async {
    final _Notification notification = _Notification();
    final _Announcements announcements = _Announcements();
    final NotificationMigrationReviewService service =
        NotificationMigrationReviewService(
          notification: notification,
          announcements: announcements,
        );
    final List<NotificationAlert> alerts = <NotificationAlert>[
      review('com.example.bank'),
      review('com.example.card'),
    ];

    await service.refresh(alerts);
    expect(notification.shownCount, 2);

    notification.shownCount = null;
    await service.refresh(alerts.reversed.toList());
    expect(notification.shownCount, isNull);
  });

  test('includes failed migrations in the announcement', () async {
    final _Notification notification = _Notification();
    final _Announcements announcements = _Announcements();
    final NotificationMigrationReviewService service =
        NotificationMigrationReviewService(
          notification: notification,
          announcements: announcements,
        );

    await service.refresh(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationFailed,
        operation: 'Migration',
        message: 'Invalid settings.',
      ),
    ]);

    expect(notification.shownCount, 1);
    expect(announcements.fingerprint, isNotNull);
  });

  test('clears the notification when no migration alerts remain', () async {
    final _Notification notification = _Notification();
    final _Announcements announcements = _Announcements()
      ..fingerprint = 'existing';
    final NotificationMigrationReviewService service =
        NotificationMigrationReviewService(
          notification: notification,
          announcements: announcements,
        );

    await service.refresh(const <NotificationAlert>[]);

    expect(notification.cancelCount, 1);
    expect(announcements.fingerprint, isNull);
  });
}
