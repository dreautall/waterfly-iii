// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_v2_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyV2Array _$CurrencyV2ArrayFromJson(Map<String, dynamic> json) =>
    CurrencyV2Array(
      data: (json['data'] as List<dynamic>)
          .map((e) => CurrencyV2Read.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyV2ArrayToJson(CurrencyV2Array instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
