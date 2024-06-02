// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_group_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleGroupArray _$RuleGroupArrayFromJson(Map<String, dynamic> json) =>
    RuleGroupArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => RuleGroupRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleGroupArrayToJson(RuleGroupArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
