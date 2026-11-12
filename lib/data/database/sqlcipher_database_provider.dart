import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_key_store.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/data/database/database_schema.dart';

class SqlcipherDatabaseProvider implements DatabaseProvider<Database> {
  SqlcipherDatabaseProvider({
    required this.databaseName,
    required this.schema,
    required DatabaseKeyStore keyStore,
  }) : _keyStore = keyStore;

  final String databaseName;
  final DatabaseSchema<Database> schema;
  final DatabaseKeyStore _keyStore;
  Future<Database>? _database;

  @override
  Future<Database> get database => _database ??= _open();

  Future<Database> _open() async {
    final String databasesPath = await getDatabasesPath();
    return openDatabase(
      '$databasesPath/$databaseName',
      password: await _keyStore.loadOrCreate(),
      version: schema.version,
      onConfigure: schema.onConfigure,
      onCreate: schema.onCreate,
      onUpgrade: schema.onUpgrade,
    );
  }
}
