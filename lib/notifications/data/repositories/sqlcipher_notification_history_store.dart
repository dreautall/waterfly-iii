import 'dart:convert';

import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';

class SqlcipherNotificationHistoryStore
    implements
        NotificationHistoryStore,
        NotificationHistoryPageStore,
        NotificationHistoryEntryRemovalStore,
        NotificationHistoryTransactionLinkStore {
  const SqlcipherNotificationHistoryStore(this._databaseProvider);

  final DatabaseProvider<Database> _databaseProvider;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {
    final Database database = await _databaseProvider.database;
    await database.insert('notification_history', <String, Object?>{
      'id': entry.id,
      'application_id': entry.applicationId,
      'title': entry.title,
      'body': entry.body,
      'received_at': entry.receivedAt.millisecondsSinceEpoch,
      'outcome_json': entry.processingOutcome == null
          ? null
          : jsonEncode(entry.processingOutcome!.toJson()),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> clearBefore(DateTime cutoff) async {
    final Database database = await _databaseProvider.database;
    await database.delete(
      'notification_history',
      where: 'received_at < ?',
      whereArgs: <Object?>[cutoff.millisecondsSinceEpoch],
    );
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async {
    final Database database = await _databaseProvider.database;
    final List<Map<String, Object?>> rows = await database.query(
      'notification_history',
      orderBy: 'received_at DESC, id DESC',
    );
    return rows.map(_entryFromRow).toList();
  }

  @override
  Future<NotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  }) async {
    if (limit <= 0) {
      throw ArgumentError.value(limit, 'limit', 'Must be greater than zero.');
    }
    final Database database = await _databaseProvider.database;
    final List<Map<String, Object?>> rows = await database.query(
      'notification_history',
      where: before == null
          ? null
          : '(received_at < ?) OR (received_at = ? AND id < ?)',
      whereArgs: before == null
          ? null
          : <Object?>[
              before.receivedAt.millisecondsSinceEpoch,
              before.receivedAt.millisecondsSinceEpoch,
              before.id,
            ],
      orderBy: 'received_at DESC, id DESC',
      limit: limit + 1,
    );
    final bool hasMore = rows.length > limit;
    final List<NotificationHistoryEntry> entries = rows
        .take(limit)
        .map(_entryFromRow)
        .toList();
    final NotificationHistoryEntry? lastEntry = entries.isEmpty
        ? null
        : entries.last;
    return NotificationHistoryPage(
      entries: entries,
      hasMore: hasMore,
      nextCursor: hasMore && lastEntry != null
          ? NotificationHistoryCursor(
              receivedAt: lastEntry.receivedAt,
              id: lastEntry.id,
            )
          : null,
    );
  }

  NotificationHistoryEntry _entryFromRow(
    Map<String, Object?> row,
  ) => NotificationHistoryEntry(
    id: row['id']! as String,
    applicationId: row['application_id']! as String,
    title: row['title']! as String,
    body: row['body']! as String,
    receivedAt: DateTime.fromMillisecondsSinceEpoch(row['received_at']! as int),
    processingOutcome: row['outcome_json'] == null
        ? null
        : NotificationProcessingOutcome.fromJson(
            jsonDecode(row['outcome_json']! as String) as Map<String, dynamic>,
          ),
  );

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async {
    final Database database = await _databaseProvider.database;
    return database.transaction((Transaction transaction) async {
      final List<Map<String, Object?>> rows = await transaction.query(
        'notification_history',
        columns: <String>['outcome_json'],
        where: 'id = ?',
        whereArgs: <Object?>[historyEntryId],
        limit: 1,
      );
      if (rows.isEmpty || rows.single['outcome_json'] == null) return false;
      final NotificationProcessingOutcome outcome =
          NotificationProcessingOutcome.fromJson(
            jsonDecode(rows.single['outcome_json']! as String)
                as Map<String, dynamic>,
          );
      final int updated = await transaction.update(
        'notification_history',
        <String, Object?>{
          'outcome_json': jsonEncode(
            outcome
                .withTransactionId(
                  transactionId,
                  origin: NotificationTransactionCreationOrigin.user,
                )
                .toJson(),
          ),
        },
        where: 'id = ?',
        whereArgs: <Object?>[historyEntryId],
      );
      return updated == 1;
    });
  }

  @override
  Future<bool> unlinkTransaction(
    String historyEntryId,
    String expectedTransactionId,
  ) async {
    final Database database = await _databaseProvider.database;
    return database.transaction((Transaction transaction) async {
      final List<Map<String, Object?>> rows = await transaction.query(
        'notification_history',
        columns: <String>['outcome_json'],
        where: 'id = ?',
        whereArgs: <Object?>[historyEntryId],
        limit: 1,
      );
      if (rows.isEmpty || rows.single['outcome_json'] == null) return false;
      final NotificationProcessingOutcome outcome =
          NotificationProcessingOutcome.fromJson(
            jsonDecode(rows.single['outcome_json']! as String)
                as Map<String, dynamic>,
          );
      if (outcome.transactionId != expectedTransactionId) return false;
      final int updated = await transaction.update(
        'notification_history',
        <String, Object?>{
          'outcome_json': jsonEncode(outcome.withoutTransactionLink().toJson()),
        },
        where: 'id = ?',
        whereArgs: <Object?>[historyEntryId],
      );
      return updated == 1;
    });
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    final Database database = await _databaseProvider.database;
    await database.delete(
      'notification_history',
      where: 'application_id = ?',
      whereArgs: <Object?>[applicationId],
    );
  }

  @override
  Future<void> remove(String id) async {
    final Database database = await _databaseProvider.database;
    await database.delete(
      'notification_history',
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }

  @override
  Future<void> restore(NotificationHistoryEntry entry) => record(entry);

  @override
  Future<void> clearAll() async {
    final Database database = await _databaseProvider.database;
    await database.delete('notification_history');
  }
}
