// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_event_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankEventArray _$PiggyBankEventArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankEventArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => PiggyBankEventRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankEventArrayToJson(
        PiggyBankEventArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
