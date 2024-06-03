// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'rule.dart';

part 'rule_read.g.dart';

@JsonSerializable()
class RuleRead {
  const RuleRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RuleRead.fromJson(Map<String, Object?> json) =>
      _$RuleReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Rule attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$RuleReadToJson(this);
}
