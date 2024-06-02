// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryArray _$CategoryArrayFromJson(Map<String, dynamic> json) =>
    CategoryArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryArrayToJson(CategoryArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
