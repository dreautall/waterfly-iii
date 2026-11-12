import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_notifier.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

class NotificationListenerHealthService {
  const NotificationListenerHealthService({
    required NotificationListenerHealthStore store,
    required NotificationDefinitionStore definitionStore,
    NotificationListenerHealthNotifier notifier =
        const NoopNotificationListenerHealthNotifier(),
  }) : _store = store,
       _definitionStore = definitionStore,
       _notifier = notifier;

  final NotificationListenerHealthStore _store;
  final NotificationDefinitionStore _definitionStore;
  final NotificationListenerHealthNotifier _notifier;

  Future<NotificationListenerHealthIssue> recordFailure(
    DateTime occurredAt,
  ) async {
    final NotificationListenerHealthIssue issue = await _store.recordFailure(
      occurredAt,
    );
    await _notifier.showActive(issue.occurrenceCount);
    return issue;
  }

  Future<NotificationListenerHealthIssue?> recordSuccessfulLoad(
    DateTime recoveredAt,
  ) async {
    final NotificationListenerHealthIssue? issue = await _store.markRecovered(
      recoveredAt,
    );
    await _notifier.clearActive();
    return issue;
  }

  Future<NotificationListenerHealthIssue?> retry(DateTime recoveredAt) async {
    await _definitionStore.load();
    return recordSuccessfulLoad(recoveredAt);
  }

  Future<void> acknowledge() => _store.clear();
}
