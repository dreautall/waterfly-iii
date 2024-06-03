// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_group_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectGroupUpdate _$ObjectGroupUpdateFromJson(Map<String, dynamic> json) =>
    ObjectGroupUpdate(
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ObjectGroupUpdateToJson(ObjectGroupUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'order': instance.order,
    };
