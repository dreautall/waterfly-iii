// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_group_read.dart';

part 'object_group_single.g.dart';

@JsonSerializable()
class ObjectGroupSingle {
  const ObjectGroupSingle({
    required this.data,
  });
  
  factory ObjectGroupSingle.fromJson(Map<String, Object?> json) => _$ObjectGroupSingleFromJson(json);
  
  final ObjectGroupRead data;

  Map<String, Object?> toJson() => _$ObjectGroupSingleToJson(this);
}
