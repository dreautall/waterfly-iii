// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_type_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTypeRead _$LinkTypeReadFromJson(Map<String, dynamic> json) => LinkTypeRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: LinkType.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$LinkTypeReadToJson(LinkTypeRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
