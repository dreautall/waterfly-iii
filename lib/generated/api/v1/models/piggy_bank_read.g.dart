// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankRead _$PiggyBankReadFromJson(Map<String, dynamic> json) =>
    PiggyBankRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBank.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$PiggyBankReadToJson(PiggyBankRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
