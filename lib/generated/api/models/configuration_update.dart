// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'polymorphic_property.dart';

part 'configuration_update.g.dart';

@JsonSerializable()
class ConfigurationUpdate {
  const ConfigurationUpdate({
    required this.value,
  });
  
  factory ConfigurationUpdate.fromJson(Map<String, Object?> json) => _$ConfigurationUpdateFromJson(json);
  
  final PolymorphicProperty value;

  Map<String, Object?> toJson() => _$ConfigurationUpdateToJson(this);
}
