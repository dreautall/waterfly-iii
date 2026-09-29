import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

abstract class NumericValuesComparisonCondition
    implements NotificationCondition {
  const NumericValuesComparisonCondition({
    required this.left,
    required this.right,
  });

  final ValueSource left;
  final ValueSource right;

  bool compare(int comparison);

  String get failureReason;

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
    final _ComparableValue leftComparable = _ComparableValue.parse(leftValue);
    final _ComparableValue rightComparable = _ComparableValue.parse(rightValue);
    if (leftComparable.type != rightComparable.type) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'Both values must have the same type.',
        isDiagnosticFailure: true,
      );
    }
    if (leftComparable.type == _ComparableValueType.text) {
      return const ConditionEvaluationResult(
        matches: false,
        failureReason: 'Text values cannot be ordered.',
        isDiagnosticFailure: true,
      );
    }
    return compare(leftComparable.value.compareTo(rightComparable.value))
        ? const ConditionEvaluationResult(matches: true)
        : ConditionEvaluationResult(
            matches: false,
            failureReason: failureReason,
          );
  }
}

enum _ComparableValueType { number, dateTime, date, time, text }

class _ComparableValue {
  const _ComparableValue(this.type, this.value);

  final _ComparableValueType type;
  final Comparable<Object> value;

  factory _ComparableValue.parse(String value) {
    final String normalized = value.trim();
    final num? number = num.tryParse(normalized.replaceAll(',', '.'));
    if (number != null) {
      return _ComparableValue(_ComparableValueType.number, number);
    }
    if (RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(normalized)) {
      final DateTime? dateTime = DateTime.tryParse(normalized);
      if (dateTime != null) {
        return _ComparableValue(_ComparableValueType.dateTime, dateTime);
      }
    }
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(normalized)) {
      final DateTime? date = DateTime.tryParse(normalized);
      if (date != null) {
        return _ComparableValue(_ComparableValueType.date, date);
      }
    }
    final RegExpMatch? time = RegExp(
      r'^([01]\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?$',
    ).firstMatch(normalized);
    if (time != null) {
      final int seconds =
          int.parse(time.group(1)!) * 3600 +
          int.parse(time.group(2)!) * 60 +
          (int.tryParse(time.group(3) ?? '') ?? 0);
      return _ComparableValue(_ComparableValueType.time, seconds);
    }
    return _ComparableValue(_ComparableValueType.text, normalized);
  }
}
