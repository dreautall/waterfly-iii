// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentArray _$AttachmentArrayFromJson(Map<String, dynamic> json) =>
    AttachmentArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => AttachmentRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttachmentArrayToJson(AttachmentArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
