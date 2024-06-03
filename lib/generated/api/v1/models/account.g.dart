// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      name: json['name'] as String,
      type: ShortAccountTypeProperty.fromJson(json['type'] as String),
      active: json['active'] as bool? ?? true,
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      order: (json['order'] as num?)?.toInt(),
      accountRole: json['account_role'] == null
          ? null
          : AccountRoleProperty.fromJson(json['account_role'] as String),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      currentBalance: json['current_balance'] as String?,
      currentBalanceDate: json['current_balance_date'] == null
          ? null
          : DateTime.parse(json['current_balance_date'] as String),
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String?,
      currentDebt: json['current_debt'] as String?,
      openingBalanceDate: json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String?,
      creditCardType: json['credit_card_type'] == null
          ? null
          : CreditCardTypeProperty.fromJson(json['credit_card_type'] as String),
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: json['liability_type'] == null
          ? null
          : LiabilityTypeProperty.fromJson(json['liability_type'] as String),
      liabilityDirection: json['liability_direction'] == null
          ? null
          : LiabilityDirectionProperty.fromJson(
              json['liability_direction'] as String),
      interest: json['interest'] as String?,
      interestPeriod: json['interest_period'] == null
          ? null
          : InterestPeriodProperty.fromJson(json['interest_period'] as String),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'active': instance.active,
      'order': instance.order,
      'name': instance.name,
      'type': _$ShortAccountTypePropertyEnumMap[instance.type]!,
      'account_role': _$AccountRolePropertyEnumMap[instance.accountRole],
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'current_balance': instance.currentBalance,
      'current_balance_date': instance.currentBalanceDate?.toIso8601String(),
      'iban': instance.iban,
      'bic': instance.bic,
      'account_number': instance.accountNumber,
      'opening_balance': instance.openingBalance,
      'current_debt': instance.currentDebt,
      'opening_balance_date': instance.openingBalanceDate?.toIso8601String(),
      'virtual_balance': instance.virtualBalance,
      'include_net_worth': instance.includeNetWorth,
      'credit_card_type':
          _$CreditCardTypePropertyEnumMap[instance.creditCardType],
      'monthly_payment_date': instance.monthlyPaymentDate?.toIso8601String(),
      'liability_type': _$LiabilityTypePropertyEnumMap[instance.liabilityType],
      'liability_direction':
          _$LiabilityDirectionPropertyEnumMap[instance.liabilityDirection],
      'interest': instance.interest,
      'interest_period':
          _$InterestPeriodPropertyEnumMap[instance.interestPeriod],
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zoom_level': instance.zoomLevel,
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

const _$CreditCardTypePropertyEnumMap = {
  CreditCardTypeProperty.monthlyFull: 'monthlyFull',
  CreditCardTypeProperty.valueNull: 'null',
  CreditCardTypeProperty.$unknown: r'$unknown',
};

const _$LiabilityTypePropertyEnumMap = {
  LiabilityTypeProperty.loan: 'loan',
  LiabilityTypeProperty.debt: 'debt',
  LiabilityTypeProperty.mortgage: 'mortgage',
  LiabilityTypeProperty.valueNull: 'null',
  LiabilityTypeProperty.$unknown: r'$unknown',
};

const _$LiabilityDirectionPropertyEnumMap = {
  LiabilityDirectionProperty.credit: 'credit',
  LiabilityDirectionProperty.debit: 'debit',
  LiabilityDirectionProperty.valueNull: 'null',
  LiabilityDirectionProperty.$unknown: r'$unknown',
};

const _$InterestPeriodPropertyEnumMap = {
  InterestPeriodProperty.weekly: 'weekly',
  InterestPeriodProperty.monthly: 'monthly',
  InterestPeriodProperty.quarterly: 'quarterly',
  InterestPeriodProperty.halfYear: 'half-year',
  InterestPeriodProperty.yearly: 'yearly',
  InterestPeriodProperty.valueNull: 'null',
  InterestPeriodProperty.$unknown: r'$unknown',
};
