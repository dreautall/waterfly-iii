// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_link_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLinkRead _$TransactionLinkReadFromJson(Map<String, dynamic> json) =>
    TransactionLinkRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          TransactionLink.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$TransactionLinkReadToJson(
        TransactionLinkRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
