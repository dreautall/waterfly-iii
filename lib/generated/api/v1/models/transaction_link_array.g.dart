// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_link_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLinkArray _$TransactionLinkArrayFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionLinkRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionLinkArrayToJson(
        TransactionLinkArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
