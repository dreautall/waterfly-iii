// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'rule_read.dart';

part 'rule_single.g.dart';

@JsonSerializable()
class RuleSingle {
  const RuleSingle({
    required this.data,
  });

  factory RuleSingle.fromJson(Map<String, Object?> json) =>
      _$RuleSingleFromJson(json);

  final RuleRead data;

  Map<String, Object?> toJson() => _$RuleSingleToJson(this);
}
