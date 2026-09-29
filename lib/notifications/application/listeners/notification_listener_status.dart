class NotificationListenerStatus {
  const NotificationListenerStatus(
    this.servicePermission,
    this.serviceRunning,
    this.notificationPermission,
  );

  final bool servicePermission;
  final bool serviceRunning;
  final bool notificationPermission;
}

abstract interface class NotificationListenerStatusLoader {
  Future<NotificationListenerStatus> load();
}

class UnavailableNotificationListenerStatusLoader
    implements NotificationListenerStatusLoader {
  const UnavailableNotificationListenerStatusLoader();

  @override
  Future<NotificationListenerStatus> load() =>
      Future<NotificationListenerStatus>.value(
        const NotificationListenerStatus(false, false, false),
      );
}
