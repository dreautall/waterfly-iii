import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:kaisel/kaisel.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/routes/guards.dart';
import 'package:waterflyiii/routes/router.dart';
import 'package:waterflyiii/routes/routes.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/themes/dark.dart';
import 'package:waterflyiii/themes/light.dart';

final Logger log = Logger("App");

class WaterflyApp extends StatefulWidget {
  const WaterflyApp({super.key});

  static KaiselRouter<AppRoute>? routerInstance;

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  bool _startup = true;
  String? _quickAction;
  NotificationTransaction? _notificationPayload;
  List<SharedFile>? _filesSharedToApp;
  DateTime? _lcLastOpen;

  final FireflyService _fireflyService = FireflyService();
  final SettingsProvider _settingsProvider = SettingsProvider();
  final LayoutProvider _layoutProvider = LayoutProvider();

  late final KaiselRouterConfig<AppRoute> _routerConfig;

  @override
  void initState() {
    super.initState();

    _routerConfig = KaiselRouterConfig<AppRoute>(
      initial: const SplashRoute(),
      builder: buildScreen,
      guards: <KaiselGuard<AppRoute>>[
        createAuthGuard(_fireflyService),
        createLockGuard(_settingsProvider),
      ],
      androidPredictiveBack: true,
      reevaluateOn: Listenable.merge(<Listenable?>[
        _fireflyService,
        _settingsProvider,
      ]),
    );
    WaterflyApp.routerInstance = _routerConfig.router;

    _handleStartup();
  }

  Future<void> _handleStartup() async {
    final List<Future<void>> startup = <Future<void>>[
      _fireflyService.signInFromStorage(),
      // App lifecycle listener
      _initLifecycleListener(),
      // Quick Actions (Android + iOS)
      _initQuickActions(),
      // Share to Waterfly III (Android + iOS)
      _initSharingIntent(),
    ];

    // Notifications (Android only)
    if (Platform.isAndroid) {
      startup.add(_initNotifications());
    }

    // Wait for tasks to finish (especially login)
    await Future.wait(startup);
    _startup = false;

    if (_fireflyService.status != AuthStatus.authenticated) {
      log.config("not authed, skipping sharing intents");
      _notificationPayload = null;
      _filesSharedToApp = null;
      _quickAction = null;
      return;
    }

    // Handle Transaction Deep Link
    if (_notificationPayload != null ||
        _quickAction == "action_transaction_add" ||
        (_filesSharedToApp?.isNotEmpty ?? false)) {
      log.config(() => "showing transaction screen");
      unawaited(
        _routerConfig.router.set(<AppRoute>[
          TransactionDetail(
            notification: _notificationPayload,
            files: _filesSharedToApp,
          ),
        ]),
      );
    }
  }

  Future<void> _initNotifications() async {
    await FlutterLocalNotificationsPlugin().initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_notification'),
      ),
      onDidReceiveNotificationResponse: nlNotificationTap,
    );

    final NotificationAppLaunchDetails? details =
        await FlutterLocalNotificationsPlugin()
            .getNotificationAppLaunchDetails();
    if (details == null) {
      return;
    }

    log.config("checking NotificationAppLaunchDetails");
    if ((details.didNotificationLaunchApp) &&
        (details.notificationResponse?.payload?.isNotEmpty ?? false)) {
      log.info("Was launched from notification!");
      _notificationPayload = .fromJson(
        jsonDecode(details.notificationResponse!.payload!),
      );
    }
  }

  Future<void> _initQuickActions() async {
    const QuickActions quickActions = QuickActions();
    await quickActions.initialize((String shortcutType) {
      log.config("QA: Received QuickAction $shortcutType");
      _quickAction = shortcutType;
      if (_startup == true) {
        log.finest(() => "QA: app is still starting, doing nothing");
        return;
      }

      if (_fireflyService.status == AuthStatus.authenticated) {
        log.finest(() => "QA: app already started, pushing route");
        _routerConfig.router.push(const TransactionDetail());
      } else {
        log.warning("QA: user was not authed, not doing anything");
      }
    });
    await quickActions.clearShortcutItems();
  }

  Future<void> _initSharingIntent() async {
    final FlutterSharingIntent instance = FlutterSharingIntent.instance;

    // For sharing images coming from outside the app while the app is closed
    final List<SharedFile> shared = await instance.getInitialSharing();
    if (shared.isNotEmpty) {
      log.config("SI: App was opened via file sharing");
      log.finest(
        () => "SI: files ${shared.map((SharedFile f) => f.value).join(",")}",
      );
      _filesSharedToApp = shared;
    }

    instance.getMediaStream().listen((List<SharedFile> shared) {
      if (_startup == true) {
        return;
      }
      log.config("SI: File shared to app while running");
      log.finest(
        () =>
            "SI: getMediaStream ${shared.map((SharedFile f) => f.value).join(",")}",
      );
      if (_fireflyService.status == AuthStatus.authenticated) {
        log.finest(() => "SI: app already started, pushing route");
        _routerConfig.router.push(TransactionDetail(files: shared));
      } else {
        log.warning("SI: user was not authed, not doing anything");
      }
    });
  }

  Future<void> _initLifecycleListener() async => AppLifecycleListener(
    onResume: () {
      log.finest(() => "Lifecycle: Resume");
      // If lock is enabled, check if we need to re-authenticate based on timeout (10 mins)
      if (_settingsProvider.lock &&
          (_lcLastOpen?.isBefore(
                DateTime.now().subtract(const Duration(minutes: 10)),
              ) ??
              false)) {
        log.finest(() => "App resuming, timeout reached. Requiring re-auth.");
        _settingsProvider.sessionLock();
      }
    },
    onPause: () {
      log.finest(() => "Lifecycle: Pause");
      if (_settingsProvider.lock) {
        _lcLastOpen ??= DateTime.now();
      }
    },
  );

  @override
  void dispose() {
    _fireflyService.dispose();
    _settingsProvider.dispose();
    _layoutProvider.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      _layoutProvider.updateSize(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    log.fine(() => "WaterflyApp() building");

    return DynamicColorBuilder(
      builder: (ColorScheme? cSchemeDynamicLight, ColorScheme? cSchemeDynamicDark) {
        log.finest(
          () =>
              "has dynamic color? light: ${cSchemeDynamicLight != null}, dark: ${cSchemeDynamicDark != null}",
        );

        return MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<FireflyService>.value(
              value: _fireflyService,
            ),
            ChangeNotifierProvider<SettingsProvider>.value(
              value: _settingsProvider,
            ),
            ChangeNotifierProvider<LayoutProvider>.value(
              value: _layoutProvider,
            ),
          ],
          child: Consumer<SettingsProvider>(
            builder: (BuildContext context, SettingsProvider settings, _) {
              return MaterialApp.router(
                title: 'Waterfly III',
                theme: lightTheme(settings, cSchemeDynamicLight),
                darkTheme: darkTheme(settings, cSchemeDynamicDark),
                themeMode: settings.theme,
                localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                  S.delegate,
                  ...GlobalMaterialLocalizations.delegates,
                ],
                supportedLocales: S.supportedLocales,
                locale: settings.locale,
                routerConfig: _routerConfig,
              );
            },
          ),
        );
      },
    );
  }
}
