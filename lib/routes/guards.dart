import 'package:kaisel/kaisel.dart';
import 'package:waterflyiii/auth.dart' show FireflyService;
import 'package:waterflyiii/routes/routes.dart';
import 'package:waterflyiii/settings.dart' show SettingsProvider;

KaiselGuard<AppRoute> createAuthGuard(FireflyService firefly) =>
    (List<AppRoute> current, List<AppRoute> proposed) {
      final bool goingToAuthScreen = proposed.any(
        (AppRoute r) => r is LoginRoute,
      );
      final bool isLoggedIn = firefly.hasApi;

      if (goingToAuthScreen) {
        // Always allow navigation to the Login route itself.
        return proposed;
      }
      if (!isLoggedIn) {
        // Force-redirect any mutation to the login screen.
        return <AppRoute>[const LoginRoute()];
      }
      return proposed;
    };

KaiselGuard<AppRoute> createLockGuard(SettingsProvider settings) =>
    (List<AppRoute> current, List<AppRoute> proposed) {
      final bool goingToLockScreen = proposed.any(
        (AppRoute r) => r is LockRoute,
      );
      final bool shouldLock = settings.lock;

      if (goingToLockScreen) {
        // Always allow navigation to the Login route itself.
        return proposed;
      }
      if (shouldLock && !settings.isSessionAuthed) {
        // Force-redirect any mutation to the login screen.
        return <AppRoute>[LockRoute(settings.sessionAuthed)];
      }
      return proposed;
    };
