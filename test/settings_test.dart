import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:waterflyiii/settings.dart';

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
        },
      );
      testSettings.defaultAccountId = "1234";
      expect(
        testSettings.toJson(),
        <String, dynamic>{
          "appName": "debug.test.app",
          "defaultAccountId": "1234",
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
      final NotificationAppSettings testSettings2 =
          NotificationAppSettings.fromJson(<String, dynamic>{
        "appName": "debug.test.app",
        "defaultAccountId": "1234",
      });
      expect(testSettings2.appName, "debug.test.app");
      expect(testSettings2.defaultAccountId, "1234");
    });
  });

  late SettingsProvider settings;
  group("SettingsProvider", () {
    setUp(() {
      SharedPreferences.setMockInitialValues(const <String, Object>{});
      settings = SettingsProvider();
    });
    test("is not yet initialized", () {
      expect(settings.loaded, false);
    });
    test("load initial values", () async {
      await settings.loadSettings();
      expect(settings.loaded, true);
      expect(settings.getTheme, ThemeMode.system);
      expect(settings.getLocale, null);
      expect(settings.notificationApps, isEmpty);
    });
    test("setTheme", () async {
      await settings.setTheme(ThemeMode.dark);
      expect(settings.getTheme, ThemeMode.dark);
      await settings.setTheme(ThemeMode.light);
      expect(settings.getTheme, ThemeMode.light);
      await settings.setTheme(ThemeMode.system);
      expect(settings.getTheme, ThemeMode.system);
    });
    test("setLocale", () async {
      await settings.setLocale(const Locale("en"));
      expect(settings.getLocale, const Locale("en"));
      await settings.setLocale(const Locale("de"));
      expect(settings.getLocale, const Locale("de"));
      // Locale "asdf" does not exit, should return last valid one
      await settings.setLocale(const Locale("asdf"));
      expect(settings.getLocale, const Locale("de"));
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
          completion(
              containsAll(<String>["debug.test.app", "debug.test.other"])),
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
      await expectLater(
        settings.notificationAddUsedApp("debug.test.app"),
        completion(isTrue),
      );
      expect(settings.notificationApps, contains("debug.test.app"));
      expect(settings.notificationApps, hasLength(1));
      await expectLater(
        settings.notificationAddUsedApp("debug.test.app"),
        completion(isFalse),
      );
      expect(settings.notificationApps, contains("debug.test.app"));
      expect(settings.notificationApps, hasLength(1));
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
      await settings.notificationAddUsedApp("debug.test.app");
      await expectLater(
        settings.notificationRemoveUsedApp("debug.test.app"),
        completion(isTrue),
      );
      expect(settings.notificationApps, isEmpty);
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
    });

    test("notificationSetAppSettings", () async {
      await settings.notificationSetAppSettings(
        "debug.test.app",
        NotificationAppSettings("debug.test.app", defaultAccountId: "1234"),
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
      await settings.notificationSetAppSettings(
        "debug.test.app",
        NotificationAppSettings("debug.test.app", defaultAccountId: "4567"),
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
    });
  });
}
