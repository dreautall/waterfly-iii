import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/widgets/logo.dart';

final Logger log = Logger("Pages.Splash");

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.host, this.apiKey});

  final String? host;
  final String? apiKey;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Logger log = Logger("Pages.Splash.Page");

  Object? _loginError;

  Future<void> _login(String? host, String? apiKey) async {
    log.fine(() => "SplashPage->_login()");

    bool success = false;

    try {
      if (host == null || apiKey == null) {
        log.finer(() => "SplashPage->_login() from storage");
        success = await context.read<FireflyService>().signInFromStorage();
      } else {
        log.finer(
          () =>
              "SplashPage->_login() with credentials: $host, apiKey ${apiKey.isEmpty ? "unset" : "set"}",
        );
        success = await context.read<FireflyService>().signIn(host, apiKey);
      }
    } catch (e, stackTrace) {
      log.warning(
        "_login got exception, assigning to _loginError",
        e,
        stackTrace,
      );
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

    _loginError ??= context.select(
      (FireflyService f) => f.storageSignInException,
    );

    if (_loginError == null) {
      log.finer(() => "_loginError null --> show spinner");
      page = Container(
        alignment: const Alignment(0, 0),
        child: const CircularProgressIndicator(),
      );
      const QuickActions().setShortcutItems(<ShortcutItem>[
        ShortcutItem(
          type: "action_transaction_add",
          localizedTitle: S.of(context).transactionTitleAdd,
          icon: "action_icon_add",
        ),
      ]);
    } else {
      log.finer(() => "_loginError available --> show error");
      String errorDetails =
          "Host: ${context.read<FireflyService>().lastTriedHost}";
      final String errorDescription = () {
        if (_loginError is AuthErrorHost ||
            _loginError is AuthErrorApiKey ||
            _loginError is AuthErrorNoInstance ||
            _loginError is AuthErrorVersionInvalid) {
          final AuthError errorType = _loginError as AuthError;
          return errorType.cause;
        } else if (_loginError is AuthErrorStatusCode) {
          final AuthErrorStatusCode errorType =
              _loginError as AuthErrorStatusCode;
          errorDetails += "\n";
          errorDetails += S.of(context).errorStatusCode(errorType.code);
          return errorType.cause;
        } else if (_loginError is AuthErrorVersionTooLow) {
          final AuthErrorVersionTooLow errorType =
              _loginError as AuthErrorVersionTooLow;
          errorDetails += "\n";
          errorDetails += S
              .of(context)
              .errorMinAPIVersion(errorType.requiredVersion.toString());
          return errorType.cause;
        }
        errorDetails += "\n$_loginError";
        return S.of(context).errorUnknown;
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
                      height: 2,
                      color: Theme.of(context).colorScheme.error,
                    ),
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
                      height: 2,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              spacing: 12,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      context.read<FireflyService>().signOut();
                    }
                  },
                  child:
                      Navigator.canPop(context)
                          ? Text(
                            MaterialLocalizations.of(context).backButtonTooltip,
                          )
                          : Text(S.of(context).formButtonResetLogin),
                ),
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
            ),
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
                  AnimatedHeight(child: page),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
