import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_post_permission_requester.dart';

class PlatformNotificationPostPermissionRequester
    implements NotificationPostPermissionRequester {
  const PlatformNotificationPostPermissionRequester();

  @override
  Future<bool> requestPermission() async {
    if (!Platform.isAndroid) return false;
    return await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        false;
  }
}
