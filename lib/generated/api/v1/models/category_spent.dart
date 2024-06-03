// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'category_spent.g.dart';

@JsonSerializable()
class CategorySpent {
  const CategorySpent({
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.sum,
  });

  factory CategorySpent.fromJson(Map<String, Object?> json) =>
      _$CategorySpentFromJson(json);

  @JsonKey(name: 'currency_id')
  final String? currencyId;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'currency_decimal_places')
  final int? currencyDecimalPlaces;

  /// The amount spent.
  final String? sum;

  Map<String, Object?> toJson() => _$CategorySpentToJson(this);
}
