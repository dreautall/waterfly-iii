// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_group_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsightGroupEntry _$InsightGroupEntryFromJson(Map<String, dynamic> json) =>
    InsightGroupEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightGroupEntryToJson(InsightGroupEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };
