// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_group_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectGroupArray _$ObjectGroupArrayFromJson(Map<String, dynamic> json) =>
    ObjectGroupArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => ObjectGroupRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectGroupArrayToJson(ObjectGroupArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
