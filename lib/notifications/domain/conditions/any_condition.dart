import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';

class AnyCondition implements NotificationCondition {
  const AnyCondition(this.conditions);

  static const String type = 'any';

  final List<NotificationCondition> conditions;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    ConditionEvaluationResult? diagnosticFailure;
    for (final NotificationCondition condition in conditions) {
      final ConditionEvaluationResult result = condition.evaluate(context);
      if (result.matches) {
        return const ConditionEvaluationResult(matches: true);
      }
      if (result.isDiagnosticFailure) diagnosticFailure ??= result;
    }

    return diagnosticFailure ??
        const ConditionEvaluationResult(
          matches: false,
          failureReason: 'No condition matched.',
        );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'conditions': conditions
        .map((NotificationCondition condition) => condition.toJson())
        .toList(),
  };

  factory AnyCondition.fromJson(Map<String, dynamic> json) {
    return AnyCondition(
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
