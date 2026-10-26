import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_configuration_service.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/settings/controllers/notification_processing_settings_view_model.dart';

class _DefinitionStore implements NotificationDefinitionStore {
  _DefinitionStore([List<NotificationDefinition>? definitions, this.saveError])
    : definitions = definitions ?? <NotificationDefinition>[];

  List<NotificationDefinition> definitions;
  final Object? saveError;

  @override
  Future<List<NotificationDefinition>> load() async => definitions;

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    if (saveError != null) throw saveError!;
    this.definitions = definitions;
  }
}

class _HistoryStore implements NotificationHistoryStore {
  _HistoryStore([
    List<NotificationHistoryEntry>? entries,
    this.clearForApplicationError,
  ]) : entries = entries ?? <NotificationHistoryEntry>[];

  List<NotificationHistoryEntry> entries;
  final Object? clearForApplicationError;
  bool cleared = false;
  final List<String> clearedApplicationIds = <String>[];

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearAll() async {
    cleared = true;
    entries = <NotificationHistoryEntry>[];
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    if (clearForApplicationError != null) {
      throw clearForApplicationError!;
    }
    clearedApplicationIds.add(applicationId);
    entries = entries
        .where(
          (NotificationHistoryEntry entry) =>
              entry.applicationId != applicationId,
        )
        .toList();
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async => entries;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

class _AlertStore implements NotificationAlertStore {
  _AlertStore([List<NotificationAlert>? alerts])
    : alerts = alerts ?? <NotificationAlert>[];

  List<NotificationAlert> alerts;
  bool cleared = false;
  final List<String> clearedApplicationIds = <String>[];

  @override
  Future<void> clearAll() async {
    cleared = true;
    alerts = <NotificationAlert>[];
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplicationIds.add(applicationId);
    alerts = alerts
        .where(
          (NotificationAlert alert) => alert.applicationId != applicationId,
        )
        .toList();
  }

  @override
  Future<void> dismiss(String fingerprint) async {}

  @override
  Future<List<NotificationAlert>> load() async => alerts;

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

class _SettingsStore implements NotificationProcessingSettingsStore {
  _SettingsStore({this.saveError});

  NotificationProcessingSettings settings =
      NotificationProcessingSettings.defaults;
  final Object? saveError;
  bool resetCalled = false;

  @override
  Future<NotificationProcessingSettings> load() async => settings;

  @override
  Future<void> reset() async {
    resetCalled = true;
    settings = NotificationProcessingSettings.defaults;
  }

  @override
  Future<void> save(NotificationProcessingSettings settings) async {
    if (saveError != null) throw saveError!;
    this.settings = settings;
  }
}

const NotificationDefinition definition = NotificationDefinition(
  id: 'bank',
  applicationId: 'com.example.bank',
  name: 'Example Bank',
  extractors: <RegExpDefinition>[],
  rules: <NotificationRule>[],
);

NotificationProcessingSettingsViewModel _viewModel({
  _DefinitionStore? definitionStore,
  _HistoryStore? historyStore,
  _AlertStore? alertStore,
  _SettingsStore? settingsStore,
}) => NotificationProcessingSettingsViewModel(
  definitionStore: definitionStore ?? _DefinitionStore(),
  historyStore: historyStore ?? _HistoryStore(),
  alertStore: alertStore ?? _AlertStore(),
  settingsStore: settingsStore ?? _SettingsStore(),
);

void main() {
  test('loads processing settings from the settings store', () async {
    final _SettingsStore settingsStore = _SettingsStore()
      ..settings = const NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.disabled,
      );
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      settingsStore: settingsStore,
    );

    await viewModel.load();

    expect(viewModel.loadError, isNull);
    expect(viewModel.isLoading, isFalse);
    expect(
      viewModel.settings?.historyStorageMode,
      NotificationHistoryStorageMode.disabled,
    );
    expect(viewModel.hasDefinitions, isFalse);
    expect(viewModel.hasHistory, isFalse);
    expect(viewModel.hasAlerts, isFalse);
    expect(viewModel.hasSetupOrStoredData, isFalse);
  });

  test('loads setup and stored data availability', () async {
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      definitionStore: _DefinitionStore(const <NotificationDefinition>[
        definition,
      ]),
      historyStore: _HistoryStore(<NotificationHistoryEntry>[
        NotificationHistoryEntry(
          id: 'history',
          applicationId: definition.applicationId,
          title: 'Payment',
          body: r'$10',
          receivedAt: DateTime(2026, 10),
        ),
      ]),
      alertStore: _AlertStore(<NotificationAlert>[
        NotificationAlert.failure(
          kind: NotificationAlertKind.evaluationFailed,
          operation: 'Evaluating notification',
          message: 'Could not evaluate notification.',
        ),
      ]),
    );

    await viewModel.load();

    expect(viewModel.hasDefinitions, isTrue);
    expect(viewModel.definitionCount, 1);
    expect(viewModel.hasHistory, isTrue);
    expect(viewModel.hasAlerts, isTrue);
    expect(viewModel.hasSetupOrStoredData, isTrue);
  });

  test('reverts optimistic settings changes when saving fails', () async {
    final _SettingsStore settingsStore = _SettingsStore(
      saveError: StateError('cannot save'),
    );
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      settingsStore: settingsStore,
    );
    await viewModel.load();

    final bool saved = await viewModel.updateSettings(
      const NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
      ),
    );

    expect(saved, isFalse);
    expect(
      viewModel.settings?.historyStorageMode,
      NotificationHistoryStorageMode.full,
    );
  });

  test('creates and restores backups through the view model', () async {
    final _DefinitionStore definitionStore = _DefinitionStore(
      const <NotificationDefinition>[definition],
    );
    final _SettingsStore settingsStore = _SettingsStore()
      ..settings = const NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
      );
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      definitionStore: definitionStore,
      settingsStore: settingsStore,
    );

    final Uint8List payload = await viewModel.createBackup(
      exportedAt: DateTime(2026, 9, 25),
    );
    definitionStore.definitions = <NotificationDefinition>[];
    settingsStore.settings = NotificationProcessingSettings.defaults;
    await viewModel.restoreBackup(viewModel.readBackup(payload));

    expect(definitionStore.definitions.single.id, definition.id);
    expect(
      viewModel.settings?.historyStorageMode,
      NotificationHistoryStorageMode.metadataOnly,
    );
    expect(viewModel.hasDefinitions, isTrue);
    expect(viewModel.isBusy, isFalse);
  });

  test('updates stored data availability after clearing', () async {
    final _HistoryStore historyStore = _HistoryStore(<NotificationHistoryEntry>[
      NotificationHistoryEntry(
        id: 'history',
        applicationId: definition.applicationId,
        title: 'Payment',
        body: r'$10',
        receivedAt: DateTime(2026, 10),
      ),
    ]);
    final _AlertStore alertStore = _AlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.evaluationFailed,
        operation: 'Evaluating notification',
        message: 'Could not evaluate notification.',
      ),
    ]);
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      historyStore: historyStore,
      alertStore: alertStore,
    );
    await viewModel.load();

    await viewModel.clearHistory();
    await viewModel.clearAlerts();

    expect(viewModel.hasHistory, isFalse);
    expect(viewModel.hasAlerts, isFalse);
    expect(viewModel.hasSetupOrStoredData, isFalse);
  });

  test('deletes all definitions and their associated stored data', () async {
    final _DefinitionStore definitionStore = _DefinitionStore(
      const <NotificationDefinition>[definition],
    );
    final _HistoryStore historyStore = _HistoryStore(<NotificationHistoryEntry>[
      NotificationHistoryEntry(
        id: 'registered-history',
        applicationId: definition.applicationId,
        title: 'Payment',
        body: r'$10',
        receivedAt: DateTime(2026, 10),
      ),
      NotificationHistoryEntry(
        id: 'other-history',
        applicationId: 'com.example.other',
        title: 'Other',
        body: 'Other',
        receivedAt: DateTime(2026, 10),
      ),
    ]);
    final _AlertStore alertStore = _AlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.evaluationFailed,
        operation: 'Evaluating notification',
        message: 'Registered application failed.',
        applicationId: definition.applicationId,
      ),
      NotificationAlert.failure(
        kind: NotificationAlertKind.evaluationFailed,
        operation: 'Evaluating notification',
        message: 'Global failure.',
      ),
    ]);
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      definitionStore: definitionStore,
      historyStore: historyStore,
      alertStore: alertStore,
    );
    await viewModel.load();

    final DeleteNotificationDefinitionsResult result = await viewModel
        .deleteAllDefinitions();

    expect(result.cleanupSucceeded, isTrue);
    expect(definitionStore.definitions, isEmpty);
    expect(viewModel.definitionCount, 0);
    expect(viewModel.hasDefinitions, isFalse);
    expect(historyStore.clearedApplicationIds, <String>[
      definition.applicationId,
    ]);
    expect(alertStore.clearedApplicationIds, <String>[
      definition.applicationId,
    ]);
    expect(historyStore.entries.single.id, 'other-history');
    expect(alertStore.alerts.single.applicationId, isNull);
    expect(viewModel.hasHistory, isTrue);
    expect(viewModel.hasAlerts, isTrue);
  });

  test(
    'reports incomplete cleanup after registrations are successfully deleted',
    () async {
      final _DefinitionStore definitionStore = _DefinitionStore(
        const <NotificationDefinition>[definition],
      );
      final _HistoryStore historyStore =
          _HistoryStore(<NotificationHistoryEntry>[
            NotificationHistoryEntry(
              id: 'history',
              applicationId: definition.applicationId,
              title: 'Payment',
              body: 'Paid 12.50 CAD',
              receivedAt: DateTime(2026, 10),
            ),
          ], StateError('cannot clear history'));
      final NotificationProcessingSettingsViewModel viewModel = _viewModel(
        definitionStore: definitionStore,
        historyStore: historyStore,
      );
      await viewModel.load();

      final DeleteNotificationDefinitionsResult result = await viewModel
          .deleteAllDefinitions();

      expect(result.cleanupSucceeded, isFalse);
      expect(definitionStore.definitions, isEmpty);
      expect(viewModel.definitionCount, 0);
      expect(viewModel.hasDefinitions, isFalse);
      expect(viewModel.hasHistory, isTrue);
    },
  );

  test(
    'reset all clears definitions, stored data, alerts, and settings',
    () async {
      final _DefinitionStore definitionStore = _DefinitionStore(
        const <NotificationDefinition>[definition],
      );
      final _HistoryStore historyStore = _HistoryStore();
      final _AlertStore alertStore = _AlertStore();
      final _SettingsStore settingsStore = _SettingsStore()
        ..settings = const NotificationProcessingSettings(
          historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
        );
      final NotificationProcessingSettingsViewModel viewModel = _viewModel(
        definitionStore: definitionStore,
        historyStore: historyStore,
        alertStore: alertStore,
        settingsStore: settingsStore,
      );

      await viewModel.resetAll();

      expect(definitionStore.definitions, isEmpty);
      expect(historyStore.cleared, isTrue);
      expect(alertStore.cleared, isTrue);
      expect(settingsStore.resetCalled, isTrue);
      expect(viewModel.settings, NotificationProcessingSettings.defaults);
    },
  );

  test('restores previous state when backup restore fails', () async {
    final _DefinitionStore definitionStore = _DefinitionStore(
      const <NotificationDefinition>[definition],
      StateError('cannot save'),
    );
    final _SettingsStore settingsStore = _SettingsStore()
      ..settings = const NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
      );
    final NotificationProcessingSettingsViewModel viewModel = _viewModel(
      definitionStore: definitionStore,
      settingsStore: settingsStore,
    );

    await expectLater(
      viewModel.restoreBackup(
        const NotificationProcessingBackup(
          definitions: <NotificationDefinition>[],
          settings: NotificationProcessingSettings(
            historyStorageMode: NotificationHistoryStorageMode.disabled,
          ),
        ),
      ),
      throwsStateError,
    );

    expect(definitionStore.definitions, const <NotificationDefinition>[
      definition,
    ]);
    expect(
      viewModel.settings?.historyStorageMode,
      NotificationHistoryStorageMode.metadataOnly,
    );
  });
}
