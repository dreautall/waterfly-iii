// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'rule_group_store.g.dart';

@JsonSerializable()
class RuleGroupStore {
  const RuleGroupStore({
    required this.title,
    this.description,
    this.order,
    this.active,
  });

  factory RuleGroupStore.fromJson(Map<String, Object?> json) =>
      _$RuleGroupStoreFromJson(json);

  final String title;
  final String? description;
  final int? order;
  final bool? active;

  Map<String, Object?> toJson() => _$RuleGroupStoreToJson(this);
}
