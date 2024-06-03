// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_summary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicSummaryEntry _$BasicSummaryEntryFromJson(Map<String, dynamic> json) =>
    BasicSummaryEntry(
      key: json['key'] as String?,
      title: json['title'] as String?,
      monetaryValue: (json['monetary_value'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      valueParsed: json['value_parsed'] as String?,
      localIcon: json['local_icon'] as String?,
      subTitle: json['sub_title'] as String?,
    );

Map<String, dynamic> _$BasicSummaryEntryToJson(BasicSummaryEntry instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'monetary_value': instance.monetaryValue,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'value_parsed': instance.valueParsed,
      'local_icon': instance.localIcon,
      'sub_title': instance.subTitle,
    };
