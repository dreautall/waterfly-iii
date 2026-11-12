import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
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

class PagedHistoryLoader
    implements
        RecentNotificationHistoryLoader,
        PagedRecentNotificationHistoryLoader {
  PagedHistoryLoader(this.pages);

  final List<RecentNotificationHistoryPage> pages;
  final List<NotificationHistoryCursor?> requestedCursors =
      <NotificationHistoryCursor?>[];
  Object? loadMoreError;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() async =>
      pages.first.entries;

  @override
  Future<RecentNotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  }) async {
    requestedCursors.add(before);
    if (before != null && loadMoreError != null) throw loadMoreError!;
    return pages[before == null ? 0 : 1];
  }
}

RecentNotificationHistoryEntry entry(
  String id, {
  DateTime? receivedAt,
  String? title,
}) => RecentNotificationHistoryEntry(
  notification: NotificationHistoryEntry(
    id: id,
    applicationId: 'com.example.bank',
    title: title ?? 'Payment $id',
    body: 'Paid 12.50 CAD',
    receivedAt: receivedAt ?? DateTime(2026, 9, 14),
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

  test(
    'appends cursor pages and removes duplicates across boundaries',
    () async {
      final NotificationHistoryCursor cursor = NotificationHistoryCursor(
        receivedAt: DateTime(2026, 9, 14, 12),
        id: 'first',
      );
      final PagedHistoryLoader loader = PagedHistoryLoader(
        <RecentNotificationHistoryPage>[
          RecentNotificationHistoryPage(
            entries: <RecentNotificationHistoryEntry>[
              entry('first', receivedAt: DateTime(2026, 9, 14, 12)),
            ],
            hasMore: true,
            nextCursor: cursor,
          ),
          RecentNotificationHistoryPage(
            entries: <RecentNotificationHistoryEntry>[
              entry('first', receivedAt: DateTime(2026, 9, 14, 12)),
              entry('second', receivedAt: DateTime(2026, 9, 13, 12)),
            ],
            hasMore: false,
          ),
        ],
      );
      final RecentNotificationsViewModel viewModel =
          RecentNotificationsViewModel(loader);

      await viewModel.load();
      await viewModel.loadMore();

      expect(
        viewModel.entries.map(
          (RecentNotificationHistoryEntry item) => item.notification.id,
        ),
        <String>['first', 'second'],
      );
      expect(loader.requestedCursors, <NotificationHistoryCursor?>[
        null,
        cursor,
      ]);
      expect(viewModel.hasMore, isFalse);
      expect(viewModel.isLoadingMore, isFalse);
    },
  );

  test('keeps loaded entries when loading an earlier page fails', () async {
    final NotificationHistoryCursor cursor = NotificationHistoryCursor(
      receivedAt: DateTime(2026, 9, 14),
      id: 'first',
    );
    final PagedHistoryLoader loader = PagedHistoryLoader(
      <RecentNotificationHistoryPage>[
        RecentNotificationHistoryPage(
          entries: <RecentNotificationHistoryEntry>[entry('first')],
          hasMore: true,
          nextCursor: cursor,
        ),
        const RecentNotificationHistoryPage(
          entries: <RecentNotificationHistoryEntry>[],
          hasMore: false,
        ),
      ],
    )..loadMoreError = StateError('Page unavailable');
    final RecentNotificationsViewModel viewModel = RecentNotificationsViewModel(
      loader,
    );

    await viewModel.load();
    await viewModel.loadMore();

    expect(viewModel.entries.single.notification.id, 'first');
    expect(viewModel.error, isNull);
    expect(viewModel.loadMoreError, isA<StateError>());
    expect(viewModel.hasMore, isTrue);
  });

  test('refresh replaces accumulated pages and resets the cursor', () async {
    final NotificationHistoryCursor cursor = NotificationHistoryCursor(
      receivedAt: DateTime(2026, 9, 14),
      id: 'first',
    );
    final PagedHistoryLoader loader = PagedHistoryLoader(
      <RecentNotificationHistoryPage>[
        RecentNotificationHistoryPage(
          entries: <RecentNotificationHistoryEntry>[entry('first')],
          hasMore: true,
          nextCursor: cursor,
        ),
        RecentNotificationHistoryPage(
          entries: <RecentNotificationHistoryEntry>[entry('second')],
          hasMore: false,
        ),
      ],
    );
    final RecentNotificationsViewModel viewModel = RecentNotificationsViewModel(
      loader,
    );

    await viewModel.load();
    await viewModel.loadMore();
    await viewModel.refresh();

    expect(
      viewModel.entries.map(
        (RecentNotificationHistoryEntry item) => item.notification.id,
      ),
      <String>['first'],
    );
    expect(loader.requestedCursors, <NotificationHistoryCursor?>[
      null,
      cursor,
      null,
    ]);
  });
}
