// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_budget.g.dart';

@JsonSerializable()
class AutocompleteBudget {
  const AutocompleteBudget({
    required this.id,
    required this.name,
  });

  factory AutocompleteBudget.fromJson(Map<String, Object?> json) =>
      _$AutocompleteBudgetFromJson(json);

  final String id;

  /// Name of the budget found by an auto-complete search.
  final String name;

  Map<String, Object?> toJson() => _$AutocompleteBudgetToJson(this);
}
