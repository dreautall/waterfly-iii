import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/pages/bills.dart';

final Logger log = Logger("Settings");

class NotificationAppSettings {
  NotificationAppSettings(
    this.appName, {
    this.defaultAccountId,
    this.includeTitle = true,
  });

  final String appName;
  String? defaultAccountId;
  bool includeTitle = true;

  NotificationAppSettings.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        defaultAccountId = json['defaultAccountId'],
        includeTitle = json['includeTitle'] ?? true;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': appName,
        'defaultAccountId': defaultAccountId,
        'includeTitle': includeTitle,
      };
}

enum BoolSettings {
  debug,
  lock,
  showFutureTXs,
  dynamicColors,
  useServerTime,
  hideTags,
}

class SettingsBitmask {
  int _value;

  SettingsBitmask([this._value = 0]) {
    assert(_value >= 0);
  }

  bool operator [](BoolSettings flag) => hasFlag(flag);

  void operator []=(BoolSettings flag, bool value) {
    if (value) {
      setFlag(flag);
    } else {
      unsetFlag(flag);
    }
  }

  bool hasFlag(BoolSettings flag) => (_value & (1 << flag.index)) != 0;

  void setFlag(BoolSettings flag) {
    _value |= 1 << flag.index;
  }

  void unsetFlag(BoolSettings flag) {
    _value &= ~(1 << flag.index);
  }

  int get value => _value;

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    for (final BoolSettings flag in BoolSettings.values.reversed) {
      if (hasFlag(flag)) {
        buffer.write('1');
      } else {
        buffer.write('0');
      }
    }
    return buffer.toString();
  }
}

class SettingsProvider with ChangeNotifier {
  static const String settingsBitmask = "BOOLBITMASK";
  static const String settingDebug = "DEBUG";
  static const String settingLocale = "LOCALE";
  static const String settingLock = "LOCK";
  static const String settingShowFutureTXs = "SHOWFUTURETXS";
  static const String settingNLKnownApps = "NL_KNOWNAPPS";
  static const String settingNLUsedApps = "NL_USEDAPPS";
  static const String settingNLAppPrefix = "NL_APP_";
  static const String settingTheme = "THEME";
  static const String settingThemeDark = "DARK";
  static const String settingThemeLight = "LIGHT";
  static const String settingThemeSystem = "SYSTEM";
  static const String settingDynamicColors = "DYNAMICCOLORS";
  static const String settingUseServerTime = "USESERVERTIME";
  static const String settingBillsDefaultLayout = "BILLSDEFAULTLAYOUT";
  static const String settingBillsDefaultSort = "BILLSDEFAULTSORT";
  static const String settingBillsDefaultSortOrder = "BILLSDEFAULTSORTORDER";
  static const String settingsCategoriesSumExcluded = "CAT_SUMEXCLUDED";

  bool get debug => _loaded ? _boolSettings[BoolSettings.debug] : false;
  bool get lock => _loaded ? _boolSettings[BoolSettings.lock] : false;
  bool get showFutureTXs =>
      _loaded ? _boolSettings[BoolSettings.showFutureTXs] : false;
  bool get dynamicColors =>
      _loaded ? _boolSettings[BoolSettings.dynamicColors] : false;
  bool get useServerTime =>
      _loaded ? _boolSettings[BoolSettings.useServerTime] : true;
  bool get hideTags => _loaded ? _boolSettings[BoolSettings.hideTags] : false;

  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;

  Locale? _locale;
  Locale? get locale => _locale;

  StreamSubscription<LogRecord>? _debugLogger;

  bool _loaded = false;
  bool get loaded => _loaded;

  List<String> _notificationApps = <String>[];
  List<String> get notificationApps => _notificationApps;

  BillsLayout _billsLayout = BillsLayout.grouped;
  BillsLayout get billsLayout => _billsLayout;
  BillsSort _billsSort = BillsSort.name;
  BillsSort get billsSort => _billsSort;
  SortingOrder _billsSortOrder = SortingOrder.ascending;
  SortingOrder get billsSortOrder => _billsSortOrder;

  List<String> _categoriesSumExcluded = <String>[];
  List<String> get categoriesSumExcluded => _categoriesSumExcluded;

  late SettingsBitmask _boolSettings;
  SettingsBitmask get boolSettings => _boolSettings;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log.config("reading prefs");

    _boolSettings = SettingsBitmask(prefs.getInt(settingsBitmask) ?? 0);
    if (!prefs.containsKey(settingsBitmask)) {
      // Fallback solution for migration
      log.config("no bitmask saved, trying legacy settings");
      _boolSettings[BoolSettings.debug] = prefs.getBool(settingDebug) ?? false;
      _boolSettings[BoolSettings.lock] = prefs.getBool(settingLock) ?? false;
      _boolSettings[BoolSettings.showFutureTXs] =
          prefs.getBool(settingShowFutureTXs) ?? false;
      _boolSettings[BoolSettings.dynamicColors] =
          prefs.getBool(settingDynamicColors) ?? false;
      _boolSettings[BoolSettings.useServerTime] =
          prefs.getBool(settingUseServerTime) ?? true;
      _boolSettings[BoolSettings.hideTags] = false;
    }
    log.config("read bool bitmask $_boolSettings");

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

    final String? countryCode = Intl.defaultLocale?.split("_").last;
    final Locale locale = Locale(prefs.getString(settingLocale) ?? "unset");
    log.config("read locale $locale");
    if (S.supportedLocales.contains(locale)) {
      _locale = locale;
      Intl.defaultLocale = "${locale.languageCode}_$countryCode";
    } else {
      _locale = const Locale('en');
    }

    if (debug) {
      log.config("setting debug");
      Logger.root.level = Level.ALL;
      _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
    } else {
      log.config("not setting debug");
      Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    }

    _notificationApps = prefs.getStringList(settingNLUsedApps) ?? <String>[];

    int? billsLayoutIndex = prefs.getInt(settingBillsDefaultLayout);
    _billsLayout = billsLayoutIndex == null
        ? BillsLayout.grouped
        : BillsLayout.values[billsLayoutIndex];

    int? billsSortIndex = prefs.getInt(settingBillsDefaultSort);
    _billsSort = billsSortIndex == null
        ? BillsSort.name
        : BillsSort.values[billsSortIndex];

    int? billsSortOrderIndex = prefs.getInt(settingBillsDefaultSortOrder);
    _billsSortOrder = billsSortOrderIndex == null
        ? SortingOrder.ascending
        : SortingOrder.values[billsSortOrderIndex];

    _categoriesSumExcluded =
        prefs.getStringList(settingsCategoriesSumExcluded) ?? <String>[];

    _loaded = true;
    log.finest(() => "notify SettingsProvider->loadSettings()");
    notifyListeners();
  }

  bool _setBool(BoolSettings setting, bool value) {
    if (_boolSettings[setting] == value) {
      return false;
    }

    _boolSettings[setting] = value;

    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(settingsBitmask, _boolSettings.value);

      log.finest(() => "notify SettingsProvider->_setBool($setting)");
      notifyListeners();
    }();

    return true;
  }

  // Bool setters
  set debug(bool enabled) {
    if (!_setBool(BoolSettings.debug, enabled)) {
      return;
    }

    () async {
      if (debug) {
        Logger.root.level = Level.ALL;
        _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
      } else {
        Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
        await _debugLogger?.cancel();
        await DebugLogger().destroy();
      }
    }();
  }

  set lock(bool enabled) => _setBool(BoolSettings.lock, enabled);
  set showFutureTXs(bool enabled) =>
      _setBool(BoolSettings.showFutureTXs, enabled);
  set dynamicColors(bool enabled) =>
      _setBool(BoolSettings.dynamicColors, enabled);
  set useServerTime(bool enabled) =>
      _setBool(BoolSettings.useServerTime, enabled);
  set hideTags(bool enabled) => _setBool(BoolSettings.hideTags, enabled);

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
        await prefs.setString(settingTheme, settingThemeSystem);
    }

    log.finest(() => "notify SettingsProvider->setTheme()");
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!S.supportedLocales.contains(locale)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = Locale(locale.languageCode);
    final String? countryCode = Intl.defaultLocale?.split("_").last;
    Intl.defaultLocale = "${locale.languageCode}_$countryCode";
    await prefs.setString(settingLocale, locale.languageCode);

    log.finest(() => "notify SettingsProvider->setLocale()");
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

    log.finest(() => "notify SettingsProvider->notificationAddUsedApp()");
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

    log.finest(() => "notify SettingsProvider->notificationRemoveUsedApp()");

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
    if (!const ListEquality<String>().equals(apps, _notificationApps)) {
      _notificationApps = apps;

      log.finest(() => "notify SettingsProvider->notificationUsedApps()");
      notifyListeners();
    }

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

  Future<void> setBillsLayout(BillsLayout billsLayout) async {
    if (billsLayout == _billsLayout) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _billsLayout = billsLayout;
    await prefs.setInt(settingBillsDefaultLayout, billsLayout.index);

    log.finest(() => "notify SettingsProvider->billsLayout()");
    notifyListeners();
  }

  Future<void> setBillsSort(BillsSort billsSort) async {
    if (billsSort == _billsSort) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _billsSort = billsSort;
    await prefs.setInt(settingBillsDefaultSort, billsSort.index);

    log.finest(() => "notify SettingsProvider->billsSort()");
    notifyListeners();
  }

  Future<void> setBillsSortOrder(SortingOrder sortOrder) async {
    if (sortOrder == _billsSortOrder) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _billsSortOrder = sortOrder;
    await prefs.setInt(settingBillsDefaultSortOrder, sortOrder.index);

    log.finest(() => "notify SettingsProvider->billsSortOrder()");
    notifyListeners();
  }

  Future<void> categoryAddSumExcluded(String categoryId) async {
    if (categoryId.isEmpty || categoriesSumExcluded.contains(categoryId)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _categoriesSumExcluded.add(categoryId);
    await prefs.setStringList(
      settingsCategoriesSumExcluded,
      categoriesSumExcluded,
    );

    log.finest(() => "notify SettingsProvider->categoryAddSumExcluded()");
    notifyListeners();
  }

  Future<void> categoryRemoveSumExcluded(String categoryId) async {
    if (categoryId.isEmpty || !categoriesSumExcluded.contains(categoryId)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _categoriesSumExcluded.remove(categoryId);
    await prefs.setStringList(
      settingsCategoriesSumExcluded,
      categoriesSumExcluded,
    );

    log.finest(() => "notify SettingsProvider->categoryRemoveSumExcluded()");

    notifyListeners();
  }
}

class DebugLogger {
  String? _logPath;

  Future<Function(LogRecord)> get() async {
    _logPath = await _getPath();
    return _log;
  }

  Future<String> _getPath() async {
    final Directory tmpPath = await getTemporaryDirectory();
    return "${tmpPath.path}/debuglog.txt";
  }

  void _log(LogRecord record) {
    if (_logPath?.isEmpty ?? true) {
      return;
    }
    String message = record.message;
    if (record.error != null) {
      message += "\nERROR MESSAGE: ${record.error}";
    }
    if (record.stackTrace != null) {
      message += "\nSTACKTRACE:\n${record.stackTrace}\n\n";
    }
    File(_logPath!).writeAsStringSync(
      "${record.time}: [${record.loggerName} - ${record.level.name}] $message\n",
      mode: FileMode.append,
      flush: true,
    );
  }

  Future<void> destroy() async {
    File file = File(await _getPath());
    if (await file.exists()) {
      file.deleteSync();
    }
  }
}
