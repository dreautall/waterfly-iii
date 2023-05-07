import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

import 'package:shared_preferences/shared_preferences.dart';

final Logger log = Logger("Settings");

class NotificationAppSettings {
  NotificationAppSettings(
    this.appName, {
    this.defaultAccountId,
  });

  final String appName;
  String? defaultAccountId;

  NotificationAppSettings.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        defaultAccountId = json['defaultAccountId'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': appName,
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

  List<String> _notificationApps = <String>[];
  List<String> get notificationApps => _notificationApps;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log.config("reading prefs!");

    final String theme = prefs.getString(settingTheme) ?? "unset";
    log.config("read theme $theme");
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
    log.config("read locale $locale");
    if (S.supportedLocales.contains(locale)) {
      _locale = locale;
    }

    _notificationApps = prefs.getStringList(settingNLUsedApps) ?? <String>[];

    _loaded = true;
    log.finest("notify SettingsProvider->loadSettings()");
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode theme) async {
    _theme = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (theme) {
      case ThemeMode.dark:
        await prefs.setString(settingTheme, settingThemeDark);
        break;
      case ThemeMode.light:
        await prefs.setString(settingTheme, settingThemeLight);
        break;
      case ThemeMode.system:
      default:
        await prefs.setString(settingTheme, settingThemeSystem);
    }

    log.finest("notify SettingsProvider->setTheme()");
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!S.supportedLocales.contains(locale)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = locale;
    await prefs.setString(settingLocale, locale.languageCode);

    log.finest("notify SettingsProvider->setLocale()");
    notifyListeners();
  }

  Future<bool> notificationAddKnownApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLKnownApps) ?? <String>[];

    if (packageName.isEmpty || apps.contains(packageName)) {
      return false;
    }

    apps.add(packageName);
    return prefs.setStringList(settingNLKnownApps, apps);
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

  Future<bool> notificationAddUsedApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final List<String> apps =
        prefs.getStringList(settingNLUsedApps) ?? <String>[];

    if (packageName.isEmpty || apps.contains(packageName)) {
      return false;
    }

    apps.add(packageName);
    await prefs.setStringList(settingNLUsedApps, apps);

    _notificationApps = apps;

    log.finest("notify SettingsProvider->notificationAddUsedApp()");
    notifyListeners();
    return true;
  }

  Future<bool> notificationRemoveUsedApp(String packageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> apps =
        prefs.getStringList(settingNLUsedApps) ?? <String>[];

    if (packageName.isEmpty || !apps.contains(packageName)) {
      return false;
    }

    apps.remove(packageName);
    await prefs.remove("$settingNLAppPrefix$packageName");
    await prefs.setStringList(settingNLUsedApps, apps);

    _notificationApps = apps;

    log.finest("notify SettingsProvider->notificationRemoveUsedApp()");

    notifyListeners();
    return true;
  }

  Future<List<String>> notificationUsedApps({bool forceReload = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (forceReload) {
      await prefs.reload();
    }
    final List<String> apps =
        prefs.getStringList(settingNLUsedApps) ?? <String>[];
    _notificationApps = apps;

    log.finest("notify SettingsProvider->notificationUsedApps()");
    notifyListeners();

    return _notificationApps;
  }

  Future<NotificationAppSettings> notificationGetAppSettings(
    String packageName,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json =
        prefs.getString("$settingNLAppPrefix$packageName") ?? "";
    try {
      return NotificationAppSettings.fromJson(jsonDecode(json));
    } on FormatException catch (_) {
      return NotificationAppSettings(packageName);
    }
  }

  Future<void> notificationSetAppSettings(
    String packageName,
    NotificationAppSettings settings,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "$settingNLAppPrefix$packageName", jsonEncode(settings));
  }
}
