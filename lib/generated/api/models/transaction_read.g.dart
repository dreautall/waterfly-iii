// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRead _$TransactionReadFromJson(Map<String, dynamic> json) =>
    TransactionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Transaction.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$TransactionReadToJson(TransactionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
