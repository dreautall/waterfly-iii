// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'rule_group.g.dart';

@JsonSerializable()
class RuleGroup {
  const RuleGroup({
    required this.title,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.order,
    this.active,
  });

  factory RuleGroup.fromJson(Map<String, Object?> json) =>
      _$RuleGroupFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final String title;
  final String? description;
  final int? order;
  final bool? active;

  Map<String, Object?> toJson() => _$RuleGroupToJson(this);
}
