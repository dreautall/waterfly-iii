// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_piggy_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompletePiggyBalance _$AutocompletePiggyBalanceFromJson(
        Map<String, dynamic> json) =>
    AutocompletePiggyBalance(
      id: json['id'] as String,
      name: json['name'] as String,
      nameWithBalance: json['name_with_balance'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$AutocompletePiggyBalanceToJson(
        AutocompletePiggyBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_with_balance': instance.nameWithBalance,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'object_group_id': instance.objectGroupId,
      'object_group_title': instance.objectGroupTitle,
    };
