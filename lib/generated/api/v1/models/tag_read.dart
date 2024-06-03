// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'tag_model.dart';

part 'tag_read.g.dart';

@JsonSerializable()
class TagRead {
  const TagRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory TagRead.fromJson(Map<String, Object?> json) =>
      _$TagReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final TagModel attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$TagReadToJson(this);
}
