import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';

class NotCondition implements NotificationCondition {
  const NotCondition(this.condition);

  static const String type = 'not';

  final NotificationCondition condition;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    final ConditionEvaluationResult result = condition.evaluate(context);
    if (result.isDiagnosticFailure) return result;
    return ConditionEvaluationResult(
      matches: !result.matches,
      failureReason: result.matches ? 'The nested condition matched.' : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'condition': condition.toJson(),
  };

  factory NotCondition.fromJson(Map<String, dynamic> json) {
    return NotCondition(
      NotificationCondition.fromJson(json['condition'] as Map<String, dynamic>),
    );
  }
}
