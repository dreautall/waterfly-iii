// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyStore _$CurrencyStoreFromJson(Map<String, dynamic> json) =>
    CurrencyStore(
      defaultValue: json['default'] as bool,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num).toInt(),
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$CurrencyStoreToJson(CurrencyStore instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'default': instance.defaultValue,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };
