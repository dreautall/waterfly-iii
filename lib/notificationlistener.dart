import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:notifications_listener_service/notifications_listener_service.dart';

@pragma('vm:entry-point')
void nlCallback() async {
  debugPrint("nlCallback()");
  NotificationServicePlugin.instance
      .executeNotificationListener((NotificationEvent? evt) async {
    debugPrint("got event $evt");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (evt?.packageName?.startsWith("com.dreautall.waterflyiii") ?? false) {
      return;
    }
    if (evt?.state == NotificationState.remove) {
      return;
    }
    flutterLocalNotificationsPlugin.show(
      evt?.id ?? 1,
      "Got Event from ${evt?.packageName}",
      evt?.tag,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'waterflyiii_debug',
          'Debug Notificiations',
          channelDescription: 'Debugging stuff',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ticker: 'ticker',
        ),
      ),
      payload: evt?.key,
    );
  });
}

Future<void> nlInit() async {
  debugPrint("nlInit()");
  NotificationServicePlugin.instance.initialize(nlCallback);
}
