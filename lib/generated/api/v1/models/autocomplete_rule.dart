// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_rule.g.dart';

@JsonSerializable()
class AutocompleteRule {
  const AutocompleteRule({
    required this.id,
    required this.name,
    this.description,
  });

  factory AutocompleteRule.fromJson(Map<String, Object?> json) =>
      _$AutocompleteRuleFromJson(json);

  final String id;

  /// Name of the rule found by an auto-complete search.
  final String name;

  /// Description of the rule found by auto-complete.
  final String? description;

  Map<String, Object?> toJson() => _$AutocompleteRuleToJson(this);
}
