// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'system_info.g.dart';

@JsonSerializable()
class SystemInfo {
  const SystemInfo({
    required this.data,
  });

  factory SystemInfo.fromJson(Map<String, Object?> json) =>
      _$SystemInfoFromJson(json);

  final Data data;

  Map<String, Object?> toJson() => _$SystemInfoToJson(this);
}
