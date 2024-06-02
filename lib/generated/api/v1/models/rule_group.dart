// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'rule_group.g.dart';

@JsonSerializable()
class RuleGroup {
  const RuleGroup({
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.order,
    required this.active,
  });
  
  factory RuleGroup.fromJson(Map<String, Object?> json) => _$RuleGroupFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String title;
  final String? description;
  final int order;
  final bool active;

  Map<String, Object?> toJson() => _$RuleGroupToJson(this);
}
