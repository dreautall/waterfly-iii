import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflyiii/notifications/application/stores/notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

class SharedPreferencesNotificationListenerHealthStore
    implements NotificationListenerHealthStore {
  const SharedPreferencesNotificationListenerHealthStore({
    NotificationListenerHealthPreferences? preferences,
  }) : _preferences = preferences;

  static const String storageKey = 'notification_listener_health_issue';

  final NotificationListenerHealthPreferences? _preferences;

  NotificationListenerHealthPreferences get _prefs =>
      _preferences ??
      const SharedPreferencesNotificationListenerHealthPreferences();

  @override
  Future<NotificationListenerHealthIssue?> load() async {
    final String? encoded = await _prefs.getString(storageKey);
    if (encoded == null || encoded.trim().isEmpty) return null;
    return NotificationListenerHealthIssue.fromJson(
      jsonDecode(encoded) as Map<String, dynamic>,
    );
  }

  @override
  Future<NotificationListenerHealthIssue> recordFailure(
    DateTime occurredAt,
  ) async {
    final NotificationListenerHealthIssue? current = await load();
    final NotificationListenerHealthIssue issue = current == null
        ? NotificationListenerHealthIssue(
            firstOccurredAt: occurredAt,
            lastOccurredAt: occurredAt,
            occurrenceCount: 1,
          )
        : current.recordOccurrence(occurredAt);
    await _save(issue);
    return issue;
  }

  @override
  Future<NotificationListenerHealthIssue?> markRecovered(
    DateTime recoveredAt,
  ) async {
    final NotificationListenerHealthIssue? current = await load();
    if (current == null || !current.isActive) return current;
    final NotificationListenerHealthIssue recovered = current.markRecovered(
      recoveredAt,
    );
    await _save(recovered);
    return recovered;
  }

  @override
  Future<void> clear() => _prefs.remove(storageKey);

  Future<void> _save(NotificationListenerHealthIssue issue) =>
      _prefs.setString(storageKey, jsonEncode(issue.toJson()));
}

abstract interface class NotificationListenerHealthPreferences {
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<void> remove(String key);
}

class SharedPreferencesNotificationListenerHealthPreferences
    implements NotificationListenerHealthPreferences {
  const SharedPreferencesNotificationListenerHealthPreferences();

  @override
  Future<String?> getString(String key) =>
      SharedPreferencesAsync().getString(key);

  @override
  Future<void> remove(String key) async {
    await SharedPreferencesAsync().remove(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await SharedPreferencesAsync().setString(key, value);
  }
}
