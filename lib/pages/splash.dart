import 'dart:io' show HandshakeException;

import 'package:flutter/material.dart';

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
    print("SplashPage->_login()");

    var success = false;

    try {
      if (host == null || apiKey == null) {
        print("SplashPage->_login() from storage");
        success = await FireflyProvider.of(context).signInFromStorage();
      } else {
        print("SplashPage->_login() with credentials: $host, $apiKey");
        success = await FireflyProvider.of(context).signIn(host, apiKey);
      }
    } catch (e) {
      print("SplashPage->_login got exception $e, assigning to _loginError");
      setState(() {
        _loginError = e;
      });
    }

    print("SplashPage->_login() returning $success");
    /*if (success) {
      print("popping");
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    }*/

    return;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("initState() scheduling login");
      _login(widget.host, widget.apiKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("splash build(), current _loginError: $_loginError");
    if (FireflyProvider.of(context).signedIn) {
      return const Text("");
    }

    Widget page;

    if (_loginError == null) {
      print("_loginError null --> show spinner");
      page = Container(
        alignment: const Alignment(0, 0),
        child: const CircularProgressIndicator(),
      );
    } else {
      print("_loginError available --> show error");
      String errorDetails =
          "Host: ${FireflyProvider.of(context).lastTriedHost}";
      final String errorDescription = () {
        switch (_loginError.runtimeType) {
          case AuthErrorHost:
          case AuthErrorApiKey:
          case AuthErrorNoInstance:
            var errorType = _loginError as AuthError;
            return errorType.cause;
          case AuthErrorStatusCode:
            var errorType = _loginError as AuthErrorStatusCode;
            errorDetails += "\nStatus Code: ${errorType.code}";
            return errorType.cause;
          case HandshakeException:
            return "Invalid SSL Certificate";
          default:
            errorDetails += "\n$_loginError";
            return "Unknown error";
        }
      }();
      page = SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            animatedHeightCard(
              Card(
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
            animatedHeightCard(
              Card(
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
                      ? const Text("Back")
                      : const Text("Reset login"),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _loginError = null;
                    });
                    _login(widget.host, widget.apiKey);
                  },
                  child: const Text("Try again"),
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
                animatedHeightCard(page),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
