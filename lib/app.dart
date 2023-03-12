import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/pages/login.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/pages/splash.dart';

class WaterflyApp extends StatefulWidget {
  const WaterflyApp({Key? key}) : super(key: key);

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  final FireflyService _firefly = FireflyService();
  bool _loggedIn = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _firefly.addListener(_handleAuthStateChanged);
  }

  @override
  void dispose() {
    _firefly.removeListener(_handleAuthStateChanged);
    _firefly.dispose();

    super.dispose();
  }

  void _handleAuthStateChanged() {
    debugPrint("handleAuthStateChanged()");
    if (!_firefly.signedIn) {
      debugPrint("handleAuthStateChanged() -> not signed in");
      setState(() {
        _loggedIn = false;
      });
    } else {
      debugPrint("handleAuthStateChanged() -> logged in");
      _loggedIn = true;
    }
    setState(() {
      debugPrint("handleAuthStateChanged() -> loading = false");
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "WaterflyApp() building, _loggedIn: $_loggedIn, _loading: $_loading");

    // This is only called if the state refreshes, so let's always pop back to the beginning
    _navigator.currentState?.popUntil((Route<dynamic> route) => route.isFirst);

    return FireflyProvider(
      fireflyService: _firefly,
      child: MaterialApp(
        title: 'Waterfly III',
        theme: ThemeData(
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue, brightness: Brightness.dark)
              .copyWith(
            surfaceVariant: Colors.blueGrey.shade900,
            onSurfaceVariant: Colors.white,
          ),
          useMaterial3: true,
        ).copyWith(),
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorKey: _navigator,
        home: _loading
            ? const SplashPage()
            : _loggedIn
                ? const NavPage()
                : const LoginPage(),
      ),
    );
  }
}
