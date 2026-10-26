import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class DatabaseKeyStore {
  Future<String> loadOrCreate();
}

abstract interface class DatabaseKeyStorage {
  Future<String?> read(String key);

  Future<void> write(String key, String value);
}

class FlutterSecureDatabaseKeyStorage implements DatabaseKeyStorage {
  FlutterSecureDatabaseKeyStorage({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> read(String key) => _secureStorage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _secureStorage.write(key: key, value: value);
}

abstract interface class DatabaseKeyInitializationLock {
  Future<T> synchronized<T>(Future<T> Function() action);
}

class CallbackDatabaseKeyInitializationLock
    implements DatabaseKeyInitializationLock {
  CallbackDatabaseKeyInitializationLock({
    required Future<T> Function<T>(Future<T> Function() action) synchronized,
  }) : _synchronized = synchronized;

  final Future<T> Function<T>(Future<T> Function() action) _synchronized;

  @override
  Future<T> synchronized<T>(Future<T> Function() action) =>
      _synchronized(action);
}

class SecureDatabaseKeyStore implements DatabaseKeyStore {
  SecureDatabaseKeyStore({
    required String keyName,
    required DatabaseKeyInitializationLock initializationLock,
    DatabaseKeyStorage? storage,
  }) : _keyName = keyName,
       _initializationLock = initializationLock,
       _storage = storage ?? FlutterSecureDatabaseKeyStorage();

  final String _keyName;
  final DatabaseKeyInitializationLock _initializationLock;
  final DatabaseKeyStorage _storage;

  @override
  Future<String> loadOrCreate() => _initializationLock.synchronized(() async {
    final String? existingKey = await _storage.read(_keyName);
    if (existingKey != null) return existingKey;

    final String key = base64UrlEncode(
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    );
    await _storage.write(_keyName, key);
    return key;
  });
}
