// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRead _$CategoryReadFromJson(Map<String, dynamic> json) => CategoryRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Category.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryReadToJson(CategoryRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
