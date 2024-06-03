// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyV2 _$CurrencyV2FromJson(Map<String, dynamic> json) => CurrencyV2(
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      defaultValue: json['default'] as bool?,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyV2ToJson(CurrencyV2 instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'enabled': instance.enabled,
      'default': instance.defaultValue,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };
