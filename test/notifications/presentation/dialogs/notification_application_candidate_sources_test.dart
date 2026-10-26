import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_candidate_sources.dart';

class _FixedHistoryStore implements NotificationHistoryStore {
  const _FixedHistoryStore(this.entries);

  final List<NotificationHistoryEntry> entries;

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<List<NotificationHistoryEntry>> load() async => entries;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

void main() {
  test(
    'loads application candidates from encrypted notification history',
    () async {
      final NotificationHistoryStorePackageSource source =
          NotificationHistoryStorePackageSource(
            _FixedHistoryStore(<NotificationHistoryEntry>[
              NotificationHistoryEntry(
                id: 'one',
                applicationId: 'com.example.bank',
                title: 'Payment',
                body: 'Paid 10',
                receivedAt: DateTime(2026, 9, 26),
              ),
              NotificationHistoryEntry(
                id: 'two',
                applicationId: 'com.example.wallet',
                title: 'Payment',
                body: 'Paid 20',
                receivedAt: DateTime(2026, 9, 26),
              ),
            ]),
          );

      expect(await source.loadPackageIds(), <String>[
        'com.example.bank',
        'com.example.wallet',
      ]);
    },
  );
}
