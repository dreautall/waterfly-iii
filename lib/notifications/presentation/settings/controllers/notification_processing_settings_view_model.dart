import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_configuration_service.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

@immutable
class DeleteNotificationDefinitionsResult {
  const DeleteNotificationDefinitionsResult({required this.cleanupSucceeded});

  final bool cleanupSucceeded;
}

class NotificationProcessingSettingsViewModel extends ChangeNotifier {
  NotificationProcessingSettingsViewModel({
    required NotificationDefinitionStore definitionStore,
    required NotificationHistoryStore historyStore,
    required NotificationAlertStore alertStore,
    required NotificationProcessingSettingsStore settingsStore,
    NotificationProcessingConfigurationService? configurationService,
  }) : _definitionStore = definitionStore,
       _historyStore = historyStore,
       _alertStore = alertStore,
       _settingsStore = settingsStore,
       _configurationService =
           configurationService ??
           const NotificationProcessingConfigurationService();

  final NotificationDefinitionStore _definitionStore;
  final NotificationHistoryStore _historyStore;
  final NotificationAlertStore _alertStore;
  final NotificationProcessingSettingsStore _settingsStore;
  final NotificationProcessingConfigurationService _configurationService;
  static final Logger _log = Logger('Notifications.ProcessingSettings');

  NotificationProcessingSettings? settings;
  Object? loadError;
  bool isLoading = false;
  bool isBusy = false;
  int definitionCount = 0;
  bool hasHistory = false;
  bool hasAlerts = false;
  int _loadGeneration = 0;

  bool get hasDefinitions => definitionCount > 0;

  bool get hasSetupOrStoredData => hasDefinitions || hasHistory || hasAlerts;

  Future<void> load() async {
    final int loadGeneration = ++_loadGeneration;
    isLoading = true;
    loadError = null;
    notifyListeners();
    try {
      final (
        NotificationProcessingSettings loadedSettings,
        List<NotificationDefinition> definitions,
        List<NotificationHistoryEntry> history,
        List<NotificationAlert> alerts,
      ) = await (
        _settingsStore.load(),
        _definitionStore.load(),
        _historyStore.load(),
        _alertStore.load(),
      ).wait;
      if (loadGeneration != _loadGeneration) return;
      settings = loadedSettings;
      definitionCount = definitions.length;
      hasHistory = history.isNotEmpty;
      hasAlerts = alerts.isNotEmpty;
      _log.fine('Loaded notification processing settings.');
    } catch (error, stackTrace) {
      if (loadGeneration != _loadGeneration) return;
      _log.warning(
        'Could not load notification processing settings.',
        error,
        stackTrace,
      );
      loadError = error;
      settings = null;
      definitionCount = 0;
      hasHistory = false;
      hasAlerts = false;
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> updateSettings(
    NotificationProcessingSettings nextSettings,
  ) async {
    final NotificationProcessingSettings previousSettings =
        settings ?? NotificationProcessingSettings.defaults;
    settings = nextSettings;
    notifyListeners();
    try {
      await _settingsStore.save(nextSettings);
      _log.fine('Saved notification processing settings.');
      return true;
    } catch (error, stackTrace) {
      _log.warning(
        'Could not save notification processing settings.',
        error,
        stackTrace,
      );
      settings = previousSettings;
      notifyListeners();
      return false;
    }
  }

  NotificationProcessingBackup readBackup(Uint8List data) {
    try {
      final NotificationProcessingBackup backup = _configurationService
          .readBackup(data);
      _log.fine(
        'Read notification processing backup with ${backup.definitions.length} definitions.',
      );
      return backup;
    } catch (error, stackTrace) {
      _log.warning(
        'Could not read notification processing backup.',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  Future<Uint8List> createBackup({
    required DateTime exportedAt,
  }) => _runBusy(() async {
    final List<NotificationDefinition> definitions = await _definitionStore
        .load();
    final NotificationProcessingSettings backupSettings = await _settingsStore
        .load();
    final Uint8List backup = _configurationService.createBackup(
      definitions: definitions,
      settings: backupSettings,
      exportedAt: exportedAt,
    );
    _log.info(
      'Created notification processing backup with ${definitions.length} definitions.',
    );
    return backup;
  });

  Future<void> restoreBackup(
    NotificationProcessingBackup backup,
  ) => _runBusy(() async {
    final List<NotificationDefinition> previousDefinitions =
        await _definitionStore.load();
    final NotificationProcessingSettings previousSettings = await _settingsStore
        .load();
    try {
      _log.info(
        'Restoring notification processing backup with ${backup.definitions.length} definitions.',
      );
      await _definitionStore.save(backup.definitions);
      await _settingsStore.save(backup.settings);
      settings = backup.settings;
      definitionCount = backup.definitions.length;
      _log.info('Restored notification processing backup.');
    } catch (error, stackTrace) {
      _log.warning(
        'Could not restore notification processing backup; restoring previous state.',
        error,
        stackTrace,
      );
      await _restoreDefinitionsAndSettings(
        previousDefinitions,
        previousSettings,
      );
      settings = previousSettings;
      rethrow;
    }
  });

  Future<void> clearHistory() => _runBusy(() async {
    await _historyStore.clearAll();
    hasHistory = false;
    _log.info('Cleared notification processing history.');
  });

  Future<void> clearAlerts() => _runBusy(() async {
    await _alertStore.clearAll();
    hasAlerts = false;
    _log.info('Cleared notification processing alerts.');
  });

  Future<DeleteNotificationDefinitionsResult>
  deleteAllDefinitions() => _runBusy(() async {
    final List<NotificationDefinition> definitions = await _definitionStore
        .load();
    if (definitions.isEmpty) {
      definitionCount = 0;
      return const DeleteNotificationDefinitionsResult(cleanupSucceeded: true);
    }

    await _definitionStore.save(const <NotificationDefinition>[]);
    definitionCount = 0;

    bool cleanupSucceeded = true;
    final Set<String> applicationIds = definitions
        .map((NotificationDefinition definition) => definition.applicationId)
        .toSet();
    for (final String applicationId in applicationIds) {
      try {
        await _alertStore.clearForApplication(applicationId);
      } catch (error, stackTrace) {
        cleanupSucceeded = false;
        _log.warning(
          'Could not clear alerts after deleting all definitions.',
          error,
          stackTrace,
        );
      }
      try {
        await _historyStore.clearForApplication(applicationId);
      } catch (error, stackTrace) {
        cleanupSucceeded = false;
        _log.warning(
          'Could not clear history after deleting all definitions.',
          error,
          stackTrace,
        );
      }
    }

    try {
      hasHistory = (await _historyStore.load()).isNotEmpty;
    } catch (error, stackTrace) {
      cleanupSucceeded = false;
      _log.warning(
        'Could not refresh history availability after deleting all definitions.',
        error,
        stackTrace,
      );
    }
    try {
      hasAlerts = (await _alertStore.load()).isNotEmpty;
    } catch (error, stackTrace) {
      cleanupSucceeded = false;
      _log.warning(
        'Could not refresh alert availability after deleting all definitions.',
        error,
        stackTrace,
      );
    }
    if (cleanupSucceeded) {
      _log.info('Deleted all notification application registrations.');
    } else {
      _log.warning(
        'Deleted all notification application registrations with incomplete related-data cleanup.',
      );
    }
    return DeleteNotificationDefinitionsResult(
      cleanupSucceeded: cleanupSucceeded,
    );
  });

  Future<void> resetAll() => _runBusy(() async {
    final List<NotificationDefinition> previousDefinitions =
        await _definitionStore.load();
    final NotificationProcessingSettings previousSettings = await _settingsStore
        .load();
    try {
      await _definitionStore.save(const <NotificationDefinition>[]);
      await _historyStore.clearAll();
      await _alertStore.clearAll();
      await _settingsStore.reset();
      settings = NotificationProcessingSettings.defaults;
      definitionCount = 0;
      hasHistory = false;
      hasAlerts = false;
      _log.info('Reset all notification processing data.');
    } catch (error, stackTrace) {
      _log.warning(
        'Could not reset all notification processing data; restoring previous state.',
        error,
        stackTrace,
      );
      await _restoreDefinitionsAndSettings(
        previousDefinitions,
        previousSettings,
      );
      settings = previousSettings;
      rethrow;
    }
  });

  Future<void> _restoreDefinitionsAndSettings(
    List<NotificationDefinition> definitions,
    NotificationProcessingSettings settings,
  ) async {
    try {
      await _definitionStore.save(definitions);
      await _settingsStore.save(settings);
    } catch (rollbackError, stackTrace) {
      _log.warning(
        'Could not restore notification processing state after a failed '
        'settings operation.',
        rollbackError,
        stackTrace,
      );
    }
  }

  Future<T> _runBusy<T>(Future<T> Function() action) async {
    if (isBusy) {
      throw StateError('Notification processing settings are already busy.');
    }
    isBusy = true;
    notifyListeners();
    try {
      return await action();
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }
}
