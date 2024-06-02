// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserArray _$UserArrayFromJson(Map<String, dynamic> json) => UserArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserArrayToJson(UserArray instance) => <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
