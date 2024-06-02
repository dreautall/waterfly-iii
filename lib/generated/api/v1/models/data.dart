// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  const Data({
    required this.version,
    required this.apiVersion,
    required this.phpVersion,
    required this.os,
    required this.driver,
  });
  
  factory Data.fromJson(Map<String, Object?> json) => _$DataFromJson(json);
  
  final String version;
  @JsonKey(name: 'api_version')
  final String apiVersion;
  @JsonKey(name: 'php_version')
  final String phpVersion;
  final String os;
  final String driver;

  Map<String, Object?> toJson() => _$DataToJson(this);
}
