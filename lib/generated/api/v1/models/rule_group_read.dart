// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'rule_group.dart';

part 'rule_group_read.g.dart';

@JsonSerializable()
class RuleGroupRead {
  const RuleGroupRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RuleGroupRead.fromJson(Map<String, Object?> json) =>
      _$RuleGroupReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final RuleGroup attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$RuleGroupReadToJson(this);
}
