import 'dart:convert';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quick_actions/quick_actions.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:local_auth/local_auth.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/login.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/splash.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("App");

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Main Navigator");

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

  @override
  void initState() {
    super.initState();

    // Notifications
    FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_notification'),
      ),
      onDidReceiveNotificationResponse: nlNotificationTap,
    );

    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then(
      (NotificationAppLaunchDetails? details) {
        log.config("checking NotificationAppLaunchDetails");
        if ((details?.didNotificationLaunchApp ?? false) &&
            (details?.notificationResponse?.payload?.isNotEmpty ?? false)) {
          log.info("Was launched from notification!");
          _notificationPayload = NotificationTransaction.fromJson(
            jsonDecode(details!.notificationResponse!.payload!),
          );
        }
      },
    );

    // Quick Actions
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

    // Share to Waterfly III
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
    FlutterSharingIntent.instance.getInitialSharing().then(
      (List<SharedFile> value) {
        log.config("App was opened via file sharing");
        _filesSharedToApp = value;
      },
    );
  }

  /* Not needed right now, as sharing while the app is open does not work
  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();

    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    log.fine(() => "WaterflyApp() building");

    return DynamicColorBuilder(
      builder: (
        ColorScheme? cSchemeDynamicLight,
        ColorScheme? cSchemeDynamicDark,
      ) {
        ColorScheme cSchemeLight = ColorScheme.fromSeed(
          seedColor: Colors.blue,
        );
        ColorScheme cSchemeDark = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ).copyWith(
          surfaceVariant: Colors.blueGrey.shade900,
          onSurfaceVariant: Colors.white,
        );

        log.finest(() =>
            "has dynamic color? light: ${cSchemeDynamicLight != null}, dark: ${cSchemeDynamicDark != null}");

        return MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<FireflyService>(
              create: (_) => FireflyService(),
            ),
            ChangeNotifierProvider<SettingsProvider>(
              create: (_) => SettingsProvider(),
            ),
          ],
          builder: (BuildContext context, _) {
            late bool signedIn;
            log.finest(() => "_startup = $_startup");
            if (_startup) {
              signedIn = false;

              if (!context.select((SettingsProvider s) => s.loaded)) {
                log.finer(() => "Load Step 1: Loading Settings");
                context.read<SettingsProvider>().loadSettings();
              } else {
                log.finer(() => "Load Step 2: Signin In");
                context.read<FireflyService>().signInFromStorage().then(
                  (bool success) async {
                    if (!success || !context.read<SettingsProvider>().lock) {
                      setState(() {
                        log.finest(() => "set _startup = false");
                        _startup = false;
                      });
                    } else {
                      // Authentication required
                      log.fine("awaiting authentication");
                      final LocalAuthentication auth = LocalAuthentication();
                      final bool authed = await auth.authenticate(
                        localizedReason: "Waterfly III",
                        options: const AuthenticationOptions(
                          useErrorDialogs: false,
                          stickyAuth: true,
                        ),
                      );
                      log.finest("done authing, $authed");
                      if (authed) {
                        setState(() {
                          log.finest(() => "authentication succeeded");
                          _startup = false;
                        });
                      } else {
                        log.shout(() => "authentication failed");
                        // close app
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      }
                    }
                  },
                );
              }
            } else {
              signedIn = context.select((FireflyService f) => f.signedIn);
              if (signedIn) {
                context.read<FireflyService>().tzHandler.setUseServerTime(
                    context.read<SettingsProvider>().useServerTime);
              }
              log.config("signedIn: $signedIn");
            }

            return MaterialApp(
              title: 'Waterfly III',
              theme: ThemeData(
                brightness: Brightness.light,
                colorScheme:
                    context.select((SettingsProvider s) => s.dynamicColors)
                        ? cSchemeDynamicLight?.harmonized() ?? cSchemeLight
                        : cSchemeLight,
                useMaterial3: true,
                // See https://github.com/flutter/flutter/issues/131042#issuecomment-1690737834
                appBarTheme: const AppBarTheme(
                  shape: RoundedRectangleBorder(),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme:
                    context.select((SettingsProvider s) => s.dynamicColors)
                        ? cSchemeDynamicDark?.harmonized() ?? cSchemeDark
                        : cSchemeDark,
                useMaterial3: true,
              ),
              themeMode: context.select((SettingsProvider s) => s.theme),
              localizationsDelegates: S.localizationsDelegates,
              supportedLocales: S.supportedLocales,
              locale: context.select((SettingsProvider s) => s.locale),
              navigatorKey: navigatorKey,
              home: (_startup ||
                      context.select((FireflyService f) =>
                          f.storageSignInException != null))
                  ? const SplashPage()
                  : signedIn
                      ? (_notificationPayload != null ||
                              _quickAction == "action_transaction_add" ||
                              _filesSharedToApp != null)
                          ? TransactionPage(notification: _notificationPayload)
                          : const NavPage()
                      : const LoginPage(),
            );
          },
        );
      },
    );
  }
}
