import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';

import 'package:waterflyiii/app.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("NotificationListener");

class NotificationTransaction {
  NotificationTransaction(
    this.appName,
    this.title,
    this.body,
    this.date,
  );

  final String appName;
  final String title;
  final String body;
  final DateTime date;

  NotificationTransaction.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        title = json['title'],
        body = json['body'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': appName,
        'title': title,
        'body': body,
        'date': date.toIso8601String(),
      };
}

class NotificationListenerStatus {
  NotificationListenerStatus(
    this.servicePermission,
    this.serviceRunning,
    this.notificationPermission,
  );

  final bool servicePermission;
  final bool serviceRunning;
  final bool notificationPermission;
}

final RegExp rFindMoney = RegExp(
    r'(?:^|\s)(?<preCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})\s*(?<amount>[.,\d]+(?:[.,]\d+)?)\s*(?<postCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})(?:$|\s)');

Future<NotificationListenerStatus> nlStatus() async {
  return NotificationListenerStatus(
      await NotificationServicePlugin.instance.isServicePermissionGranted(),
      await NotificationServicePlugin.instance.isServiceRunning(),
      await FlutterLocalNotificationsPlugin()
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()!
              .areNotificationsEnabled() ??
          false);
}

@pragma('vm:entry-point')
void nlCallback() async {
  log.finest(() => "nlCallback()");
  NotificationServicePlugin.instance
      .executeNotificationListener((NotificationEvent? evt) async {
    if (evt?.packageName?.startsWith("com.dreautall.waterflyiii") ?? false) {
      return;
    }
    if (evt?.state == NotificationState.remove) {
      return;
    }

    final Iterable<RegExpMatch> matches =
        rFindMoney.allMatches(evt?.text ?? "");
    if (matches.isEmpty) {
      log.finer(() => "nlCallback(${evt?.packageName}): no money found");
      return;
    }

    bool validMatch = false;
    for (RegExpMatch match in matches) {
      if ((match.namedGroup("postCurrency")?.isNotEmpty ?? false) ||
          (match.namedGroup("preCurrency")?.isNotEmpty ?? false)) {
        validMatch = true;
        break;
      }
    }
    if (!validMatch) {
      log.finer(() =>
          "nlCallback(${evt?.packageName}): no money with currency found");
      return;
    }

    SettingsProvider().notificationAddKnownApp(evt?.packageName ?? "");

    if (!(await SettingsProvider().notificationUsedApps(forceReload: true))
        .contains(evt?.packageName ?? "")) {
      log.finer(() => "nlCallback(${evt?.packageName}): app not used");
      return;
    }

    FlutterLocalNotificationsPlugin().show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "Create Transaction?",
      "Click to create a transaction based on the notification ${evt?.title}",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'extract_transaction',
          'Create Transaction from Notification',
          channelDescription:
              'Notification asking to create a transaction from another Notification.',
          importance: Importance.low, // Android 8.0 and higher
          priority: Priority.low, // Android 7.1 and lower
        ),
      ),
      payload: jsonEncode(NotificationTransaction(
        evt?.packageName ?? "",
        evt?.title ?? "",
        evt?.text ?? "",
        DateTime.tryParse(evt?.postTime ?? "") ?? DateTime.now(),
      )),
    );
  });
}

Future<void> nlInit() async {
  log.finest(() => "nlInit()");
  await NotificationServicePlugin.instance.initialize(nlCallback);
}

Future<void> nlNotificationTap(
    NotificationResponse notificationResponse) async {
  log.finest(() => "nlNotificationTap()");
  if (notificationResponse.payload?.isEmpty ?? true) {
    return;
  }
  await showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) => TransactionPage(
      notification: NotificationTransaction.fromJson(
        jsonDecode(notificationResponse.payload!),
      ),
    ),
  );
}
