// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetStore _$BudgetStoreFromJson(Map<String, dynamic> json) => BudgetStore(
      name: json['name'] as String,
      active: json['active'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      autoBudgetType: json['auto_budget_type'] == null
          ? null
          : AutoBudgetType.fromJson(json['auto_budget_type'] as String),
      autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
      autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      autoBudgetPeriod: json['auto_budget_period'] == null
          ? null
          : AutoBudgetPeriod.fromJson(json['auto_budget_period'] as String),
    );

Map<String, dynamic> _$BudgetStoreToJson(BudgetStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'active': instance.active,
      'order': instance.order,
      'notes': instance.notes,
      'auto_budget_type': _$AutoBudgetTypeEnumMap[instance.autoBudgetType],
      'auto_budget_currency_id': instance.autoBudgetCurrencyId,
      'auto_budget_currency_code': instance.autoBudgetCurrencyCode,
      'auto_budget_amount': instance.autoBudgetAmount,
      'auto_budget_period':
          _$AutoBudgetPeriodEnumMap[instance.autoBudgetPeriod],
    };

const _$AutoBudgetTypeEnumMap = {
  AutoBudgetType.reset: 'reset',
  AutoBudgetType.rollover: 'rollover',
  AutoBudgetType.none: 'none',
  AutoBudgetType.valueNull: 'null',
  AutoBudgetType.$unknown: r'$unknown',
};

const _$AutoBudgetPeriodEnumMap = {
  AutoBudgetPeriod.daily: 'daily',
  AutoBudgetPeriod.weekly: 'weekly',
  AutoBudgetPeriod.monthly: 'monthly',
  AutoBudgetPeriod.quarterly: 'quarterly',
  AutoBudgetPeriod.halfYear: 'half-year',
  AutoBudgetPeriod.yearly: 'yearly',
  AutoBudgetPeriod.valueNull: 'null',
  AutoBudgetPeriod.$unknown: r'$unknown',
};
