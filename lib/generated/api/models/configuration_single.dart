// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'configuration.dart';

part 'configuration_single.g.dart';

@JsonSerializable()
class ConfigurationSingle {
  const ConfigurationSingle({
    required this.data,
  });
  
  factory ConfigurationSingle.fromJson(Map<String, Object?> json) => _$ConfigurationSingleFromJson(json);
  
  final Configuration data;

  Map<String, Object?> toJson() => _$ConfigurationSingleToJson(this);
}
