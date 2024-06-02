// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRead _$TagReadFromJson(Map<String, dynamic> json) => TagRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: TagModel.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$TagReadToJson(TagRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
