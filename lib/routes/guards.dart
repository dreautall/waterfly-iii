import 'package:kaisel/kaisel.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/auth.dart' show FireflyService, AuthStatus;
import 'package:waterflyiii/routes/routes.dart';
import 'package:waterflyiii/settings.dart' show SettingsProvider;

final Logger log = Logger("Guards");

KaiselGuard<AppRoute> createAuthGuard(
  FireflyService firefly,
) => (List<AppRoute> current, List<AppRoute> proposed) {
  final bool goingToAuthScreen = proposed.any((AppRoute r) => r is LoginRoute);
  final bool goingToSplashScreen = proposed.any(
    (AppRoute r) => r is SplashRoute,
  );
  if (goingToAuthScreen || goingToSplashScreen) {
    // Always allow navigation to the Login route itself.
    log.finest(
      () =>
          "authGuard: goingToAuthScreen($goingToAuthScreen) || goingToSplashScreen($goingToSplashScreen)",
    );
    return proposed;
  }

  log.finest(() => "authGuard proposed stack: ${proposed.toString()}");
  log.finest(() => "authGuard current stack: ${current.toString()}");

  return switch (firefly.status) {
    // Keep user on SplashRoute for loading OR connection retries
    AuthStatus.uninitialized ||
    AuthStatus.authenticating ||
    AuthStatus.connectionError => <AppRoute>[const SplashRoute()],

    // Send user to LoginRoute only when explicitly unauthenticated
    AuthStatus.unauthenticated => <AppRoute>[const LoginRoute()],

    // Allow target route (DashboardRoute)
    AuthStatus.authenticated => () {
      log.finest(() => "authGuard: authenticated");
      final List<AppRoute> cleanStack = proposed
          .where((AppRoute r) => r is! SplashRoute && r is! LoginRoute)
          .toList();
      if (cleanStack.isEmpty) {
        cleanStack.insert(0, const DashboardRoute());
      }

      return cleanStack;
    }(),
  };
};

KaiselGuard<AppRoute> createLockGuard(SettingsProvider settings) =>
    (List<AppRoute> current, List<AppRoute> proposed) {
      final bool goingToLockScreen = proposed.any(
        (AppRoute r) => r is LockRoute,
      );

      if (goingToLockScreen) {
        // Always allow navigation to the Login route itself.
        log.finest(() => "lockGuard: goingToLockScreen");
        return proposed;
      }
      if (settings.lock && !settings.isSessionAuthed) {
        // Force-redirect any mutation to the login screen.
        log.finest(() => "lockGuard: forcing LockRoute");
        return <AppRoute>[LockRoute(settings.sessionAuthed)];
      }
      return proposed;
    };
