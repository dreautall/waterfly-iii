// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceArray _$PreferenceArrayFromJson(Map<String, dynamic> json) =>
    PreferenceArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => PreferenceRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceArrayToJson(PreferenceArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
