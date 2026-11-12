import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';

class PlatformNotificationListenerStatusLoader
    implements NotificationListenerStatusLoader {
  const PlatformNotificationListenerStatusLoader();

  @override
  Future<NotificationListenerStatus> load() async {
    if (!Platform.isAndroid) {
      return const NotificationListenerStatus(false, false, false);
    }
    return NotificationListenerStatus(
      await NotificationServicePlugin.instance.isServicePermissionGranted(),
      await NotificationServicePlugin.instance.isServiceRunning(),
      await FlutterLocalNotificationsPlugin()
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()!
              .areNotificationsEnabled() ??
          false,
    );
  }
}
