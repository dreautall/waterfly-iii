// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'auto_budget_period.dart';
import 'auto_budget_type.dart';
import 'budget_spent.dart';

part 'budget.g.dart';

@JsonSerializable()
class Budget {
  const Budget({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.active,
    required this.notes,
    required this.order,
    required this.autoBudgetType,
    required this.autoBudgetCurrencyId,
    required this.autoBudgetCurrencyCode,
    required this.autoBudgetAmount,
    required this.autoBudgetPeriod,
    required this.spent,
  });
  
  factory Budget.fromJson(Map<String, Object?> json) => _$BudgetFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String name;
  final bool active;
  final String? notes;
  final int order;
  @JsonKey(name: 'auto_budget_type')
  final AutoBudgetType autoBudgetType;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'auto_budget_currency_id')
  final String? autoBudgetCurrencyId;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'auto_budget_currency_code')
  final String? autoBudgetCurrencyCode;
  @JsonKey(name: 'auto_budget_amount')
  final String? autoBudgetAmount;
  @JsonKey(name: 'auto_budget_period')
  final AutoBudgetPeriod autoBudgetPeriod;

  /// Information on how much was spent in this budget. Is only filled in when the start and end date are submitted.
  final List<BudgetSpent> spent;

  Map<String, Object?> toJson() => _$BudgetToJson(this);
}
