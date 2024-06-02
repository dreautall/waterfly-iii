// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_event_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankEventRead _$PiggyBankEventReadFromJson(Map<String, dynamic> json) =>
    PiggyBankEventRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBankEvent.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$PiggyBankEventReadToJson(PiggyBankEventRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
