// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillRead _$BillReadFromJson(Map<String, dynamic> json) => BillRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Bill.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillReadToJson(BillRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
