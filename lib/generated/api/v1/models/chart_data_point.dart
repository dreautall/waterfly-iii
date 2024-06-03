// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'chart_data_point.g.dart';

@JsonSerializable()
class ChartDataPoint {
  const ChartDataPoint({
    this.key,
  });

  factory ChartDataPoint.fromJson(Map<String, Object?> json) =>
      _$ChartDataPointFromJson(json);

  /// The key is the label of the value, so for example: '2018-01-01' => 13 or 'Groceries' => -123.
  final String? key;

  Map<String, Object?> toJson() => _$ChartDataPointToJson(this);
}
