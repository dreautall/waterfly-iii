import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';

ReceivePort _receivePort = ReceivePort();

@pragma('vm:entry-point')
void nlCallback(NotificationEvent evt) async {
  debugPrint("nlCallback()");
  debugPrint("send evt to ui: $evt");
  if (evt.packageName?.startsWith("com.dreautall.waterflyiii") ?? false) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    flutterLocalNotificationsPlugin.show(
      evt.id ?? 1,
      "Got Event from ${evt.packageName}",
      evt.message,
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
      payload: evt.text,
    );
  }
  final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
  if (send == null) debugPrint("can't find the sender");
  send?.send(evt);
}

Future<void> nlInit() async {
  debugPrint("nlInit()");
  NotificationsListener.initialize(callbackHandle: nlCallback);

  // this can fix restart<debug> can't handle error
  IsolateNameServer.removePortNameMapping("_listener_");
  IsolateNameServer.registerPortWithName(_receivePort.sendPort, "_listener_");
  _receivePort.listen((dynamic message) => nlOnData(message));

  // don't use the default receivePort
  // NotificationsListener.receivePort.listen((evt) => onData(evt));

  bool isRunning = (await NotificationsListener.isRunning) ?? false;
  debugPrint("""Service is ${!isRunning ? "not " : ""}already running""");
}

void nlOnData(NotificationEvent event) {
  debugPrint("nlOnData()");
  debugPrint(event.toString());
}
