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

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  bool _startup = true;
  String? _quickAction;
  NotificationTransaction? _notificationPayload;
  // Not needed right now, as sharing while the app is open does not work
  //late StreamSubscription<List<SharedFile>> _intentDataStreamSubscription;
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

    _fireflyService.signInFromStorage();

    _initializePlatformServices();
  }

  void _initializePlatformServices() {
    // App Lifecycle State
    _initLifecycleListener();

    return; // :TODO:
    // Notifications (Android only)
    if (Platform.isAndroid) {
      _initNotifications();
    }
    // Quick Actions (Android + iOS)
    _initQuickActions();
    // Share to Waterfly III
    _initSharingIntent();
  }

  void _initNotifications() {
    FlutterLocalNotificationsPlugin().initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_notification'),
      ),
      onDidReceiveNotificationResponse: nlNotificationTap,
    );

    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then((
      NotificationAppLaunchDetails? details,
    ) {
      log.config("checking NotificationAppLaunchDetails");
      if ((details?.didNotificationLaunchApp ?? false) &&
          (details?.notificationResponse?.payload?.isNotEmpty ?? false)) {
        log.info("Was launched from notification!");
        _notificationPayload = .fromJson(
          jsonDecode(details!.notificationResponse!.payload!),
        );
      }
    });
  }

  void _initQuickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      log.info("Was launched from QuickAction $shortcutType");
      _quickAction = shortcutType;
      /* :TODO:
      if (!_startup && navigatorKey.currentState != null) {
        log.finest(() => "App already started, pushing route");
        navigatorKey.currentState!.push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const TransactionPage(),
          ),
        );
      }*/
    });
    quickActions.clearShortcutItems();
  }

  void _initSharingIntent() {
    // While the app is open...
    /* Sharing while app is open is currently not supported :(
       The fix from https://github.com/bhagat-techind/flutter_sharing_intent/issues/33
       does not seem to work, unfortunately.

    _intentDataStreamSubscription = FlutterSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedFile> value) {
      setState(() {
        list = value;
      });
      debugPrint(
          "Shared: getMediaStream ${value.map((SharedFile f) => f.value).join(",")}");
    }, onError: (Object err) {
      debugPrint("getIntentDataStream error: $err");
    });*/

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((
      List<SharedFile> value,
    ) {
      if (value.isEmpty) return;

      log.config("App was opened via file sharing");
      log.finest(
        () => "files: ${value.map((SharedFile f) => f.value).join(",")}",
      );
      _filesSharedToApp = value;
    });
  }

  void _initLifecycleListener() {
    AppLifecycleListener(
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
  }

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
