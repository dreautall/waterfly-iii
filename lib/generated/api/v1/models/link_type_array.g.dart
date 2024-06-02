// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_type_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTypeArray _$LinkTypeArrayFromJson(Map<String, dynamic> json) =>
    LinkTypeArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => LinkTypeRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkTypeArrayToJson(LinkTypeArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
