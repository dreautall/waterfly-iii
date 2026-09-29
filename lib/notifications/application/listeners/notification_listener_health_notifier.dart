abstract interface class NotificationListenerHealthNotifier {
  Future<void> showActive(int occurrenceCount);

  Future<void> clearActive();
}

class NoopNotificationListenerHealthNotifier
    implements NotificationListenerHealthNotifier {
  const NoopNotificationListenerHealthNotifier();

  @override
  Future<void> showActive(int occurrenceCount) async {}

  @override
  Future<void> clearActive() async {}
}
