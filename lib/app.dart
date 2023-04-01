import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/pages/login.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/splash.dart';
import 'package:waterflyiii/pages/transaction_detail.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Main Navigator");

class WaterflyApp extends StatefulWidget {
  const WaterflyApp({Key? key}) : super(key: key);

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  bool _startup = true;
  bool _fromNotification = false;
  late NotificationTransaction _notificationPayload;

  @override
  void initState() {
    super.initState();

    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then(
      (NotificationAppLaunchDetails? details) {
        debugPrint("checking NotificationAppLaunchDetails");
        if ((details?.didNotificationLaunchApp ?? false) &&
            (details?.notificationResponse?.payload?.isNotEmpty ?? false)) {
          debugPrint("Was launched from notification!");
          _fromNotification = true;
          _notificationPayload = NotificationTransaction.fromJson(
              jsonDecode(details!.notificationResponse!.payload!));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("WaterflyApp() building");

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
        debugPrint("_startup = $_startup");
        if (_startup) {
          signedIn = false;

          if (!context.select((SettingsProvider s) => s.loaded)) {
            debugPrint("Load Step 1: Loading Settings");
            context.read<SettingsProvider>().loadSettings();
          } else {
            debugPrint("Load Step 2: Signin In");
            context.read<FireflyService>().signInFromStorage().then(
                  (_) => setState(() {
                    debugPrint("set _startup = false");
                    _startup = false;
                  }),
                );
          }
        } else {
          signedIn = context.select((FireflyService f) => f.signedIn);
          debugPrint("signedIn: $signedIn");
        }
        return MaterialApp(
          title: 'Waterfly III',
          theme: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ).copyWith(
              surfaceVariant: Colors.blueGrey.shade900,
              onSurfaceVariant: Colors.white,
            ),
            useMaterial3: true,
          ),
          themeMode: context.select((SettingsProvider s) => s.getTheme),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: context.select((SettingsProvider s) => s.getLocale),
          navigatorKey: navigatorKey,
          home: (_startup ||
                  context.select(
                      (FireflyService f) => f.storageSignInException != null))
              ? const SplashPage()
              : signedIn
                  ? _fromNotification
                      ? TransactionPage(notification: _notificationPayload)
                      : const NavPage()
                  : const LoginPage(),
        );
      },
    );
  }
}
