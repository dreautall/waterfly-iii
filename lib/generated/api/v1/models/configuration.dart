// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'config_value_filter.dart';
import 'polymorphic_property.dart';

part 'configuration.g.dart';

@JsonSerializable()
class Configuration {
  const Configuration({
    required this.title,
    required this.value,
    required this.editable,
  });
  
  factory Configuration.fromJson(Map<String, Object?> json) => _$ConfigurationFromJson(json);
  
  final ConfigValueFilter title;
  final PolymorphicProperty value;

  /// If this config variable can be edited by the user
  final bool editable;

  Map<String, Object?> toJson() => _$ConfigurationToJson(this);
}
