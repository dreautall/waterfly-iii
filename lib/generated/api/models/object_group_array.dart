// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'object_group_read.dart';

part 'object_group_array.g.dart';

@JsonSerializable()
class ObjectGroupArray {
  const ObjectGroupArray({
    required this.data,
    required this.meta,
  });
  
  factory ObjectGroupArray.fromJson(Map<String, Object?> json) => _$ObjectGroupArrayFromJson(json);
  
  final List<ObjectGroupRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$ObjectGroupArrayToJson(this);
}
