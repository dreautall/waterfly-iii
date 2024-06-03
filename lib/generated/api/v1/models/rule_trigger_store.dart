// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_trigger_keyword.dart';

part 'rule_trigger_store.g.dart';

@JsonSerializable()
class RuleTriggerStore {
  const RuleTriggerStore({
    required this.type,
    required this.value,
    this.active = true,
    this.prohibited = false,
    this.stopProcessing = false,
    this.order,
  });

  factory RuleTriggerStore.fromJson(Map<String, Object?> json) =>
      _$RuleTriggerStoreFromJson(json);

  final RuleTriggerKeyword type;

  /// The accompanying value the trigger responds to. This value is often mandatory, but this depends on the trigger.
  final String value;

  /// Order of the trigger
  final int? order;

  /// If the trigger is active. Defaults to true.
  final bool active;

  /// If 'prohibited' is true, this rule trigger will be negated. 'Description is' will become 'Description is NOT' etc.
  final bool prohibited;

  /// When true, other triggers will not be checked if this trigger was triggered. Defaults to false.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;

  Map<String, Object?> toJson() => _$RuleTriggerStoreToJson(this);
}
