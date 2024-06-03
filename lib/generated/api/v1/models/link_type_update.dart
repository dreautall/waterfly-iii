// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'link_type_update.g.dart';

@JsonSerializable()
class LinkTypeUpdate {
  const LinkTypeUpdate({
    this.name,
    this.inward,
    this.outward,
  });

  factory LinkTypeUpdate.fromJson(Map<String, Object?> json) =>
      _$LinkTypeUpdateFromJson(json);

  final String? name;
  final String? inward;
  final String? outward;

  Map<String, Object?> toJson() => _$LinkTypeUpdateToJson(this);
}
