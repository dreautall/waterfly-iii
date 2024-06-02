// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_action_keyword.dart';

part 'rule_action_update.g.dart';

@JsonSerializable()
class RuleActionUpdate {
  const RuleActionUpdate({
    required this.type,
    required this.value,
    required this.order,
    required this.active,
    required this.stopProcessing,
  });
  
  factory RuleActionUpdate.fromJson(Map<String, Object?> json) => _$RuleActionUpdateFromJson(json);
  
  final RuleActionKeyword type;

  /// The accompanying value the action will set, change or update. Can be empty, but for some types this value is mandatory.
  final String? value;

  /// Order of the action
  final int order;

  /// If the action is active.
  final bool active;

  /// When true, other actions will not be fired after this action has fired.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;

  Map<String, Object?> toJson() => _$RuleActionUpdateToJson(this);
}
