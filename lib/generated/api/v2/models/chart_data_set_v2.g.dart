// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_set_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataSetV2 _$ChartDataSetV2FromJson(Map<String, dynamic> json) =>
    ChartDataSetV2(
      label: json['label'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      period: json['period'] == null
          ? null
          : ChartV2PeriodProperty.fromJson(json['period'] as String),
      entries: json['entries'],
      nativeEntries: json['native_entries'],
    );

Map<String, dynamic> _$ChartDataSetV2ToJson(ChartDataSetV2 instance) =>
    <String, dynamic>{
      'label': instance.label,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'period': _$ChartV2PeriodPropertyEnumMap[instance.period],
      'entries': instance.entries,
      'native_entries': instance.nativeEntries,
    };

const _$ChartV2PeriodPropertyEnumMap = {
  ChartV2PeriodProperty.value1D: '1D',
  ChartV2PeriodProperty.value1W: '1W',
  ChartV2PeriodProperty.value1M: '1M',
  ChartV2PeriodProperty.value3M: '3M',
  ChartV2PeriodProperty.value6M: '6M',
  ChartV2PeriodProperty.value1Y: '1Y',
  ChartV2PeriodProperty.$unknown: r'$unknown',
};
