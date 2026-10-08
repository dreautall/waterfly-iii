import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_schema.dart';

class NotificationDatabaseSchema {
  static const int version = 5;

  static final DatabaseSchema<Database> schema = DatabaseSchema<Database>(
    version: version,
    onConfigure: (Database database) async {
      await database.execute('PRAGMA cipher_memory_security = ON');
    },
    onCreate: (Database database, int _) async {
      await database.execute('''
        CREATE TABLE notification_metadata (
          key TEXT PRIMARY KEY,
          value TEXT NOT NULL
        )
      ''');
      await database.execute('''
        CREATE TABLE notification_definitions (
          id TEXT PRIMARY KEY,
          definition_json TEXT NOT NULL
        )
      ''');
      await database.execute('''
        CREATE TABLE notification_alerts (
          fingerprint TEXT PRIMARY KEY,
          updated_at INTEGER NOT NULL,
          alert_json TEXT NOT NULL
        )
      ''');
      await _createHistoryTable(database);
    },
    onUpgrade: (Database database, int oldVersion, int _) async {
      if (oldVersion < 2) await _createHistoryTable(database);
      if (oldVersion >= 2 && oldVersion < 3) {
        await database.execute(
          'ALTER TABLE notification_history ADD COLUMN outcome_json TEXT',
        );
      }
      if (oldVersion < 4) {
        await database.delete(
          'notification_history',
          where: "id LIKE 'preview-history-%' OR application_id IN (?, ?)",
          whereArgs: <Object?>[
            'com.waterfly.preview.bank',
            'com.waterfly.preview.legacy',
          ],
        );
        await database.delete(
          'notification_alerts',
          where: "fingerprint LIKE 'preview-alert-%'",
        );
      }
      if (oldVersion < 5) await _createHistoryPaginationIndex(database);
    },
  );

  static Future<void> _createHistoryTable(Database database) async {
    await database.execute('''
      CREATE TABLE notification_history (
        id TEXT PRIMARY KEY,
        application_id TEXT NOT NULL,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        received_at INTEGER NOT NULL,
        outcome_json TEXT
      )
    ''');
    await _createHistoryPaginationIndex(database);
  }

  static Future<void> _createHistoryPaginationIndex(Database database) async {
    await database.execute(
      'DROP INDEX IF EXISTS notification_history_received_at',
    );
    await database.execute('''
      CREATE INDEX IF NOT EXISTS notification_history_received_at_id
      ON notification_history (received_at DESC, id DESC)
    ''');
  }
}
