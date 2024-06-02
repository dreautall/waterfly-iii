// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_group_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectGroupRead _$ObjectGroupReadFromJson(Map<String, dynamic> json) =>
    ObjectGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          ObjectGroup.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectGroupReadToJson(ObjectGroupRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
