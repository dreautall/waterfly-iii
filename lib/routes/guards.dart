import 'package:kaisel/kaisel.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/auth.dart' show FireflyService;
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
  if (!firefly.signedIn) {
    // Force-redirect any mutation to the login screen.
    log.finest(() => "authGuard: not logged in, forcing LoginRoute");
    return <AppRoute>[const LoginRoute()];
  }
  return proposed;
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
        log.finest(
          () => "lockGuard: should lock and not authed, forcing LockRoute",
        );
        return <AppRoute>[LockRoute(settings.sessionAuthed)];
      }
      return proposed;
    };
