// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountUpdate _$AccountUpdateFromJson(Map<String, dynamic> json) =>
    AccountUpdate(
      name: json['name'] as String,
      active: json['active'] as bool? ?? true,
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String?,
      openingBalanceDate: json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      order: (json['order'] as num?)?.toInt(),
      accountRole: json['account_role'] == null
          ? null
          : AccountRoleProperty.fromJson(json['account_role'] as String),
      creditCardType: json['credit_card_type'] == null
          ? null
          : CreditCardTypeProperty.fromJson(json['credit_card_type'] as String),
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: json['liability_type'] == null
          ? null
          : LiabilityTypeProperty.fromJson(json['liability_type'] as String),
      interest: json['interest'] as String?,
      interestPeriod: json['interest_period'] == null
          ? null
          : InterestPeriodProperty.fromJson(json['interest_period'] as String),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountUpdateToJson(AccountUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iban': instance.iban,
      'bic': instance.bic,
      'account_number': instance.accountNumber,
      'opening_balance': instance.openingBalance,
      'opening_balance_date': instance.openingBalanceDate?.toIso8601String(),
      'virtual_balance': instance.virtualBalance,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'active': instance.active,
      'order': instance.order,
      'include_net_worth': instance.includeNetWorth,
      'account_role': _$AccountRolePropertyEnumMap[instance.accountRole],
      'credit_card_type':
          _$CreditCardTypePropertyEnumMap[instance.creditCardType],
      'monthly_payment_date': instance.monthlyPaymentDate?.toIso8601String(),
      'liability_type': _$LiabilityTypePropertyEnumMap[instance.liabilityType],
      'interest': instance.interest,
      'interest_period':
          _$InterestPeriodPropertyEnumMap[instance.interestPeriod],
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zoom_level': instance.zoomLevel,
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

const _$InterestPeriodPropertyEnumMap = {
  InterestPeriodProperty.weekly: 'weekly',
  InterestPeriodProperty.monthly: 'monthly',
  InterestPeriodProperty.quarterly: 'quarterly',
  InterestPeriodProperty.halfYear: 'half-year',
  InterestPeriodProperty.yearly: 'yearly',
  InterestPeriodProperty.valueNull: 'null',
  InterestPeriodProperty.$unknown: r'$unknown',
};
