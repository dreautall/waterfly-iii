// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_v2_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountV2Read _$AccountV2ReadFromJson(Map<String, dynamic> json) =>
    AccountV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          AccountV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountV2ReadToJson(AccountV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
