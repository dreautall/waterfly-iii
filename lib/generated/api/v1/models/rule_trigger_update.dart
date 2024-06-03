// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_trigger_keyword.dart';

part 'rule_trigger_update.g.dart';

@JsonSerializable()
class RuleTriggerUpdate {
  const RuleTriggerUpdate({
    required this.type,
    required this.value,
    required this.order,
    required this.active,
    required this.stopProcessing,
  });

  factory RuleTriggerUpdate.fromJson(Map<String, Object?> json) =>
      _$RuleTriggerUpdateFromJson(json);

  final RuleTriggerKeyword type;

  /// The accompanying value the trigger responds to. This value is often mandatory, but this depends on the trigger. If the rule trigger is something like 'has any tag', submit the string 'true'.
  final String value;

  /// Order of the trigger
  final int order;

  /// If the trigger is active.
  final bool active;

  /// When true, other triggers will not be checked if this trigger was triggered.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;

  Map<String, Object?> toJson() => _$RuleTriggerUpdateToJson(this);
}
