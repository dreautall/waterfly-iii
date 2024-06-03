// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'rule_group_update.g.dart';

@JsonSerializable()
class RuleGroupUpdate {
  const RuleGroupUpdate({
    required this.title,
    required this.description,
    required this.order,
    required this.active,
  });

  factory RuleGroupUpdate.fromJson(Map<String, Object?> json) =>
      _$RuleGroupUpdateFromJson(json);

  final String title;
  final String? description;
  final int order;
  final bool active;

  Map<String, Object?> toJson() => _$RuleGroupUpdateToJson(this);
}
