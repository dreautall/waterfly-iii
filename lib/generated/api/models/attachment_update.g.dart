// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentUpdate _$AttachmentUpdateFromJson(Map<String, dynamic> json) =>
    AttachmentUpdate(
      filename: json['filename'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentUpdateToJson(AttachmentUpdate instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'title': instance.title,
      'notes': instance.notes,
    };
