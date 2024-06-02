// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountV2 _$AccountV2FromJson(Map<String, dynamic> json) => AccountV2(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      order: (json['order'] as num?)?.toInt(),
      name: json['name'] as String,
      iban: json['iban'] as String?,
      type: ShortAccountTypeProperty.fromJson(json['type'] as String),
      accountRole: AccountRoleProperty.fromJson(json['account_role'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      nativeCurrencyId: json['native_currency_id'] as String,
      nativeCurrencyCode: json['native_currency_code'] as String,
      nativeCurrencySymbol: json['native_currency_symbol'] as String,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num).toInt(),
      currentBalance: json['current_balance'] as String,
      nativeCurrentBalance: json['native_current_balance'] as String,
      currentBalanceDate:
          DateTime.parse(json['current_balance_date'] as String),
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$AccountV2ToJson(AccountV2 instance) => <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'active': instance.active,
      'order': instance.order,
      'name': instance.name,
      'iban': instance.iban,
      'type': _$ShortAccountTypePropertyEnumMap[instance.type]!,
      'account_role': _$AccountRolePropertyEnumMap[instance.accountRole]!,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'current_balance': instance.currentBalance,
      'native_current_balance': instance.nativeCurrentBalance,
      'current_balance_date': instance.currentBalanceDate.toIso8601String(),
    };

const _$ShortAccountTypePropertyEnumMap = {
  ShortAccountTypeProperty.asset: 'asset',
  ShortAccountTypeProperty.expense: 'expense',
  ShortAccountTypeProperty.valueImport: 'import',
  ShortAccountTypeProperty.revenue: 'revenue',
  ShortAccountTypeProperty.cash: 'cash',
  ShortAccountTypeProperty.liability: 'liability',
  ShortAccountTypeProperty.liabilities: 'liabilities',
  ShortAccountTypeProperty.initialBalance: 'initial-balance',
  ShortAccountTypeProperty.reconciliation: 'reconciliation',
  ShortAccountTypeProperty.$unknown: r'$unknown',
};

const _$AccountRolePropertyEnumMap = {
  AccountRoleProperty.defaultAsset: 'defaultAsset',
  AccountRoleProperty.sharedAsset: 'sharedAsset',
  AccountRoleProperty.savingAsset: 'savingAsset',
  AccountRoleProperty.ccAsset: 'ccAsset',
  AccountRoleProperty.cashWalletAsset: 'cashWalletAsset',
  AccountRoleProperty.valueNull: 'null',
  AccountRoleProperty.$unknown: r'$unknown',
};
