// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'preference.dart';

part 'preference_read.g.dart';

@JsonSerializable()
class PreferenceRead {
  const PreferenceRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory PreferenceRead.fromJson(Map<String, Object?> json) => _$PreferenceReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final Preference attributes;

  Map<String, Object?> toJson() => _$PreferenceReadToJson(this);
}
