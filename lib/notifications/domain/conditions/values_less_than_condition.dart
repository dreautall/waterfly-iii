import 'package:waterflyiii/notifications/domain/conditions/ordered_values_comparison_condition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ValuesLessThanCondition extends OrderedValuesComparisonCondition {
  const ValuesLessThanCondition({required super.left, required super.right});

  static const String type = 'valuesLessThan';

  @override
  String get failureReason =>
      'The left value is not less than the right value.';

  @override
  bool compare(int comparison) => comparison < 0;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'left': left.toJson(),
    'right': right.toJson(),
  };

  factory ValuesLessThanCondition.fromJson(Map<String, dynamic> json) {
    return ValuesLessThanCondition(
      left: ValueSource.fromJson(json['left'] as Map<String, dynamic>),
      right: ValueSource.fromJson(json['right'] as Map<String, dynamic>),
    );
  }
}
