import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_post_permission_requester.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_post_permission_requester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel(
    'waterflyiii/notification_settings_test',
  );
  late bool supportsRuntimePermission;
  late bool opensSettings;
  late List<String> methodCalls;

  setUp(() {
    supportsRuntimePermission = true;
    opensSettings = true;
    methodCalls = <String>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
          methodCalls.add(call.method);
          return switch (call.method) {
            'supportsRuntimeNotificationPermission' =>
              supportsRuntimePermission,
            'openAppNotificationSettings' => opensSettings,
            _ => null,
          };
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'requests runtime permission when the Android version supports it',
    () async {
      int requestCount = 0;
      final PlatformNotificationPostPermissionRequester requester =
          PlatformNotificationPostPermissionRequester(
            channel: channel,
            isAndroid: true,
            requestRuntimePermission: () async {
              requestCount++;
              return true;
            },
          );

      final NotificationPostPermissionRequestResult result = await requester
          .requestPermission();

      expect(result, NotificationPostPermissionRequestResult.granted);
      expect(requestCount, 1);
      expect(methodCalls, <String>['supportsRuntimeNotificationPermission']);
    },
  );

  test('reports a denied runtime permission', () async {
    final PlatformNotificationPostPermissionRequester requester =
        PlatformNotificationPostPermissionRequester(
          channel: channel,
          isAndroid: true,
          requestRuntimePermission: () async => false,
        );

    expect(
      await requester.requestPermission(),
      NotificationPostPermissionRequestResult.denied,
    );
    expect(methodCalls, <String>['supportsRuntimeNotificationPermission']);
  });

  test(
    'opens app notification settings without runtime permission support',
    () async {
      supportsRuntimePermission = false;
      int requestCount = 0;
      final PlatformNotificationPostPermissionRequester requester =
          PlatformNotificationPostPermissionRequester(
            channel: channel,
            isAndroid: true,
            requestRuntimePermission: () async {
              requestCount++;
              return true;
            },
          );

      expect(
        await requester.requestPermission(),
        NotificationPostPermissionRequestResult.settingsOpened,
      );
      expect(requestCount, 0);
      expect(methodCalls, <String>[
        'supportsRuntimeNotificationPermission',
        'openAppNotificationSettings',
      ]);

      methodCalls.clear();
      opensSettings = false;
      expect(
        await requester.requestPermission(),
        NotificationPostPermissionRequestResult.failed,
      );
      expect(methodCalls, <String>[
        'supportsRuntimeNotificationPermission',
        'openAppNotificationSettings',
      ]);
    },
  );
}
