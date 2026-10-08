import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';

class NotificationHistoryEntry {
  const NotificationHistoryEntry({
    required this.id,
    required this.applicationId,
    required this.title,
    required this.body,
    required this.receivedAt,
    this.processingOutcome,
  });

  final String id;
  final String applicationId;
  final String title;
  final String body;
  final DateTime receivedAt;
  final NotificationProcessingOutcome? processingOutcome;
}
