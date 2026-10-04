import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaisel_core/src/kaisel_guard.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/routes/guards.dart';
import 'package:waterflyiii/routes/routes.dart';
import 'package:waterflyiii/settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (MethodCall methodCall) async {
            return null;
          },
        );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/shared_preferences'),
          (MethodCall methodCall) async {
            if (methodCall.method == 'getAll') {
              return <String, dynamic>{};
            }
            if (methodCall.method == 'clear') {
              return true;
            }
            return null;
          },
        );
  });

  group('AuthGuard Tests', () {
    late FireflyService fireflyService;

    setUp(() {
      fireflyService = FireflyService();
    });

    test(
      'Redirects to SplashRoute when uninitialized or authenticating',
      () async {
        final KaiselGuard<AppRoute> guard = createAuthGuard(fireflyService);

        final List<AppRoute> result = await Future.value(
          guard(<AppRoute>[], <AppRoute>[const DashboardRoute()]),
        );
        expect(result, equals(<SplashRoute>[const SplashRoute()]));
      },
    );

    test('Redirects to LoginRoute when unauthenticated', () async {
      final KaiselGuard<AppRoute> guard = createAuthGuard(fireflyService);
      await fireflyService.signOut(); // Sets status to unauthenticated

      final List<AppRoute> result = await Future.value(
        guard(<AppRoute>[], <AppRoute>[const DashboardRoute()]),
      );
      expect(result, equals(<LoginRoute>[const LoginRoute()]));
    });

    test('Allows navigation to LoginRoute or SplashRoute explicitly', () async {
      final KaiselGuard<AppRoute> guard = createAuthGuard(fireflyService);

      final List<AppRoute> loginResult = await Future.value(
        guard(<AppRoute>[], <AppRoute>[const LoginRoute()]),
      );
      expect(loginResult, equals(<LoginRoute>[const LoginRoute()]));

      final List<AppRoute> splashResult = await Future.value(
        guard(<AppRoute>[], <AppRoute>[const SplashRoute()]),
      );
      expect(splashResult, equals(<SplashRoute>[const SplashRoute()]));
    });
  });

  group('LockGuard Tests', () {
    late SettingsProvider settingsProvider;

    setUp(() {
      settingsProvider = SettingsProvider();
    });

    test('Allows navigation when lock is disabled', () async {
      final KaiselGuard<AppRoute> guard = createLockGuard(settingsProvider);

      final List<AppRoute> result = await Future.value(
        guard(<AppRoute>[], <AppRoute>[const DashboardRoute()]),
      );
      expect(result, equals(<DashboardRoute>[const DashboardRoute()]));
    });

    test('Allows navigation when going to LockRoute', () async {
      final KaiselGuard<AppRoute> guard = createLockGuard(settingsProvider);

      final List<AppRoute> result = await Future.value(
        guard(<AppRoute>[], <AppRoute>[LockRoute(() {})]),
      );
      expect(result, isA<List<AppRoute>>());
      expect(result.any((AppRoute r) => r is LockRoute), isTrue);
    });
  });
}
