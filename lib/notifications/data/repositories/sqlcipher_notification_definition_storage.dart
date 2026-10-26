import 'dart:convert';

import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_storage.dart';

class SqlcipherNotificationDefinitionStorage
    implements NotificationDefinitionStorage {
  static const String _initializedKey = 'definitions_initialized';

  const SqlcipherNotificationDefinitionStorage(this._databaseProvider);

  final DatabaseProvider<Database> _databaseProvider;

  @override
  Future<Map<String, dynamic>?> read() async {
    final Database database = await _databaseProvider.database;
    return _read(database);
  }

  Future<Map<String, dynamic>?> _read(DatabaseExecutor database) async {
    final List<Map<String, Object?>> metadata = await database.query(
      'notification_metadata',
      columns: <String>['value'],
      where: 'key = ?',
      whereArgs: <Object?>[_initializedKey],
      limit: 1,
    );
    if (metadata.isEmpty) {
      return null;
    }

    final List<Map<String, Object?>> rows = await database.query(
      'notification_definitions',
      orderBy: 'id ASC',
    );
    return <String, dynamic>{
      'definitions': rows
          .map(
            (Map<String, Object?> row) =>
                jsonDecode(row['definition_json']! as String),
          )
          .toList(),
    };
  }

  @override
  Future<void> write(Map<String, dynamic> data) async {
    final Database database = await _databaseProvider.database;
    await database.transaction((Transaction transaction) async {
      await _write(transaction, data);
    });
  }

  @override
  Future<NotificationDefinitionInitializationResult> initializeIfAbsent(
    Map<String, dynamic> data,
  ) async {
    final Database database = await _databaseProvider.database;
    return database.transaction((Transaction transaction) async {
      final Map<String, dynamic>? existing = await _read(transaction);
      if (existing != null) {
        return NotificationDefinitionInitializationResult(
          data: existing,
          initializedByCaller: false,
        );
      }
      await _write(transaction, data);
      return NotificationDefinitionInitializationResult(
        data: data,
        initializedByCaller: true,
      );
    });
  }

  Future<void> _write(
    DatabaseExecutor database,
    Map<String, dynamic> data,
  ) async {
    final List<dynamic> definitions = data['definitions'] as List<dynamic>;
    await database.delete('notification_definitions');
    for (final dynamic definition in definitions) {
      final Map<String, dynamic> definitionData =
          definition as Map<String, dynamic>;
      await database.insert('notification_definitions', <String, Object?>{
        'id': definitionData['id'] as String,
        'definition_json': jsonEncode(definitionData),
      });
    }
    await database.insert('notification_metadata', <String, Object?>{
      'key': _initializedKey,
      'value': 'true',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
