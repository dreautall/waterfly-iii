import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

class InMemoryNotificationDefinitionStore
    implements NotificationDefinitionStore {
  InMemoryNotificationDefinitionStore([
    List<NotificationDefinition>? definitions,
  ]) : definitions = definitions ?? <NotificationDefinition>[];

  List<NotificationDefinition> definitions;

  @override
  Future<List<NotificationDefinition>> load() async => definitions;

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    this.definitions = definitions;
  }
}

class InMemoryNotificationAlertStore implements NotificationAlertStore {
  InMemoryNotificationAlertStore([List<NotificationAlert>? alerts])
    : alerts = alerts ?? <NotificationAlert>[];

  List<NotificationAlert> alerts;

  @override
  Future<void> clearForApplication(String applicationId) async {
    alerts = alerts
        .where(
          (NotificationAlert alert) => alert.applicationId != applicationId,
        )
        .toList();
  }

  @override
  Future<void> clearAll() async {
    alerts = <NotificationAlert>[];
  }

  @override
  Future<void> dismiss(String fingerprint) async {
    alerts = alerts
        .where((NotificationAlert alert) => alert.fingerprint != fingerprint)
        .toList();
  }

  @override
  Future<List<NotificationAlert>> load() async => alerts;

  @override
  Future<void> record(NotificationAlert alert) async {
    alerts = <NotificationAlert>[...alerts, alert];
  }

  @override
  Future<void> restore(NotificationAlert alert) async {
    alerts = <NotificationAlert>[...alerts, alert];
  }
}

class InMemoryNotificationListenerHealthStore
    implements NotificationListenerHealthStore {
  InMemoryNotificationListenerHealthStore([this.issue]);

  NotificationListenerHealthIssue? issue;

  @override
  Future<void> clear() async {
    issue = null;
  }

  @override
  Future<NotificationListenerHealthIssue?> load() async => issue;

  @override
  Future<NotificationListenerHealthIssue?> markRecovered(
    DateTime recoveredAt,
  ) async {
    if (issue case final NotificationListenerHealthIssue current
        when current.isActive) {
      issue = current.markRecovered(recoveredAt);
    }
    return issue;
  }

  @override
  Future<NotificationListenerHealthIssue> recordFailure(
    DateTime occurredAt,
  ) async {
    issue = issue == null
        ? NotificationListenerHealthIssue(
            firstOccurredAt: occurredAt,
            lastOccurredAt: occurredAt,
            occurrenceCount: 1,
          )
        : issue!.recordOccurrence(occurredAt);
    return issue!;
  }
}
