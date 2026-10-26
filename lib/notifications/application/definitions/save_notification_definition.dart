import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';

enum SaveNotificationDefinitionStatus { saved, duplicate, notFound, failed }

class SaveNotificationDefinitionResult {
  const SaveNotificationDefinitionResult(
    this.status, {
    this.definition,
    this.error,
    this.stackTrace,
  });

  final SaveNotificationDefinitionStatus status;
  final NotificationDefinition? definition;
  final Object? error;
  final StackTrace? stackTrace;

  bool get succeeded => status == SaveNotificationDefinitionStatus.saved;
}

class SaveNotificationDefinition {
  const SaveNotificationDefinition(
    this._definitionStore, {
    this.alertStore,
    this.historyStore,
  });

  final NotificationDefinitionStore _definitionStore;
  final NotificationAlertStore? alertStore;
  final NotificationHistoryStore? historyStore;
  static final Logger _log = Logger('Notifications.SaveDefinition');

  Future<SaveNotificationDefinitionResult> addApplication({
    required String applicationId,
    required String applicationName,
  }) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = List<NotificationDefinition>.of(
        await _definitionStore.load(),
      );
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    if (definitions.any(
      (NotificationDefinition definition) =>
          definition.applicationId == applicationId,
    )) {
      return const SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.duplicate,
      );
    }
    final NotificationDefinition definition = NotificationDefinition(
      id: newNotificationId(),
      applicationId: applicationId,
      name: applicationName,
      extractors: const <RegExpDefinition>[],
      rules: const <NotificationRule>[],
      createdAt: DateTime.now(),
    );
    return _save(<NotificationDefinition>[
      ...definitions,
      definition,
    ], definition);
  }

  Future<SaveNotificationDefinitionResult> update(
    NotificationDefinition definition,
  ) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = List<NotificationDefinition>.of(
        await _definitionStore.load(),
      );
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final int index = definitions.indexWhere(
      (NotificationDefinition candidate) => candidate.id == definition.id,
    );
    if (index < 0) {
      return const SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.notFound,
      );
    }
    if (definitions.any(
      (NotificationDefinition candidate) =>
          candidate.id != definition.id &&
          candidate.applicationId == definition.applicationId,
    )) {
      return const SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.duplicate,
      );
    }
    final NotificationDefinition previous = definitions[index];
    definitions[index] = definition;
    final SaveNotificationDefinitionResult result = await _save(
      definitions,
      definition,
    );
    if (result.succeeded) {
      await _resolveCurrencyMigrationAlerts(previous, definition);
      await _resolveApplicationNameMigrationAlerts(previous, definition);
      await _resolveInvalidRegexMigrationAlerts(previous, definition);
    }

    return result;
  }

  Future<void> _resolveApplicationNameMigrationAlerts(
    NotificationDefinition previous,
    NotificationDefinition updated,
  ) async {
    final NotificationAlertStore? store = alertStore;
    if (store == null ||
        (previous.name.trim().isNotEmpty &&
            previous.name != previous.applicationId) ||
        updated.name.trim().isEmpty ||
        updated.name == updated.applicationId) {
      return;
    }

    await _dismissMigrationAlerts(
      store,
      updated,
      NotificationMigrationIssue.missingApplicationName,
      'Could not dismiss the resolved application-name migration alert.',
      applicationIds: <String>{previous.applicationId, updated.applicationId},
    );
  }

  Future<void> _resolveInvalidRegexMigrationAlerts(
    NotificationDefinition previous,
    NotificationDefinition updated,
  ) async {
    final NotificationAlertStore? store = alertStore;
    if (store == null ||
        !_hasInvalidRegex(previous) ||
        _hasInvalidRegex(updated)) {
      return;
    }
    await _dismissMigrationAlerts(
      store,
      updated,
      NotificationMigrationIssue.invalidRegularExpression,
      'Could not dismiss the resolved regular-expression migration alert.',
    );
  }

  bool _hasInvalidRegex(NotificationDefinition definition) {
    final NotificationContext context = NotificationContext(
      applicationId: definition.applicationId,
      applicationName: definition.name,
      title: definition.sampleTitle ?? '',
      body: definition.sampleBody ?? '',
      receivedAt: definition.sampleReceivedAt,
    );
    return definition.extractors.any(
      (RegExpDefinition extractor) =>
          !extractor.evaluate(context).isPatternValid,
    );
  }

  Future<SaveNotificationDefinitionResult> delete(String definitionId) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = List<NotificationDefinition>.of(
        await _definitionStore.load(),
      );
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final int index = definitions.indexWhere(
      (NotificationDefinition definition) => definition.id == definitionId,
    );
    if (index < 0) {
      return const SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.notFound,
      );
    }
    final NotificationDefinition definition = definitions.removeAt(index);
    final SaveNotificationDefinitionResult result = await _save(
      definitions,
      definition,
    );
    if (!result.succeeded) return result;
    try {
      await alertStore?.clearForApplication(definition.applicationId);
      await historyStore?.clearForApplication(definition.applicationId);
    } catch (error, stackTrace) {
      // Cleanup failures must not restore a deleted registration.
      _log.warning(
        'Could not clear notification data after deleting a definition.',
        error,
        stackTrace,
      );
    }
    return result;
  }

  Future<SaveNotificationDefinitionResult> _save(
    List<NotificationDefinition> definitions,
    NotificationDefinition definition,
  ) async {
    try {
      await _definitionStore.save(definitions);
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.saved,
        definition: definition,
      );
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _resolveCurrencyMigrationAlerts(
    NotificationDefinition previous,
    NotificationDefinition updated,
  ) async {
    final NotificationAlertStore? store = alertStore;
    if (store == null) return;
    final bool hadSharedCurrencyAction = previous.sharedActions
        .whereType<SetTransactionFieldAction>()
        .any(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    final Set<String> previousMappingIds = previous.rules
        .where(_isCurrencyMappingRule)
        .map((NotificationRule rule) => rule.id)
        .toSet();
    if (!hadSharedCurrencyAction && previousMappingIds.isEmpty) return;
    final bool hasUnresolvedMapping =
        updated.sharedActions.whereType<SetTransactionFieldAction>().any(
          _isUnresolvedCurrencyAction,
        ) ||
        updated.rules.any(
          (NotificationRule rule) =>
              previousMappingIds.contains(rule.id) &&
              !_hasMappedCurrencyAction(rule),
        );
    if (hasUnresolvedMapping) return;
    await _dismissMigrationAlerts(
      store,
      updated,
      NotificationMigrationIssue.currencyUnresolved,
      'Could not dismiss resolved currency migration alerts.',
    );
  }

  Future<void> _dismissMigrationAlerts(
    NotificationAlertStore store,
    NotificationDefinition definition,
    NotificationMigrationIssue issue,
    String failureMessage, {
    Set<String>? applicationIds,
  }) async {
    final Set<String> matchingApplicationIds =
        applicationIds ?? <String>{definition.applicationId};
    try {
      final List<NotificationAlert> alerts = await store.load();
      for (final NotificationAlert alert in alerts.where(
        (NotificationAlert alert) =>
            (alert.definitionId == definition.id ||
                matchingApplicationIds.contains(alert.applicationId)) &&
            alert.migrationIssue == issue,
      )) {
        await store.dismiss(alert.fingerprint);
      }
    } catch (error, stackTrace) {
      _log.warning(failureMessage, error, stackTrace);
    }
  }

  bool _isCurrencyMappingRule(NotificationRule rule) =>
      rule.isPredefined &&
      (rule.id.endsWith(':currency') || _hasMappedCurrencyAction(rule));

  bool _hasMappedCurrencyAction(NotificationRule rule) =>
      rule.actions.whereType<SetTransactionFieldAction>().any(
        (SetTransactionFieldAction action) =>
            action.target == TransactionField.currency &&
            action.valueSource is CurrencyCaptureValueSource,
      );

  bool _isUnresolvedCurrencyAction(SetTransactionFieldAction action) =>
      action.target == TransactionField.currency &&
      action.valueSource is! CurrencyCaptureValueSource;
}
