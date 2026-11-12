import 'dart:ui';

import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';

NotificationFormattingPreferences platformNotificationFormattingPreferences() {
  final PlatformDispatcher dispatcher = PlatformDispatcher.instance;
  return NotificationFormattingPreferences(
    locale: dispatcher.locale.toString(),
    use24HourFormat: dispatcher.alwaysUse24HourFormat,
  );
}
