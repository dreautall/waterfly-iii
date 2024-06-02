// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceRead _$PreferenceReadFromJson(Map<String, dynamic> json) =>
    PreferenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Preference.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceReadToJson(PreferenceRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
