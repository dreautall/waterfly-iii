import 'dart:io';

import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_registration_service.dart';

class PlatformNotificationListenerRegistrationGateway
    implements NotificationListenerRegistrationGateway {
  const PlatformNotificationListenerRegistrationGateway();

  @override
  bool get isSupported => Platform.isAndroid;

  @override
  Future<bool> isAccessGranted() =>
      NotificationServicePlugin.instance.isServicePermissionGranted();

  @override
  Future<void> requestPermissionsIfDenied() async {
    await NotificationServicePlugin.instance.requestPermissionsIfDenied();
  }

  @override
  Future<void> initialize(NotificationListenerEntryPoint callback) =>
      NotificationServicePlugin.instance.initialize(callback);
}
