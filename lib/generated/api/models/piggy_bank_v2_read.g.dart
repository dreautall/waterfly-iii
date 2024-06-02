// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_v2_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankV2Read _$PiggyBankV2ReadFromJson(Map<String, dynamic> json) =>
    PiggyBankV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBankV2.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$PiggyBankV2ReadToJson(PiggyBankV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
