// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_action_keyword.dart';

part 'rule_action_store.g.dart';

@JsonSerializable()
class RuleActionStore {
  const RuleActionStore({
    required this.type,
    required this.value,
    required this.order,
    this.active = true,
    this.stopProcessing = false,
  });

  factory RuleActionStore.fromJson(Map<String, Object?> json) =>
      _$RuleActionStoreFromJson(json);

  final RuleActionKeyword type;

  /// The accompanying value the action will set, change or update. Can be empty, but for some types this value is mandatory.
  final String? value;

  /// Order of the action
  final int order;

  /// If the action is active. Defaults to true.
  final bool active;

  /// When true, other actions will not be fired after this action has fired. Defaults to false.
  @JsonKey(name: 'stop_processing')
  final bool stopProcessing;

  Map<String, Object?> toJson() => _$RuleActionStoreToJson(this);
}
