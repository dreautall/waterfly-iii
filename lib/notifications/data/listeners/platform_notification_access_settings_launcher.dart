import 'dart:io';

import 'package:flutter/services.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';

class PlatformNotificationAccessSettingsLauncher
    implements NotificationAccessSettingsLauncher {
  const PlatformNotificationAccessSettingsLauncher({
    MethodChannel channel = const MethodChannel(
      'waterflyiii/notification_settings',
    ),
  }) : _channel = channel;

  final MethodChannel _channel;

  @override
  Future<bool> openNotificationAccessSettings() async {
    if (!Platform.isAndroid) return false;
    return await _channel.invokeMethod<bool>(
          'openNotificationListenerSettings',
        ) ??
        false;
  }
}
