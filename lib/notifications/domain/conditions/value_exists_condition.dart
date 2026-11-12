import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ValueExistsCondition implements NotificationCondition {
  const ValueExistsCondition(this.valueSource);

  static const String type = 'valueExists';

  final ValueSource valueSource;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    final String? value = valueSource.resolve(context);
    if (value == null || value.isEmpty) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'The value source did not resolve.',
        isDiagnosticFailure: true,
      );
    }

    return const ConditionEvaluationResult(matches: true);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'valueSource': valueSource.toJson(),
  };

  factory ValueExistsCondition.fromJson(Map<String, dynamic> json) {
    return ValueExistsCondition(
      ValueSource.fromJson(json['valueSource'] as Map<String, dynamic>),
    );
  }
}
