import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:waterflyiii/app.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
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
    r'(?:^|\s)(?<preCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})\s*(?<amount>\d[.,\s\d]+(?:[.,]\d+)?)\s*(?<postCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})(?:$|\s)');

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
    if (evt == null || evt.packageName == null) {
      return;
    }
    if (evt.packageName?.startsWith("com.dreautall.waterflyiii") ?? false) {
      return;
    }
    if (evt.state == NotificationState.remove) {
      return;
    }

    final Iterable<RegExpMatch> matches = rFindMoney.allMatches(evt.text ?? "");
    if (matches.isEmpty) {
      log.finer(() => "nlCallback(${evt.packageName}): no money found");
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
      log.finer(
          () => "nlCallback(${evt.packageName}): no money with currency found");
      return;
    }

    final SettingsProvider settings = SettingsProvider();

    settings.notificationAddKnownApp(evt.packageName!);

    if (!(await settings.notificationUsedApps()).contains(evt.packageName)) {
      log.finer(() => "nlCallback(${evt.packageName}): app not used");
      return;
    }

    final NotificationAppSettings appSettings =
        await settings.notificationGetAppSettings(evt.packageName!);
    bool showNotification = true;

    if (appSettings.autoAdd) {
      tz.initializeTimeZones();
      log.finer(() =>
          "nlCallback(${evt.packageName}): trying to auto-add transaction");
      try {
        final FireflyService ffService = FireflyService();
        if (!await ffService.signInFromStorage()) {
          throw UnauthenticatedResponse;
        }
        final FireflyIii api = ffService.api;
        final CurrencyRead localCurrency = ffService.defaultCurrency;
        late CurrencyRead? currency;
        late double amount;

        (currency, amount) =
            await parseNotificationText(api, evt.text!, localCurrency);
        // Fallback solution
        currency ??= localCurrency;

        // Set date
        DateTime date = ffService.tzHandler
            .notificationTXTime(
                DateTime.tryParse(evt.postTime ?? "") ?? DateTime.now())
            .toLocal();
        String note = "";
        if (appSettings.autoAdd) {
          note = evt.text ?? "";
        }

        // Check currency
        if (currency != localCurrency) {
          throw Exception("Can't auto-add TX with foreign currency");
        }

        // Check account
        if (appSettings.defaultAccountId == null) {
          throw Exception("Can't auto-add TX with no default account ID");
        }

        final TransactionStore newTx = TransactionStore(
          groupTitle: null,
          transactions: <TransactionSplitStore>[
            TransactionSplitStore(
              type: TransactionTypeProperty.withdrawal,
              date: date,
              amount: amount.toString(),
              description: evt.title!,
              // destinationId
              // destinationName
              notes: note,
              order: 0,
              sourceId: appSettings.defaultAccountId,
            )
          ],
          applyRules: true,
          fireWebhooks: true,
          errorIfDuplicateHash: true,
        );
        final Response<TransactionSingle> resp =
            await api.v1TransactionsPost(body: newTx);
        if (!resp.isSuccessful || resp.body == null) {
          try {
            ValidationErrorResponse valError = ValidationErrorResponse.fromJson(
              json.decode(resp.error.toString()),
            );
            throw Exception(valError.message);
          } catch (_) {
            throw Exception("unknown");
          }
        }

        FlutterLocalNotificationsPlugin().show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          "Transaction created",
          "Transaction created based on notification ${evt.title}",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'extract_transaction_created',
              'Transaction from Notification Created',
              channelDescription:
                  'Notification that a Transaction has been created from another Notification.',
              importance: Importance.low, // Android 8.0 and higher
              priority: Priority.low, // Android 7.1 and lower
            ),
          ),
          payload: "",
        );

        showNotification = false;
      } catch (e, stackTrace) {
        log.severe("Error while auto-adding transaction", e, stackTrace);
        showNotification = true;
      }
    }

    if (showNotification) {
      FlutterLocalNotificationsPlugin().show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        "Create Transaction?",
        "Click to create a transaction based on the notification ${evt.title}",
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
          evt.packageName ?? "",
          evt.title ?? "",
          evt.text ?? "",
          DateTime.tryParse(evt.postTime ?? "") ?? DateTime.now(),
        )),
      );
    }
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

Future<(CurrencyRead?, double)> parseNotificationText(
    FireflyIii api, String notificationBody, CurrencyRead localCurrency) async {
  CurrencyRead? currency;
  double amount = 0;
  // Try to extract some money
  final Iterable<RegExpMatch> matches = rFindMoney.allMatches(notificationBody);
  if (matches.isNotEmpty) {
    RegExpMatch? validMatch;
    for (RegExpMatch match in matches) {
      if ((match.namedGroup("postCurrency")?.isNotEmpty ?? false) ||
          (match.namedGroup("preCurrency")?.isNotEmpty ?? false)) {
        validMatch = match;
        break;
      }
    }
    if (validMatch != null) {
      // extract currency
      String currencyStr = validMatch.namedGroup("preCurrency") ?? "";
      String currencyStrAlt = validMatch.namedGroup("postCurrency") ?? "";
      if (currencyStr.isEmpty) {
        currencyStr = currencyStrAlt;
      }
      if (currencyStr.isEmpty) {
        log.warning("no currency found");
      }
      if (localCurrency.attributes.code == currencyStr ||
          localCurrency.attributes.symbol == currencyStr ||
          localCurrency.attributes.code == currencyStrAlt ||
          localCurrency.attributes.symbol == currencyStrAlt) {
      } else {
        final Response<CurrencyArray> response = await api.v1CurrenciesGet();
        if (!response.isSuccessful || response.body == null) {
          log.warning("api currency fetch failed");
        } else {
          for (CurrencyRead cur in response.body!.data) {
            if (cur.attributes.code == currencyStr ||
                cur.attributes.symbol == currencyStr ||
                cur.attributes.code == currencyStrAlt ||
                cur.attributes.symbol == currencyStrAlt) {
              currency = cur;
              break;
            }
          }
        }
      }
      // extract amount
      // Check if string has a decimal separator
      final String amountStr =
          (validMatch.namedGroup("amount") ?? "").replaceAll(" ", "");
      final int decimalSepPos = amountStr.length >= 3 &&
              (amountStr[amountStr.length - 3] == "." ||
                  amountStr[amountStr.length - 3] == ",")
          ? amountStr.length - 3
          : amountStr.length - 2;
      final String decimalSep =
          amountStr.length >= decimalSepPos && decimalSepPos > 0
              ? amountStr[decimalSepPos]
              : "";
      if (decimalSep == "," || decimalSep == ".") {
        final double wholes = double.tryParse(amountStr
                .substring(0, decimalSepPos)
                .replaceAll(",", "")
                .replaceAll(".", "")) ??
            0;
        final String decStr = amountStr
            .substring(decimalSepPos + 1)
            .replaceAll(",", "")
            .replaceAll(".", "");
        final double dec = double.tryParse(decStr) ?? 0;
        amount = decStr.length == 1 ? wholes + dec / 10 : wholes + dec / 100;
      } else {
        amount = double.tryParse(
                amountStr.replaceAll(",", "").replaceAll(".", "")) ??
            0;
      }
    } else {
      log.info("no currency was found");
    }
  } else {
    log.warning("regex did not match");
  }

  return (currency, amount);
}
