// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'link_type.g.dart';

@JsonSerializable()
class LinkType {
  const LinkType({
    required this.name,
    required this.inward,
    required this.outward,
    this.editable,
  });

  factory LinkType.fromJson(Map<String, Object?> json) =>
      _$LinkTypeFromJson(json);

  final String name;
  final String inward;
  final String outward;
  final bool? editable;

  Map<String, Object?> toJson() => _$LinkTypeToJson(this);
}
