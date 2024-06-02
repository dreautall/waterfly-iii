// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_piggy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompletePiggy _$AutocompletePiggyFromJson(Map<String, dynamic> json) =>
    AutocompletePiggy(
      id: json['id'] as String,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$AutocompletePiggyToJson(AutocompletePiggy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_name': instance.currencyName,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'object_group_id': instance.objectGroupId,
      'object_group_title': instance.objectGroupTitle,
    };
