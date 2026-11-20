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
    try {
      return await mutateNotificationDefinitions(_definitionStore, (
        List<NotificationDefinition> definitions,
      ) {
        if (definitions.any(
          (NotificationDefinition definition) =>
              definition.applicationId == applicationId,
        )) {
          return const NotificationDefinitionMutation<
            SaveNotificationDefinitionResult
          >.unchanged(
            SaveNotificationDefinitionResult(
              SaveNotificationDefinitionStatus.duplicate,
            ),
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
        definitions.add(definition);
        return NotificationDefinitionMutation<
          SaveNotificationDefinitionResult
        >.changed(
          SaveNotificationDefinitionResult(
            SaveNotificationDefinitionStatus.saved,
            definition: definition,
          ),
        );
      });
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<SaveNotificationDefinitionResult> update(
    NotificationDefinition definition,
  ) => updateLatest(
    definition.id,
    (NotificationDefinition current) => definition,
  );

  Future<SaveNotificationDefinitionResult> updateLatest(
    String definitionId,
    NotificationDefinition Function(NotificationDefinition current) update,
  ) async {
    NotificationDefinition? previous;
    try {
      final SaveNotificationDefinitionResult result =
          await mutateNotificationDefinitions(_definitionStore, (
            List<NotificationDefinition> definitions,
          ) {
            final int index = definitions.indexWhere(
              (NotificationDefinition candidate) =>
                  candidate.id == definitionId,
            );
            if (index < 0) {
              return const NotificationDefinitionMutation<
                SaveNotificationDefinitionResult
              >.unchanged(
                SaveNotificationDefinitionResult(
                  SaveNotificationDefinitionStatus.notFound,
                ),
              );
            }
            previous = definitions[index];
            final NotificationDefinition updated = update(previous!);
            if (definitions.any(
              (NotificationDefinition candidate) =>
                  candidate.id != updated.id &&
                  candidate.applicationId == updated.applicationId,
            )) {
              return const NotificationDefinitionMutation<
                SaveNotificationDefinitionResult
              >.unchanged(
                SaveNotificationDefinitionResult(
                  SaveNotificationDefinitionStatus.duplicate,
                ),
              );
            }
            definitions[index] = updated;
            return NotificationDefinitionMutation<
              SaveNotificationDefinitionResult
            >.changed(
              SaveNotificationDefinitionResult(
                SaveNotificationDefinitionStatus.saved,
                definition: updated,
              ),
            );
          });
      if (result.succeeded) {
        final NotificationDefinition updated = result.definition!;
        await _resolveCurrencyMigrationAlerts(previous!, updated);
        await _resolveApplicationNameMigrationAlerts(previous!, updated);
        await _resolveInvalidRegexMigrationAlerts(previous!, updated);
        await _dismissReviewedMigrationAlerts(previous!, updated);
      }
      return result;
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _dismissReviewedMigrationAlerts(
    NotificationDefinition previous,
    NotificationDefinition updated,
  ) async {
    final NotificationAlertStore? store = alertStore;
    final bool hadMigrationReview =
        previous.requiresMigrationReview ||
        previous.migrationReviewIssues.isNotEmpty;
    final bool hasMigrationReview =
        updated.requiresMigrationReview ||
        updated.migrationReviewIssues.isNotEmpty;
    if (store == null || !hadMigrationReview || hasMigrationReview) {
      return;
    }
    try {
      final List<NotificationAlert> alerts = await store.load();
      for (final NotificationAlert alert in alerts.where(
        (NotificationAlert alert) =>
            alert.kind == NotificationAlertKind.migrationNeedsReview &&
            (alert.definitionId == updated.id ||
                alert.applicationId == previous.applicationId ||
                alert.applicationId == updated.applicationId),
      )) {
        await store.dismiss(alert.fingerprint);
      }
    } catch (error, stackTrace) {
      _log.warning(
        'Could not dismiss reviewed notification migration alerts.',
        error,
        stackTrace,
      );
    }
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
    NotificationDefinition? definition;
    try {
      final SaveNotificationDefinitionResult result =
          await mutateNotificationDefinitions(_definitionStore, (
            List<NotificationDefinition> definitions,
          ) {
            final int index = definitions.indexWhere(
              (NotificationDefinition candidate) =>
                  candidate.id == definitionId,
            );
            if (index < 0) {
              return const NotificationDefinitionMutation<
                SaveNotificationDefinitionResult
              >.unchanged(
                SaveNotificationDefinitionResult(
                  SaveNotificationDefinitionStatus.notFound,
                ),
              );
            }
            definition = definitions.removeAt(index);
            return NotificationDefinitionMutation<
              SaveNotificationDefinitionResult
            >.changed(
              SaveNotificationDefinitionResult(
                SaveNotificationDefinitionStatus.saved,
                definition: definition,
              ),
            );
          });
      if (!result.succeeded) return result;
    } catch (error, stackTrace) {
      return SaveNotificationDefinitionResult(
        SaveNotificationDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    try {
      await alertStore?.clearForApplication(definition!.applicationId);
      await historyStore?.clearForApplication(definition!.applicationId);
    } catch (error, stackTrace) {
      // Cleanup failures must not restore a deleted registration.
      _log.warning(
        'Could not clear notification data after deleting a definition.',
        error,
        stackTrace,
      );
    }
    return SaveNotificationDefinitionResult(
      SaveNotificationDefinitionStatus.saved,
      definition: definition,
    );
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
            isConfiguredCurrencyValueSource(action.valueSource),
      );

  bool _isUnresolvedCurrencyAction(SetTransactionFieldAction action) =>
      action.target == TransactionField.currency &&
      !isConfiguredCurrencyValueSource(action.valueSource);
}
