import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ValueContainsCondition implements NotificationCondition {
  const ValueContainsCondition({required this.value, required this.substring});

  static const String type = 'valueContains';

  final ValueSource value;
  final ValueSource substring;

  @override
  ConditionEvaluationResult evaluate(EvaluationContext context) {
    final String? resolvedValue = value.resolve(context);
    final String? resolvedSubstring = substring.resolve(context);
    if (resolvedValue == null || resolvedSubstring == null) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'A value source did not resolve.',
        isDiagnosticFailure: true,
      );
    }

    if (!resolvedValue.toLowerCase().contains(
      resolvedSubstring.toLowerCase(),
    )) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'The value does not contain the expected text.',
      );
    }

    return const ConditionEvaluationResult(matches: true);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'value': value.toJson(),
    'substring': substring.toJson(),
  };

  factory ValueContainsCondition.fromJson(Map<String, dynamic> json) {
    return ValueContainsCondition(
      value: ValueSource.fromJson(json['value'] as Map<String, dynamic>),
      substring: ValueSource.fromJson(
        json['substring'] as Map<String, dynamic>,
      ),
    );
  }
}
