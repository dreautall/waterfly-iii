// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_group_read.dart';

part 'rule_group_single.g.dart';

@JsonSerializable()
class RuleGroupSingle {
  const RuleGroupSingle({
    required this.data,
  });

  factory RuleGroupSingle.fromJson(Map<String, Object?> json) =>
      _$RuleGroupSingleFromJson(json);

  final RuleGroupRead data;

  Map<String, Object?> toJson() => _$RuleGroupSingleToJson(this);
}
