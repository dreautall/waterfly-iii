import 'dart:io' show HandshakeException;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/widgets/logo.dart';
import 'package:waterflyiii/widgets/animatedheightcard.dart';
import 'package:waterflyiii/auth.dart';

enum SplashState {
  login,
  error,
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, this.host, this.apiKey}) : super(key: key);

  final String? host;
  final String? apiKey;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Object? _loginError;

  void _login(String? host, String? apiKey) async {
    debugPrint("SplashPage->_login()");

    bool success = false;

    try {
      if (host == null || apiKey == null) {
        debugPrint("SplashPage->_login() from storage");
        success = await FireflyProvider.of(context).signInFromStorage();
      } else {
        debugPrint("SplashPage->_login() with credentials: $host, $apiKey");
        success = await FireflyProvider.of(context).signIn(host, apiKey);
      }
    } catch (e) {
      debugPrint(
          "SplashPage->_login got exception $e, assigning to _loginError");
      setState(() {
        _loginError = e;
      });
    }

    debugPrint("SplashPage->_login() returning $success");

    return;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("initState() scheduling login");
      _login(widget.host, widget.apiKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("splash build(), current _loginError: $_loginError");
    if (FireflyProvider.of(context).signedIn) {
      return const Text("");
    }

    Widget page;

    if (_loginError == null) {
      debugPrint("_loginError null --> show spinner");
      page = Container(
        alignment: const Alignment(0, 0),
        child: const CircularProgressIndicator(),
      );
    } else {
      debugPrint("_loginError available --> show error");
      String errorDetails =
          "Host: ${FireflyProvider.of(context).lastTriedHost}";
      final String errorDescription = () {
        switch (_loginError.runtimeType) {
          case AuthErrorHost:
          case AuthErrorApiKey:
          case AuthErrorNoInstance:
            AuthError errorType = _loginError as AuthError;
            return errorType.cause;
          case AuthErrorStatusCode:
            AuthErrorStatusCode errorType = _loginError as AuthErrorStatusCode;
            errorDetails += "\n";
            errorDetails += S.of(context).errorStatusCode(errorType.code);
            return errorType.cause;
          case HandshakeException:
            return S.of(context).errorInvalidSSLCert;
          default:
            errorDetails += "\n$_loginError";
            return S.of(context).errorUnknown;
        }
      }();
      page = SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            AnimatedHeightCard(
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    errorDescription,
                    style: TextStyle(
                        height: 2, color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ),
            AnimatedHeightCard(
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    errorDetails,
                    style: TextStyle(
                        height: 2, color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      FireflyProvider.of(context).signOut();
                    }
                  },
                  child: Navigator.canPop(context)
                      ? Text(S.of(context).formButtonBack)
                      : Text(S.of(context).formButtonResetLogin),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _loginError = null;
                    });
                    _login(widget.host, widget.apiKey);
                  },
                  child: Text(S.of(context).formButtonTryAgain),
                ),
              ],
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const AppLogo(),
                const SizedBox(height: 20),
                AnimatedHeightCard(
                  child: page,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
