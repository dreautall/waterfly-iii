// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_category.g.dart';

@JsonSerializable()
class AutocompleteCategory {
  const AutocompleteCategory({
    required this.id,
    required this.name,
  });

  factory AutocompleteCategory.fromJson(Map<String, Object?> json) =>
      _$AutocompleteCategoryFromJson(json);

  final String id;

  /// Name of the category found by an auto-complete search.
  final String name;

  Map<String, Object?> toJson() => _$AutocompleteCategoryToJson(this);
}
