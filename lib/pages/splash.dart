import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/widgets/logo.dart';

final Logger log = Logger("Pages.Splash");

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Splash.Page");
    final AuthStatus status = context.select((FireflyService f) => f.status);
    log.finest(() => "build(status: $status)");

    Widget page;

    if (status == AuthStatus.unauthenticated ||
        status == AuthStatus.authenticating ||
        status == AuthStatus.uninitialized) {
      log.finest(() => "show spinner");
      page = Container(
        alignment: const Alignment(0, 0),
        child: const CircularProgressIndicator.adaptive(),
      );

      // :TODO: move to after authentication
      const QuickActions().setShortcutItems(<ShortcutItem>[
        ShortcutItem(
          type: "action_transaction_add",
          localizedTitle: S.of(context).transactionTitleAdd,
          icon: "action_icon_add",
        ),
      ]);
    } else {
      log.finer(() => "error available --> show error");
      final Object? error = context
          .read<FireflyService>()
          .storageSignInException;
      String errorDetails =
          "Host: ${context.read<FireflyService>().lastTriedHost}";
      final String errorDescription = () {
        if (error is AuthErrorStatusCode) {
          final AuthErrorStatusCode errorType = error;
          errorDetails += "\n";
          errorDetails += S.of(context).errorStatusCode(errorType.code);
          return errorType.cause;
        } else if (error is AuthErrorVersionTooLow) {
          final AuthErrorVersionTooLow errorType = error;
          errorDetails += "\n";
          errorDetails += S
              .of(context)
              .errorMinAPIVersion(errorType.requiredVersion.toString());
          return errorType.cause;
        } else if (error is AuthError) {
          final AuthError errorType = error;
          return errorType.cause;
        }
        errorDetails += "\n$error";
        return S.of(context).errorUnknown;
      }();
      page = SizedBox(
        width: .infinity,
        child: Column(
          children: <Widget>[
            AnimatedHeight(
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const .all(12),
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
                  padding: const .all(12),
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
              alignment: .center,
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
                  child: Navigator.canPop(context)
                      ? Text(
                          MaterialLocalizations.of(context).backButtonTooltip,
                        )
                      : Text(S.of(context).formButtonResetLogin),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<FireflyService>().signInFromStorage();
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
            padding: const .all(24),
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
