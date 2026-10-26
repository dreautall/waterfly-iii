import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';

class NotificationRuleEvaluationResult {
  const NotificationRuleEvaluationResult({
    required this.matches,
    required this.conditions,
    required this.actions,
    required this.patch,
    this.conditionalGroups =
        const <String, NotificationActionGroupEvaluationResult>{},
    this.unmetRequirements = const <NotificationRuleRequirement>[],
    this.transactionIntent,
  });

  final bool matches;
  final List<ConditionEvaluationResult> conditions;
  final List<ActionEvaluationResult> actions;
  final TransactionPatch patch;
  final Map<String, NotificationActionGroupEvaluationResult> conditionalGroups;
  final List<NotificationRuleRequirement> unmetRequirements;
  final TransactionIntent? transactionIntent;

  bool get requirementsMet => unmetRequirements.isEmpty;

  bool get actionsSucceeded =>
      actions.every((ActionEvaluationResult action) => action.succeeded) &&
      conditionalGroups.values
          .where(
            (NotificationActionGroupEvaluationResult group) => group.matches,
          )
          .every(
            (NotificationActionGroupEvaluationResult group) => group.succeeded,
          );
}
