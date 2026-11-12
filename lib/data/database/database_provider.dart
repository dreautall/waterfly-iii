abstract interface class DatabaseProvider<TDatabase> {
  Future<TDatabase> get database;
}
