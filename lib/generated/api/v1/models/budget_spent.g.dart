// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_spent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetSpent _$BudgetSpentFromJson(Map<String, dynamic> json) => BudgetSpent(
      sum: json['sum'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$BudgetSpentToJson(BudgetSpent instance) =>
    <String, dynamic>{
      'sum': instance.sum,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
    };
