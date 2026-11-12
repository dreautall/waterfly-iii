import 'package:logging/logging.dart';
import 'package:waterflyiii/auth.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/data/resources/api_firefly_currency_gateway.dart';
import 'package:waterflyiii/notifications/data/resources/installed_application_name_resolver.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_definition_storage.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_storage.dart';
import 'package:waterflyiii/notifications/data/migrations/shared_preferences_legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

class NotificationDefinitionRepository implements NotificationDefinitionStore {
  const NotificationDefinitionRepository(this._storage, {this.migrator});

  factory NotificationDefinitionRepository.encryptedDatabase(
    DatabaseProvider<Database> database, {
    NotificationAlertStore? alertStore,
    FireflyCurrencyResolver? currencyResolver,
  }) {
    final FireflyCurrencyResolver effectiveCurrencyResolver =
        currencyResolver ??
        FireflyCurrencyResolver(ApiFireflyCurrencyGateway(FireflyService()));
    return NotificationDefinitionRepository(
      SqlcipherNotificationDefinitionStorage(database),
      migrator: SharedPreferencesLegacyNotificationDefinitionMigrator(
        alertStore: alertStore,
        currencyResolver: effectiveCurrencyResolver,
        applicationNameResolver: const InstalledApplicationNameResolver(),
      ),
    );
  }

  final NotificationDefinitionStorage _storage;
  final NotificationDefinitionMigrator? migrator;
  static final Logger _log = Logger('Notifications.DefinitionRepository');

  @override
  Future<List<NotificationDefinition>> load() async {
    final Map<String, dynamic>? data = await _storage.read();
    if (data == null) {
      _log.info(
        'Notification definition storage is uninitialized; starting legacy migration.',
      );
      final List<NotificationDefinition> migratedDefinitions =
          await migrator?.migrate() ?? <NotificationDefinition>[];
      if (migrator != null) {
        final NotificationDefinitionInitializationResult initialization =
            await _storage.initializeIfAbsent(
              _definitionsData(migratedDefinitions),
            );
        if (!initialization.initializedByCaller) {
          _log.fine(
            'Notification definition storage was initialized concurrently.',
          );
          return _definitionsFromData(initialization.data);
        }
        await _verifyPersistedDefinitions(migratedDefinitions);
        if (migrator
            case final NotificationDefinitionMigrationCleanup cleanup) {
          await cleanup.cleanupMigratedSettings();
        }
      }
      _log.info(
        'Initialized notification definition storage with ${migratedDefinitions.length} migrated definitions.',
      );
      return migratedDefinitions;
    }

    final List<NotificationDefinition> definitions = _definitionsFromData(data);
    if (_containsPersistedResourceMetadata(data)) {
      _log.fine(
        'Removing obsolete resource metadata from notification definitions.',
      );
      await save(definitions);
    }
    return definitions;
  }

  Future<void> _verifyPersistedDefinitions(
    List<NotificationDefinition> expectedDefinitions,
  ) async {
    final Map<String, dynamic>? persistedData = await _storage.read();
    if (persistedData == null) {
      throw StateError('Notification definitions were not persisted.');
    }
    final Set<String> persistedIds = _definitionsFromData(
      persistedData,
    ).map((NotificationDefinition definition) => definition.id).toSet();
    final Set<String> expectedIds = expectedDefinitions
        .map((NotificationDefinition definition) => definition.id)
        .toSet();
    if (persistedIds.length != expectedIds.length ||
        !persistedIds.containsAll(expectedIds)) {
      throw StateError(
        'Persisted notification definitions did not match migration.',
      );
    }
  }

  List<NotificationDefinition> _definitionsFromData(Map<String, dynamic> data) {
    final List<dynamic> definitions = data['definitions'] as List<dynamic>;
    return definitions
        .map(
          (dynamic definition) => NotificationDefinition.fromJson(
            definition as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  bool _containsPersistedResourceMetadata(Object? value) {
    if (value is List<dynamic>) {
      return value.any(_containsPersistedResourceMetadata);
    }
    if (value is! Map<String, dynamic>) return false;
    if ((value['type'] == 'fireflyResource' ||
            value['type'] == 'currencyCapture') &&
        (value.containsKey('displayName') ||
            value.containsKey('currencyCode'))) {
      return true;
    }
    return value.values.any(_containsPersistedResourceMetadata);
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) {
    return _storage.write(_definitionsData(definitions));
  }

  Map<String, dynamic> _definitionsData(
    List<NotificationDefinition> definitions,
  ) => <String, dynamic>{
    'definitions': definitions
        .map((NotificationDefinition definition) => definition.toJson())
        .toList(),
  };
}
