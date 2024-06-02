// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitStore _$BudgetLimitStoreFromJson(Map<String, dynamic> json) =>
    BudgetLimitStore(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      budgetId: json['budget_id'] as String,
      start: DateTime.parse(json['start'] as String),
      period: json['period'] as String?,
      end: DateTime.parse(json['end'] as String),
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$BudgetLimitStoreToJson(BudgetLimitStore instance) =>
    <String, dynamic>{
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'budget_id': instance.budgetId,
      'start': instance.start.toIso8601String(),
      'period': instance.period,
      'end': instance.end.toIso8601String(),
      'amount': instance.amount,
    };
