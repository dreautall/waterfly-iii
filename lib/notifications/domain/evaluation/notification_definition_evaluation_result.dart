import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';

class NotificationDefinitionEvaluationResult {
  const NotificationDefinitionEvaluationResult({
    required this.extractionResults,
    required this.ruleResults,
    this.sharedActions = const <ActionEvaluationResult>[],
    this.unmetSharedRequirements = const <NotificationRuleRequirement>[],
    this.selectedRuleId,
    this.effectiveTransactionIntent,
  });

  final Map<String, RegExpEvaluationResult> extractionResults;
  final Map<String, NotificationRuleEvaluationResult> ruleResults;
  final List<ActionEvaluationResult> sharedActions;
  final List<NotificationRuleRequirement> unmetSharedRequirements;
  final String? selectedRuleId;
  final TransactionIntent? effectiveTransactionIntent;

  bool get sharedRequirementsMet => unmetSharedRequirements.isEmpty;
}
