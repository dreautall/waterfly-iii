// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionArray _$TransactionArrayFromJson(Map<String, dynamic> json) =>
    TransactionArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionArrayToJson(TransactionArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
