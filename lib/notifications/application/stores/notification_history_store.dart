import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

abstract interface class NotificationHistoryStore {
  Future<void> record(NotificationHistoryEntry entry);

  Future<List<NotificationHistoryEntry>> load();

  Future<bool> linkTransaction(String historyEntryId, String transactionId);

  Future<void> clearForApplication(String applicationId);

  Future<void> clearAll();
}

abstract interface class NotificationHistoryEntryRemovalStore {
  Future<void> remove(String id);

  Future<void> restore(NotificationHistoryEntry entry);
}

abstract interface class NotificationHistoryTransactionLinkStore {
  Future<bool> unlinkTransaction(
    String historyEntryId,
    String expectedTransactionId,
  );
}
