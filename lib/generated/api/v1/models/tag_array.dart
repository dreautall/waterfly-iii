// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'tag_read.dart';

part 'tag_array.g.dart';

@JsonSerializable()
class TagArray {
  const TagArray({
    required this.data,
    required this.meta,
    required this.links,
  });
  
  factory TagArray.fromJson(Map<String, Object?> json) => _$TagArrayFromJson(json);
  
  final List<TagRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$TagArrayToJson(this);
}
