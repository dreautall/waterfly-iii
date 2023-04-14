import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationAppSettings {
  NotificationAppSettings(
    this.appName, {
    this.defaultAccountName,
    this.defaultAccountId,
  });

  final String appName;
  final String? defaultAccountName;
  final String? defaultAccountId;

  NotificationAppSettings.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        defaultAccountName = json['defaultAccountName'],
        defaultAccountId = json['defaultAccountId'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': appName,
        'defaultAccountName': defaultAccountName,
        'defaultAccountId': defaultAccountId,
      };
}

class SettingsProvider with ChangeNotifier {
  static const String settingTheme = "THEME";
  static const String settingThemeDark = "DARK";
  static const String settingThemeLight = "LIGHT";
  static const String settingThemeSystem = "SYSTEM";
  static const String settingLocale = "LOCALE";
  static const String settingNLKnownApps = "NL_KNOWNAPPS";
  static const String settingNLUsedApps = "NL_USEDAPPS";
  static const String settingNLAppPrefix = "NL_APP_";

  ThemeMode _theme = ThemeMode.system;
  ThemeMode get getTheme => _theme;

  Locale? _locale;
  Locale? get getLocale => _locale;

  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("reading prefs!");

    final String theme = prefs.getString(settingTheme) ?? "unset";
    debugPrint("read theme $theme");
    switch (theme) {
      case settingThemeDark:
        _theme = ThemeMode.dark;
        break;
      case settingThemeLight:
        _theme = ThemeMode.light;
        break;
      case settingThemeSystem:
      default:
        _theme = ThemeMode.system;
    }

    final Locale locale = Locale.fromSubtags(
      languageCode: prefs.getString(settingLocale) ?? "unset",
    );
    debugPrint("read locale $locale");
    if (S.supportedLocales.contains(locale)) {
      _locale = locale;
    }

    _loaded = true;
    debugPrint("notify SettingsProvider->loadSettings()");
    notifyListeners();
  }

  void setTheme(ThemeMode theme) async {
    _theme = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (theme) {
      case ThemeMode.dark:
        prefs.setString(settingTheme, settingThemeDark);
        break;
      case ThemeMode.light:
        prefs.setString(settingTheme, settingThemeLight);
        break;
      case ThemeMode.system:
      default:
        prefs.setString(settingTheme, settingThemeSystem);
    }

    debugPrint("notify SettingsProvider->setTheme()");
    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (!S.supportedLocales.contains(locale)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = locale;
    prefs.setString(settingLocale, locale.languageCode);

    debugPrint("notify SettingsProvider->setLocale()");
    notifyListeners();
  }

  void notificationAddKnownApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLKnownApps) ?? <String>[];

    if (packageName.isEmpty || apps.contains(packageName)) {
      return;
    }

    apps.add(packageName);
    prefs.setStringList(settingNLKnownApps, apps);

    debugPrint("notify SettingsProvider->notificationAddKnownApp()");
    notifyListeners();
  }

  Future<List<String>> notificationKnownApps({bool filterUsed = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLKnownApps) ?? <String>[];
    if (filterUsed) {
      final List<String> knownApps = await notificationUsedApps();
      return apps
          .where((String element) => !knownApps.contains(element))
          .toList();
    }

    return apps;
  }

  void notificationAddUsedApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLUsedApps) ?? <String>[];

    if (packageName.isEmpty || apps.contains(packageName)) {
      return;
    }

    apps.add(packageName);
    prefs.setStringList(settingNLUsedApps, apps);

    debugPrint("notify SettingsProvider->notificationAddApp()");
    notifyListeners();
  }

  void notificationRemoveUsedApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLUsedApps) ?? <String>[];

    if (packageName.isEmpty || !apps.contains(packageName)) {
      return;
    }

    apps.remove(packageName);
    prefs.setStringList(settingNLUsedApps, apps);
    prefs.setString("$settingNLAppPrefix$packageName", "");

    debugPrint("notify SettingsProvider->notificationRemoveApp()");
    notifyListeners();
  }

  Future<List<String>> notificationUsedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(settingNLUsedApps) ?? <String>[];
  }

  Future<NotificationAppSettings> notificationGetAppSettings(
    String packageName,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return NotificationAppSettings.fromJson(
      jsonDecode(prefs.getString("$settingNLAppPrefix$packageName") ?? ""),
    );
  }

  void notificationSetAppSettings(
    String packageName,
    NotificationAppSettings settings,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("$settingNLAppPrefix$packageName", jsonEncode(settings));
  }
}
