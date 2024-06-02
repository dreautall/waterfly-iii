// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyArray _$CurrencyArrayFromJson(Map<String, dynamic> json) =>
    CurrencyArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => CurrencyRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyArrayToJson(CurrencyArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
