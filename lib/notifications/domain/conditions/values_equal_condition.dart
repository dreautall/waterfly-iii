import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ValuesEqualCondition implements NotificationCondition {
  const ValuesEqualCondition({required this.left, required this.right});

  static const String type = 'valuesEqual';

  final ValueSource left;
  final ValueSource right;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    final String? leftValue = left.resolve(context);
    final String? rightValue = right.resolve(context);
    if (leftValue == null || rightValue == null) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'A value source did not resolve.',
        isDiagnosticFailure: true,
      );
    }

    if (leftValue != rightValue) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'The values are not equal.',
      );
    }

    return const ConditionEvaluationResult(matches: true);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'left': left.toJson(),
    'right': right.toJson(),
  };

  factory ValuesEqualCondition.fromJson(Map<String, dynamic> json) {
    return ValuesEqualCondition(
      left: ValueSource.fromJson(json['left'] as Map<String, dynamic>),
      right: ValueSource.fromJson(json['right'] as Map<String, dynamic>),
    );
  }
}
