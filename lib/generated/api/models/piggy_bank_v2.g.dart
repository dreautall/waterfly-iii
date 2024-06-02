// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankV2 _$PiggyBankV2FromJson(Map<String, dynamic> json) => PiggyBankV2(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      accountId: json['account_id'] as String,
      accountName: json['account_name'] as String,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      nativeCurrencyId: json['native_currency_id'] as String,
      nativeCurrencyCode: json['native_currency_code'] as String,
      nativeCurrencySymbol: json['native_currency_symbol'] as String,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num).toInt(),
      currentAmount: json['current_amount'] as String,
      nativeCurrentAmount: json['native_current_amount'] as String,
      targetAmount: json['target_amount'] as String?,
      nativeTargetAmount: json['native_target_amount'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      leftToSave: json['left_to_save'] as String?,
      nativeLeftToSave: json['native_left_to_save'] as String?,
      savePerMonth: json['save_per_month'] as String?,
      nativeSavePerMonth: json['native_save_per_month'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num).toInt(),
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankV2ToJson(PiggyBankV2 instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'account_id': instance.accountId,
      'account_name': instance.accountName,
      'name': instance.name,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'current_amount': instance.currentAmount,
      'native_current_amount': instance.nativeCurrentAmount,
      'target_amount': instance.targetAmount,
      'native_target_amount': instance.nativeTargetAmount,
      'percentage': instance.percentage,
      'left_to_save': instance.leftToSave,
      'native_left_to_save': instance.nativeLeftToSave,
      'save_per_month': instance.savePerMonth,
      'native_save_per_month': instance.nativeSavePerMonth,
      'start_date': instance.startDate.toIso8601String(),
      'target_date': instance.targetDate?.toIso8601String(),
      'order': instance.order,
      'active': instance.active,
      'notes': instance.notes,
      'object_group_id': instance.objectGroupId,
      'object_group_order': instance.objectGroupOrder,
      'object_group_title': instance.objectGroupTitle,
    };
