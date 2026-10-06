import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

class NotificationHistoryCursor {
  const NotificationHistoryCursor({required this.receivedAt, required this.id});

  final DateTime receivedAt;
  final String id;
}

class NotificationHistoryPage {
  const NotificationHistoryPage({
    required this.entries,
    required this.hasMore,
    this.nextCursor,
  });

  final List<NotificationHistoryEntry> entries;
  final bool hasMore;
  final NotificationHistoryCursor? nextCursor;
}

abstract interface class NotificationHistoryStore {
  Future<void> record(NotificationHistoryEntry entry);

  Future<List<NotificationHistoryEntry>> load();

  Future<bool> linkTransaction(String historyEntryId, String transactionId);

  Future<void> clearForApplication(String applicationId);

  Future<void> clearAll();
}

abstract interface class NotificationHistoryPageStore {
  Future<NotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  });
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
