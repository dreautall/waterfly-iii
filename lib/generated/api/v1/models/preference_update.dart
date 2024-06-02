// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'polymorphic_property.dart';

part 'preference_update.g.dart';

@JsonSerializable()
class PreferenceUpdate {
  const PreferenceUpdate({
    required this.data,
  });
  
  factory PreferenceUpdate.fromJson(Map<String, Object?> json) => _$PreferenceUpdateFromJson(json);
  
  final PolymorphicProperty data;

  Map<String, Object?> toJson() => _$PreferenceUpdateToJson(this);
}
