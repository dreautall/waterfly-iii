// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_tag.g.dart';

@JsonSerializable()
class AutocompleteTag {
  const AutocompleteTag({
    required this.id,
    required this.name,
    required this.tag,
  });

  factory AutocompleteTag.fromJson(Map<String, Object?> json) =>
      _$AutocompleteTagFromJson(json);

  final String id;

  /// Name of the tag found by an auto-complete search.
  final String name;

  /// Name of the tag found by an auto-complete search.
  final String tag;

  Map<String, Object?> toJson() => _$AutocompleteTagToJson(this);
}
