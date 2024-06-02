// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRead _$UserReadFromJson(Map<String, dynamic> json) => UserRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: User.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$UserReadToJson(UserRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
