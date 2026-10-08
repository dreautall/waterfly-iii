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
