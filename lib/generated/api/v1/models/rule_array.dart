// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'rule_read.dart';

part 'rule_array.g.dart';

@JsonSerializable()
class RuleArray {
  const RuleArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory RuleArray.fromJson(Map<String, Object?> json) =>
      _$RuleArrayFromJson(json);

  final List<RuleRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$RuleArrayToJson(this);
}
