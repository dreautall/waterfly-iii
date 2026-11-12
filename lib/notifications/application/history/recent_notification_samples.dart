import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

Future<List<NotificationSample>> loadRecentNotificationSamples({
  required NotificationHistoryStore historyStore,
  required String applicationId,
  int limit = 8,
}) async {
  final List<NotificationHistoryEntry> entries;
  if (historyStore
      case final NotificationHistoryApplicationStore applicationStore) {
    entries = await applicationStore.loadRecentForApplication(
      applicationId: applicationId,
      limit: limit * 3,
    );
  } else {
    entries = await historyStore.load();
  }
  final List<NotificationHistoryEntry> candidates =
      entries
          .where(
            (NotificationHistoryEntry entry) =>
                entry.applicationId == applicationId &&
                entry.title.trim().isNotEmpty &&
                entry.body.trim().isNotEmpty,
          )
          .toList()
        ..sort((NotificationHistoryEntry left, NotificationHistoryEntry right) {
          final int receivedAt = right.receivedAt.compareTo(left.receivedAt);
          return receivedAt != 0 ? receivedAt : right.id.compareTo(left.id);
        });
  final List<NotificationHistoryEntry> selected = <NotificationHistoryEntry>[];
  for (final NotificationHistoryEntry candidate in candidates) {
    final bool isRepeatedDelivery = selected.any(
      (NotificationHistoryEntry existing) =>
          existing.title == candidate.title &&
          existing.body == candidate.body &&
          existing.receivedAt.difference(candidate.receivedAt).abs() <=
              const Duration(seconds: 1),
    );
    if (!isRepeatedDelivery) {
      selected.add(candidate);
    }
    if (selected.length == limit) break;
  }
  return selected
      .map(
        (NotificationHistoryEntry entry) => NotificationSample(
          title: entry.title,
          body: entry.body,
          receivedAt: entry.receivedAt,
        ),
      )
      .toList(growable: false);
}
