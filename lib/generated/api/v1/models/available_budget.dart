// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_spent.dart';

part 'available_budget.g.dart';

@JsonSerializable()
class AvailableBudget {
  const AvailableBudget({
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.amount,
    required this.start,
    required this.end,
    required this.spentInBudgets,
    required this.spentOutsideBudget,
  });
  
  factory AvailableBudget.fromJson(Map<String, Object?> json) => _$AvailableBudgetFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Use either currency_id or currency_code.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Use either currency_id or currency_code.
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;
  final String amount;

  /// Start date of the available budget.
  final DateTime start;

  /// End date of the available budget.
  final DateTime end;
  @JsonKey(name: 'spent_in_budgets')
  final List<BudgetSpent> spentInBudgets;
  @JsonKey(name: 'spent_outside_budget')
  final List<BudgetSpent> spentOutsideBudget;

  Map<String, Object?> toJson() => _$AvailableBudgetToJson(this);
}
