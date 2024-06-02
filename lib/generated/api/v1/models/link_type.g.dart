// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkType _$LinkTypeFromJson(Map<String, dynamic> json) => LinkType(
      name: json['name'] as String,
      inward: json['inward'] as String,
      outward: json['outward'] as String,
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$LinkTypeToJson(LinkType instance) => <String, dynamic>{
      'name': instance.name,
      'inward': instance.inward,
      'outward': instance.outward,
      'editable': instance.editable,
    };
