import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class NotificationActionGroupEvaluationResult {
  const NotificationActionGroupEvaluationResult({
    required this.matches,
    required this.conditions,
    required this.actions,
    required this.patch,
  });

  final bool matches;
  final List<ConditionEvaluationResult> conditions;
  final List<ActionEvaluationResult> actions;
  final TransactionPatch patch;

  bool get succeeded =>
      matches &&
      actions.every((ActionEvaluationResult action) => action.succeeded);
}
