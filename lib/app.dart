import 'package:flutter/material.dart';

import 'pages/login.dart';
import 'pages/navigation.dart';
import 'auth.dart';
import 'pages/splash.dart';

class WaterflyApp extends StatefulWidget {
  const WaterflyApp({Key? key}) : super(key: key);

  @override
  State<WaterflyApp> createState() => _WaterflyAppState();
}

class _WaterflyAppState extends State<WaterflyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  final _firefly = FireflyService();
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
    print("handleAuthStateChanged()");
    if (!_firefly.signedIn) {
      print("handleAuthStateChanged() -> not signed in");
      setState(() {
        _loggedIn = false;
      });
    } else {
      print("handleAuthStateChanged() -> logged in");
      _loggedIn = true;
    }
    setState(() {
      print("handleAuthStateChanged() -> loading = false");
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("WaterflyApp() building, _loggedIn: $_loggedIn, _loading: $_loading");

    // This is only called if the state refreshes, so let's always pop back to the beginning
    // :TODO: enable again
    //_navigator.currentState?.popUntil((route) => route.isFirst);

    return FireflyProvider(
      fireflyService: _firefly,
      child: MaterialApp(
        title: 'Waterfly III',
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          useMaterial3: true,
        ),
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
