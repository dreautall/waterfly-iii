// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_group_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleGroupRead _$RuleGroupReadFromJson(Map<String, dynamic> json) =>
    RuleGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          RuleGroup.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$RuleGroupReadToJson(RuleGroupRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
