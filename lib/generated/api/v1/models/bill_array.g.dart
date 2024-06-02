// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillArray _$BillArrayFromJson(Map<String, dynamic> json) => BillArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => BillRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillArrayToJson(BillArray instance) => <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
