import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';

class SharedPreferencesNotificationProcessingSettingsStore
    implements NotificationProcessingSettingsStore {
  const SharedPreferencesNotificationProcessingSettingsStore({
    SharedPreferencesAsync? preferences,
  }) : _preferences = preferences;

  static const String _settingsKey = 'notification_processing_settings';

  final SharedPreferencesAsync? _preferences;

  SharedPreferencesAsync get _prefs => _preferences ?? SharedPreferencesAsync();

  @override
  Future<NotificationProcessingSettings> load() async {
    final String? encoded = await _prefs.getString(_settingsKey);
    if (encoded == null || encoded.trim().isEmpty) {
      return NotificationProcessingSettings.defaults;
    }
    try {
      return NotificationProcessingSettings.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
    } catch (_) {
      return NotificationProcessingSettings.defaults;
    }
  }

  @override
  Future<void> save(NotificationProcessingSettings settings) =>
      _prefs.setString(_settingsKey, jsonEncode(settings.toJson()));

  @override
  Future<void> reset() => save(NotificationProcessingSettings.defaults);
}
