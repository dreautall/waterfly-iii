import 'dart:io' show HandshakeException;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/widgets/logo.dart';

final Logger log = Logger("Pages.Splash");

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, this.host, this.apiKey}) : super(key: key);

  final String? host;
  final String? apiKey;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Logger log = Logger("Pages.Splash.Page");

  Object? _loginError;

  void _login(String? host, String? apiKey) async {
    log.fine(() => "SplashPage->_login()");

    bool success = false;

    try {
      if (host == null || apiKey == null) {
        log.finer(() => "SplashPage->_login() from storage");
        success = await context.read<FireflyService>().signInFromStorage();
      } else {
        log.finer(() =>
            "SplashPage->_login() with credentials: $host, apiKey apiKey ${apiKey.isEmpty ? "unset" : "set"}");
        success = await context.read<FireflyService>().signIn(host, apiKey);
      }
    } catch (e, stackTrace) {
      log.warning(
          "_login got exceptionassigning to _loginError", e, stackTrace);
      setState(() {
        _loginError = e;
      });
    }

    log.fine(() => "_login() returning $success");

    return;
  }

  @override
  void initState() {
    super.initState();

    if (widget.host != null && widget.apiKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        log.finest(() => "initState() scheduling login");
        _login(widget.host, widget.apiKey);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build(loginError: $_loginError)");

    if (context.read<FireflyService>().signedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    Widget page;

    _loginError ??=
        context.select((FireflyService f) => f.storageSignInException);

    if (_loginError == null) {
      log.finer(() => "_loginError null --> show spinner");
      page = Container(
        alignment: const Alignment(0, 0),
        child: const CircularProgressIndicator(),
      );
    } else {
      log.finer(() => "_loginError available --> show error");
      String errorDetails =
          "Host: ${context.read<FireflyService>().lastTriedHost}";
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
            AnimatedHeight(
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
            AnimatedHeight(
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
                      context.read<FireflyService>().signOut();
                    }
                  },
                  child: Navigator.canPop(context)
                      ? Text(
                          MaterialLocalizations.of(context).backButtonTooltip)
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

    return Scaffold(
      body: SafeArea(
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
                  AnimatedHeight(
                    child: page,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
