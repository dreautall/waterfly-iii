import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';

class RecentNotificationsViewModel extends ChangeNotifier {
  RecentNotificationsViewModel(this._history);

  final RecentNotificationHistoryLoader _history;

  List<RecentNotificationHistoryEntry> entries =
      <RecentNotificationHistoryEntry>[];
  Object? error;
  bool isLoading = false;
  int _loadGeneration = 0;

  Future<void> load() => _load(showLoading: true);

  Future<void> refresh() => _load(showLoading: false);

  Future<void> _load({required bool showLoading}) async {
    final int loadGeneration = ++_loadGeneration;
    isLoading = showLoading;
    error = null;
    if (showLoading) notifyListeners();
    try {
      final List<RecentNotificationHistoryEntry> loadedEntries = await _history
          .load();
      if (loadGeneration != _loadGeneration) return;
      entries = loadedEntries;
    } catch (loadError) {
      if (loadGeneration != _loadGeneration) return;
      error = loadError;
      entries = <RecentNotificationHistoryEntry>[];
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
