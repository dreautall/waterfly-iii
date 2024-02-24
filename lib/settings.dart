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

class SettingsProvider with ChangeNotifier {
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

  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;
  bool _dynamicColors = false;
  bool get dynamicColors => _dynamicColors;
  bool _useServerTime = true;
  bool get useServerTime => _useServerTime;

  Locale? _locale;
  Locale? get locale => _locale;

  bool _debug = false;
  bool get debug => _debug;
  StreamSubscription<LogRecord>? _debugLogger;

  bool _lock = false;
  bool get lock => _lock;

  bool _showFutureTXs = false;
  bool get showFutureTXs => _showFutureTXs;

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
    _dynamicColors = prefs.getBool(settingDynamicColors) ?? false;
    log.config("read dynamic colors $dynamicColors");
    _useServerTime = prefs.getBool(settingUseServerTime) ?? true;
    log.config("read use server time $useServerTime");

    final String? countryCode = Intl.defaultLocale?.split("_").last;
    final Locale locale = Locale(prefs.getString(settingLocale) ?? "unset");
    log.config("read locale $locale");
    if (S.supportedLocales.contains(locale)) {
      _locale = locale;
      Intl.defaultLocale = "${locale.languageCode}_$countryCode";
    } else {
      _locale = const Locale('en');
    }

    _debug = prefs.getBool(settingDebug) ?? false;
    log.config("read debug $debug");
    if (_debug) {
      Logger.root.level = Level.ALL;
      _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
    } else {
      Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    }

    _lock = prefs.getBool(settingLock) ?? false;
    log.config("read lock $lock");

    _showFutureTXs = prefs.getBool(settingShowFutureTXs) ?? false;
    log.config("read showFutureTXs $showFutureTXs");

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

  Future<void> setDebug(bool debug) async {
    if (debug == _debug) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _debug = debug;
    await prefs.setBool(settingDebug, debug);

    if (debug) {
      Logger.root.level = Level.ALL;
      _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
    } else {
      Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
      await _debugLogger?.cancel();
      await DebugLogger().destroy();
    }

    log.finest(() => "notify SettingsProvider->setDebug()");
    notifyListeners();
  }

  Future<void> setLock(bool lock) async {
    if (lock == _lock) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lock = lock;
    await prefs.setBool(settingLock, lock);

    log.finest(() => "notify SettingsProvider->setLock()");
    notifyListeners();
  }

  Future<void> setShowFutureTXs(bool showFutureTXs) async {
    if (showFutureTXs == _showFutureTXs) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _showFutureTXs = showFutureTXs;
    await prefs.setBool(settingShowFutureTXs, showFutureTXs);

    log.finest(() => "notify SettingsProvider->setShowFutureTXs()");
    notifyListeners();
  }

  Future<void> setDynamicColors(bool dynamicColors) async {
    if (dynamicColors == _dynamicColors) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dynamicColors = dynamicColors;
    await prefs.setBool(settingDynamicColors, dynamicColors);

    log.finest(() => "notify SettingsProvider->dynamicColors()");
    notifyListeners();
  }

  Future<void> setUseServerTime(bool useServerTime) async {
    if (useServerTime == _useServerTime) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _useServerTime = useServerTime;
    await prefs.setBool(settingUseServerTime, useServerTime);

    log.finest(() => "notify SettingsProvider->setUseServerTime()");
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
    File(_logPath!).writeAsStringSync(
      "${record.time}: [${record.loggerName} - ${record.level.name}] ${record.message}\n",
      mode: FileMode.append,
      flush: true,
    );
  }

  Future<void> destroy() async {
    File(await _getPath()).deleteSync();
  }
}
