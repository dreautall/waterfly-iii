// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object_group_update.g.dart';

@JsonSerializable()
class ObjectGroupUpdate {
  const ObjectGroupUpdate({
    required this.title,
    this.order,
  });

  factory ObjectGroupUpdate.fromJson(Map<String, Object?> json) =>
      _$ObjectGroupUpdateFromJson(json);

  final String title;

  /// Order of the object group
  final int? order;

  Map<String, Object?> toJson() => _$ObjectGroupUpdateToJson(this);
}
