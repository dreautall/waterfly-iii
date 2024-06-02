// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRead _$AccountReadFromJson(Map<String, dynamic> json) => AccountRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Account.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountReadToJson(AccountRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
