import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

class NotificationMigrationAlertReconciler {
  const NotificationMigrationAlertReconciler(this._alertStore);

  final NotificationAlertStore _alertStore;

  Future<void> reconcile(Iterable<NotificationDefinition> definitions) async {
    final List<NotificationDefinition> current = definitions.toList(
      growable: false,
    );
    if (current.isEmpty) return;
    final List<NotificationAlert> alerts = await _alertStore.load();
    for (final NotificationAlert alert in alerts.where(
      (NotificationAlert alert) =>
          alert.kind == NotificationAlertKind.migrationNeedsReview,
    )) {
      final NotificationDefinition? definition = current
          .where(
            (NotificationDefinition definition) =>
                alert.definitionId == definition.id ||
                alert.applicationId == definition.applicationId,
          )
          .firstOrNull;
      if (definition == null) continue;
      final NotificationMigrationIssue? issue = alert.migrationIssue;
      if (issue != null && definition.migrationReviewIssues.contains(issue)) {
        continue;
      }
      await _alertStore.dismiss(alert.fingerprint);
    }
  }
}
