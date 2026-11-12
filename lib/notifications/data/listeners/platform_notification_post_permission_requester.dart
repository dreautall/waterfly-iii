import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_post_permission_requester.dart';

typedef RuntimeNotificationPermissionRequester = Future<bool?> Function();

class PlatformNotificationPostPermissionRequester
    implements NotificationPostPermissionRequester {
  PlatformNotificationPostPermissionRequester({
    MethodChannel channel = const MethodChannel(
      'waterflyiii/notification_settings',
    ),
    bool? isAndroid,
    RuntimeNotificationPermissionRequester? requestRuntimePermission,
  }) : _channel = channel,
       _isAndroid = isAndroid ?? Platform.isAndroid,
       _requestRuntimePermission =
           requestRuntimePermission ?? _requestNotificationsPermission;

  final MethodChannel _channel;
  final bool _isAndroid;
  final RuntimeNotificationPermissionRequester _requestRuntimePermission;

  @override
  Future<NotificationPostPermissionRequestResult> requestPermission() async {
    if (!_isAndroid) return NotificationPostPermissionRequestResult.failed;
    final bool supportsRuntimePermission =
        await _channel.invokeMethod<bool>(
          'supportsRuntimeNotificationPermission',
        ) ??
        false;
    if (!supportsRuntimePermission) {
      return _openSettings();
    }
    final bool permanentlyDenied =
        await _channel.invokeMethod<bool>(
          'isRuntimeNotificationPermissionPermanentlyDenied',
        ) ??
        false;
    if (permanentlyDenied) {
      return _openSettings();
    }
    final bool granted = await _requestRuntimePermission() ?? false;
    await _channel.invokeMethod<void>(
      'markRuntimeNotificationPermissionRequested',
    );
    return granted
        ? NotificationPostPermissionRequestResult.granted
        : NotificationPostPermissionRequestResult.denied;
  }

  Future<NotificationPostPermissionRequestResult> _openSettings() async {
    final bool opened =
        await _channel.invokeMethod<bool>('openAppNotificationSettings') ??
        false;
    return opened
        ? NotificationPostPermissionRequestResult.settingsOpened
        : NotificationPostPermissionRequestResult.failed;
  }

  static Future<bool?> _requestNotificationsPermission() async =>
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
}
