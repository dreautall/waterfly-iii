// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2Array _$TransactionV2ArrayFromJson(Map<String, dynamic> json) =>
    TransactionV2Array(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionV2Read.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionV2ArrayToJson(TransactionV2Array instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
