import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  static const String settingTheme = "THEME";
  static const String settingThemeDark = "DARK";
  static const String settingThemeLight = "LIGHT";
  static const String settingThemeSystem = "SYSTEM";
  static const String settingLocale = "LOCALE";
  static const String settingNLKnownApps = "NL_KNOWNAPPS";
  static const String settingNLIgnoredApps = "NL_IGNOREDAPPS";

  ThemeMode _theme = ThemeMode.system;
  ThemeMode get getTheme => _theme;

  Locale? _locale;
  Locale? get getLocale => _locale;

  bool _loaded = false;
  bool get loaded => _loaded;

  List<String> _notificationKnownApps = <String>[];
  List<String> get notificationKnownApps => _notificationKnownApps;
  List<String> _notificationIgnoredApps = <String>[];
  List<String> get notificationIgnoredApps => _notificationIgnoredApps;

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

    _notificationIgnoredApps =
        prefs.getStringList(settingNLIgnoredApps) ?? <String>[];
    _notificationKnownApps =
        prefs.getStringList(settingNLKnownApps) ?? <String>[];

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
    if (packageName.isEmpty || _notificationKnownApps.contains(packageName)) {
      return;
    }

    _notificationKnownApps.add(packageName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(settingNLKnownApps, _notificationKnownApps);

    debugPrint("notify SettingsProvider->notificationAddKnownApp()");
    notifyListeners();
  }

  void notificationAddIgnoredApp(String packageName) async {
    if (packageName.isEmpty || _notificationIgnoredApps.contains(packageName)) {
      return;
    }

    _notificationIgnoredApps.add(packageName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(settingNLIgnoredApps, _notificationIgnoredApps);

    debugPrint("notify SettingsProvider->notificationAddIgnoredApp()");
    notifyListeners();
  }

  void notificationRemoveIgnoredApp(String packageName) async {
    if (packageName.isEmpty ||
        !_notificationIgnoredApps.contains(packageName)) {
      return;
    }

    _notificationIgnoredApps.remove(packageName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(settingNLIgnoredApps, _notificationIgnoredApps);

    debugPrint("notify SettingsProvider->notificationRemoveIgnoredApp()");
    notifyListeners();
  }
}
