// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_recurrence.g.dart';

@JsonSerializable()
class AutocompleteRecurrence {
  const AutocompleteRecurrence({
    required this.id,
    required this.name,
    required this.description,
  });
  
  factory AutocompleteRecurrence.fromJson(Map<String, Object?> json) => _$AutocompleteRecurrenceFromJson(json);
  
  final String id;

  /// Name of the recurrence found by an auto-complete search.
  final String name;

  /// Description of the recurrence found by auto-complete.
  final String description;

  Map<String, Object?> toJson() => _$AutocompleteRecurrenceToJson(this);
}
