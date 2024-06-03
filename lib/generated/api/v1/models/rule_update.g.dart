// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleUpdate _$RuleUpdateFromJson(Map<String, dynamic> json) => RuleUpdate(
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
      title: json['title'] as String?,
      description: json['description'] as String?,
      ruleGroupId: json['rule_group_id'] as String?,
      order: (json['order'] as num?)?.toInt(),
      trigger: json['trigger'] == null
          ? null
          : RuleTriggerType.fromJson(json['trigger'] as String),
      strict: json['strict'] as bool?,
      triggers: (json['triggers'] as List<dynamic>?)
          ?.map((e) => RuleTriggerUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => RuleActionUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RuleUpdateToJson(RuleUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'rule_group_id': instance.ruleGroupId,
      'order': instance.order,
      'trigger': _$RuleTriggerTypeEnumMap[instance.trigger],
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
