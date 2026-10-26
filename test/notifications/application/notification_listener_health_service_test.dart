import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_notifier.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

import '../support/in_memory_notification_stores.dart';

class _DefinitionStore implements NotificationDefinitionStore {
  _DefinitionStore({this.error});

  final Object? error;

  @override
  Future<List<NotificationDefinition>> load() async {
    if (error != null) throw error!;
    return <NotificationDefinition>[];
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {}
}

class _Notifier implements NotificationListenerHealthNotifier {
  int? shownCount;
  int clearCount = 0;

  @override
  Future<void> clearActive() async {
    clearCount++;
  }

  @override
  Future<void> showActive(int occurrenceCount) async {
    shownCount = occurrenceCount;
  }
}

void main() {
  test(
    'records aggregated failures and updates the active notification',
    () async {
      final InMemoryNotificationListenerHealthStore store =
          InMemoryNotificationListenerHealthStore();
      final _Notifier notifier = _Notifier();
      final NotificationListenerHealthService service =
          NotificationListenerHealthService(
            store: store,
            definitionStore: _DefinitionStore(),
            notifier: notifier,
          );

      await service.recordFailure(DateTime.utc(2026, 10, 1, 8));
      final NotificationListenerHealthIssue issue = await service.recordFailure(
        DateTime.utc(2026, 10, 1, 9),
      );

      expect(issue.occurrenceCount, 2);
      expect(notifier.shownCount, 2);
    },
  );

  test(
    'successful retry records recovery and clears the notification',
    () async {
      final InMemoryNotificationListenerHealthStore store =
          InMemoryNotificationListenerHealthStore(
            NotificationListenerHealthIssue(
              firstOccurredAt: DateTime.utc(2026, 10, 1, 8),
              lastOccurredAt: DateTime.utc(2026, 10, 1, 8),
              occurrenceCount: 1,
            ),
          );
      final _Notifier notifier = _Notifier();
      final NotificationListenerHealthService service =
          NotificationListenerHealthService(
            store: store,
            definitionStore: _DefinitionStore(),
            notifier: notifier,
          );

      final NotificationListenerHealthIssue? issue = await service.retry(
        DateTime.utc(2026, 10, 1, 9),
      );

      expect(issue?.isActive, isFalse);
      expect(notifier.clearCount, 1);
    },
  );

  test('failed retry leaves the active incident unchanged', () async {
    final NotificationListenerHealthIssue active =
        NotificationListenerHealthIssue(
          firstOccurredAt: DateTime.utc(2026, 10, 1, 8),
          lastOccurredAt: DateTime.utc(2026, 10, 1, 8),
          occurrenceCount: 1,
        );
    final InMemoryNotificationListenerHealthStore store =
        InMemoryNotificationListenerHealthStore(active);
    final _Notifier notifier = _Notifier();
    final NotificationListenerHealthService service =
        NotificationListenerHealthService(
          store: store,
          definitionStore: _DefinitionStore(error: StateError('unavailable')),
          notifier: notifier,
        );

    await expectLater(
      service.retry(DateTime.utc(2026, 10, 1, 9)),
      throwsStateError,
    );

    expect(store.issue, same(active));
    expect(notifier.clearCount, 0);
  });
}
