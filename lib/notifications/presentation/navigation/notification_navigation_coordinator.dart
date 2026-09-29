import 'package:chopper/chopper.dart' show Response;
import 'package:appcheck/appcheck.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/definitions/resolve_notification_alert_definition.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/application/rules/save_rule_in_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context_factories.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/alerts/pages/notification_alerts_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definition_details_page.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_selector_dialog.dart';
import 'package:waterflyiii/notifications/presentation/extractors/notification_definition_extractor_editor.dart';
import 'package:waterflyiii/notifications/presentation/history/pages/recent_notifications_page.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';
import 'package:waterflyiii/notifications/presentation/settings/pages/notification_processing_settings_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';

class NotificationNavigationCoordinator {
  NotificationNavigationCoordinator({
    required NotificationAlertStore alertStore,
    required NotificationDefinitionStore definitionStore,
    required NotificationRuleOperations ruleOperations,
    NotificationFeatureScope? scope,
  }) : _alertStore = alertStore,
       _definitionStore = definitionStore,
       _ruleOperations = ruleOperations,
       _scope = scope;

  NotificationNavigationCoordinator.forAlertEditors({
    required NotificationDefinitionStore definitionStore,
    required NotificationRuleOperations ruleOperations,
    NotificationFeatureScope? scope,
  }) : _alertStore = null,
       _definitionStore = definitionStore,
       _ruleOperations = ruleOperations,
       _scope = scope;

  static final Logger _log = Logger('Notifications.Navigation');

  final NotificationAlertStore? _alertStore;
  final NotificationDefinitionStore _definitionStore;
  final NotificationRuleOperations _ruleOperations;
  final NotificationFeatureScope? _scope;

  Future<void> openAlerts(
    BuildContext context, {
    NotificationAlert? initialAlert,
  }) async {
    final NotificationAlertStore? alertStore = _alertStore;
    if (alertStore == null) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NotificationAlertsPage(
          alertStore: alertStore,
          definitionStore: _definitionStore,
          initialAlertFingerprint: initialAlert?.fingerprint,
          navigationCoordinator: this,
        ),
      ),
    );
  }

  Future<void> openHistory(BuildContext context) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => RecentNotificationsPage(
            actions: RecentNotificationActions(
              createRule: (RecentNotificationHistoryEntry entry) =>
                  createRuleFromNotification(context, entry),
              createTransaction: (RecentNotificationHistoryEntry entry) =>
                  createTransactionFromNotification(context, entry),
              editRule: (RecentNotificationHistoryEntry entry) =>
                  editRuleFromNotification(context, entry),
              openAlert: (NotificationAlert alert) =>
                  openAlerts(context, initialAlert: alert),
              openAlerts: () => openAlerts(context),
              openDefinition: (RecentNotificationHistoryEntry entry) =>
                  openDefinitionFromNotification(context, entry),
              openTransaction: (String transactionId) =>
                  openCreatedTransaction(context, transactionId),
            ),
          ),
        ),
      );

  Future<void> openSettings(BuildContext context) async {
    final NotificationFeatureScope? scope = _scope;
    final NotificationAlertStore? alertStore = _alertStore;
    if (scope == null || alertStore == null) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NotificationProcessingSettingsPage(
          definitionStore: _definitionStore,
          historyStore: scope.historyStore,
          alertStore: alertStore,
          settingsStore: scope.settingsStore,
          accessSettingsLauncher: scope.accessSettingsLauncher,
          backupFileGateway: scope.backupFileGateway,
          appSettings: context.read<SettingsProvider>(),
        ),
      ),
    );
  }

  Future<void> openRuleFromAlert(
    BuildContext context,
    NotificationAlert alert,
  ) async {
    final ResolveNotificationAlertRuleResult resolution = await _ruleOperations
        .resolveAlertRule(alert);
    if (!resolution.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resolution.status == ResolveNotificationAlertRuleStatus.notFound
                  ? S.of(context).notificationsAlertsRuleUnavailable
                  : S.of(context).notificationsAlertsOpenRuleFailure,
            ),
          ),
        );
      }
      return;
    }
    if (!context.mounted) return;
    NotificationDefinition selectedDefinition = resolution.definition!;
    if (_isUnknownApplication(selectedDefinition)) {
      final NotificationDefinition? recovered = await _recoverApplication(
        context,
        selectedDefinition,
      );
      if (recovered == null || !context.mounted) return;
      selectedDefinition = recovered;
    }
    final NotificationRule selectedRule = resolution.rule!;
    bool hasSaved = false;
    final NotificationRuleDetailsResult? result = await Navigator.of(context)
        .push<NotificationRuleDetailsResult>(
          MaterialPageRoute<NotificationRuleDetailsResult>(
            builder: (BuildContext context) => NotificationRuleDetailsPage(
              rule: selectedRule,
              extractors: selectedDefinition.extractors,
              notificationContext:
                  alert.notification ?? selectedDefinition.toSampleContext(),
              definitionSampleContext: selectedDefinition.toSampleContext(),
              extractorMode: selectedDefinition.extractorMode,
              initialTestMode: true,
              isTestModeLocked: true,
              showStatusTag: false,
              rules: selectedDefinition.rules,
              sharedActions: selectedDefinition.sharedActions,
              transactionCreationMode:
                  selectedDefinition.transactionCreationMode,
              onEditExtractor: (RegExpDefinition extractor) async {
                final SaveNotificationDefinitionResult? result =
                    await editNotificationDefinitionExtractor(
                      context: context,
                      definition: selectedDefinition,
                      extractor: extractor,
                      store: _definitionStore,
                    );
                if (result != null && !result.succeeded && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).notificationsDefinitionSaveFailure,
                      ),
                    ),
                  );
                }
              },
              onSave: (NotificationRule updated) async {
                final SaveRuleInDefinitionResult saveResult =
                    await _ruleOperations.update(
                      definitionId: selectedDefinition.id,
                      originalRuleId: selectedRule.id,
                      rule: updated,
                    );
                if (saveResult.succeeded) hasSaved = true;
                return saveResult.succeeded;
              },
            ),
          ),
        );
    if (result == null) return;
    final SaveRuleInDefinitionResult? saveResult = result.delete
        ? await _ruleOperations.delete(
            definitionId: selectedDefinition.id,
            ruleId: selectedRule.id,
          )
        : result.rule == null || hasSaved
        ? null
        : await _ruleOperations.update(
            definitionId: selectedDefinition.id,
            originalRuleId: selectedRule.id,
            rule: result.rule!,
          );
    if (result.rule != null && hasSaved) return;
    if ((saveResult == null || !saveResult.succeeded) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsAlertsRuleSaveFailure),
        ),
      );
    }
  }

  Future<void> openDefinitionFromAlert(
    BuildContext context,
    NotificationAlert alert,
  ) async {
    final ResolveNotificationAlertDefinitionResult resolution =
        await ResolveNotificationAlertDefinition(_definitionStore)(alert);
    if (resolution.status == ResolveNotificationAlertDefinitionStatus.failed) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsAlertsOpenSetupFailure),
          ),
        );
      }
      return;
    }
    if (!resolution.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsAlertsSetupUnavailable),
          ),
        );
      }
      return;
    }
    if (!context.mounted) return;
    NotificationDefinition selectedDefinition = resolution.definition!;
    if (_isUnknownApplication(selectedDefinition)) {
      final NotificationDefinition? recovered = await _recoverApplication(
        context,
        selectedDefinition,
      );
      if (recovered == null || !context.mounted) return;
      selectedDefinition = recovered;
    }
    final List<NotificationAlert> migrationAlerts =
        await _migrationAlertsForDefinition(
          selectedDefinition,
          fallback: alert,
        );
    if (!context.mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NotificationDefinitionDetailsPage(
          definition: selectedDefinition,
          migrationAlerts: migrationAlerts,
          onSave: (NotificationDefinition updated) async {
            final SaveNotificationDefinitionResult saveResult =
                await SaveNotificationDefinition(
                  _definitionStore,
                ).update(updated);
            return saveResult.succeeded;
          },
        ),
      ),
    );
  }

  Future<List<NotificationAlert>> _migrationAlertsForDefinition(
    NotificationDefinition definition, {
    required NotificationAlert fallback,
  }) async {
    final NotificationAlertStore? store = _alertStore;
    if (store == null) return <NotificationAlert>[fallback];
    try {
      return (await store.load())
          .where(
            (NotificationAlert candidate) =>
                (candidate.definitionId == definition.id ||
                    candidate.applicationId == definition.applicationId) &&
                (candidate.kind == NotificationAlertKind.migrationNeedsReview ||
                    candidate.kind == NotificationAlertKind.migrationFailed),
          )
          .toList(growable: false);
    } catch (error, stackTrace) {
      _log.warning(
        'Could not load migration alerts while opening a definition.',
        error,
        stackTrace,
      );
      return <NotificationAlert>[fallback];
    }
  }

  bool _isUnknownApplication(NotificationDefinition definition) {
    final String name = definition.name.trim();
    return name.isEmpty || name == definition.applicationId;
  }

  Future<NotificationDefinition?> _recoverApplication(
    BuildContext context,
    NotificationDefinition definition,
  ) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _definitionStore.load();
    } catch (error, stackTrace) {
      _log.warning(
        'Could not load notification definitions for application recovery.',
        error,
        stackTrace,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsDefinitionsLoadFailure),
          ),
        );
      }
      return null;
    }
    if (!context.mounted) return null;
    final AppInfo? application = await showNotificationDialog<AppInfo>(
      context: context,
      builder: (BuildContext context) => NotificationApplicationSelectorDialog(
        mode: NotificationApplicationSelectionMode.recover,
        historyStore: _scope?.historyStore,
        excludedPackageIds: definitions
            .where(
              (NotificationDefinition candidate) =>
                  candidate.id != definition.id,
            )
            .map((NotificationDefinition candidate) => candidate.applicationId)
            .toSet(),
      ),
    );
    if (application == null || !context.mounted) return null;
    final SaveNotificationDefinitionResult result =
        await SaveNotificationDefinition(
          _definitionStore,
          alertStore: _alertStore,
        ).update(
          definition.copyWith(
            applicationId: application.packageName,
            name: application.appName ?? application.packageName,
          ),
        );
    if (!result.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.status == SaveNotificationDefinitionStatus.duplicate
                  ? S.of(context).notificationsDefinitionsDuplicate
                  : S.of(context).notificationsDefinitionsSaveFailure,
            ),
          ),
        );
      }
      return null;
    }
    return result.definition;
  }

  Future<bool> createRuleFromNotification(
    BuildContext context,
    RecentNotificationHistoryEntry entry,
  ) async {
    final NotificationDefinition? definition = entry.definition;
    if (definition == null || !context.mounted) return false;
    final NotificationRule draft = NotificationRule(
      id: newNotificationId(),
      name: 'Unnamed rule',
      conditions: const <NotificationCondition>[],
      actions: const <NotificationAction>[],
    );
    final NotificationContext notificationContext = entry.notification
        .toNotificationContext(applicationName: definition.name);
    bool hasSaved = false;
    final NotificationRuleDetailsResult? result = await Navigator.of(context)
        .push<NotificationRuleDetailsResult>(
          MaterialPageRoute<NotificationRuleDetailsResult>(
            builder: (BuildContext context) => NotificationRuleDetailsPage(
              rule: draft,
              extractors: definition.extractors,
              notificationContext: notificationContext,
              extractorMode: definition.extractorMode,
              initialTestMode: true,
              rules: definition.rules,
              sharedActions: definition.sharedActions,
              transactionCreationMode: definition.transactionCreationMode,
              onEditExtractor: (RegExpDefinition extractor) async {
                final SaveNotificationDefinitionResult? result =
                    await editNotificationDefinitionExtractor(
                      context: context,
                      definition: definition,
                      extractor: extractor,
                      store: _definitionStore,
                    );
                if (result != null && !result.succeeded && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).notificationsDefinitionSaveFailure,
                      ),
                    ),
                  );
                }
              },
              onSave: (NotificationRule rule) async {
                final SaveRuleInDefinitionResult saveResult = hasSaved
                    ? await _ruleOperations.update(
                        definitionId: definition.id,
                        originalRuleId: draft.id,
                        rule: rule,
                      )
                    : await _ruleOperations.add(
                        definitionId: definition.id,
                        rule: rule,
                      );
                if (saveResult.succeeded) hasSaved = true;
                return saveResult.succeeded;
              },
            ),
          ),
        );
    if (!context.mounted) return false;
    if (result?.delete ?? false) {
      if (!hasSaved) return false;
      final SaveRuleInDefinitionResult saveResult = await _ruleOperations
          .delete(definitionId: definition.id, ruleId: draft.id);
      return saveResult.succeeded ? false : hasSaved;
    }
    if (result?.rule == null) return hasSaved;
    final SaveRuleInDefinitionResult saveResult = hasSaved
        ? await _ruleOperations.update(
            definitionId: definition.id,
            originalRuleId: draft.id,
            rule: result!.rule!,
          )
        : await _ruleOperations.add(
            definitionId: definition.id,
            rule: result!.rule!,
          );
    if (!saveResult.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsMenuRuleSaveFailure),
          ),
        );
      }
      return false;
    }
    return true;
  }

  Future<bool> editRuleFromNotification(
    BuildContext context,
    RecentNotificationHistoryEntry entry,
  ) async {
    final NotificationDefinition? definition = entry.definition;
    final NotificationRule? matchedRule = entry.matchingRule;
    if (definition == null || matchedRule == null || !context.mounted) {
      return false;
    }
    final NotificationContext notificationContext = entry.notification
        .toNotificationContext(applicationName: definition.name);
    final NotificationRuleDetailsResult? result = await Navigator.of(context)
        .push<NotificationRuleDetailsResult>(
          MaterialPageRoute<NotificationRuleDetailsResult>(
            builder: (BuildContext context) => NotificationRuleDetailsPage(
              rule: matchedRule,
              extractors: definition.extractors,
              notificationContext: notificationContext,
              extractorMode: definition.extractorMode,
              initialTestMode: true,
              rules: definition.rules,
              sharedActions: definition.sharedActions,
              transactionCreationMode: definition.transactionCreationMode,
              onEditExtractor: (RegExpDefinition extractor) async {
                final SaveNotificationDefinitionResult? result =
                    await editNotificationDefinitionExtractor(
                      context: context,
                      definition: definition,
                      extractor: extractor,
                      store: _definitionStore,
                    );
                if (result != null && !result.succeeded && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).notificationsDefinitionSaveFailure,
                      ),
                    ),
                  );
                }
              },
              onSave: (NotificationRule rule) async {
                final SaveRuleInDefinitionResult saveResult =
                    await _ruleOperations.update(
                      definitionId: definition.id,
                      originalRuleId: matchedRule.id,
                      rule: rule,
                    );
                return saveResult.succeeded;
              },
            ),
          ),
        );
    if (!context.mounted || result == null) return false;
    if (!result.delete && result.rule == null) return false;
    final SaveRuleInDefinitionResult saveResult = result.delete
        ? await _ruleOperations.delete(
            definitionId: definition.id,
            ruleId: matchedRule.id,
          )
        : await _ruleOperations.update(
            definitionId: definition.id,
            originalRuleId: matchedRule.id,
            rule: result.rule!,
          );
    if (!saveResult.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsMenuRuleSaveFailure),
          ),
        );
      }
      return false;
    }
    return result.delete || result.rule != null;
  }

  Future<void> openDefinitionFromNotification(
    BuildContext context,
    RecentNotificationHistoryEntry entry,
  ) async {
    final NotificationDefinition? original = entry.definition;
    if (original == null || !context.mounted) return;
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _definitionStore.load();
    } catch (error, stackTrace) {
      _log.warning(
        'Could not load the notification definition.',
        error,
        stackTrace,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).notificationsHistoryOpenDefinitionFailure,
            ),
          ),
        );
      }
      return;
    }
    if (!context.mounted) return;
    final NotificationDefinition? definition = definitions
        .cast<NotificationDefinition?>()
        .firstWhere(
          (NotificationDefinition? candidate) => candidate?.id == original.id,
          orElse: () => null,
        );
    if (definition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).notificationsHistoryDefinitionUnavailable,
          ),
        ),
      );
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NotificationDefinitionDetailsPage(
          definition: definition,
          onSave: (NotificationDefinition updated) async =>
              (await SaveNotificationDefinition(
                _definitionStore,
              ).update(updated)).succeeded,
        ),
      ),
    );
  }

  Future<void> createTransactionFromNotification(
    BuildContext context,
    RecentNotificationHistoryEntry entry,
  ) => Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => TransactionPage(
        notification: NotificationTransaction(
          entry.notification.applicationId,
          entry.notification.title,
          entry.notification.body,
          entry.notification.receivedAt,
          intent: TransactionIntent(
            mode: entry.processingOutcome!.transactionCreationMode!,
            patch: entry.processingOutcome!.transactionPatch!,
          ),
          historyEntryId: entry.notification.id,
        ),
      ),
    ),
  );

  Future<void> openCreatedTransaction(
    BuildContext context,
    String transactionId,
  ) async {
    try {
      final FireflyIii api = context.read<FireflyService>().api;
      final Response<TransactionSingle> response = await api
          .v1TransactionsIdGet(id: transactionId);
      apiThrowErrorIfEmpty(response, context.mounted ? context : null);
      if (!context.mounted) return;
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              TransactionPage(transaction: response.body!.data),
        ),
      );
    } catch (error, stackTrace) {
      _log.warning(
        'Could not open an automatically created transaction.',
        error,
        stackTrace,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).notificationsHistoryOpenTransactionFailure,
            ),
          ),
        );
      }
    }
  }
}
