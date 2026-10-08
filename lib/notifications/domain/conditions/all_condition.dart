import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';

class AllCondition implements NotificationCondition {
  const AllCondition(this.conditions);

  static const String type = 'all';

  final List<NotificationCondition> conditions;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    for (final NotificationCondition condition in conditions) {
      final ConditionEvaluationResult result = condition.evaluate(context);
      if (!result.matches) {
        return result;
      }
    }

    return const ConditionEvaluationResult(matches: true);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'conditions': conditions
        .map((NotificationCondition condition) => condition.toJson())
        .toList(),
  };

  factory AllCondition.fromJson(Map<String, dynamic> json) {
    return AllCondition(
      (json['conditions'] as List<dynamic>)
          .map(
            (dynamic condition) => NotificationCondition.fromJson(
              condition as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
