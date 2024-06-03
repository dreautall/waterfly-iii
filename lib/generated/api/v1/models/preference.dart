// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'polymorphic_property.dart';

part 'preference.g.dart';

@JsonSerializable()
class Preference {
  const Preference({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.data,
  });

  factory Preference.fromJson(Map<String, Object?> json) =>
      _$PreferenceFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String name;
  final PolymorphicProperty data;

  Map<String, Object?> toJson() => _$PreferenceToJson(this);
}
