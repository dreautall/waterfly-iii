// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'chart_v2_period_property.dart';

part 'chart_data_set_v2.g.dart';

@JsonSerializable()
class ChartDataSetV2 {
  const ChartDataSetV2({
    this.label,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyDecimalPlaces,
    this.start,
    this.end,
    this.period,
    this.entries,
    this.nativeEntries,
  });

  factory ChartDataSetV2.fromJson(Map<String, Object?> json) =>
      _$ChartDataSetV2FromJson(json);

  /// This is the label of the current data-set. It can refer to an object by name, or a collected set of data.
  final String? label;

  /// The currency ID of the currency associated to the data in the entries.
  @JsonKey(name: 'currency_id')
  final String? currencyId;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// Number of decimals for the currency associated to the data in the entries.
  @JsonKey(name: 'currency_decimal_places')
  final int? currencyDecimalPlaces;

  /// The currency ID of the user's native (default) currency.
  @JsonKey(name: 'native_currency_id')
  final String? nativeCurrencyId;

  /// The currency code of the user's native (default) currency.
  @JsonKey(name: 'native_currency_code')
  final String? nativeCurrencyCode;

  /// The currency symbol of the user's native (default) currency.
  @JsonKey(name: 'native_currency_symbol')
  final String? nativeCurrencySymbol;

  /// Number of decimals for the native (default) currency of the user.
  @JsonKey(name: 'native_currency_decimal_places')
  final int? nativeCurrencyDecimalPlaces;

  /// Holds the date and time of start of the range of data collected. It could be there was no data for this point in time, but this is the start of the requested range.
  final DateTime? start;

  /// Holds the date and time of END of the range of data collected. It could be there was no data for this point in time, but this is the end of the requested range.
  final DateTime? end;
  final ChartV2PeriodProperty? period;

  /// The actual entries for this data set. They 'key' value is the label for the data point. The value is the actual (numerical) value.
  final dynamic entries;

  /// The entries for this data set converted to the user's native (default) currency. They 'key' value is the label for the data point. The value is the actual (numerical) value.
  @JsonKey(name: 'native_entries')
  final dynamic nativeEntries;

  Map<String, Object?> toJson() => _$ChartDataSetV2ToJson(this);
}
