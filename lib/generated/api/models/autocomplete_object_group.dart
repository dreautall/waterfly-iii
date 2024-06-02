// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_object_group.g.dart';

@JsonSerializable()
class AutocompleteObjectGroup {
  const AutocompleteObjectGroup({
    required this.id,
    required this.title,
    required this.name,
  });
  
  factory AutocompleteObjectGroup.fromJson(Map<String, Object?> json) => _$AutocompleteObjectGroupFromJson(json);
  
  final String id;

  /// Title of the object group found by an auto-complete search.
  final String title;

  /// Title of the object group found by an auto-complete search.
  final String name;

  Map<String, Object?> toJson() => _$AutocompleteObjectGroupToJson(this);
}
