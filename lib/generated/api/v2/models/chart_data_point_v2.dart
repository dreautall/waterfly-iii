// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'chart_data_point_v2.g.dart';

@JsonSerializable()
class ChartDataPointV2 {
  const ChartDataPointV2({
    required this.key,
  });
  
  factory ChartDataPointV2.fromJson(Map<String, Object?> json) => _$ChartDataPointV2FromJson(json);
  
  /// The key is the label of the value, so for example: '2018-01-01' => 13 or 'Groceries' => -123. For date-related charts, this is always a Atom date.
  final String key;

  Map<String, Object?> toJson() => _$ChartDataPointV2ToJson(this);
}
