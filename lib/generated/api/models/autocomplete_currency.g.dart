// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteCurrency _$AutocompleteCurrencyFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCurrency(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$AutocompleteCurrencyToJson(
        AutocompleteCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };
