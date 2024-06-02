// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleRead _$RuleReadFromJson(Map<String, dynamic> json) => RuleRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Rule.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$RuleReadToJson(RuleRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
