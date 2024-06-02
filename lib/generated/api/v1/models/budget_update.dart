// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'auto_budget_period.dart';
import 'auto_budget_type.dart';

part 'budget_update.g.dart';

@JsonSerializable()
class BudgetUpdate {
  const BudgetUpdate({
    required this.name,
    required this.active,
    required this.order,
    required this.notes,
    required this.autoBudgetType,
    required this.autoBudgetCurrencyId,
    required this.autoBudgetCurrencyCode,
    required this.autoBudgetAmount,
    required this.autoBudgetPeriod,
  });
  
  factory BudgetUpdate.fromJson(Map<String, Object?> json) => _$BudgetUpdateFromJson(json);
  
  final String name;
  final bool active;
  final int order;
  final String? notes;
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

  Map<String, Object?> toJson() => _$BudgetUpdateToJson(this);
}
