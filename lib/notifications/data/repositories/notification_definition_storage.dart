class NotificationDefinitionInitializationResult {
  const NotificationDefinitionInitializationResult({
    required this.data,
    required this.initializedByCaller,
  });

  final Map<String, dynamic> data;
  final bool initializedByCaller;
}

abstract interface class NotificationDefinitionStorage {
  Future<Map<String, dynamic>?> read();

  Future<void> write(Map<String, dynamic> data);

  Future<NotificationDefinitionInitializationResult> initializeIfAbsent(
    Map<String, dynamic> data,
  );
}

class NotificationDefinitionStorageMutation<T> {
  const NotificationDefinitionStorageMutation.changed(this.value)
    : changed = true;

  const NotificationDefinitionStorageMutation.unchanged(this.value)
    : changed = false;

  final T value;
  final bool changed;
}

abstract interface class AtomicNotificationDefinitionStorage
    implements NotificationDefinitionStorage {
  Future<T> mutate<T>(
    NotificationDefinitionStorageMutation<T> Function(Map<String, dynamic> data)
    mutation,
  );
}
