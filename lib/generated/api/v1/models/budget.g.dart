// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      name: json['name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      order: (json['order'] as num?)?.toInt(),
      autoBudgetType: json['auto_budget_type'] == null
          ? null
          : AutoBudgetType.fromJson(json['auto_budget_type'] as String),
      autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
      autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      autoBudgetPeriod: json['auto_budget_period'] == null
          ? null
          : AutoBudgetPeriod.fromJson(json['auto_budget_period'] as String),
      spent: (json['spent'] as List<dynamic>?)
          ?.map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
      'active': instance.active,
      'notes': instance.notes,
      'order': instance.order,
      'auto_budget_type': _$AutoBudgetTypeEnumMap[instance.autoBudgetType],
      'auto_budget_currency_id': instance.autoBudgetCurrencyId,
      'auto_budget_currency_code': instance.autoBudgetCurrencyCode,
      'auto_budget_amount': instance.autoBudgetAmount,
      'auto_budget_period':
          _$AutoBudgetPeriodEnumMap[instance.autoBudgetPeriod],
      'spent': instance.spent,
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
