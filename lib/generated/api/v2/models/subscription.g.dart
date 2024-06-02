// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      nativeAmountMin: json['native_amount_min'] as String,
      nativeAmountMax: json['native_amount_max'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      nativeCurrencyId: json['native_currency_id'] as String,
      nativeCurrencyCode: json['native_currency_code'] as String,
      nativeCurrencySymbol: json['native_currency_symbol'] as String,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      extensionDate: json['extension_date'] == null
          ? null
          : DateTime.parse(json['extension_date'] as String),
      repeatFreq:
          SubscriptionRepeatProperty.fromJson(json['repeat_freq'] as String),
      skip: (json['skip'] as num).toInt(),
      active: json['active'] as bool,
      order: (json['order'] as num).toInt(),
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      nextExpectedMatch: json['next_expected_match'] == null
          ? null
          : DateTime.parse(json['next_expected_match'] as String),
      nextExpectedMatchDiff: json['next_expected_match_diff'] as String?,
      payDates: (json['pay_dates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      paidDates: (json['paid_dates'] as List<dynamic>)
          .map((e) => PaidDates.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'amount_min': instance.amountMin,
      'amount_max': instance.amountMax,
      'native_amount_min': instance.nativeAmountMin,
      'native_amount_max': instance.nativeAmountMax,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'date': instance.date.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'extension_date': instance.extensionDate?.toIso8601String(),
      'repeat_freq': _$SubscriptionRepeatPropertyEnumMap[instance.repeatFreq]!,
      'skip': instance.skip,
      'active': instance.active,
      'order': instance.order,
      'notes': instance.notes,
      'object_group_id': instance.objectGroupId,
      'object_group_order': instance.objectGroupOrder,
      'object_group_title': instance.objectGroupTitle,
      'next_expected_match': instance.nextExpectedMatch?.toIso8601String(),
      'next_expected_match_diff': instance.nextExpectedMatchDiff,
      'pay_dates': instance.payDates.map((e) => e.toIso8601String()).toList(),
      'paid_dates': instance.paidDates,
    };

const _$SubscriptionRepeatPropertyEnumMap = {
  SubscriptionRepeatProperty.weekly: 'weekly',
  SubscriptionRepeatProperty.monthly: 'monthly',
  SubscriptionRepeatProperty.quarterly: 'quarterly',
  SubscriptionRepeatProperty.halfYear: 'half-year',
  SubscriptionRepeatProperty.yearly: 'yearly',
  SubscriptionRepeatProperty.$unknown: r'$unknown',
};
