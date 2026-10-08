import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/data/repositories/shared_preferences_notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

class _Preferences implements NotificationListenerHealthPreferences {
  final Map<String, String> values = <String, String>{};

  @override
  Future<String?> getString(String key) async => values[key];

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }
}

void main() {
  test('aggregates failures and preserves recovery until cleared', () async {
    final SharedPreferencesNotificationListenerHealthStore store =
        SharedPreferencesNotificationListenerHealthStore(
          preferences: _Preferences(),
        );
    final DateTime first = DateTime.utc(2026, 10, 1, 8);
    final DateTime second = DateTime.utc(2026, 10, 1, 9);
    final DateTime recovered = DateTime.utc(2026, 10, 1, 10);

    await store.recordFailure(first);
    await store.recordFailure(second);
    final NotificationListenerHealthIssue? issue = await store.markRecovered(
      recovered,
    );

    expect(issue?.firstOccurredAt, first);
    expect(issue?.lastOccurredAt, second);
    expect(issue?.occurrenceCount, 2);
    expect(issue?.recoveredAt, recovered);
    expect((await store.load())?.isActive, isFalse);

    await store.clear();
    expect(await store.load(), isNull);
  });

  test('persists only operational incident metadata', () async {
    final _Preferences preferences = _Preferences();
    final SharedPreferencesNotificationListenerHealthStore store =
        SharedPreferencesNotificationListenerHealthStore(
          preferences: preferences,
        );
    await store.recordFailure(DateTime.utc(2026, 10, 1));

    final String? encoded = preferences
        .values[SharedPreferencesNotificationListenerHealthStore.storageKey];
    final Map<String, dynamic> persisted =
        jsonDecode(encoded!) as Map<String, dynamic>;

    expect(
      persisted.keys,
      unorderedEquals(<String>[
        'firstOccurredAt',
        'lastOccurredAt',
        'occurrenceCount',
        'recoveredAt',
      ]),
    );
  });
}
