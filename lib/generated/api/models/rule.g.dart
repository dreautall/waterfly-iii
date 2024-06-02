// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      ruleGroupId: json['rule_group_id'] as String,
      ruleGroupTitle: json['rule_group_title'] as String,
      order: (json['order'] as num).toInt(),
      trigger: RuleTriggerType.fromJson(json['trigger'] as String),
      strict: json['strict'] as bool,
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) => RuleTrigger.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => RuleAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'rule_group_id': instance.ruleGroupId,
      'rule_group_title': instance.ruleGroupTitle,
      'order': instance.order,
      'trigger': _$RuleTriggerTypeEnumMap[instance.trigger]!,
      'active': instance.active,
      'strict': instance.strict,
      'stop_processing': instance.stopProcessing,
      'triggers': instance.triggers,
      'actions': instance.actions,
    };

const _$RuleTriggerTypeEnumMap = {
  RuleTriggerType.storeJournal: 'store-journal',
  RuleTriggerType.updateJournal: 'update-journal',
  RuleTriggerType.$unknown: r'$unknown',
};
