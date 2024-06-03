// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_trigger_keyword.dart';

part 'rule_trigger.g.dart';

@JsonSerializable()
class RuleTrigger {
  const RuleTrigger({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.value,
    required this.order,
    this.prohibited = false,
    this.active = true,
    this.stopProcessing = false,
  });

  factory RuleTrigger.fromJson(Map<String, Object?> json) =>
      _$RuleTriggerFromJson(json);

  final String id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final RuleTriggerKeyword type;

  /// The accompanying value the trigger responds to. This value is often mandatory, but this depends on the trigger.
  final String value;

  /// If 'prohibited' is true, this rule trigger will be negated. 'Description is' will become 'Description is NOT' etc.
  final bool prohibited;

  /// Order of the trigger
  final int order;

  /// If the trigger is active. Defaults to true.
  final bool active;

  /// When true, other triggers will not be checked if this trigger was triggered. Defaults to false.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;

  Map<String, Object?> toJson() => _$RuleTriggerToJson(this);
}
