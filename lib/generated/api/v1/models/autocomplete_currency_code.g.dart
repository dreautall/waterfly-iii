// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_currency_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteCurrencyCode _$AutocompleteCurrencyCodeFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCurrencyCode(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$AutocompleteCurrencyCodeToJson(
        AutocompleteCurrencyCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };
