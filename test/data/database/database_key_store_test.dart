import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/data/database/database_key_store.dart';

void main() {
  test('serializes key creation across independent store instances', () async {
    final _DelayedDatabaseKeyStorage storage = _DelayedDatabaseKeyStorage();
    final _SerialKeyInitializationCoordinator coordinator =
        _SerialKeyInitializationCoordinator();
    final SecureDatabaseKeyStore first = SecureDatabaseKeyStore(
      keyName: 'database-key',
      storage: storage,
      initializationLock: CallbackDatabaseKeyInitializationLock(
        synchronized: coordinator.synchronized,
      ),
    );
    final SecureDatabaseKeyStore second = SecureDatabaseKeyStore(
      keyName: 'database-key',
      storage: storage,
      initializationLock: CallbackDatabaseKeyInitializationLock(
        synchronized: coordinator.synchronized,
      ),
    );

    final List<String> keys = await Future.wait(<Future<String>>[
      first.loadOrCreate(),
      second.loadOrCreate(),
    ]);

    expect(keys.toSet(), hasLength(1));
    expect(storage.writeCount, 1);
    expect(await storage.read('database-key'), keys.first);
  });
  test('releases the initialization lock after a failure', () async {
    final _SerialKeyInitializationCoordinator coordinator =
        _SerialKeyInitializationCoordinator();
    final CallbackDatabaseKeyInitializationLock lock =
        CallbackDatabaseKeyInitializationLock(
          synchronized: coordinator.synchronized,
        );

    await expectLater(
      lock.synchronized<void>(() async => throw StateError('failed')),
      throwsStateError,
    );

    expect(await lock.synchronized(() async => 'acquired'), 'acquired');
  });
}

class _SerialKeyInitializationCoordinator {
  Future<void> _pending = Future<void>.value();

  Future<T> synchronized<T>(Future<T> Function() action) {
    final Future<T> result = _pending.then((_) => action());
    _pending = result.then<void>((_) {}, onError: (_, _) {});
    return result;
  }
}

class _DelayedDatabaseKeyStorage implements DatabaseKeyStorage {
  String? _value;
  int writeCount = 0;

  @override
  Future<String?> read(String key) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return _value;
  }

  @override
  Future<void> write(String key, String value) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    _value = value;
    writeCount++;
  }
}
