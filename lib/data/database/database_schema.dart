typedef DatabaseConfigure<TDatabase> =
    Future<void> Function(TDatabase database);
typedef DatabaseCreate<TDatabase> =
    Future<void> Function(TDatabase database, int version);
typedef DatabaseUpgrade<TDatabase> =
    Future<void> Function(TDatabase database, int oldVersion, int newVersion);

class DatabaseSchema<TDatabase> {
  const DatabaseSchema({
    required this.version,
    required this.onCreate,
    required this.onUpgrade,
    this.onConfigure,
  });

  final int version;
  final DatabaseConfigure<TDatabase>? onConfigure;
  final DatabaseCreate<TDatabase> onCreate;
  final DatabaseUpgrade<TDatabase> onUpgrade;
}
