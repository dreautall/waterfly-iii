import 'dart:convert';

import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

class SqlcipherNotificationAlertStore implements NotificationAlertStore {
  const SqlcipherNotificationAlertStore(this._databaseProvider);

  final DatabaseProvider<Database> _databaseProvider;

  @override
  Future<List<NotificationAlert>> load() async {
    final Database database = await _databaseProvider.database;
    final List<Map<String, Object?>> rows = await database.query(
      'notification_alerts',
      orderBy: 'updated_at DESC',
    );
    return rows
        .map(
          (Map<String, Object?> row) => NotificationAlert.fromJson(
            jsonDecode(row['alert_json']! as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<void> record(NotificationAlert alert) async {
    final Database database = await _databaseProvider.database;
    await database.transaction((Transaction transaction) async {
      final List<Map<String, Object?>> rows = await transaction.query(
        'notification_alerts',
        columns: <String>['alert_json'],
        where: 'fingerprint = ?',
        whereArgs: <Object?>[alert.fingerprint],
        limit: 1,
      );
      final NotificationAlert storedAlert = rows.isEmpty
          ? alert
          : NotificationAlert.fromJson(
              jsonDecode(rows.single['alert_json']! as String)
                  as Map<String, dynamic>,
            ).recordAnotherOccurrence(notification: alert.notification);
      await transaction.insert('notification_alerts', <String, Object?>{
        'fingerprint': storedAlert.fingerprint,
        'updated_at': storedAlert.updatedAt.millisecondsSinceEpoch,
        'alert_json': jsonEncode(storedAlert.toJson()),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  @override
  Future<void> dismiss(String fingerprint) async {
    final Database database = await _databaseProvider.database;
    await database.delete(
      'notification_alerts',
      where: 'fingerprint = ?',
      whereArgs: <Object?>[fingerprint],
    );
  }

  @override
  Future<void> restore(NotificationAlert alert) async {
    final Database database = await _databaseProvider.database;
    await database.insert('notification_alerts', <String, Object?>{
      'fingerprint': alert.fingerprint,
      'updated_at': alert.updatedAt.millisecondsSinceEpoch,
      'alert_json': jsonEncode(alert.toJson()),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    final Database database = await _databaseProvider.database;
    await database.transaction((Transaction transaction) async {
      final List<Map<String, Object?>> rows = await transaction.query(
        'notification_alerts',
        columns: <String>['fingerprint', 'alert_json'],
      );
      final List<String> fingerprints = <String>[];
      for (final Map<String, Object?> row in rows) {
        try {
          final NotificationAlert alert = NotificationAlert.fromJson(
            jsonDecode(row['alert_json']! as String) as Map<String, dynamic>,
          );
          if (alert.applicationId == applicationId) {
            fingerprints.add(row['fingerprint']! as String);
          }
        } catch (_) {
          // A corrupt alert must not prevent cleanup of valid alert records.
        }
      }
      for (final String fingerprint in fingerprints) {
        await transaction.delete(
          'notification_alerts',
          where: 'fingerprint = ?',
          whereArgs: <Object?>[fingerprint],
        );
      }
    });
  }

  @override
  Future<void> clearAll() async {
    final Database database = await _databaseProvider.database;
    await database.delete('notification_alerts');
  }
}
