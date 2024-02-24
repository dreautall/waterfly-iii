import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:syncfusion_flutter_charts/charts.dart" show SortingOrder;

import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/pages/bills.dart' show BillsLayout, BillsSort;

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  group("NotificationAppSettings", () {
    test("toJson", () {
      final NotificationAppSettings testSettings =
          NotificationAppSettings("debug.test.app");
      expect(
        testSettings.toJson(),
        <String, dynamic>{
          "appName": "debug.test.app",
          "defaultAccountId": null,
          "includeTitle": true,
        },
      );
      testSettings.defaultAccountId = "1234";
      testSettings.includeTitle = false;
      expect(
        testSettings.toJson(),
        <String, dynamic>{
          "appName": "debug.test.app",
          "defaultAccountId": "1234",
          "includeTitle": false,
        },
      );
    });
    test("fromJson", () {
      final NotificationAppSettings testSettings1 =
          NotificationAppSettings.fromJson(<String, dynamic>{
        "appName": "debug.test.app",
        "defaultAccountId": null,
      });
      expect(testSettings1.appName, "debug.test.app");
      expect(testSettings1.defaultAccountId, isNull);
      expect(testSettings1.includeTitle, true);
      final NotificationAppSettings testSettings2 =
          NotificationAppSettings.fromJson(<String, dynamic>{
        "appName": "debug.test.app",
        "defaultAccountId": "1234",
        "includeTitle": false,
      });
      expect(testSettings2.appName, "debug.test.app");
      expect(testSettings2.defaultAccountId, "1234");
      expect(testSettings2.includeTitle, false);
    });
  });

  late SettingsProvider settings;
  group("SettingsProvider", () {
    final MockCallbackFunction notifyListenerCallback = MockCallbackFunction();

    setUp(() {
      SharedPreferences.setMockInitialValues(const <String, Object>{});
      settings = SettingsProvider()..addListener(notifyListenerCallback.call);
      reset(notifyListenerCallback);
    });
    test("is not yet initialized", () {
      expect(settings.loaded, false);
    });
    test("load initial values", () async {
      await settings.loadSettings();
      expect(settings.loaded, true);
      expect(settings.theme, ThemeMode.system);
      expect(settings.dynamicColors, false);
      expect(settings.useServerTime, true);
      expect(settings.locale, const Locale("en"));
      expect(settings.debug, false);
      expect(settings.lock, false);
      expect(settings.showFutureTXs, false);
      expect(settings.notificationApps, <String>[]);
      expect(settings.billsLayout, BillsLayout.grouped);
      expect(settings.billsSort, BillsSort.name);
      expect(settings.billsSortOrder, SortingOrder.ascending);
      expect(settings.categoriesSumExcluded, <String>[]);
      verify(notifyListenerCallback()).called(1);
    });
    test("setTheme", () async {
      await settings.setTheme(ThemeMode.dark);
      expect(settings.theme, ThemeMode.dark);
      verify(notifyListenerCallback()).called(1);
      await settings.setTheme(ThemeMode.light);
      expect(settings.theme, ThemeMode.light);
      await settings.setTheme(ThemeMode.system);
      expect(settings.theme, ThemeMode.system);

      verify(notifyListenerCallback()).called(2);
    });
    test("setLocale", () async {
      await settings.setLocale(const Locale("en"));
      expect(settings.locale, const Locale("en"));
      verify(notifyListenerCallback()).called(1);
      await settings.setLocale(const Locale("de"));
      expect(settings.locale, const Locale("de"));

      // Locale "asdf" does not exit, should return last valid one
      await settings.setLocale(const Locale("asdf"));
      expect(settings.locale, const Locale("de"));
      verify(notifyListenerCallback()).called(1);
    });
    /*
    // Would need to mock getTemporaryDirectory for it to work
    test("setDebug", () async {
      await settings.setDebug(true);
      expect(settings.debug, true);
      expect(Logger.root.level, Level.ALL);

      verify(notifyListenerCallback()).called(1);
      await settings.setDebug(false);
      expect(settings.debug, false);
      verify(notifyListenerCallback()).called(1);
    });
    */
    test("setLock", () async {
      await settings.setLock(true);
      expect(settings.lock, true);

      verify(notifyListenerCallback()).called(1);
      await settings.setLock(false);
      expect(settings.lock, false);

      await settings.setLock(false);
      verify(notifyListenerCallback()).called(1);
    });
    test("setShowFutureTXs", () async {
      await settings.setShowFutureTXs(true);
      expect(settings.showFutureTXs, true);

      verify(notifyListenerCallback()).called(1);
      await settings.setShowFutureTXs(false);
      expect(settings.showFutureTXs, false);

      await settings.setShowFutureTXs(false);
      verify(notifyListenerCallback()).called(1);
    });
    test("setDynamicColors", () async {
      await settings.setDynamicColors(true);
      expect(settings.dynamicColors, true);

      verify(notifyListenerCallback()).called(1);
      await settings.setDynamicColors(false);
      expect(settings.dynamicColors, false);

      await settings.setDynamicColors(false);
      verify(notifyListenerCallback()).called(1);
    });
    test("setUseServerTime", () async {
      await settings.setUseServerTime(false);
      expect(settings.useServerTime, false);

      verify(notifyListenerCallback()).called(1);
      await settings.setUseServerTime(true);
      expect(settings.useServerTime, true);

      await settings.setUseServerTime(true);
      verify(notifyListenerCallback()).called(1);
    });
    test("notificationAddKnownApp", () async {
      await expectLater(
        settings.notificationAddKnownApp(""),
        completion(isFalse),
      );
      await expectLater(
        settings.notificationAddKnownApp("debug.test.app"),
        completion(isTrue),
      );
      await expectLater(
        settings.notificationAddKnownApp("debug.test.app"),
        completion(isFalse),
      );
    });
    group("notificationKnownApps", () {
      test("filterUsed=false", () async {
        await expectLater(
          settings.notificationKnownApps(),
          completion(isEmpty),
        );
        await settings.notificationAddKnownApp("debug.test.app");
        await expectLater(
          settings.notificationKnownApps(),
          completion(contains("debug.test.app")),
        );
        await expectLater(
          settings.notificationKnownApps(),
          completion(isNot(contains("debug.test.other"))),
        );
      });
      test("filterUsed=true", () async {
        await settings.notificationAddKnownApp("debug.test.app");
        await settings.notificationAddKnownApp("debug.test.other");
        await settings.notificationAddUsedApp("debug.test.other");
        await expectLater(
          settings.notificationKnownApps(filterUsed: true),
          completion(contains("debug.test.app")),
        );
        await expectLater(
          settings.notificationKnownApps(filterUsed: true),
          completion(hasLength(1)),
        );
        await settings.notificationRemoveUsedApp("debug.test.other");
        await expectLater(
          settings.notificationKnownApps(filterUsed: true),
          completion(containsAll(<String>[
            "debug.test.app",
            "debug.test.other",
          ])),
        );
        await expectLater(
          settings.notificationKnownApps(filterUsed: true),
          completion(hasLength(2)),
        );
      });
    });
    test("notificationAddUsedApp", () async {
      expect(settings.notificationApps, isEmpty);
      await expectLater(
        settings.notificationAddUsedApp(""),
        completion(isFalse),
      );
      expect(settings.notificationApps, isEmpty);
      verifyNever(notifyListenerCallback());
      await expectLater(
        settings.notificationAddUsedApp("debug.test.app"),
        completion(isTrue),
      );
      expect(settings.notificationApps, contains("debug.test.app"));
      expect(settings.notificationApps, hasLength(1));
      verify(notifyListenerCallback()).called(1);
      await expectLater(
        settings.notificationAddUsedApp("debug.test.app"),
        completion(isFalse),
      );
      expect(settings.notificationApps, contains("debug.test.app"));
      expect(settings.notificationApps, hasLength(1));
      verifyNever(notifyListenerCallback());
    });
    test("notificationRemoveUsedApp", () async {
      await expectLater(
        settings.notificationRemoveUsedApp(""),
        completion(isFalse),
      );
      await expectLater(
        settings.notificationRemoveUsedApp("debug.test.app"),
        completion(isFalse),
      );
      verifyNever(notifyListenerCallback());
      await settings.notificationAddUsedApp("debug.test.app");
      verify(notifyListenerCallback()).called(1);
      await expectLater(
        settings.notificationRemoveUsedApp("debug.test.app"),
        completion(isTrue),
      );
      expect(settings.notificationApps, isEmpty);
      verify(notifyListenerCallback()).called(1);
    });

    test("notificationUsedApps", () async {
      await expectLater(
        settings.notificationUsedApps(),
        completion(isEmpty),
      );
      await settings.notificationAddUsedApp("debug.test.app");
      await expectLater(
        settings.notificationUsedApps(),
        completion(contains("debug.test.app")),
      );
      await expectLater(
        settings.notificationUsedApps(),
        completion(isNot(contains("debug.test.other"))),
      );
      await settings.notificationRemoveUsedApp("debug.test.app");
      await expectLater(
        settings.notificationUsedApps(),
        completion(isEmpty),
      );
    });
    test("notificationGetAppSettings", () async {
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.appName,
            "appName",
            "debug.test.app",
          ),
        ),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.defaultAccountId,
            "defaultAccountId",
            isNull,
          ),
        ),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.includeTitle,
            "includeTitle",
            isTrue,
          ),
        ),
      );
    });
    test("notificationSetAppSettings", () async {
      await settings.notificationSetAppSettings(
        "debug.test.app",
        NotificationAppSettings("debug.test.app",
            defaultAccountId: "1234", includeTitle: false),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.appName,
            "appName",
            "debug.test.app",
          ),
        ),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.defaultAccountId,
            "defaultAccountId",
            "1234",
          ),
        ),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.includeTitle,
            "includeTitle",
            isFalse,
          ),
        ),
      );
      await settings.notificationSetAppSettings(
        "debug.test.app",
        NotificationAppSettings("debug.test.app",
            defaultAccountId: "4567", includeTitle: true),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.defaultAccountId,
            "defaultAccountId",
            "4567",
          ),
        ),
      );
      await expectLater(
        settings.notificationGetAppSettings("debug.test.app"),
        completion(
          isA<NotificationAppSettings>().having(
            (NotificationAppSettings p0) => p0.includeTitle,
            "includeTitle",
            isTrue,
          ),
        ),
      );
    });

    test("setBillsLayout", () async {
      expect(settings.billsLayout, BillsLayout.grouped);
      await settings.setBillsLayout(BillsLayout.list);
      expect(settings.billsLayout, BillsLayout.list);
      verify(notifyListenerCallback()).called(1);

      await settings.setBillsLayout(BillsLayout.grouped);
      expect(settings.billsLayout, BillsLayout.grouped);

      await settings.setBillsLayout(BillsLayout.grouped);
      verify(notifyListenerCallback()).called(1);
    });
    test("setBillsSort", () async {
      expect(settings.billsSort, BillsSort.name);
      await settings.setBillsSort(BillsSort.frequency);
      expect(settings.billsSort, BillsSort.frequency);
      verify(notifyListenerCallback()).called(1);

      await settings.setBillsSort(BillsSort.name);
      expect(settings.billsSort, BillsSort.name);

      await settings.setBillsSort(BillsSort.name);
      verify(notifyListenerCallback()).called(1);
    });
    test("setBillsSortOrder", () async {
      expect(settings.billsSortOrder, SortingOrder.ascending);
      await settings.setBillsSortOrder(SortingOrder.descending);
      expect(settings.billsSortOrder, SortingOrder.descending);
      verify(notifyListenerCallback()).called(1);

      await settings.setBillsSortOrder(SortingOrder.ascending);
      expect(settings.billsSortOrder, SortingOrder.ascending);

      await settings.setBillsSortOrder(SortingOrder.ascending);
      verify(notifyListenerCallback()).called(1);

      await settings.setBillsSortOrder(SortingOrder.none);
      expect(settings.billsSortOrder, SortingOrder.ascending);
      verifyNever(notifyListenerCallback());
    });
    test("categoryAddSumExcluded", () async {
      expect(settings.categoriesSumExcluded, isEmpty);
      await settings.categoryAddSumExcluded("1234");
      expect(settings.categoriesSumExcluded, contains("1234"));
      expect(settings.categoriesSumExcluded, hasLength(1));
      verify(notifyListenerCallback()).called(1);

      await settings.categoryAddSumExcluded("5678");
      expect(settings.categoriesSumExcluded, contains("1234"));
      expect(settings.categoriesSumExcluded, contains("5678"));
      expect(settings.categoriesSumExcluded, hasLength(2));
      verify(notifyListenerCallback()).called(1);

      await settings.categoryAddSumExcluded("1234");
      expect(settings.categoriesSumExcluded, hasLength(2));
      verifyNever(notifyListenerCallback());

      await settings.categoryAddSumExcluded("");
      expect(settings.categoriesSumExcluded, hasLength(2));
      verifyNever(notifyListenerCallback());
    });
    test("categoryRemoveSumExcluded", () async {
      await settings.categoryAddSumExcluded("1234");
      await settings.categoryAddSumExcluded("5678");
      expect(settings.categoriesSumExcluded, contains("1234"));
      expect(settings.categoriesSumExcluded, contains("5678"));
      expect(settings.categoriesSumExcluded, hasLength(2));
      verify(notifyListenerCallback()).called(2);

      await settings.categoryRemoveSumExcluded("9012");
      expect(settings.categoriesSumExcluded, hasLength(2));
      verifyNever(notifyListenerCallback());

      await settings.categoryRemoveSumExcluded("");
      expect(settings.categoriesSumExcluded, hasLength(2));
      verifyNever(notifyListenerCallback());

      await settings.categoryRemoveSumExcluded("5678");
      expect(settings.categoriesSumExcluded, contains("1234"));
      expect(settings.categoriesSumExcluded, isNot(contains("5678")));
      expect(settings.categoriesSumExcluded, hasLength(1));
      verify(notifyListenerCallback()).called(1);

      await settings.categoryRemoveSumExcluded("1234");
      expect(settings.categoriesSumExcluded, isEmpty);
      verify(notifyListenerCallback()).called(1);
    });
  });
}
