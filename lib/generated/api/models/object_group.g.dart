// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectGroup _$ObjectGroupFromJson(Map<String, dynamic> json) => ObjectGroup(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$ObjectGroupToJson(ObjectGroup instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'order': instance.order,
    };
