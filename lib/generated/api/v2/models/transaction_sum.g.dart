// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_sum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSum _$TransactionSumFromJson(Map<String, dynamic> json) =>
    TransactionSum(
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyName: json['native_currency_name'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      sum: json['sum'] as String?,
      nativeSum: json['native_sum'] as String?,
    );

Map<String, dynamic> _$TransactionSumToJson(TransactionSum instance) =>
    <String, dynamic>{
      'currency_id': instance.currencyId,
      'currency_name': instance.currencyName,
      'currency_symbol': instance.currencySymbol,
      'currency_code': instance.currencyCode,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_name': instance.nativeCurrencyName,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'sum': instance.sum,
      'native_sum': instance.nativeSum,
    };
