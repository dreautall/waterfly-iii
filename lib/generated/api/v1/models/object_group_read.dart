// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_group.dart';

part 'object_group_read.g.dart';

@JsonSerializable()
class ObjectGroupRead {
  const ObjectGroupRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory ObjectGroupRead.fromJson(Map<String, Object?> json) =>
      _$ObjectGroupReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final ObjectGroup attributes;

  Map<String, Object?> toJson() => _$ObjectGroupReadToJson(this);
}
