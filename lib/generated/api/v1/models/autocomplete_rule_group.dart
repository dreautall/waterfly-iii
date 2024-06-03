// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_rule_group.g.dart';

@JsonSerializable()
class AutocompleteRuleGroup {
  const AutocompleteRuleGroup({
    required this.id,
    required this.name,
    this.description,
  });

  factory AutocompleteRuleGroup.fromJson(Map<String, Object?> json) =>
      _$AutocompleteRuleGroupFromJson(json);

  final String id;

  /// Name of the rule group found by an auto-complete search.
  final String name;

  /// Description of the rule group found by auto-complete.
  final String? description;

  Map<String, Object?> toJson() => _$AutocompleteRuleGroupToJson(this);
}
