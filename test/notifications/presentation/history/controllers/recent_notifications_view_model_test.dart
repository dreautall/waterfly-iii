import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/presentation/history/controllers/recent_notifications_view_model.dart';

class DelayedHistoryLoader implements RecentNotificationHistoryLoader {
  final List<Completer<List<RecentNotificationHistoryEntry>>> _loads =
      <Completer<List<RecentNotificationHistoryEntry>>>[];

  @override
  Future<List<RecentNotificationHistoryEntry>> load() {
    final Completer<List<RecentNotificationHistoryEntry>> load =
        Completer<List<RecentNotificationHistoryEntry>>();
    _loads.add(load);
    return load.future;
  }

  Completer<List<RecentNotificationHistoryEntry>> takePendingLoad() =>
      _loads.removeAt(0);
}

class InMemoryHistoryLoader implements RecentNotificationHistoryLoader {
  InMemoryHistoryLoader({
    this.entries = const <RecentNotificationHistoryEntry>[],
    this.error,
  });

  final List<RecentNotificationHistoryEntry> entries;
  final Object? error;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() {
    if (error != null) {
      return Future<List<RecentNotificationHistoryEntry>>.error(error!);
    }
    return Future<List<RecentNotificationHistoryEntry>>.value(entries);
  }
}

RecentNotificationHistoryEntry entry(String id) =>
    RecentNotificationHistoryEntry(
      notification: NotificationHistoryEntry(
        id: id,
        applicationId: 'com.example.bank',
        title: 'Payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 14),
      ),
    );

void main() {
  test(
    'keeps the newest history load when requests complete out of order',
    () async {
      final DelayedHistoryLoader loader = DelayedHistoryLoader();
      final RecentNotificationsViewModel viewModel =
          RecentNotificationsViewModel(loader);

      final Future<void> firstLoad = viewModel.load();
      final Future<void> secondLoad = viewModel.load();
      final Completer<List<RecentNotificationHistoryEntry>> firstResponse =
          loader.takePendingLoad();
      final Completer<List<RecentNotificationHistoryEntry>> secondResponse =
          loader.takePendingLoad();
      secondResponse.complete(<RecentNotificationHistoryEntry>[entry('new')]);
      await secondLoad;
      firstResponse.complete(<RecentNotificationHistoryEntry>[entry('old')]);
      await firstLoad;

      expect(viewModel.entries.single.notification.id, 'new');
      expect(viewModel.isLoading, isFalse);
    },
  );

  test('loads history entries and captures loader failures', () async {
    final RecentNotificationsViewModel successfulViewModel =
        RecentNotificationsViewModel(
          InMemoryHistoryLoader(
            entries: <RecentNotificationHistoryEntry>[entry('history')],
          ),
        );
    final RecentNotificationsViewModel failingViewModel =
        RecentNotificationsViewModel(
          InMemoryHistoryLoader(error: StateError('History unavailable')),
        );

    await successfulViewModel.load();
    await failingViewModel.load();

    expect(successfulViewModel.entries.single.notification.id, 'history');
    expect(successfulViewModel.error, isNull);
    expect(failingViewModel.entries, isEmpty);
    expect(failingViewModel.error, isA<StateError>());
    expect(failingViewModel.isLoading, isFalse);
  });
}
