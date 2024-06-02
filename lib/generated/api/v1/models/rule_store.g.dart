// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleStore _$RuleStoreFromJson(Map<String, dynamic> json) => RuleStore(
      title: json['title'] as String,
      description: json['description'] as String,
      ruleGroupId: json['rule_group_id'] as String,
      ruleGroupTitle: json['rule_group_title'] as String,
      order: (json['order'] as num).toInt(),
      trigger: RuleTriggerType.fromJson(json['trigger'] as String),
      stopProcessing: json['stop_processing'] as bool,
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) => RuleTriggerStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => RuleActionStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool? ?? true,
      strict: json['strict'] as bool? ?? true,
    );

Map<String, dynamic> _$RuleStoreToJson(RuleStore instance) => <String, dynamic>{
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
