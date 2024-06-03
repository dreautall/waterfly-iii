// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'budget_spent.g.dart';

@JsonSerializable()
class BudgetSpent {
  const BudgetSpent({
    required this.sum,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
  });

  factory BudgetSpent.fromJson(Map<String, Object?> json) =>
      _$BudgetSpentFromJson(json);

  /// The amount spent.
  final String sum;
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  Map<String, Object?> toJson() => _$BudgetSpentToJson(this);
}
