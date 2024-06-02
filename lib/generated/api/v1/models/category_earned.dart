// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'category_earned.g.dart';

@JsonSerializable()
class CategoryEarned {
  const CategoryEarned({
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.sum,
  });
  
  factory CategoryEarned.fromJson(Map<String, Object?> json) => _$CategoryEarnedFromJson(json);
  
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// The amount earned.
  final String sum;

  Map<String, Object?> toJson() => _$CategoryEarnedToJson(this);
}
