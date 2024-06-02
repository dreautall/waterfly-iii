// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyUpdate _$CurrencyUpdateFromJson(Map<String, dynamic> json) =>
    CurrencyUpdate(
      enabled: json['enabled'] as bool,
      defaultEnum: CurrencyUpdateDefaultEnum.fromJson(json['default'] as bool),
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$CurrencyUpdateToJson(CurrencyUpdate instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'default': _$CurrencyUpdateDefaultEnumEnumMap[instance.defaultEnum]!,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

const _$CurrencyUpdateDefaultEnumEnumMap = {
  CurrencyUpdateDefaultEnum.valueTrue: 'true',
  CurrencyUpdateDefaultEnum.$unknown: r'$unknown',
};
