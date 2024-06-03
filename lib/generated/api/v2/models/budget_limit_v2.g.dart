// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitV2 _$BudgetLimitV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitV2(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      budgetId: json['budget_id'] as String,
      amount: json['amount'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyName: json['currency_name'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      period: json['period'] as String?,
    );

Map<String, dynamic> _$BudgetLimitV2ToJson(BudgetLimitV2 instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_name': instance.currencyName,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'budget_id': instance.budgetId,
      'period': instance.period,
      'amount': instance.amount,
    };
