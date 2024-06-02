// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_link_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLinkStore _$TransactionLinkStoreFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkStore(
      linkTypeId: json['link_type_id'] as String,
      linkTypeName: json['link_type_name'] as String,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkStoreToJson(
        TransactionLinkStore instance) =>
    <String, dynamic>{
      'link_type_id': instance.linkTypeId,
      'link_type_name': instance.linkTypeName,
      'inward_id': instance.inwardId,
      'outward_id': instance.outwardId,
      'notes': instance.notes,
    };
