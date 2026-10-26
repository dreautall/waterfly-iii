enum NotificationPostPermissionRequestResult {
  granted,
  settingsOpened,
  denied,
  failed,
}

abstract interface class NotificationPostPermissionRequester {
  Future<NotificationPostPermissionRequestResult> requestPermission();
}

class UnavailableNotificationPostPermissionRequester
    implements NotificationPostPermissionRequester {
  const UnavailableNotificationPostPermissionRequester();

  @override
  Future<NotificationPostPermissionRequestResult> requestPermission() async =>
      NotificationPostPermissionRequestResult.failed;
}
