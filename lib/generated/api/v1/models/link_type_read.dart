// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'link_type.dart';
import 'object_link.dart';

part 'link_type_read.g.dart';

@JsonSerializable()
class LinkTypeRead {
  const LinkTypeRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory LinkTypeRead.fromJson(Map<String, Object?> json) =>
      _$LinkTypeReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final LinkType attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$LinkTypeReadToJson(this);
}
