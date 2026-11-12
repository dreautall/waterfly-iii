import 'package:waterflyiii/notifications/domain/conditions/ordered_values_comparison_condition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ValuesGreaterThanCondition extends OrderedValuesComparisonCondition {
  const ValuesGreaterThanCondition({required super.left, required super.right});

  static const String type = 'valuesGreaterThan';

  @override
  String get failureReason =>
      'The left value is not greater than the right value.';

  @override
  bool compare(int comparison) => comparison > 0;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'left': left.toJson(),
    'right': right.toJson(),
  };

  factory ValuesGreaterThanCondition.fromJson(Map<String, dynamic> json) {
    return ValuesGreaterThanCondition(
      left: ValueSource.fromJson(json['left'] as Map<String, dynamic>),
      right: ValueSource.fromJson(json['right'] as Map<String, dynamic>),
    );
  }
}
