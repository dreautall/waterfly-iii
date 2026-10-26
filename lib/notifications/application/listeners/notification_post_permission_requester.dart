abstract interface class NotificationPostPermissionRequester {
  Future<bool> requestPermission();
}

class UnavailableNotificationPostPermissionRequester
    implements NotificationPostPermissionRequester {
  const UnavailableNotificationPostPermissionRequester();

  @override
  Future<bool> requestPermission() async => false;
}
