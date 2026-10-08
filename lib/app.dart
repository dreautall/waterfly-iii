import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_registration_service.dart';
import 'package:waterflyiii/notifications/application/migrations/notification_migration_review_service.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_listener_registration_gateway.dart';
import 'package:waterflyiii/notifications/data/migrations/platform_notification_migration_review_notifier.dart';
import 'package:waterflyiii/notifications/data/resources/api_firefly_currency_gateway.dart';
import 'package:waterflyiii/notifications/data/resources/api_firefly_resource_label_gateway.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_listener_health_notifier.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definitions_view_model.dart';
import 'package:waterflyiii/notifications/presentation/history/controllers/recent_notifications_view_model.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/pages/lock.dart';
import 'package:waterflyiii/pages/login.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/splash.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/theme.dart';

final Logger log = Logger("App");

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Main Navigator",
);

class WaterflyApp extends StatefulWidget {
  const WaterflyApp({super.key});

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  bool _startup = true;
  String? _quickAction;
  NotificationTransaction? _notificationPayload;
  bool _notificationHealthPayload = false;
  bool _notificationMigrationReviewPayload = false;
  // Not needed right now, as sharing while the app is open does not work
  //late StreamSubscription<List<SharedFile>> _intentDataStreamSubscription;
  List<SharedFile>? _filesSharedToApp;
  DateTime? _lcLastOpen;

  final FireflyService _fireflyService = FireflyService();
  late final FireflyResourceLabelResolver _resourceLabels =
      FireflyResourceLabelResolver(
        ApiFireflyResourceLabelGateway(_fireflyService),
      );
  late final FireflyCurrencyResolver _currencyResolver =
      FireflyCurrencyResolver(ApiFireflyCurrencyGateway(_fireflyService));
  final SettingsProvider _settingsProvider = SettingsProvider();
  final LayoutProvider _layoutProvider = LayoutProvider();
  late final NotificationFeatureScope _notificationFeatureScope =
      NotificationFeatureScope.encrypted(currencyResolver: _currencyResolver);
  final NotificationListenerRegistrationService
  _notificationListenerRegistration = NotificationListenerRegistrationService(
    gateway: const PlatformNotificationListenerRegistrationGateway(),
    callback: nlCallback,
  );
  final NotificationMigrationReviewService _migrationReviewService =
      const NotificationMigrationReviewService(
        notification: PlatformNotificationMigrationReviewNotifier(),
        announcements:
            SharedPreferencesNotificationMigrationReviewAnnouncementStore(),
      );

  @override
  void initState() {
    super.initState();

    _initializePlatformServices();
    _handleStartup();
  }

  void _initializePlatformServices() {
    // Notifications (Android only)
    if (Platform.isAndroid) {
      _initNotifications();
    }
    // Quick Actions (Android + iOS)
    _initQuickActions();
    // Share to Waterfly III
    _initSharingIntent();
    // App Lifecycle State
    _initLifecycleListener();
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
        final String payload = details!.notificationResponse!.payload!;
        if (payload == notificationListenerHealthPayload) {
          _notificationHealthPayload = true;
        } else if (payload == notificationMigrationReviewPayload) {
          _notificationMigrationReviewPayload = true;
        } else {
          _notificationPayload = .fromJson(jsonDecode(payload));
        }
        if (mounted) setState(() {});
      }
    });
  }

  void _initQuickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      log.info("Was launched from QuickAction $shortcutType");
      _quickAction = shortcutType;
      if (!_startup && navigatorKey.currentState != null) {
        log.finest(() => "App already started, pushing route");
        navigatorKey.currentState!.push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const TransactionPage(),
          ),
        );
      }
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
        unawaited(_ensureNotificationListenerRegistered());
        // If lock is enabled, check if we need to re-authenticate based on timeout (10 mins)
        if (_settingsProvider.lock &&
            (_lcLastOpen?.isBefore(
                  DateTime.now().subtract(const Duration(minutes: 10)),
                ) ??
                false)) {
          log.finest(() => "App resuming, timeout reached. Requiring re-auth.");
          _settingsProvider.sessionLock();
          if (mounted) {
            setState(() => _lcLastOpen = null);
          }
        }
      },
      onPause: () {
        log.finest(() => "Lifecycle: Pause");
        _resourceLabels.invalidate();
        if (_settingsProvider.lock) {
          _lcLastOpen ??= DateTime.now();
        }
      },
    );
  }

  Future<void> _handleStartup() async {
    log.finer(() => "Load Step 1: Loading Settings");
    await _settingsProvider.loadSettings();
    await _ensureNotificationListenerRegistered();

    log.finer(() => "Load Step 2: Sign in");
    await _fireflyService.signInFromStorage();
    await _initializeNotificationMigration();

    log.finer(() => "Loading done.");
    if (mounted) {
      setState(() => _startup = false);
    }
  }

  Future<void> _initializeNotificationMigration() async {
    if (!Platform.isAndroid) return;
    try {
      await _notificationFeatureScope.definitionStore.load();
      await _migrationReviewService.refresh(
        await _notificationFeatureScope.alertStore.load(),
      );
    } catch (error, stackTrace) {
      log.severe(
        'Failed to initialize notification migration.',
        error,
        stackTrace,
      );
    }
  }

  Future<void> _ensureNotificationListenerRegistered() async {
    try {
      await _notificationListenerRegistration.ensureRegistered();
    } catch (error, stackTrace) {
      log.severe(
        'Failed to initialize the notification listener.',
        error,
        stackTrace,
      );
    }
  }

  @override
  void dispose() {
    unawaited(_resourceLabels.close());
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

  Widget _getHome(SettingsProvider settings, FireflyService firefly) {
    // 1. Show Splash during initial startup or until settings are loaded
    if (_startup || !settings.loaded) {
      log.finest(
        () =>
            "_getHome: showing splash (startup: $_startup, settings: ${settings.loaded})",
      );
      return const SplashPage();
    }

    // 2. Show LockPage if security is enabled and user isn't authenticated
    if (settings.lock && !settings.isSessionAuthed) {
      log.finest(
        () =>
            "_getHome: showing lockpage (authed: ${settings.isSessionAuthed})",
      );
      return LockPage(onSuccess: settings.sessionAuthed);
    }

    // 3. Handle Login/Errors
    if (firefly.storageSignInException != null) {
      log.finest(() => "_getHome: showing splash (storageSignInException)");
      return const SplashPage();
    }

    if (!firefly.signedIn) {
      log.finest(() => "_getHome: showing login");
      return const LoginPage();
    }

    // 4. Handle Deep Links
    if (_notificationHealthPayload || _notificationMigrationReviewPayload) {
      log.finest(() => "_getHome: showing notification setup");
      return const NotificationDefinitionsPage(showAppBar: true);
    }
    if (_notificationPayload != null ||
        _quickAction == "action_transaction_add" ||
        (_filesSharedToApp?.isNotEmpty ?? false)) {
      log.finest(() => "_getHome: showing transaction");
      return TransactionPage(
        notification: _notificationPayload,
        files: _filesSharedToApp,
      );
    }

    // 5. Default to Home
    log.finest(() => "_getHome: showing navpage");
    return const NavPage();
  }

  @override
  Widget build(BuildContext context) {
    log.fine(() => "WaterflyApp() building");

    return DynamicColorBuilder(
      builder: (ColorScheme? cSchemeDynamicLight, ColorScheme? cSchemeDynamicDark) {
        final ColorScheme cSchemeLight = .fromSeed(seedColor: Colors.blue);
        final ColorScheme cSchemeDark =
            .fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ).copyWith(
              surfaceContainerHighest: Colors.blueGrey.shade900,
              onSurfaceVariant: Colors.white,
            );

        log.finest(
          () =>
              "has dynamic color? light: ${cSchemeDynamicLight != null}, dark: ${cSchemeDynamicDark != null}",
        );

        return MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<FireflyService>.value(
              value: _fireflyService,
            ),
            Provider<FireflyResourceLabelResolver>.value(
              value: _resourceLabels,
            ),
            Provider<FireflyCurrencyResolver>.value(value: _currencyResolver),
            ChangeNotifierProvider<SettingsProvider>.value(
              value: _settingsProvider,
            ),
            ChangeNotifierProvider<LayoutProvider>.value(
              value: _layoutProvider,
            ),
            Provider<NotificationFeatureScope>.value(
              value: _notificationFeatureScope,
            ),
            ChangeNotifierProvider<NotificationDefinitionsViewModel>.value(
              value: _notificationFeatureScope.definitionsViewModel,
            ),
            ChangeNotifierProvider<RecentNotificationsViewModel>.value(
              value: _notificationFeatureScope.recentNotificationsViewModel,
            ),
            ChangeNotifierProvider<NotificationAlertsViewModel>.value(
              value: _notificationFeatureScope.alertsViewModel,
            ),
            ChangeNotifierProvider<NotificationListenerHealthViewModel>.value(
              value: _notificationFeatureScope.healthViewModel,
            ),
          ],
          builder: (BuildContext context, _) {
            final SettingsProvider settings = context.watch<SettingsProvider>();
            final FireflyService firefly = context.watch<FireflyService>();
            final bool useDynamicLight =
                settings.dynamicColors && cSchemeDynamicLight != null;
            final bool useDynamicDark =
                settings.dynamicColors && cSchemeDynamicDark != null;
            final ColorScheme lightScheme = useDynamicLight
                ? cSchemeDynamicLight.harmonized()
                : cSchemeLight;
            final ColorScheme darkScheme = useDynamicDark
                ? cSchemeDynamicDark.harmonized()
                : cSchemeDark;

            return MaterialApp(
              title: 'Waterfly III',
              theme: ThemeData(
                brightness: .light,
                colorScheme: lightScheme,
                useMaterial3: true,
                extensions: <ThemeExtension<dynamic>>[
                  if (useDynamicLight)
                    NotificationCardTheme(
                      surfaceColor: lightScheme.surfaceContainerLowest,
                      nestedSurfaceColor: lightScheme.surfaceContainerLow,
                      deepNestedSurfaceColor: lightScheme.surfaceContainer,
                    ),
                  const TransactionColors(
                    positiveColor: Colors.green,
                    negativeColor: Colors.red,
                    transferColor: Colors.blue,
                    neutralColor: Colors.grey,
                  ),
                ],
                // See https://github.com/flutter/flutter/issues/131042#issuecomment-1690737834
                appBarTheme: const AppBarTheme(shape: RoundedRectangleBorder()),
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.android:
                        PredictiveBackPageTransitionsBuilder(),
                  },
                ),
              ),
              darkTheme: ThemeData(
                brightness: .dark,
                colorScheme: darkScheme,
                useMaterial3: true,
                extensions: <ThemeExtension<dynamic>>[
                  TransactionColors(
                    positiveColor: Colors.green,
                    negativeColor: Colors.red.shade300,
                    transferColor: Colors.blue,
                    neutralColor: Colors.grey,
                  ),
                  if (useDynamicDark)
                    NotificationCardTheme(
                      surfaceColor: darkScheme.surfaceContainerHigh,
                      nestedSurfaceColor: darkScheme.surfaceContainerLow,
                      deepNestedSurfaceColor: darkScheme.surfaceContainer,
                    ),
                ],
              ),
              themeMode: settings.theme,
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                S.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: S.supportedLocales,
              locale: settings.locale,
              navigatorKey: navigatorKey,
              home: _getHome(settings, firefly),
            );
          },
        );
      },
    );
  }
}
