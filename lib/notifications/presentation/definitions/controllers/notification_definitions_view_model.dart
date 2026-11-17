import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/migrations/pending_notification_migration_completion_service.dart';
import 'package:waterflyiii/notifications/application/migrations/notification_migration_alert_reconciler.dart';
import 'package:waterflyiii/notifications/application/resources/application_name_resolver.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

class NotificationDefinitionsViewModel extends ChangeNotifier {
  NotificationDefinitionsViewModel(
    this._store,
    this._saveDefinition, {
    NotificationAlertStore? alertStore,
    ApplicationNameResolver? applicationNameResolver,
  }) : _alertStore = alertStore,
       _applicationNameResolver = applicationNameResolver;

  final NotificationDefinitionStore _store;
  final SaveNotificationDefinition _saveDefinition;
  final NotificationAlertStore? _alertStore;
  final ApplicationNameResolver? _applicationNameResolver;
  static final Logger _log = Logger('Notifications.Definitions');

  List<NotificationDefinition> definitions = <NotificationDefinition>[];
  List<NotificationAlert> migrationAlerts = <NotificationAlert>[];
  Object? error;
  Object? migrationAlertsError;
  bool isLoading = false;
  bool isMutating = false;
  int _loadGeneration = 0;

  bool get hasPendingAutomaticMigration => definitions.any(
    PendingNotificationMigrationCompletionService.isPendingAutomaticCompletion,
  );

  Future<void> load() async {
    final int loadGeneration = ++_loadGeneration;
    isLoading = true;
    error = null;
    migrationAlertsError = null;
    notifyListeners();
    try {
      final List<NotificationDefinition> loadedDefinitions =
          await _resolveMissingApplicationNames(await _store.load());
      if (loadGeneration != _loadGeneration) return;
      definitions = List<NotificationDefinition>.of(loadedDefinitions)
        ..sort(_compareDefinitions);
      final NotificationAlertStore? alertStore = _alertStore;
      if (alertStore != null) {
        try {
          await NotificationMigrationAlertReconciler(
            alertStore,
          ).reconcile(loadedDefinitions);
          final List<NotificationAlert> loadedAlerts = await alertStore.load();
          if (loadGeneration != _loadGeneration) return;
          migrationAlerts = loadedAlerts
              .where(
                (NotificationAlert alert) =>
                    alert.kind == NotificationAlertKind.migrationNeedsReview ||
                    alert.kind == NotificationAlertKind.migrationFailed,
              )
              .toList(growable: false);
        } catch (loadError) {
          if (loadGeneration != _loadGeneration) return;
          migrationAlerts = <NotificationAlert>[];
          migrationAlertsError = loadError;
        }
      } else {
        migrationAlerts = <NotificationAlert>[];
      }
    } catch (loadError) {
      if (loadGeneration != _loadGeneration) return;
      error = loadError;
      definitions = <NotificationDefinition>[];
      migrationAlerts = <NotificationAlert>[];
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<List<NotificationDefinition>> _resolveMissingApplicationNames(
    List<NotificationDefinition> loadedDefinitions,
  ) async {
    final ApplicationNameResolver? resolver = _applicationNameResolver;
    if (resolver == null) return loadedDefinitions;
    final List<NotificationDefinition> resolved =
        List<NotificationDefinition>.of(loadedDefinitions);
    for (final (int index, NotificationDefinition definition)
        in resolved.indexed) {
      final String currentName = definition.name.trim();
      if (currentName.isNotEmpty && currentName != definition.applicationId) {
        continue;
      }
      try {
        final String? name = await resolver.resolve(definition.applicationId);
        if (name == null ||
            name.trim().isEmpty ||
            name.trim() == definition.applicationId) {
          continue;
        }
        final SaveNotificationDefinitionResult result = await _saveDefinition
            .updateLatest(definition.id, (NotificationDefinition current) {
              final Set<NotificationMigrationIssue> migrationReviewIssues =
                  Set<NotificationMigrationIssue>.of(
                    current.migrationReviewIssues,
                  )..remove(NotificationMigrationIssue.missingApplicationName);
              return current.copyWith(
                name: name.trim(),
                requiresMigrationReview: migrationReviewIssues.isNotEmpty,
                migrationReviewIssues: migrationReviewIssues,
              );
            });
        if (result.succeeded) resolved[index] = result.definition!;
      } catch (error, stackTrace) {
        _log.warning(
          'Could not refresh the installed application name for ${definition.applicationId}.',
          error,
          stackTrace,
        );
      }
    }
    return resolved;
  }

  Future<SaveNotificationDefinitionResult> addApplication({
    required String applicationId,
    required String applicationName,
  }) => _mutate(
    () => _saveDefinition.addApplication(
      applicationId: applicationId,
      applicationName: applicationName,
    ),
  );

  Future<SaveNotificationDefinitionResult> update(
    NotificationDefinition definition,
  ) => _mutate(() => _saveDefinition.update(definition));

  Future<SaveNotificationDefinitionResult> delete(String definitionId) =>
      _mutate(() => _saveDefinition.delete(definitionId));

  List<NotificationAlert> migrationAlertsFor(
    NotificationDefinition definition,
  ) => migrationAlerts
      .where(
        (NotificationAlert alert) =>
            alert.definitionId == definition.id ||
            alert.applicationId == definition.applicationId,
      )
      .toList(growable: false);

  static int _compareDefinitions(
    NotificationDefinition first,
    NotificationDefinition second,
  ) {
    final int nameComparison = first.name.toLowerCase().compareTo(
      second.name.toLowerCase(),
    );
    if (nameComparison != 0) return nameComparison;
    return first.applicationId.compareTo(second.applicationId);
  }

  Future<SaveNotificationDefinitionResult> _mutate(
    Future<SaveNotificationDefinitionResult> Function() operation,
  ) async {
    isMutating = true;
    notifyListeners();
    try {
      final SaveNotificationDefinitionResult result = await operation();
      if (result.succeeded) {
        await load();
      }
      return result;
    } finally {
      isMutating = false;
      notifyListeners();
    }
  }
}
