// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'link_type_read.dart';
import 'meta.dart';
import 'page_link.dart';

part 'link_type_array.g.dart';

@JsonSerializable()
class LinkTypeArray {
  const LinkTypeArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory LinkTypeArray.fromJson(Map<String, Object?> json) =>
      _$LinkTypeArrayFromJson(json);

  final List<LinkTypeRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$LinkTypeArrayToJson(this);
}
