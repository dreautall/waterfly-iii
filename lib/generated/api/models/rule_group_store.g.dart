// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_group_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleGroupStore _$RuleGroupStoreFromJson(Map<String, dynamic> json) =>
    RuleGroupStore(
      title: json['title'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num).toInt(),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$RuleGroupStoreToJson(RuleGroupStore instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'active': instance.active,
    };
