// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'rule_group_read.dart';

part 'rule_group_array.g.dart';

@JsonSerializable()
class RuleGroupArray {
  const RuleGroupArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory RuleGroupArray.fromJson(Map<String, Object?> json) =>
      _$RuleGroupArrayFromJson(json);

  final List<RuleGroupRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$RuleGroupArrayToJson(this);
}
