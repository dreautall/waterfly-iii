// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleArray _$RuleArrayFromJson(Map<String, dynamic> json) => RuleArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => RuleRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleArrayToJson(RuleArray instance) => <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
