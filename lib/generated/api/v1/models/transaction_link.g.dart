// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLink _$TransactionLinkFromJson(Map<String, dynamic> json) =>
    TransactionLink(
      linkTypeId: json['link_type_id'] as String,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      linkTypeName: json['link_type_name'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkToJson(TransactionLink instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'link_type_id': instance.linkTypeId,
      'link_type_name': instance.linkTypeName,
      'inward_id': instance.inwardId,
      'outward_id': instance.outwardId,
      'notes': instance.notes,
    };
