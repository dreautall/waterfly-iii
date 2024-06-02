// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2Read _$TransactionV2ReadFromJson(Map<String, dynamic> json) =>
    TransactionV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          TransactionV2.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$TransactionV2ReadToJson(TransactionV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
