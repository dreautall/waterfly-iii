// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentRead _$AttachmentReadFromJson(Map<String, dynamic> json) =>
    AttachmentRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Attachment.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$AttachmentReadToJson(AttachmentRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
