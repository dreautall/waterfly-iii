import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

class DismissNotificationAlertsResult {
  const DismissNotificationAlertsResult({
    required this.completed,
    required this.failures,
  });

  final List<NotificationAlert> completed;
  final List<NotificationAlert> failures;

  bool get succeeded => failures.isEmpty;
}

class DismissNotificationAlerts {
  const DismissNotificationAlerts(this._store);

  final NotificationAlertStore _store;

  Future<DismissNotificationAlertsResult> dismiss(
    List<NotificationAlert> alerts,
  ) => _process(
    alerts,
    (NotificationAlert alert) => _store.dismiss(alert.fingerprint),
  );

  Future<DismissNotificationAlertsResult> restore(
    List<NotificationAlert> alerts,
  ) => _process(alerts, (NotificationAlert alert) => _store.restore(alert));

  Future<DismissNotificationAlertsResult> _process(
    List<NotificationAlert> alerts,
    Future<void> Function(NotificationAlert alert) operation,
  ) async {
    final List<NotificationAlert> completed = <NotificationAlert>[];
    final List<NotificationAlert> failures = <NotificationAlert>[];
    for (final NotificationAlert alert in alerts) {
      try {
        await operation(alert);
        completed.add(alert);
      } catch (_) {
        failures.add(alert);
      }
    }
    return DismissNotificationAlertsResult(
      completed: completed,
      failures: failures,
    );
  }
}
