import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

extension NotificationHistoryEntryContext on NotificationHistoryEntry {
  NotificationContext toNotificationContext({String? applicationName}) =>
      NotificationContext(
        applicationId: applicationId,
        applicationName: applicationName,
        deliveryId: id,
        title: title,
        body: body,
        receivedAt: receivedAt,
      );
}

extension NotificationDefinitionSampleContext on NotificationDefinition {
  NotificationContext toSampleContext({
    String? title,
    String? body,
    DateTime? receivedAt,
  }) => NotificationContext(
    applicationId: applicationId,
    applicationName: name,
    title: title ?? sampleTitle ?? '',
    body: body ?? sampleBody ?? '',
    receivedAt: receivedAt ?? sampleReceivedAt,
  );
}

extension NotificationSampleContext on NotificationSample {
  NotificationContext toNotificationContext({
    String? applicationId,
    String? applicationName,
    String? deliveryId,
  }) => NotificationContext(
    applicationId: applicationId,
    applicationName: applicationName,
    deliveryId: deliveryId,
    title: title,
    body: body,
    receivedAt: receivedAt,
  );
}
