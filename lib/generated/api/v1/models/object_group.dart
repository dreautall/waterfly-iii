// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object_group.g.dart';

@JsonSerializable()
class ObjectGroup {
  const ObjectGroup({
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.order,
  });

  factory ObjectGroup.fromJson(Map<String, Object?> json) =>
      _$ObjectGroupFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String title;

  /// Order of the object group
  final int order;

  Map<String, Object?> toJson() => _$ObjectGroupToJson(this);
}
