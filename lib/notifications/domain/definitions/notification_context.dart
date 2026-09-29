class NotificationContext {
  const NotificationContext({
    required this.title,
    required this.body,
    required this.receivedAt,
    this.applicationId,
    this.applicationName,
    this.deliveryId,
  });

  final String? applicationId;
  final String? applicationName;
  final String? deliveryId;
  final String title;
  final String body;
  final DateTime receivedAt;
}
