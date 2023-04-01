import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';

import 'package:waterflyiii/app.dart';
import 'package:waterflyiii/pages/transaction_detail.dart';

class NotificationTransaction {
  final String appName;
  final String title;
  final String body;

  NotificationTransaction(this.appName, this.title, this.body);

  NotificationTransaction.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        title = json['title'],
        body = json['body'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': appName,
        'title': title,
        'body': body,
      };
}

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
      payload: jsonEncode(NotificationTransaction(
        evt?.packageName ?? "",
        evt?.title ?? "",
        evt?.text ?? "",
      )),
    );
  });
}

Future<void> nlInit() async {
  debugPrint("nlInit()");
  NotificationServicePlugin.instance.initialize(nlCallback);
}

@pragma('vm:entry-point')
void nlNotificationTap(NotificationResponse notificationResponse) async {
  debugPrint("Pressed notification: $notificationResponse");
  await showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) => const TransactionPage(),
  );
}
