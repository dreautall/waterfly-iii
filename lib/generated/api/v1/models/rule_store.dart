// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_action_store.dart';
import 'rule_trigger_store.dart';
import 'rule_trigger_type.dart';

part 'rule_store.g.dart';

@JsonSerializable()
class RuleStore {
  const RuleStore({
    required this.title,
    required this.description,
    required this.ruleGroupId,
    required this.ruleGroupTitle,
    required this.order,
    required this.trigger,
    required this.stopProcessing,
    required this.triggers,
    required this.actions,
    this.active = true,
    this.strict = true,
  });
  
  factory RuleStore.fromJson(Map<String, Object?> json) => _$RuleStoreFromJson(json);
  
  final String title;
  final String description;

  /// ID of the rule group under which the rule must be stored. Either this field or rule_group_title is mandatory.
  @JsonKey(name: 'rule_group_id')
  final String ruleGroupId;

  /// Title of the rule group under which the rule must be stored. Either this field or rule_group_id is mandatory.
  @JsonKey(name: 'rule_group_title')
  final String ruleGroupTitle;
  final int order;
  final RuleTriggerType trigger;

  /// Whether or not the rule is even active. Default is true.
  final bool active;

  /// If the rule is set to be strict, ALL triggers must hit in order for the rule to fire. Otherwise, just one is enough. Default value is true.
  final bool strict;

  /// If this value is true and the rule is triggered, other rules  after this one in the group will be skipped. Default value is false.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;
  final List<RuleTriggerStore> triggers;
  final List<RuleActionStore> actions;

  Map<String, Object?> toJson() => _$RuleStoreToJson(this);
}
