import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class NotificationDefinitionProcessor {
  const NotificationDefinitionProcessor(
    this._store, {
    this.alertStore,
    this.formattingPreferences,
  });

  final NotificationDefinitionStore _store;
  final NotificationAlertStore? alertStore;
  final NotificationFormattingPreferences? formattingPreferences;

  Future<List<ProcessedNotificationDefinition>> process(
    NotificationContext notification, {
    List<NotificationDefinition>? definitions,
  }) async {
    if (notification.title.trim().isEmpty || notification.body.trim().isEmpty) {
      return <ProcessedNotificationDefinition>[];
    }
    final List<NotificationDefinition> configuredDefinitions =
        definitions ?? await _store.load();
    final List<ProcessedNotificationDefinition> results =
        <ProcessedNotificationDefinition>[];

    for (final NotificationDefinition definition in configuredDefinitions) {
      if (definition.status != NotificationDefinitionStatus.ready) {
        continue;
      }
      NotificationDefinitionEvaluationResult? result;
      try {
        result = definition.evaluate(
          notification,
          formattingPreferences: formattingPreferences,
        );
      } catch (error) {
        await _recordFailure(
          NotificationAlertKind.evaluationFailed,
          'Evaluating notification definition',
          error,
          notification,
          definitionId: definition.id,
        );
        continue;
      }
      if (result == null) {
        continue;
      }
      final bool hasInvalidExtractor = result.extractionResults.values.any(
        (RegExpEvaluationResult result) => !result.isPatternValid,
      );
      if (hasInvalidExtractor) {
        await _recordFailure(
          NotificationAlertKind.definitionInvalid,
          'Evaluating notification definition',
          FormatException(_invalidExtractorMessage(definition, result)),
          notification,
          definitionId: definition.id,
        );
        continue;
      }
      final bool hasOversizedExtractorInput = result.extractionResults.values
          .any(
            (RegExpEvaluationResult result) =>
                result.failure == RegExpEvaluationFailure.inputTooLong,
          );
      if (hasOversizedExtractorInput) {
        await _recordFailure(
          NotificationAlertKind.evaluationFailed,
          'Evaluating notification definition',
          const FormatException(
            'The notification text is too long to evaluate safely.',
          ),
          notification,
          definitionId: definition.id,
        );
        continue;
      }
      await _recordActionFailures(
        configuredActions: definition.sharedActions,
        actionResults: result.sharedActions,
        operationOwner: 'shared notification actions',
        notification: notification,
        definitionId: definition.id,
      );
      for (final MapEntry<String, NotificationRuleEvaluationResult> entry
          in result.ruleResults.entries) {
        final NotificationRuleEvaluationResult rule = entry.value;
        final NotificationRule? configuredRule = definition.rules
            .cast<NotificationRule?>()
            .firstWhere(
              (NotificationRule? candidate) => candidate?.id == entry.key,
              orElse: () => null,
            );
        final String ruleName = configuredRule?.name ?? entry.key;
        for (final ConditionEvaluationResult condition in rule.conditions) {
          if (condition.isDiagnosticFailure) {
            await _recordFailure(
              NotificationAlertKind.evaluationFailed,
              'Evaluating notification rule "$ruleName"',
              condition.failureReason ?? 'Condition failed.',
              notification,
              definitionId: definition.id,
              ruleId: entry.key,
              ruleName: ruleName,
            );
            break;
          }
        }
        await _recordActionFailures(
          configuredActions:
              configuredRule?.actions ?? const <NotificationAction>[],
          actionResults: rule.actions,
          operationOwner: '"$ruleName"',
          notification: notification,
          definitionId: definition.id,
          ruleId: entry.key,
          ruleName: ruleName,
        );
        for (final MapEntry<String, NotificationActionGroupEvaluationResult>
            groupEntry
            in rule.conditionalGroups.entries) {
          final NotificationActionGroup? group = configuredRule
              ?.conditionalActionGroups
              .where(
                (NotificationActionGroup candidate) =>
                    candidate.id == groupEntry.key,
              )
              .firstOrNull;
          final String groupName = group?.name ?? groupEntry.key;
          for (final ConditionEvaluationResult condition
              in groupEntry.value.conditions) {
            if (!condition.isDiagnosticFailure) continue;
            await _recordFailure(
              NotificationAlertKind.evaluationFailed,
              'Evaluating action group "$groupName" for "$ruleName"',
              condition.failureReason ?? 'Condition failed.',
              notification,
              definitionId: definition.id,
              ruleId: entry.key,
              ruleName: ruleName,
            );
            break;
          }
          await _recordActionFailures(
            configuredActions: group?.actions ?? const <NotificationAction>[],
            actionResults: groupEntry.value.actions,
            operationOwner: 'action group "$groupName" for "$ruleName"',
            notification: notification,
            definitionId: definition.id,
            ruleId: entry.key,
            ruleName: ruleName,
          );
        }
      }
      results.add(
        ProcessedNotificationDefinition(
          definition: definition,
          evaluation: result,
        ),
      );
    }

    return results;
  }

  Future<void> _recordActionFailures({
    required List<NotificationAction> configuredActions,
    required List<ActionEvaluationResult> actionResults,
    required String operationOwner,
    required NotificationContext notification,
    required String definitionId,
    String? ruleId,
    String? ruleName,
  }) async {
    for (final MapEntry<int, ActionEvaluationResult> actionEntry
        in actionResults.asMap().entries) {
      final ActionEvaluationResult actionResult = actionEntry.value;
      if (actionResult.succeeded) continue;
      final NotificationAction? action =
          actionEntry.key < configuredActions.length
          ? configuredActions[actionEntry.key]
          : null;
      final String actionId = await _actionId(action);
      await _recordFailure(
        NotificationAlertKind.actionFailed,
        'Applying ${_actionName(action)} for $operationOwner',
        actionResult.failureReason ?? 'Action failed.',
        notification,
        definitionId: definitionId,
        ruleId: ruleId,
        ruleName: ruleName,
        actionId: actionId,
        actionName: _actionName(action),
      );
    }
  }

  Future<void> _recordFailure(
    NotificationAlertKind kind,
    String operation,
    Object error,
    NotificationContext notification, {
    String? definitionId,
    String? ruleId,
    String? ruleName,
    String? actionId,
    String? actionName,
  }) async {
    try {
      await alertStore?.record(
        NotificationAlert.failure(
          kind: kind,
          operation: operation,
          message: _failureMessage(error),
          applicationId: notification.applicationId,
          definitionId: definitionId,
          ruleId: ruleId,
          ruleName: ruleName,
          actionId: actionId,
          actionName: actionName,
          notification: notification,
        ),
      );
    } catch (_) {
      // Diagnostics must not prevent notification processing.
    }
  }

  String _actionName(NotificationAction? action) => switch (action) {
    SetTransactionFieldAction(:final TransactionField target) =>
      'Set ${target.name}',
    _ => 'notification action',
  };

  Future<String> _actionId(NotificationAction? action) async {
    final String serializedAction = action == null
        ? 'unknown-notification-action'
        : jsonEncode(action.toJson());
    final List<int> bytes = (await Sha256().hash(
      utf8.encode(serializedAction),
    )).bytes;
    return bytes
        .map((int byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  String _failureMessage(Object error) {
    if (error is FormatException) {
      return error.message.toString();
    }
    return error.toString();
  }

  String _invalidExtractorMessage(
    NotificationDefinition definition,
    NotificationDefinitionEvaluationResult result,
  ) {
    final String? invalidExtractorId = result.extractionResults.entries
        .where(
          (MapEntry<String, RegExpEvaluationResult> entry) =>
              !entry.value.isPatternValid,
        )
        .map((MapEntry<String, RegExpEvaluationResult> entry) => entry.key)
        .firstOrNull;
    final String? extractorName = definition.extractors
        .where(
          (RegExpDefinition extractor) => extractor.id == invalidExtractorId,
        )
        .map((RegExpDefinition extractor) => extractor.definitionName)
        .firstOrNull;
    return extractorName == null
        ? 'A notification extractor has an invalid pattern.'
        : 'The "$extractorName" extractor has an invalid pattern.';
  }
}

class ProcessedNotificationDefinition {
  const ProcessedNotificationDefinition({
    required this.definition,
    required this.evaluation,
  });

  final NotificationDefinition definition;
  final NotificationDefinitionEvaluationResult evaluation;
}
