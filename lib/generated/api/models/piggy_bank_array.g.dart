// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankArray _$PiggyBankArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => PiggyBankRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankArrayToJson(PiggyBankArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
