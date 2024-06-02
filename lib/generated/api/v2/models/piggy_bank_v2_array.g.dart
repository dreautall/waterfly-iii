// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_v2_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankV2Array _$PiggyBankV2ArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankV2Array(
      data: (json['data'] as List<dynamic>)
          .map((e) => PiggyBankV2Read.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankV2ArrayToJson(PiggyBankV2Array instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
