// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_action_update.dart';
import 'rule_trigger_type.dart';
import 'rule_trigger_update.dart';

part 'rule_update.g.dart';

@JsonSerializable()
class RuleUpdate {
  const RuleUpdate({
    this.active = true,
    this.stopProcessing = false,
    this.title,
    this.description,
    this.ruleGroupId,
    this.order,
    this.trigger,
    this.strict,
    this.triggers,
    this.actions,
  });

  factory RuleUpdate.fromJson(Map<String, Object?> json) =>
      _$RuleUpdateFromJson(json);

  final String? title;
  final String? description;

  /// ID of the rule group under which the rule must be stored. Either this field or rule_group_title is mandatory.
  @JsonKey(name: 'rule_group_id')
  final String? ruleGroupId;
  final int? order;
  final RuleTriggerType? trigger;

  /// Whether or not the rule is even active. Default is true.
  final bool active;

  /// If the rule is set to be strict, ALL triggers must hit in order for the rule to fire. Otherwise, just one is enough. Default value is true.
  final bool? strict;

  /// If this value is true and the rule is triggered, other rules  after this one in the group will be skipped. Default value is false.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;
  final List<RuleTriggerUpdate>? triggers;
  final List<RuleActionUpdate>? actions;

  Map<String, Object?> toJson() => _$RuleUpdateToJson(this);
}
