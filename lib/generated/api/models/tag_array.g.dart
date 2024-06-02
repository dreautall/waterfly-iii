// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagArray _$TagArrayFromJson(Map<String, dynamic> json) => TagArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => TagRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagArrayToJson(TagArray instance) => <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
