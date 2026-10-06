import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/data/repositories/shared_preferences_notification_processing_settings_store.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

class NotificationHistoryRepository
    implements
        NotificationHistoryStore,
        NotificationHistoryEntryRemovalStore,
        NotificationHistoryTransactionLinkStore {
  NotificationHistoryRepository(
    this._store, {
    NotificationProcessingSettingsStore? settingsStore,
  }) : _settingsStore =
           settingsStore ??
           const SharedPreferencesNotificationProcessingSettingsStore();

  final SqlcipherNotificationHistoryStore _store;
  final NotificationProcessingSettingsStore _settingsStore;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {
    await _pruneExpiredHistory();
    final NotificationProcessingSettings settings = await _settingsStore.load();
    switch (settings.historyStorageMode) {
      case NotificationHistoryStorageMode.disabled:
        return;
      case NotificationHistoryStorageMode.metadataOnly:
        await _store.record(
          NotificationHistoryEntry(
            id: entry.id,
            applicationId: entry.applicationId,
            title: '',
            body: '',
            receivedAt: entry.receivedAt,
            processingOutcome: entry.processingOutcome
                ?.withoutSensitiveDetails(),
          ),
        );
      case NotificationHistoryStorageMode.full:
        await _store.record(entry);
    }
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async {
    await _pruneExpiredHistory();
    return _store.load();
  }

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async {
    await _pruneExpiredHistory();
    return _store.linkTransaction(historyEntryId, transactionId);
  }

  @override
  Future<bool> unlinkTransaction(
    String historyEntryId,
    String expectedTransactionId,
  ) async {
    await _pruneExpiredHistory();
    return _store.unlinkTransaction(historyEntryId, expectedTransactionId);
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    await _store.clearForApplication(applicationId);
  }

  @override
  Future<void> remove(String id) => _store.remove(id);

  @override
  Future<void> restore(NotificationHistoryEntry entry) => _store.restore(entry);

  @override
  Future<void> clearAll() async {
    await _store.clearAll();
  }

  Future<void> _pruneExpiredHistory() async {
    final Duration? retention =
        (await _settingsStore.load()).historyRetention.duration;
    if (retention == null) return;
    await _store.clearBefore(DateTime.now().subtract(retention));
  }
}
