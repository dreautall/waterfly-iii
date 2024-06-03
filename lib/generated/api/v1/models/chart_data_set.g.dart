// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataSet _$ChartDataSetFromJson(Map<String, dynamic> json) => ChartDataSet(
      label: json['label'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      type: json['type'] as String?,
      yAxisID: (json['yAxisID'] as num?)?.toInt(),
      entries: json['entries'],
    );

Map<String, dynamic> _$ChartDataSetToJson(ChartDataSet instance) =>
    <String, dynamic>{
      'label': instance.label,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'type': instance.type,
      'yAxisID': instance.yAxisID,
      'entries': instance.entries,
    };
