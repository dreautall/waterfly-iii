// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteAccount _$AutocompleteAccountFromJson(Map<String, dynamic> json) =>
    AutocompleteAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      nameWithBalance: json['name_with_balance'] as String,
      type: json['type'] as String,
      currencyId: json['currency_id'] as String,
      currencyName: json['currency_name'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$AutocompleteAccountToJson(
        AutocompleteAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_with_balance': instance.nameWithBalance,
      'type': instance.type,
      'currency_id': instance.currencyId,
      'currency_name': instance.currencyName,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
    };
