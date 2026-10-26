import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_key_store.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/data/database/sqlcipher_database_provider.dart';
import 'package:waterflyiii/notifications/data/migrations/notification_database_schema.dart';

class NotificationDatabaseProvider {
  static const String databaseName = 'waterfly_notifications.db';
  static const String keyName = 'notification_database_key';
  static const String _keyLockDatabaseName = '$databaseName.key.lock.db';

  static DatabaseProvider<Database> create() => SqlcipherDatabaseProvider(
    databaseName: databaseName,
    schema: NotificationDatabaseSchema.schema,
    keyStore: SecureDatabaseKeyStore(
      keyName: keyName,
      initializationLock: CallbackDatabaseKeyInitializationLock(
        synchronized: _withKeyInitializationLock,
      ),
    ),
  );

  static Future<T> _withKeyInitializationLock<T>(
    Future<T> Function() action,
  ) async {
    final String lockDatabasePath =
        '${await getDatabasesPath()}/$_keyLockDatabaseName';
    final Database lockDatabase = await openDatabase(
      lockDatabasePath,
      singleInstance: false,
    );
    try {
      return await lockDatabase.transaction((_) => action(), exclusive: true);
    } finally {
      await lockDatabase.close();
    }
  }
}
