import 'package:kaisel/kaisel.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/auth.dart' show FireflyService, AuthStatus;
import 'package:waterflyiii/routes/routes.dart';
import 'package:waterflyiii/settings.dart' show SettingsProvider;

KaiselGuard<AppRoute> createAuthGuard(FireflyService firefly) =>
    (List<AppRoute> current, List<AppRoute> proposed) {
      final Logger log = Logger("Guards.AuthGuard");

      log.finest(() => "proposed stack: ${proposed.toString()}");
      log.finest(() => "current stack: ${current.toString()}");

      return switch (firefly.status) {
        // Keep user on SplashRoute for loading OR connection retries
        AuthStatus.uninitialized ||
        AuthStatus.authenticating ||
        AuthStatus.connectionError => <AppRoute>[const SplashRoute()],

        // Send user to LoginRoute only when explicitly unauthenticated
        AuthStatus.unauthenticated => <AppRoute>[const LoginRoute()],

        // Allow target route
        AuthStatus.authenticated => () {
          log.finest(() => "authenticated");
          final List<AppRoute> cleanStack = proposed
              .where((AppRoute r) => r is! SplashRoute && r is! LoginRoute)
              .toList();
          if (cleanStack.isEmpty) {
            cleanStack.insert(0, const NavigatorRoute());
          }

          log.finest(() => "new stack: ${cleanStack.toString()}");

          return cleanStack;
        }(),
      };
    };

KaiselGuard<AppRoute> createLockGuard(SettingsProvider settings) =>
    (List<AppRoute> current, List<AppRoute> proposed) {
      final Logger log = Logger("Guards.LockGuard");

      final bool goingToLockScreen = proposed.any(
        (AppRoute r) => r is LockRoute,
      );

      if (goingToLockScreen) {
        // Always allow navigation to the Login route itself.
        log.finest(() => "goingToLockScreen");
        return proposed;
      }
      if (settings.lock && !settings.isSessionAuthed) {
        // Force-redirect any mutation to the login screen.
        log.finest(() => "forcing LockRoute");
        return <AppRoute>[LockRoute(settings.sessionAuthed)];
      }
      return proposed;
    };
