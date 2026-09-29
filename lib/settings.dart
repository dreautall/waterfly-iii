import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/pages/bills.dart';

final Logger log = Logger("Settings");

// in default order
enum DashboardCards {
  dailyavg,
  categories,
  tags,
  accounts,
  netearnings,
  networth,
  budgets,
  bills,
}

enum BoolSettings {
  debug,
  lock,
  showFutureTXs,
  dynamicColors,
  useServerTime,
  hideTags,
  billsShowOnlyActive,
  billsShowOnlyExpected,
  privacyMode,
}

enum TransactionDateFilter {
  currentMonth,
  last30Days,
  currentYear,
  lastYear,
  all,
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
  static const String settingsDashboardOrder = "DASHBOARD_ORDER";
  static const String settingsDashboardHidden = "DASHBOARD_HIDDEN";
  static const String settingTransactionDateFilter = "TX_DATE_FILTER";
  static const String settingAutoTagAll = "AUTOTAG_ALL";
  static const String settingAutoTagNL = "AUTOTAG_NL";

  bool get debug => _loaded ? _boolSettings[.debug] : false;
  bool get lock => _loaded ? _boolSettings[.lock] : false;
  bool get showFutureTXs => _loaded ? _boolSettings[.showFutureTXs] : false;
  bool get dynamicColors => _loaded ? _boolSettings[.dynamicColors] : false;
  bool get useServerTime => _loaded ? _boolSettings[.useServerTime] : true;
  bool get hideTags => _loaded ? _boolSettings[.hideTags] : false;
  bool get billsShowOnlyActive =>
      _loaded ? _boolSettings[.billsShowOnlyActive] : false;
  bool get billsShowOnlyExpected =>
      _loaded ? _boolSettings[.billsShowOnlyExpected] : false;

  bool _isSessionAuthed = false;
  bool get isSessionAuthed => _isSessionAuthed;

  static bool _isPrivacyMode = false;
  static bool get isPrivacyMode => _isPrivacyMode;

  bool get privacyMode => _isPrivacyMode;

  ThemeMode _theme = .system;
  ThemeMode get theme => _theme;

  Locale? _locale;
  Locale? get locale => _locale;

  StreamSubscription<LogRecord>? _debugLogger;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _loading = false;

  BillsLayout _billsLayout = .grouped;
  BillsLayout get billsLayout => _billsLayout;
  BillsSort _billsSort = .name;
  BillsSort get billsSort => _billsSort;
  SortingOrder _billsSortOrder = .ascending;
  SortingOrder get billsSortOrder => _billsSortOrder;

  List<String> _categoriesSumExcluded = <String>[];
  List<String> get categoriesSumExcluded => _categoriesSumExcluded;

  List<DashboardCards> _dashboardOrder = <DashboardCards>[];
  List<DashboardCards> get dashboardOrder => _dashboardOrder;

  final List<DashboardCards> _dashboardHidden = <DashboardCards>[];
  List<DashboardCards> get dashboardHidden => _dashboardHidden;

  late SettingsBitmask _boolSettings;
  SettingsBitmask get boolSettings => _boolSettings;

  TransactionDateFilter _transactionDateFilter = .all;
  TransactionDateFilter get transactionDateFilter => _transactionDateFilter;

  List<String> _autoTagAll = <String>[];
  List<String> get autoTagAll => _autoTagAll;
  List<String> _autoTagNL = <String>[];
  List<String> get autoTagNL => _autoTagNL;

  static Future<bool> loadUseServerTime({
    Future<bool> Function(String key)? containsKey,
    Future<int?> Function(String key)? getInt,
    Future<bool?> Function(String key)? getLegacyBool,
  }) async {
    SharedPreferencesAsync? preferences;
    SharedPreferencesAsync getPreferences() =>
        preferences ??= SharedPreferencesAsync();
    final Future<bool> Function(String) readContainsKey =
        containsKey ?? (String key) => getPreferences().containsKey(key);
    final Future<int?> Function(String) readInt =
        getInt ?? (String key) => getPreferences().getInt(key);
    if (await readContainsKey(settingsBitmask)) {
      final SettingsBitmask settings = SettingsBitmask(
        await readInt(settingsBitmask) ?? 0,
      );
      return settings[.useServerTime];
    }

    final Future<bool?> Function(String) readLegacyBool =
        getLegacyBool ??
        (String key) async =>
            (await SharedPreferences.getInstance()).getBool(key);
    return await readLegacyBool(settingUseServerTime) ?? true;
  }

  Future<void> migrateLegacy(SharedPreferencesAsync prefs) async {
    log.config("trying to migrate old prefs");
    final SharedPreferences oldPrefs = await SharedPreferences.getInstance();

    _boolSettings = SettingsBitmask(oldPrefs.getInt(settingsBitmask) ?? 0);
    if (!oldPrefs.containsKey(settingsBitmask)) {
      // Fallback solution for migration
      log.config("no bitmask saved, trying legacy settings");
      _boolSettings[.debug] = oldPrefs.getBool(settingDebug) ?? false;
      _boolSettings[.lock] = oldPrefs.getBool(settingLock) ?? false;
      _boolSettings[.showFutureTXs] =
          oldPrefs.getBool(settingShowFutureTXs) ?? false;
      _boolSettings[.dynamicColors] =
          oldPrefs.getBool(settingDynamicColors) ?? false;
      _boolSettings[.useServerTime] =
          oldPrefs.getBool(settingUseServerTime) ?? true;
      _boolSettings[.hideTags] = false;
      _boolSettings[.billsShowOnlyActive] = false;
      _boolSettings[.billsShowOnlyExpected] = false;
    }
    await prefs.setInt(settingsBitmask, _boolSettings.value);

    final String? theme = oldPrefs.getString(settingTheme);
    if (theme != null) {
      await prefs.setString(settingTheme, theme);
    }

    final String? locale = oldPrefs.getString(settingLocale);
    if (locale != null) {
      await prefs.setString(settingLocale, locale);
    }

    final int? billsLayoutIndex = oldPrefs.getInt(settingBillsDefaultLayout);
    if (billsLayoutIndex != null) {
      await prefs.setInt(settingBillsDefaultLayout, billsLayoutIndex);
    }

    final int? billsSortIndex = oldPrefs.getInt(settingBillsDefaultSort);
    if (billsSortIndex != null) {
      await prefs.setInt(settingBillsDefaultSort, billsSortIndex);
    }

    final int? billsSortOrderIndex = oldPrefs.getInt(
      settingBillsDefaultSortOrder,
    );
    if (billsSortOrderIndex != null) {
      await prefs.setInt(settingBillsDefaultSortOrder, billsSortOrderIndex);
    }

    final List<String>? categoriesSumExcluded = oldPrefs.getStringList(
      settingsCategoriesSumExcluded,
    );
    if (categoriesSumExcluded != null) {
      await prefs.setStringList(
        settingsCategoriesSumExcluded,
        categoriesSumExcluded,
      );
    }
  }

  Future<void> loadSettings() async {
    if (_loading) {
      log.config("already loading prefs, skipping this call");
      return;
    }
    _loading = true;

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    log.config("reading prefs");

    _boolSettings = SettingsBitmask(await prefs.getInt(settingsBitmask) ?? 0);
    if (!await prefs.containsKey(settingsBitmask)) {
      await migrateLegacy(prefs);
    }
    _boolSettings = SettingsBitmask(await prefs.getInt(settingsBitmask) ?? 0);
    log.config("read bool bitmask $_boolSettings");

    final String theme = await prefs.getString(settingTheme) ?? "unset";
    log.config("read theme $theme");
    switch (theme) {
      case settingThemeDark:
        _theme = .dark;
        break;
      case settingThemeLight:
        _theme = .light;
        break;
      case settingThemeSystem:
      default:
        _theme = .system;
    }

    final String localeStr = await prefs.getString(settingLocale) ?? "unset";
    log.config("read locale $localeStr");
    final Locale locale = LocaleExt.fromLanguageTag(localeStr);
    if (S.supportedLocales.contains(locale)) {
      _locale = locale;
      late String? countryCode;
      if (locale.countryCode?.isEmpty ?? true) {
        countryCode = Intl.defaultLocale?.split("_").last;
      } else {
        countryCode = locale.countryCode;
      }
      Intl.defaultLocale = "${locale.languageCode}_$countryCode";
    } else {
      _locale = const Locale('en');
    }

    if (debug) {
      log.config("setting debug");
      Logger.root.level = .ALL;
      _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
    } else {
      log.config("not setting debug");
      Logger.root.level = kDebugMode ? .ALL : .INFO;
    }

    final int? billsLayoutIndex = await prefs.getInt(settingBillsDefaultLayout);
    _billsLayout = billsLayoutIndex == null
        ? .grouped
        : .values[billsLayoutIndex];

    final int? billsSortIndex = await prefs.getInt(settingBillsDefaultSort);
    _billsSort = billsSortIndex == null ? .name : .values[billsSortIndex];

    final int? billsSortOrderIndex = await prefs.getInt(
      settingBillsDefaultSortOrder,
    );
    _billsSortOrder = billsSortOrderIndex == null
        ? .ascending
        : .values[billsSortOrderIndex];

    _categoriesSumExcluded =
        await prefs.getStringList(settingsCategoriesSumExcluded) ?? <String>[];

    final List<String> dashboardOrderStr =
        await prefs.getStringList(settingsDashboardOrder) ?? <String>[];
    for (String s in dashboardOrderStr) {
      _dashboardOrder.add(
        DashboardCards.values.firstWhere((DashboardCards e) => e.name == s),
      );
    }

    // Always filter out dupes.
    _dashboardOrder = dashboardOrder.toSet().toList();

    if (dashboardOrder.isEmpty ||
        DashboardCards.values.length < dashboardOrder.length) {
      // No order saved or too many items --> use default order
      _dashboardOrder = List<DashboardCards>.from(DashboardCards.values);
    } else if (DashboardCards.values.length > dashboardOrder.length) {
      // Too few items, maybe a new card was added. Add missing items.
      for (DashboardCards s in DashboardCards.values) {
        if (!dashboardOrder.contains(s)) {
          _dashboardOrder.add(s);
        }
      }
    }

    final List<String>? dashboardHiddenStr = await prefs.getStringList(
      settingsDashboardHidden,
    );
    if (dashboardHiddenStr == null) {
      // Default hidden charts
      _dashboardHidden.add(DashboardCards.tags);
    } else {
      for (String s in dashboardHiddenStr) {
        _dashboardHidden.add(
          DashboardCards.values.firstWhere((DashboardCards e) => e.name == s),
        );
      }
    }

    // Load new transaction date filter setting
    final int? txDateFilterIndex = await prefs.getInt(
      settingTransactionDateFilter,
    );
    _transactionDateFilter = txDateFilterIndex == null
        ? .all
        : .values[txDateFilterIndex];

    _isPrivacyMode = _boolSettings[.privacyMode];

    final List<String>? autoTagAll = await prefs.getStringList(
      settingAutoTagAll,
    );
    if (autoTagAll != null) {
      _autoTagAll = autoTagAll;
    }
    final List<String>? autoTagNL = await prefs.getStringList(settingAutoTagNL);
    if (autoTagNL != null) {
      _autoTagNL = autoTagNL;
    }

    _loaded = _loading = true;
    log.finest(() => "notify SettingsProvider->loadSettings()");
    notifyListeners();
  }

  bool _setBool(BoolSettings setting, bool value) {
    if (_boolSettings[setting] == value) {
      return false;
    }

    _boolSettings[setting] = value;

    () async {
      await SharedPreferencesAsync().setInt(
        settingsBitmask,
        _boolSettings.value,
      );

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
        Logger.root.level = .ALL;
        _debugLogger = Logger.root.onRecord.listen(await DebugLogger().get());
        final PackageInfo appInfo = await PackageInfo.fromPlatform();
        log.info(
          "Enabling debug logs, app ${appInfo.appName} v${appInfo.version}+${appInfo.buildNumber}",
        );
      } else {
        Logger.root.level = kDebugMode ? .ALL : .INFO;
        await _debugLogger?.cancel();
        await DebugLogger().destroy();
      }
    }();
  }

  set lock(bool enabled) {
    _setBool(.lock, enabled);
    _isSessionAuthed = enabled;
    log.finest(() => "notify SettingsProvider->lock()");
    notifyListeners();
  }

  set showFutureTXs(bool enabled) => _setBool(.showFutureTXs, enabled);
  set dynamicColors(bool enabled) => _setBool(.dynamicColors, enabled);
  set useServerTime(bool enabled) => _setBool(.useServerTime, enabled);
  set hideTags(bool enabled) => _setBool(.hideTags, enabled);
  set billsShowOnlyActive(bool enabled) =>
      _setBool(.billsShowOnlyActive, enabled);
  set billsShowOnlyExpected(bool enabled) =>
      _setBool(.billsShowOnlyExpected, enabled);

  void setPrivacyMode(bool enabled) {
    if (enabled == _isPrivacyMode) {
      return;
    }

    _isPrivacyMode = enabled;
    _setBool(.privacyMode, enabled);
  }

  Future<void> setTheme(ThemeMode theme) async {
    _theme = theme;
    switch (theme) {
      case .dark:
        await SharedPreferencesAsync().setString(
          settingTheme,
          settingThemeDark,
        );
        break;
      case .light:
        await SharedPreferencesAsync().setString(
          settingTheme,
          settingThemeLight,
        );
        break;
      case .system:
        await SharedPreferencesAsync().setString(
          settingTheme,
          settingThemeSystem,
        );
    }

    log.finest(() => "notify SettingsProvider->setTheme()");
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!S.supportedLocales.contains(locale)) {
      return;
    }

    _locale = locale;
    late String? countryCode;
    if (locale.countryCode?.isEmpty ?? true) {
      countryCode = Intl.defaultLocale?.split("_").last;
    } else {
      countryCode = locale.countryCode;
    }
    Intl.defaultLocale = "${locale.languageCode}_$countryCode";
    await SharedPreferencesAsync().setString(
      settingLocale,
      locale.toLanguageTag(),
    );

    log.finest(() => "notify SettingsProvider->setLocale()");
    notifyListeners();
  }

  Future<void> setBillsLayout(BillsLayout billsLayout) async {
    if (billsLayout == _billsLayout) {
      return;
    }

    _billsLayout = billsLayout;
    await SharedPreferencesAsync().setInt(
      settingBillsDefaultLayout,
      billsLayout.index,
    );

    log.finest(() => "notify SettingsProvider->billsLayout()");
    notifyListeners();
  }

  Future<void> setBillsSort(BillsSort billsSort) async {
    if (billsSort == _billsSort) {
      return;
    }

    _billsSort = billsSort;
    await SharedPreferencesAsync().setInt(
      settingBillsDefaultSort,
      billsSort.index,
    );

    log.finest(() => "notify SettingsProvider->billsSort()");
    notifyListeners();
  }

  Future<void> setBillsSortOrder(SortingOrder sortOrder) async {
    if (sortOrder == _billsSortOrder) {
      return;
    }

    _billsSortOrder = sortOrder;
    await SharedPreferencesAsync().setInt(
      settingBillsDefaultSortOrder,
      sortOrder.index,
    );

    log.finest(() => "notify SettingsProvider->billsSortOrder()");
    notifyListeners();
  }

  Future<void> categoryAddSumExcluded(String categoryId) async {
    if (categoryId.isEmpty || categoriesSumExcluded.contains(categoryId)) {
      return;
    }

    _categoriesSumExcluded.add(categoryId);
    await SharedPreferencesAsync().setStringList(
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

    _categoriesSumExcluded.remove(categoryId);
    await SharedPreferencesAsync().setStringList(
      settingsCategoriesSumExcluded,
      categoriesSumExcluded,
    );

    log.finest(() => "notify SettingsProvider->categoryRemoveSumExcluded()");
    notifyListeners();
  }

  Future<void> setDashboardOrder(List<DashboardCards> order) async {
    final List<String> orderStr = <String>[];
    for (DashboardCards e in order) {
      if (orderStr.contains(e.name)) {
        continue;
      }
      orderStr.add(e.name);
    }

    _dashboardOrder = order;
    await SharedPreferencesAsync().setStringList(
      settingsDashboardOrder,
      orderStr,
    );

    log.finest(() => "notify SettingsProvider->setDashboardOrder()");
    notifyListeners();
  }

  Future<void> dashboardHideCard(DashboardCards card) async {
    if (dashboardHidden.contains(card)) {
      return;
    }
    _dashboardHidden.add(card);

    final List<String> hiddenStr = <String>[];
    for (DashboardCards e in dashboardHidden) {
      hiddenStr.add(e.name);
    }
    await SharedPreferencesAsync().setStringList(
      settingsDashboardHidden,
      hiddenStr,
    );

    log.finest(() => "notify SettingsProvider->dashboardHideCard()");
    notifyListeners();
  }

  Future<void> dashboardShowCard(DashboardCards card) async {
    if (!dashboardHidden.contains(card)) {
      return;
    }
    _dashboardHidden.remove(card);

    final List<String> hiddenStr = <String>[];
    for (DashboardCards e in dashboardHidden) {
      hiddenStr.add(e.name);
    }
    await SharedPreferencesAsync().setStringList(
      settingsDashboardHidden,
      hiddenStr,
    );

    log.finest(() => "notify SettingsProvider->dashboardShowCard()");
    notifyListeners();
  }

  Future<void> setTransactionDateFilter(TransactionDateFilter filter) async {
    if (filter == _transactionDateFilter) {
      return;
    }

    _transactionDateFilter = filter;
    await SharedPreferencesAsync().setInt(
      settingTransactionDateFilter,
      filter.index,
    );

    log.finest(() => "notify SettingsProvider->setTransactionDateFilter()");
    notifyListeners();
  }

  Future<void> setAutoTagAll(List<String> tags) async {
    _autoTagAll = tags;
    await SharedPreferencesAsync().setStringList(settingAutoTagAll, tags);

    log.finest(() => "notify SettingsProvider->setAutoTagAll()");
    notifyListeners();
  }

  Future<void> setAutoTagNL(List<String> tags) async {
    _autoTagNL = tags;
    await SharedPreferencesAsync().setStringList(settingAutoTagNL, tags);

    log.finest(() => "notify SettingsProvider->setAutoTagNL()");
    notifyListeners();
  }

  void sessionAuthed() {
    _isSessionAuthed = true;
    notifyListeners();
  }

  // Call this on app resume/timeout
  void sessionLock() {
    _isSessionAuthed = false;
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
    final File file = File(await _getPath());
    if (await file.exists()) {
      file.deleteSync();
    }
  }
}
