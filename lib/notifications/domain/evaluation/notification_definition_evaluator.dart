import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class NotificationDefinitionEvaluator {
  const NotificationDefinitionEvaluator({
    required this.extractors,
    required this.rules,
    required this.transactionCreationMode,
    this.sharedActions = const <NotificationAction>[],
    this.formattingPreferences,
  });

  final List<RegExpDefinition> extractors;
  final List<NotificationRule> rules;
  final List<NotificationAction> sharedActions;
  final TransactionCreationMode transactionCreationMode;
  final NotificationFormattingPreferences? formattingPreferences;

  NotificationDefinitionEvaluationResult evaluate(
    NotificationContext notification,
  ) {
    final Map<String, RegExpEvaluationResult> extractionResults =
        <String, RegExpEvaluationResult>{
          for (final RegExpDefinition extractor in extractors)
            extractor.id: extractor.evaluate(notification),
        };
    final EvaluationContext context = EvaluationContext(
      notification: notification,
      extractionResults: extractionResults,
      extractorNames: <String, String>{
        for (final RegExpDefinition extractor in extractors)
          extractor.id: extractor.definitionName,
      },
      dateTimeExtractorIds: <String>{
        for (final RegExpDefinition extractor in extractors)
          if (extractor.predefinedType ==
              PredefinedRegExpDefinition.notificationDate)
            extractor.id,
      },
      formattingPreferences: formattingPreferences,
    );
    final List<NotificationRuleRequirement> unmetSharedRequirements =
        NotificationRule(
              id: 'shared-actions',
              name: 'Shared actions',
              conditions: const <NotificationCondition>[],
              actions: sharedActions,
            ).requirements
            .where(
              (NotificationRuleRequirement requirement) =>
                  !requirement.isAvailable(context),
            )
            .toList();
    if (unmetSharedRequirements.isNotEmpty) {
      return NotificationDefinitionEvaluationResult(
        extractionResults: extractionResults,
        ruleResults: const <String, NotificationRuleEvaluationResult>{},
        unmetSharedRequirements: unmetSharedRequirements,
      );
    }

    final Map<String, NotificationRuleEvaluationResult> ruleResults =
        <String, NotificationRuleEvaluationResult>{};
    NotificationRule? selectedRule;
    NotificationRuleEvaluationResult? selectedResult;
    for (final NotificationRule rule in rules) {
      final NotificationRuleEvaluationResult result = rule.evaluate(context);
      ruleResults[rule.id] = result;
      if (result.matches) {
        selectedRule = rule;
        selectedResult = result;
        break;
      }
    }
    if (selectedRule == null || selectedResult == null) {
      if (sharedActions.isNotEmpty) {
        return _sharedActionsOnlyResult(
          context,
          extractionResults: extractionResults,
          ruleResults: ruleResults,
        );
      }
      return NotificationDefinitionEvaluationResult(
        extractionResults: extractionResults,
        ruleResults: ruleResults,
      );
    }

    final List<ActionEvaluationResult> sharedActionResults = sharedActions
        .map((NotificationAction action) => action.evaluate(context))
        .toList();
    final TransactionPatch effectivePatch =
        TransactionPatch.merge(<TransactionPatch?>[
          ...sharedActionResults.map(
            (ActionEvaluationResult result) => result.patch,
          ),
          selectedResult.patch,
        ]);
    final bool actionsSucceeded =
        sharedActionResults.every(
          (ActionEvaluationResult result) => result.succeeded,
        ) &&
        selectedResult.actionsSucceeded;
    return NotificationDefinitionEvaluationResult(
      extractionResults: extractionResults,
      ruleResults: ruleResults,
      sharedActions: sharedActionResults,
      selectedRuleId: selectedRule.id,
      effectiveTransactionIntent: actionsSucceeded
          ? TransactionIntent(
              mode: transactionCreationMode,
              patch: effectivePatch,
            )
          : null,
    );
  }

  NotificationDefinitionEvaluationResult _sharedActionsOnlyResult(
    EvaluationContext context, {
    required Map<String, RegExpEvaluationResult> extractionResults,
    required Map<String, NotificationRuleEvaluationResult> ruleResults,
  }) {
    final List<ActionEvaluationResult> sharedActionResults = sharedActions
        .map((NotificationAction action) => action.evaluate(context))
        .toList();
    final TransactionPatch patch = TransactionPatch.merge(
      sharedActionResults.map((ActionEvaluationResult result) => result.patch),
    );
    final bool actionsSucceeded = sharedActionResults.every(
      (ActionEvaluationResult result) => result.succeeded,
    );
    return NotificationDefinitionEvaluationResult(
      extractionResults: extractionResults,
      ruleResults: ruleResults,
      sharedActions: sharedActionResults,
      effectiveTransactionIntent: actionsSucceeded
          ? TransactionIntent(mode: transactionCreationMode, patch: patch)
          : null,
    );
  }
}
