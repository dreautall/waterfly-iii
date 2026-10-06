import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_history_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class _UnavailableDatabaseProvider implements DatabaseProvider<Database> {
  @override
  Future<Database> get database =>
      Future<Database>.error(StateError('Database should not be used.'));
}

class _RecordingHistoryStore extends SqlcipherNotificationHistoryStore {
  _RecordingHistoryStore() : super(_UnavailableDatabaseProvider());

  final List<NotificationHistoryEntry> entries = <NotificationHistoryEntry>[];
  DateTime? clearedBefore;
  NotificationHistoryCursor? requestedCursor;
  int? requestedLimit;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {
    entries.add(entry);
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async => entries;

  @override
  Future<NotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  }) async {
    requestedCursor = before;
    requestedLimit = limit;
    return NotificationHistoryPage(entries: entries, hasMore: false);
  }

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async {
    final int index = entries.indexWhere(
      (NotificationHistoryEntry entry) => entry.id == historyEntryId,
    );
    if (index == -1 || entries[index].processingOutcome == null) return false;
    final NotificationHistoryEntry entry = entries[index];
    entries[index] = NotificationHistoryEntry(
      id: entry.id,
      applicationId: entry.applicationId,
      title: entry.title,
      body: entry.body,
      receivedAt: entry.receivedAt,
      processingOutcome: entry.processingOutcome!.withTransactionId(
        transactionId,
        origin: NotificationTransactionCreationOrigin.user,
      ),
    );
    return true;
  }

  @override
  Future<bool> unlinkTransaction(
    String historyEntryId,
    String expectedTransactionId,
  ) async {
    final int index = entries.indexWhere(
      (NotificationHistoryEntry entry) => entry.id == historyEntryId,
    );
    if (index == -1 ||
        entries[index].processingOutcome?.transactionId !=
            expectedTransactionId) {
      return false;
    }
    final NotificationHistoryEntry entry = entries[index];
    entries[index] = NotificationHistoryEntry(
      id: entry.id,
      applicationId: entry.applicationId,
      title: entry.title,
      body: entry.body,
      receivedAt: entry.receivedAt,
      processingOutcome: entry.processingOutcome!.withoutTransactionLink(),
    );
    return true;
  }

  @override
  Future<void> clearBefore(DateTime cutoff) async {
    clearedBefore = cutoff;
  }

  @override
  Future<void> remove(String id) async {
    entries.removeWhere((NotificationHistoryEntry entry) => entry.id == id);
  }

  @override
  Future<void> restore(NotificationHistoryEntry entry) => record(entry);
}

class _SettingsStore implements NotificationProcessingSettingsStore {
  _SettingsStore(this.settings);

  NotificationProcessingSettings settings;

  @override
  Future<NotificationProcessingSettings> load() async => settings;

  @override
  Future<void> reset() async {
    settings = NotificationProcessingSettings.defaults;
  }

  @override
  Future<void> save(NotificationProcessingSettings settings) async {
    this.settings = settings;
  }
}

void main() {
  const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
    status: NotificationProcessingOutcomeStatus.matched,
    definition: NotificationHistoryReference(id: 'bank', name: 'Example Bank'),
    hasTransactionIntent: true,
    transactionPatch: TransactionPatch(<TransactionField, String>{
      TransactionField.amount: '12.50',
    }),
  );
  final NotificationHistoryEntry entry = NotificationHistoryEntry(
    id: 'delivery',
    applicationId: 'com.example.bank',
    title: 'Card payment',
    body: 'Paid 12.50 CAD',
    receivedAt: DateTime(2026, 9, 26),
    processingOutcome: outcome,
  );

  test('prunes retention before loading a cursor page', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore()
      ..entries.add(entry);
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyRetention: NotificationHistoryRetention.thirtyDays,
            ),
          ),
        );
    final NotificationHistoryCursor cursor = NotificationHistoryCursor(
      receivedAt: entry.receivedAt,
      id: entry.id,
    );

    final NotificationHistoryPage page = await repository.loadPage(
      before: cursor,
      limit: 30,
    );

    expect(page.entries, <NotificationHistoryEntry>[entry]);
    expect(store.requestedCursor, same(cursor));
    expect(store.requestedLimit, 30);
    expect(store.clearedBefore, isNotNull);
  });

  test(
    'does not retain notification outcomes when history is disabled',
    () async {
      final _RecordingHistoryStore store = _RecordingHistoryStore();
      final NotificationHistoryRepository repository =
          NotificationHistoryRepository(
            store,
            settingsStore: _SettingsStore(
              const NotificationProcessingSettings(
                historyStorageMode: NotificationHistoryStorageMode.disabled,
              ),
            ),
          );

      await repository.record(entry);

      expect(store.entries, isEmpty);
    },
  );

  test('retains outcome metadata without sensitive values', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
            ),
          ),
        );

    await repository.record(entry);

    expect(store.entries.single.title, isEmpty);
    expect(store.entries.single.body, isEmpty);
    expect(
      store.entries.single.processingOutcome?.hasTransactionIntent,
      isTrue,
    );
    expect(store.entries.single.processingOutcome?.transactionPatch, isNull);
  });

  test('retains source content and complete outcome in full mode', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.full,
            ),
          ),
        );

    await repository.record(entry);

    expect(store.entries.single.title, 'Card payment');
    expect(
      store
          .entries
          .single
          .processingOutcome
          ?.transactionPatch
          ?.values[TransactionField.amount],
      '12.50',
    );
  });

  test('links a created transaction to its recorded outcome', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.full,
            ),
          ),
        );
    await repository.record(entry);

    final bool linked = await repository.linkTransaction(
      'delivery',
      'transaction-42',
    );

    expect(linked, isTrue);
    expect(
      store.entries.single.processingOutcome?.transactionId,
      'transaction-42',
    );
    expect(
      store.entries.single.processingOutcome?.transactionCreationOrigin,
      NotificationTransactionCreationOrigin.user,
    );
    expect(
      store
          .entries
          .single
          .processingOutcome
          ?.transactionPatch
          ?.values[TransactionField.amount],
      '12.50',
    );
  });

  test('only unlinks the expected transaction from its outcome', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.full,
            ),
          ),
        );
    await repository.record(entry);
    await repository.linkTransaction('delivery', 'transaction-42');

    expect(
      await repository.unlinkTransaction('delivery', 'replacement-transaction'),
      isFalse,
    );
    expect(
      store.entries.single.processingOutcome?.transactionId,
      'transaction-42',
    );

    expect(
      await repository.unlinkTransaction('delivery', 'transaction-42'),
      isTrue,
    );
    expect(store.entries.single.processingOutcome?.transactionId, isNull);
    expect(
      store
          .entries
          .single
          .processingOutcome
          ?.transactionPatch
          ?.values[TransactionField.amount],
      '12.50',
    );
  });

  test('removes one notification history entry', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.full,
            ),
          ),
        );
    await repository.record(entry);
    await repository.record(
      NotificationHistoryEntry(
        id: 'other-delivery',
        applicationId: entry.applicationId,
        title: 'Other payment',
        body: 'Paid 5.00 CAD',
        receivedAt: DateTime(2026, 9, 27),
      ),
    );

    await repository.remove(entry.id);

    expect(
      store.entries.map((NotificationHistoryEntry item) => item.id),
      <String>['other-delivery'],
    );

    await repository.restore(entry);

    expect(
      store.entries.map((NotificationHistoryEntry item) => item.id),
      <String>['other-delivery', 'delivery'],
    );
  });

  test('does not link a transaction when history is unavailable', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyStorageMode: NotificationHistoryStorageMode.full,
            ),
          ),
        );

    expect(
      await repository.linkTransaction('missing', 'transaction-42'),
      isFalse,
    );
  });

  test(
    'prunes the whole history record using the configured retention',
    () async {
      final _RecordingHistoryStore store = _RecordingHistoryStore();
      final NotificationHistoryRepository repository =
          NotificationHistoryRepository(
            store,
            settingsStore: _SettingsStore(
              const NotificationProcessingSettings(
                historyRetention: NotificationHistoryRetention.sevenDays,
              ),
            ),
          );

      await repository.record(entry);

      expect(store.clearedBefore, isNotNull);
      expect(
        DateTime.now().difference(store.clearedBefore!).inDays,
        inInclusiveRange(6, 7),
      );
    },
  );

  test('does not prune history configured for forever retention', () async {
    final _RecordingHistoryStore store = _RecordingHistoryStore();
    final NotificationHistoryRepository repository =
        NotificationHistoryRepository(
          store,
          settingsStore: _SettingsStore(
            const NotificationProcessingSettings(
              historyRetention: NotificationHistoryRetention.forever,
            ),
          ),
        );

    await repository.record(entry);
    await repository.load();

    expect(store.entries, <NotificationHistoryEntry>[entry]);
    expect(store.clearedBefore, isNull);
  });
}
