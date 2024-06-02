// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_transfer_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsightTransferEntry _$InsightTransferEntryFromJson(
        Map<String, dynamic> json) =>
    InsightTransferEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      inValue: json['in'] as String,
      inFloat: (json['in_float'] as num).toDouble(),
      out: json['out'] as String,
      outFloat: (json['out_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightTransferEntryToJson(
        InsightTransferEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'in': instance.inValue,
      'in_float': instance.inFloat,
      'out': instance.out,
      'out_float': instance.outFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };
