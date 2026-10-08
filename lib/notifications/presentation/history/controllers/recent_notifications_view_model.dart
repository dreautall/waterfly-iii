import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

class RecentNotificationsViewModel extends ChangeNotifier {
  RecentNotificationsViewModel(this._history);

  static const int pageSize = 30;

  final RecentNotificationHistoryLoader _history;

  List<RecentNotificationHistoryEntry> entries =
      <RecentNotificationHistoryEntry>[];
  List<RecentNotificationHistoryEntry> mostRecentlyLoadedEntries =
      <RecentNotificationHistoryEntry>[];
  Object? error;
  Object? loadMoreError;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = false;
  NotificationHistoryCursor? _nextCursor;
  int _loadGeneration = 0;

  Future<void> load() => _loadFirstPage(showLoading: true);

  Future<void> refresh() => _loadFirstPage(showLoading: false);

  Future<void> _loadFirstPage({required bool showLoading}) async {
    final int loadGeneration = ++_loadGeneration;
    isLoading = showLoading;
    error = null;
    loadMoreError = null;
    isLoadingMore = false;
    if (showLoading) notifyListeners();
    try {
      final RecentNotificationHistoryPage page = await _loadPage();
      if (loadGeneration != _loadGeneration) return;
      entries = _deduplicate(page.entries);
      mostRecentlyLoadedEntries = entries;
      hasMore = page.hasMore && page.nextCursor != null;
      _nextCursor = page.nextCursor;
    } catch (loadError) {
      if (loadGeneration != _loadGeneration) return;
      error = loadError;
      entries = <RecentNotificationHistoryEntry>[];
      mostRecentlyLoadedEntries = <RecentNotificationHistoryEntry>[];
      hasMore = false;
      _nextCursor = null;
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadMore() async {
    if (isLoading ||
        isLoadingMore ||
        !hasMore ||
        _nextCursor == null ||
        error != null) {
      return;
    }
    final int loadGeneration = _loadGeneration;
    isLoadingMore = true;
    loadMoreError = null;
    notifyListeners();
    try {
      List<RecentNotificationHistoryEntry> appended =
          <RecentNotificationHistoryEntry>[];
      do {
        final RecentNotificationHistoryPage page = await _loadPage(
          before: _nextCursor,
        );
        if (loadGeneration != _loadGeneration) return;
        appended = _deduplicate(page.entries, existing: entries);
        entries = <RecentNotificationHistoryEntry>[...entries, ...appended];
        hasMore = page.hasMore && page.nextCursor != null;
        _nextCursor = page.nextCursor;
      } while (appended.isEmpty && hasMore && _nextCursor != null);
      mostRecentlyLoadedEntries = appended;
    } catch (loadError) {
      if (loadGeneration != _loadGeneration) return;
      loadMoreError = loadError;
      mostRecentlyLoadedEntries = <RecentNotificationHistoryEntry>[];
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoadingMore = false;
        notifyListeners();
      }
    }
  }

  void removeTransactionLink(String historyEntryId, String transactionId) {
    final int index = entries.indexWhere(
      (RecentNotificationHistoryEntry entry) =>
          entry.notification.id == historyEntryId &&
          entry.processingOutcome?.transactionId == transactionId,
    );
    if (index == -1) return;
    final RecentNotificationHistoryEntry entry = entries[index];
    entries = List<RecentNotificationHistoryEntry>.of(entries);
    entries[index] = RecentNotificationHistoryEntry(
      notification: entry.notification,
      definition: entry.definition,
      processingFailure: entry.processingFailure,
      matchingRule: entry.matchingRule,
      matchingConditionalActionGroups: entry.matchingConditionalActionGroups,
      canCreateTransaction: entry.canCreateTransaction,
      processingOutcome: entry.processingOutcome!.withoutTransactionLink(),
      currentMatchingRule: entry.currentMatchingRule,
      currentCanCreateTransaction: entry.currentCanCreateTransaction,
    );
    notifyListeners();
  }

  Future<RecentNotificationHistoryPage> _loadPage({
    NotificationHistoryCursor? before,
  }) async {
    if (_history case final PagedRecentNotificationHistoryLoader loader) {
      return loader.loadPage(before: before, limit: pageSize);
    }
    if (before != null) {
      return const RecentNotificationHistoryPage(
        entries: <RecentNotificationHistoryEntry>[],
        hasMore: false,
      );
    }
    return RecentNotificationHistoryPage(
      entries: await _history.load(),
      hasMore: false,
    );
  }

  List<RecentNotificationHistoryEntry> _deduplicate(
    List<RecentNotificationHistoryEntry> candidates, {
    List<RecentNotificationHistoryEntry> existing =
        const <RecentNotificationHistoryEntry>[],
  }) {
    final List<RecentNotificationHistoryEntry> unique =
        <RecentNotificationHistoryEntry>[];
    final Set<String> deliveryIds = existing
        .map((RecentNotificationHistoryEntry entry) => entry.notification.id)
        .toSet();
    final Map<(String, String, String), DateTime> previousDeliveries =
        <(String, String, String), DateTime>{};
    for (final RecentNotificationHistoryEntry entry in existing) {
      final NotificationHistoryEntry notification = entry.notification;
      if (notification.title.trim().isEmpty &&
          notification.body.trim().isEmpty) {
        continue;
      }
      previousDeliveries[(
            notification.applicationId,
            notification.title,
            notification.body,
          )] =
          notification.receivedAt;
    }
    for (final RecentNotificationHistoryEntry candidate in candidates) {
      final NotificationHistoryEntry notification = candidate.notification;
      if (!deliveryIds.add(notification.id)) continue;
      final bool isMetadataOnly =
          notification.title.trim().isEmpty && notification.body.trim().isEmpty;
      if (!isMetadataOnly) {
        final (String, String, String) deliveryKey = (
          notification.applicationId,
          notification.title,
          notification.body,
        );
        final DateTime? previousDelivery = previousDeliveries[deliveryKey];
        previousDeliveries[deliveryKey] = notification.receivedAt;
        if (previousDelivery != null &&
            previousDelivery.difference(notification.receivedAt).abs() <=
                const Duration(seconds: 1)) {
          continue;
        }
      }
      unique.add(candidate);
    }
    return unique;
  }
}
