import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';

abstract interface class NotificationCondition {
  ConditionEvaluationResult evaluate(EvaluationContext context);

  Map<String, dynamic> toJson();

  static NotificationCondition fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case AllCondition.type:
        return AllCondition.fromJson(json);
      case AnyCondition.type:
        return AnyCondition.fromJson(json);
      case NotCondition.type:
        return NotCondition.fromJson(json);
      case ValueExistsCondition.type:
        return ValueExistsCondition.fromJson(json);
      case ValueContainsCondition.type:
        return ValueContainsCondition.fromJson(json);
      case ValuesEqualCondition.type:
        return ValuesEqualCondition.fromJson(json);
      case ValuesGreaterThanCondition.type:
        return ValuesGreaterThanCondition.fromJson(json);
      case ValuesGreaterThanOrEqualCondition.type:
        return ValuesGreaterThanOrEqualCondition.fromJson(json);
      case ValuesLessThanCondition.type:
        return ValuesLessThanCondition.fromJson(json);
      case ValuesLessThanOrEqualCondition.type:
        return ValuesLessThanOrEqualCondition.fromJson(json);
      default:
        throw FormatException(
          'Unknown notification condition type: ${json['type']}',
        );
    }
  }
}
