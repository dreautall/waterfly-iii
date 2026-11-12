import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_storage.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';

class InMemoryNotificationDefinitionStorage
    implements NotificationDefinitionStorage {
  Map<String, dynamic>? data;

  @override
  Future<Map<String, dynamic>?> read() async => data;

  @override
  Future<void> write(Map<String, dynamic> value) async {
    data = value;
  }

  @override
  Future<NotificationDefinitionInitializationResult> initializeIfAbsent(
    Map<String, dynamic> value,
  ) async {
    final Map<String, dynamic>? existing = data;
    if (existing != null) {
      return NotificationDefinitionInitializationResult(
        data: existing,
        initializedByCaller: false,
      );
    }
    data = value;
    return NotificationDefinitionInitializationResult(
      data: value,
      initializedByCaller: true,
    );
  }
}

class ConcurrentInitializationStorage
    extends InMemoryNotificationDefinitionStorage {
  final Completer<void> _initialReadsCompleted = Completer<void>();
  int _initialReadCount = 0;

  @override
  Future<Map<String, dynamic>?> read() async {
    final Map<String, dynamic>? existing = data;
    if (existing != null) return existing;
    _initialReadCount += 1;
    if (_initialReadCount == 2) {
      _initialReadsCompleted.complete();
    }
    await _initialReadsCompleted.future;
    return existing;
  }
}

class InMemoryNotificationDefinitionMigrator
    implements NotificationDefinitionMigrator {
  InMemoryNotificationDefinitionMigrator(this.definitions);

  final List<NotificationDefinition> definitions;
  int migrationCount = 0;

  @override
  Future<List<NotificationDefinition>> migrate() async {
    migrationCount += 1;
    return definitions;
  }
}

class CleanableNotificationDefinitionMigrator
    extends InMemoryNotificationDefinitionMigrator
    implements NotificationDefinitionMigrationCleanup {
  CleanableNotificationDefinitionMigrator(super.definitions, {this.onCleanup});

  final void Function()? onCleanup;
  int cleanupCount = 0;

  @override
  Future<void> cleanupMigratedSettings() {
    cleanupCount += 1;
    onCleanup?.call();
    return Future<void>.value();
  }
}

class DelayedNotificationDefinitionMigrator
    implements
        NotificationDefinitionMigrator,
        NotificationDefinitionMigrationCleanup {
  DelayedNotificationDefinitionMigrator(this._release);

  final Future<void> _release;
  int migrationCount = 0;
  int cleanupCount = 0;

  @override
  Future<List<NotificationDefinition>> migrate() async {
    migrationCount += 1;
    await _release;
    return const <NotificationDefinition>[];
  }

  @override
  Future<void> cleanupMigratedSettings() async {
    cleanupCount += 1;
  }
}

class FailingWriteNotificationDefinitionStorage
    implements NotificationDefinitionStorage {
  @override
  Future<Map<String, dynamic>?> read() async => null;

  @override
  Future<void> write(Map<String, dynamic> value) =>
      Future<void>.error(StateError('Database write failed'));

  @override
  Future<NotificationDefinitionInitializationResult> initializeIfAbsent(
    Map<String, dynamic> value,
  ) => Future<NotificationDefinitionInitializationResult>.error(
    StateError('Database write failed'),
  );
}

void main() {
  group('NotificationDefinitionRepository', () {
    // Verifies a first-time installation starts with no definitions instead of
    // failing on a missing preferences document.
    test('loads an empty list when no definitions have been stored', () async {
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(
            InMemoryNotificationDefinitionStorage(),
          );

      expect(await repository.load(), isEmpty);
    });

    // Verifies repository JSON persistence retains the identifiers needed by
    // later evaluator and diagnostics lookups.
    test('saves and restores executable notification definitions', () async {
      final InMemoryNotificationDefinitionStorage storage =
          InMemoryNotificationDefinitionStorage();
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      const NotificationDefinition definition = NotificationDefinition(
        id: 'bank-payments',
        applicationId: 'com.example.bank',
        name: 'Example Bank payments',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      );

      await repository.save(<NotificationDefinition>[definition]);
      final List<NotificationDefinition> definitions = await repository.load();

      expect(storage.data?['definitions'], hasLength(1));
      expect(definitions.single.id, definition.id);
      expect(definitions.single.applicationId, definition.applicationId);
      expect(definitions.single.name, definition.name);
    });

    test('removes persisted display names from resource references', () async {
      final InMemoryNotificationDefinitionStorage storage =
          InMemoryNotificationDefinitionStorage();
      const NotificationDefinition definition = NotificationDefinition(
        id: 'bank-payments',
        applicationId: 'com.example.bank',
        name: 'Example Bank payments',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        sharedActions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.sourceAccount,
            valueSource: FireflyResourceValueSource(
              resourceKind: FireflyResourceKind.account,
              resourceId: '42',
            ),
          ),
        ],
      );
      final Map<String, dynamic> serialized = definition.toJson();
      final Map<String, dynamic> source =
          ((serialized['sharedActions'] as List<dynamic>).single
                  as Map<String, dynamic>)['valueSource']
              as Map<String, dynamic>;
      source['displayName'] = 'Old account name';
      storage.data = <String, dynamic>{
        'definitions': <Map<String, dynamic>>[serialized],
      };

      await NotificationDefinitionRepository(storage).load();

      final Map<String, dynamic> rewrittenSource =
          (((storage.data!['definitions'] as List<dynamic>).single
                          as Map<String, dynamic>)['sharedActions']
                      as List<dynamic>)
                  .single['valueSource']
              as Map<String, dynamic>;
      expect(rewrittenSource, isNot(contains('displayName')));
      expect(rewrittenSource['resourceId'], '42');
    });

    // Ensures migration is a one-time copy-forward operation and cannot create
    // duplicate definitions every time a notification is processed.
    test('migrates only when the new definitions document is absent', () async {
      final InMemoryNotificationDefinitionStorage storage =
          InMemoryNotificationDefinitionStorage();
      const NotificationDefinition migratedDefinition = NotificationDefinition(
        id: 'legacy:com.example.bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      );
      final InMemoryNotificationDefinitionMigrator migrator =
          InMemoryNotificationDefinitionMigrator(const <NotificationDefinition>[
            migratedDefinition,
          ]);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage, migrator: migrator);

      expect((await repository.load()).single.id, migratedDefinition.id);
      expect(migrator.migrationCount, 1);
      expect(storage.data?['definitions'], hasLength(1));

      expect((await repository.load()).single.id, migratedDefinition.id);
      expect(migrator.migrationCount, 1);
    });

    test(
      'concurrent migration cannot replace initialized definitions',
      () async {
        final ConcurrentInitializationStorage storage =
            ConcurrentInitializationStorage();
        final Completer<void> releaseCompetingMigration = Completer<void>();
        const NotificationDefinition migratedDefinition =
            NotificationDefinition(
              id: 'legacy:com.example.bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            );
        final CleanableNotificationDefinitionMigrator winningMigrator =
            CleanableNotificationDefinitionMigrator(
              const <NotificationDefinition>[migratedDefinition],
              onCleanup: releaseCompetingMigration.complete,
            );
        final NotificationDefinitionRepository winningRepository =
            NotificationDefinitionRepository(
              storage,
              migrator: winningMigrator,
            );
        final DelayedNotificationDefinitionMigrator competingMigrator =
            DelayedNotificationDefinitionMigrator(
              releaseCompetingMigration.future,
            );
        final NotificationDefinitionRepository competingRepository =
            NotificationDefinitionRepository(
              storage,
              migrator: competingMigrator,
            );

        final Future<List<NotificationDefinition>> winningLoad =
            winningRepository.load();
        final Future<List<NotificationDefinition>> competingLoad =
            competingRepository.load();
        final List<List<NotificationDefinition>> results = await Future.wait(
          <Future<List<NotificationDefinition>>>[winningLoad, competingLoad],
        );

        expect(
          results.map(
            (List<NotificationDefinition> definitions) => definitions.single.id,
          ),
          everyElement(migratedDefinition.id),
        );
        expect(storage.data?['definitions'], hasLength(1));
        expect(winningMigrator.cleanupCount, 1);
        expect(competingMigrator.migrationCount, 1);
        expect(competingMigrator.cleanupCount, 0);
      },
    );

    // Ensures an initialized but empty database remains empty rather than
    // unexpectedly importing legacy listeners after a user deletes all rules.
    test(
      'does not migrate when an empty definitions document exists',
      () async {
        final InMemoryNotificationDefinitionStorage storage =
            InMemoryNotificationDefinitionStorage()
              ..data = <String, dynamic>{'definitions': <dynamic>[]};
        final InMemoryNotificationDefinitionMigrator migrator =
            InMemoryNotificationDefinitionMigrator(
              const <NotificationDefinition>[
                NotificationDefinition(
                  id: 'legacy:com.example.bank',
                  applicationId: 'com.example.bank',
                  name: 'Example Bank',
                  extractors: <RegExpDefinition>[],
                  rules: <NotificationRule>[],
                ),
              ],
            );
        final NotificationDefinitionRepository repository =
            NotificationDefinitionRepository(storage, migrator: migrator);

        expect(await repository.load(), isEmpty);
        expect(migrator.migrationCount, 0);
      },
    );

    // Verifies legacy settings are deleted only after the migrated definitions
    // can be read back, preserving a recoverable source if persistence fails.
    test('cleans up legacy settings after migration is persisted', () async {
      final InMemoryNotificationDefinitionStorage storage =
          InMemoryNotificationDefinitionStorage();
      bool definitionsWerePersistedBeforeCleanup = false;
      final CleanableNotificationDefinitionMigrator migrator =
          CleanableNotificationDefinitionMigrator(
            const <NotificationDefinition>[
              NotificationDefinition(
                id: 'legacy:com.example.bank',
                applicationId: 'com.example.bank',
                name: 'Example Bank',
                extractors: <RegExpDefinition>[],
                rules: <NotificationRule>[],
              ),
            ],
            onCleanup: () {
              definitionsWerePersistedBeforeCleanup =
                  storage.data?['definitions'] != null;
            },
          );
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage, migrator: migrator);

      await repository.load();

      expect(definitionsWerePersistedBeforeCleanup, isTrue);
      expect(migrator.cleanupCount, 1);
    });

    // Ensures a failed database write leaves legacy settings intact instead of
    // deleting the only copy of a user's notification configuration.
    test('does not clean up legacy settings when persistence fails', () async {
      final CleanableNotificationDefinitionMigrator migrator =
          CleanableNotificationDefinitionMigrator(
            const <NotificationDefinition>[],
          );
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(
            FailingWriteNotificationDefinitionStorage(),
            migrator: migrator,
          );

      await expectLater(repository.load(), throwsStateError);

      expect(migrator.cleanupCount, 0);
    });
  });
}
