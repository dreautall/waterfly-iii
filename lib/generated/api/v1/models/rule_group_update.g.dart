// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_group_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleGroupUpdate _$RuleGroupUpdateFromJson(Map<String, dynamic> json) =>
    RuleGroupUpdate(
      title: json['title'] as String?,
      description: json['description'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$RuleGroupUpdateToJson(RuleGroupUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'active': instance.active,
    };
