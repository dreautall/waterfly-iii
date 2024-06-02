// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_total_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsightTotalEntry _$InsightTotalEntryFromJson(Map<String, dynamic> json) =>
    InsightTotalEntry(
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightTotalEntryToJson(InsightTotalEntry instance) =>
    <String, dynamic>{
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };
