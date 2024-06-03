// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'basic_summary_v2_entry.g.dart';

@JsonSerializable()
class BasicSummaryV2Entry {
  const BasicSummaryV2Entry({
    this.key,
    this.value,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
  });

  factory BasicSummaryV2Entry.fromJson(Map<String, Object?> json) =>
      _$BasicSummaryV2EntryFromJson(json);

  /// This is a reference to the type of info shared, not influenced by translations or user preferences. The EUR value is a reference to the currency code. They EUR value may also be 'native' in which case the amount is already converted to the user's native balance.
  final String? key;

  /// The amount.
  final double? value;

  /// The currency ID of the associated currency.
  @JsonKey(name: 'currency_id')
  final String? currencyId;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// Number of decimals for the associated currency.
  @JsonKey(name: 'currency_decimal_places')
  final int? currencyDecimalPlaces;

  Map<String, Object?> toJson() => _$BasicSummaryV2EntryToJson(this);
}
