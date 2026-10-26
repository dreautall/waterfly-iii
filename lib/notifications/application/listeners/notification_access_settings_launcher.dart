abstract interface class NotificationAccessSettingsLauncher {
  Future<bool> openNotificationAccessSettings();
}

class UnavailableNotificationAccessSettingsLauncher
    implements NotificationAccessSettingsLauncher {
  const UnavailableNotificationAccessSettingsLauncher();

  @override
  Future<bool> openNotificationAccessSettings() async => false;
}
