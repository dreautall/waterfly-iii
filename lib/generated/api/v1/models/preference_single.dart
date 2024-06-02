// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'preference_read.dart';

part 'preference_single.g.dart';

@JsonSerializable()
class PreferenceSingle {
  const PreferenceSingle({
    required this.data,
  });
  
  factory PreferenceSingle.fromJson(Map<String, Object?> json) => _$PreferenceSingleFromJson(json);
  
  final PreferenceRead data;

  Map<String, Object?> toJson() => _$PreferenceSingleToJson(this);
}
