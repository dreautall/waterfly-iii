import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:test/test.dart';

import 'package:mockito/mockito.dart';

import 'package:waterflyiii/notificationlistener.dart';

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  group("NotificationTransaction", () {
    late NotificationTransaction testTX;
    setUp(() {
      testTX = NotificationTransaction(
        "debug.test.app",
        "DEBUG TEST APP",
        "DEBUG TEST BODY",
        DateTime(2017, 9, 7, 17, 30, 15, 20, 25),
      );
    });

    test("toJson", () {
      expect(
        testTX.toJson(),
        <String, dynamic>{
          "appName": "debug.test.app",
          "title": "DEBUG TEST APP",
          "body": "DEBUG TEST BODY",
          "date": "2017-09-07T17:30:15.020025",
        },
      );
    });
    test("fromJson", () {
      final NotificationTransaction testTXParse =
          NotificationTransaction.fromJson(<String, dynamic>{
        "appName": "debug.test.app",
        "title": "DEBUG TEST APP",
        "body": "DEBUG TEST BODY",
        "date": "2017-09-07T17:30:15.020025",
      });
      expect(testTXParse.appName, "debug.test.app");
      expect(testTXParse.title, "DEBUG TEST APP");
      expect(testTXParse.body, "DEBUG TEST BODY");
      expect(testTXParse.date, DateTime(2017, 9, 7, 17, 30, 15, 20, 25));
    });
  });

  group("rFindMoney", () {
    final List<String> testStrings = <String>[
      // Generic Tests
      "PRETEXT PRETEXT €12,34 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT €12.34 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT €1 230,44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT €1.230,44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT €1,230.44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 12,34€ POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 12.34€ POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1 230,44€ POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1.230,44€ POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1,230.44€ POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT € 12,34 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT € 12.34 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT € 1 230,44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT € 1.230,44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT € 1,230.44 POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 12,34 € POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 12.34 € POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1 230,44 € POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1.230,44 € POSTTEXT POSTTEXT",
      "PRETEXT PRETEXT 1,230.44 € POSTTEXT POSTTEXT",

      // Google Pay
      "€12.34 with Card •••• 9876",
      // AMEX
      "Sie haben €12,34 bei Some Store mit Ihrer American Express Karte mit den Enziffern 98765 ausgegeben.",
      // Raiffeisen UA, via mail May 01, 2023 - FAILS!
      //"07.09.17 17:30 Credit Card Virtual*9876\nсплата за товар/послугу 9876.54 UAH LIQ-PAYDEMSOKIRA GO. Доступна сума: 12.34 UAH",
      // Rabobank, via mail Jun 26, 2023
      "€ 12,34 afgeschreven van *123. Jouw actuele saldo is € +987,65.",
      // Wave, via mail Jul 01, 2023
      "Vous avez envoyé 1.234F\nA Some Store (987654321)\n07/09/2017 à 17h30\nFrais 1234F\nNouveau solde: 9.876F\nAvec ABC\nABCDEFGHIJKL",
      // Amazon Pay, via mail Aug 10, 2023
      "Payment of Rs 12.34 using Amazon Pay Balance is successful at Amazon.in. Updated Balance: Rs 9876.54. For help/stmt: https://www.example.com/cstxn",
      // Tangerine, via mail Jan 4, 2024
      "A purchase of €12.34 made using your Tangerine Credit Card at Some Store on September 07, 2017",
    ];

    final List<String> validCurrencies = <String>["€", "F", "Rs", "UAH"];
    final List<double> validAmounts = <double>[12.34, 123.4, 1234, 1230.44];
    setUp(() {});
    for (String s in testStrings) {
      test(s, () {
        RegExpMatch? validMatch;

        final Iterable<RegExpMatch> matches = rFindMoney.allMatches(s);

        expect(matches, isNotEmpty);
        if (matches.isEmpty) {
          return;
        }
        for (RegExpMatch match in matches) {
          if ((match.namedGroup("postCurrency")?.isNotEmpty ?? false) ||
              (match.namedGroup("preCurrency")?.isNotEmpty ?? false)) {
            validMatch = match;
            break;
          }
        }
        expect(validMatch, isNotNull);
        if (validMatch == null) {
          return;
        }
        // extract currency
        String currencyStr = validMatch.namedGroup("preCurrency") ?? "";
        String currencyStrAlt = validMatch.namedGroup("postCurrency") ?? "";
        if (currencyStr.isEmpty) {
          currencyStr = currencyStrAlt;
        }
        expect(validCurrencies, contains(currencyStr));

        // extract amount
        late double amount;
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
        expect(validAmounts, contains(amount));
      });
    }
  });

  group("nlStatus", () {
    late Function(bool, bool, bool) fn;
    setUp(() {
      fn = (bool enabled, bool permission, bool running) {
        TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('dexterous.com/flutter/local_notifications'),
          (MethodCall methodCall) async {
            if (methodCall.method == "areNotificationsEnabled") {
              return enabled;
            }
            return false;
          },
        );
        TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel(
              'notifications_listener_service/RUN_NATIVE_FOREGROUND_METHOD'),
          (MethodCall methodCall) async {
            if (methodCall.method == "isExist") {
              // Just a test if we're listening
              return true;
            }
            if (methodCall.method == "isServiceRunning") {
              return running;
            }
            if (methodCall.method == "isNotificationPermissionGranted") {
              return permission;
            }
            return false;
          },
        );
      };
      TestWidgetsFlutterBinding.ensureInitialized();
    });
    test("status off", () async {
      fn(false, false, false);
      final NotificationListenerStatus status = await nlStatus();
      expect(status.notificationPermission, false);
      expect(status.servicePermission, false);
      expect(status.serviceRunning, false);
    });
    test("+ notification permission", () async {
      fn(true, false, false);
      final NotificationListenerStatus status = await nlStatus();
      expect(status.notificationPermission, true);
      expect(status.servicePermission, false);
      expect(status.serviceRunning, false);
    });
    test("+ service permission", () async {
      fn(true, true, false);
      final NotificationListenerStatus status = await nlStatus();
      expect(status.notificationPermission, true);
      expect(status.servicePermission, true);
      expect(status.serviceRunning, false);
    });
    test("+ service running", () async {
      fn(true, true, true);
      final NotificationListenerStatus status = await nlStatus();
      expect(status.notificationPermission, true);
      expect(status.servicePermission, true);
      expect(status.serviceRunning, true);
    });
  });
}
