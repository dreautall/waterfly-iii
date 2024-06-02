// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableBudget _$AvailableBudgetFromJson(Map<String, dynamic> json) =>
    AvailableBudget(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      amount: json['amount'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      spentInBudgets: (json['spent_in_budgets'] as List<dynamic>)
          .map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
          .toList(),
      spentOutsideBudget: (json['spent_outside_budget'] as List<dynamic>)
          .map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableBudgetToJson(AvailableBudget instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'amount': instance.amount,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'spent_in_budgets': instance.spentInBudgets,
      'spent_outside_budget': instance.spentOutsideBudget,
    };
