// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_summary_v2_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicSummaryV2Entry _$BasicSummaryV2EntryFromJson(Map<String, dynamic> json) =>
    BasicSummaryV2Entry(
      key: json['key'] as String,
      value: (json['value'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$BasicSummaryV2EntryToJson(
        BasicSummaryV2Entry instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
    };
