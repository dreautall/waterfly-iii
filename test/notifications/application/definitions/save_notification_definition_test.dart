import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

class _DefinitionStore implements NotificationDefinitionStore {
  _DefinitionStore(this.definitions);

  List<NotificationDefinition> definitions;

  @override
  Future<List<NotificationDefinition>> load() async => definitions;

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    this.definitions = definitions;
  }
}

class _FailingDefinitionStore implements NotificationDefinitionStore {
  @override
  Future<List<NotificationDefinition>> load() =>
      Future<List<NotificationDefinition>>.error(
        StateError('Could not load definitions'),
      );

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {}
}

class _AlertStore implements NotificationAlertStore {
  final List<String> clearedApplications = <String>[];

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplications.add(applicationId);
  }

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> dismiss(String fingerprint) async {}

  @override
  Future<List<NotificationAlert>> load() async => <NotificationAlert>[];

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

class _HistoryStore implements NotificationHistoryStore {
  final List<String> clearedApplications = <String>[];

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplications.add(applicationId);
  }

  @override
  Future<void> clearAll() async {}

  @override
  Future<List<NotificationHistoryEntry>> load() async =>
      <NotificationHistoryEntry>[];

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

void main() {
  const NotificationDefinition definition = NotificationDefinition(
    id: 'definition',
    applicationId: 'com.example.bank',
    name: 'Example Bank',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[],
  );

  test('prevents adding an application that is already registered', () async {
    final _DefinitionStore store = _DefinitionStore(<NotificationDefinition>[
      definition,
    ]);
    final SaveNotificationDefinition workflow = SaveNotificationDefinition(
      store,
    );

    final SaveNotificationDefinitionResult result = await workflow
        .addApplication(
          applicationId: definition.applicationId,
          applicationName: definition.name,
        );

    expect(result.status, SaveNotificationDefinitionStatus.duplicate);
    expect(store.definitions, <NotificationDefinition>[definition]);
  });

  test('updates and deletes definitions with related data cleanup', () async {
    final _DefinitionStore store = _DefinitionStore(<NotificationDefinition>[
      definition,
    ]);
    final _AlertStore alertStore = _AlertStore();
    final _HistoryStore historyStore = _HistoryStore();
    final SaveNotificationDefinition workflow = SaveNotificationDefinition(
      store,
      alertStore: alertStore,
      historyStore: historyStore,
    );
    final NotificationDefinition updated = definition.copyWith(name: 'Updated');

    expect((await workflow.update(updated)).succeeded, isTrue);
    expect(store.definitions.single.name, 'Updated');
    expect((await workflow.delete(definition.id)).succeeded, isTrue);
    expect(store.definitions, isEmpty);
    expect(alertStore.clearedApplications, <String>[definition.applicationId]);
    expect(historyStore.clearedApplications, <String>[
      definition.applicationId,
    ]);
  });

  test('preserves definition persistence failures', () async {
    final SaveNotificationDefinitionResult result =
        await SaveNotificationDefinition(
          _FailingDefinitionStore(),
        ).update(definition);

    expect(result.status, SaveNotificationDefinitionStatus.failed);
    expect(result.error, isA<StateError>());
    expect(result.stackTrace, isNotNull);
  });
}
