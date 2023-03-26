import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

ReceivePort? _receivePort;

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void bgsvcStartCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(NotificationTaskHandler());
}

void bgsvcInit() {
  debugPrint("bgsvcInit()");
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'waterflyiii_foreground_task',
      channelName: 'Background Notification Listener',
      channelDescription: 'Notification Listener to extract payment data.',
      channelImportance: NotificationChannelImportance.NONE,
      priority: NotificationPriority.MIN,
    ),
    iosNotificationOptions: const IOSNotificationOptions(),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 5000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: false,
      allowWifiLock: false,
    ),
  );
}

Future<bool> bgsvcStart() async {
  debugPrint("bgsvcStart()");
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // onNotificationPressed function to be called.
  //
  // When the notification is pressed while permission is denied,
  // the onNotificationPressed function is not called and the app opens.
  //
  // If you do not use the onNotificationPressed or launchApp function,
  // you do not need to write this code.
  if (!await FlutterForegroundTask.canDrawOverlays) {
    /*final bool isGranted =
        await FlutterForegroundTask.openSystemAlertWindowSettings();
    if (!isGranted) {
      debugPrint('SYSTEM_ALERT_WINDOW permission denied!');
      return false;
    }*/
  }

  // You can save data using the saveData function.
  //await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

  // Register the receivePort before starting the service.
  final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
  final bool isRegistered = bgsvcRegisterReceivePort(receivePort);
  if (!isRegistered) {
    debugPrint('Failed to register receivePort!');
    return false;
  }

  if (await FlutterForegroundTask.isRunningService) {
    return FlutterForegroundTask.restartService();
  } else {
    return FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      callback: bgsvcStartCallback,
    );
  }
}

Future<bool> bgsvcStop() {
  debugPrint("bgsvcStop()");
  return FlutterForegroundTask.stopService();
}

bool bgsvcRegisterReceivePort(ReceivePort? newReceivePort) {
  debugPrint("bgsvcRegisterReceivePort()");
  if (newReceivePort == null) {
    return false;
  }

  _receivePort?.close();

  _receivePort = newReceivePort;
  _receivePort?.listen((dynamic message) {
    debugPrint("got message: $message");
    if (message is int) {
      debugPrint('eventCount: $message');
    } else if (message is String) {
      debugPrint("string: $message");
    } else if (message is DateTime) {
      debugPrint('timestamp: ${message.toString()}');
    }
  });

  return _receivePort != null;
}

class NotificationTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  //int _eventCount = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    'waterflyiii_debug',
    'Debug Notificiations',
    channelDescription: 'Debugging stuff',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    debugPrint("NotificationTaskHandler->onStart()");
    NotificationListenerService.notificationsStream
        .listen((ServiceNotificationEvent event) async {
      debugPrint("Current notification: $event");
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      await flutterLocalNotificationsPlugin.show(
        0,
        event.title,
        event.packageName,
        NotificationDetails(android: androidNotificationDetails),
        payload: event.toString(),
      );
    });
    _sendPort = sendPort;

    // You can use the getData function to get the stored data.
    /*final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    debugPrint('customData: $customData');*/
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    //debugPrint("NotificationTaskHandler->onEvent()");
    // Send data to the main isolate.
    //sendPort?.send(_eventCount);

    //_eventCount++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    debugPrint("NotificationTaskHandler->onDestroy()");
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onButtonPressed(String id) {
    // Called when the notification button on the Android platform is pressed.
    debugPrint("NotificationTaskHandler->onButtonPressed($id)");
  }

  @override
  void onNotificationPressed() {
    // Called when the notification itself on the Android platform is pressed.
    //
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // this function to be called.
    debugPrint("NotificationTaskHandler->onNotificationPressed()");

    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.
    _sendPort?.send('onNotificationPressed');
  }
}
