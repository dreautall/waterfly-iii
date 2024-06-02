// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'chart_data_set.g.dart';

@JsonSerializable()
class ChartDataSet {
  const ChartDataSet({
    required this.label,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.yAxisID,
    required this.entries,
  });
  
  factory ChartDataSet.fromJson(Map<String, Object?> json) => _$ChartDataSetFromJson(json);
  
  /// This is the title of the current set. It can refer to an account, a budget or another object (by name).
  final String label;

  /// The currency ID of the currency associated to the data in the entries.
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals for the currency associated to the data in the entries.
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  /// Indicated the type of chart that is expected to be rendered. You can safely ignore this if you want.
  final String type;

  /// Used to indicate the Y axis for this data set. Is usually between 0 and 1 (left and right side of the chart).
  final int yAxisID;

  /// The actual entries for this data set. They 'key' value is the label for the data point. The value is the actual (numerical) value.
  final dynamic entries;

  Map<String, Object?> toJson() => _$ChartDataSetToJson(this);
}
