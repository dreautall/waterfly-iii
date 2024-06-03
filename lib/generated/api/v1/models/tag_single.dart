// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'tag_read.dart';

part 'tag_single.g.dart';

@JsonSerializable()
class TagSingle {
  const TagSingle({
    required this.data,
  });

  factory TagSingle.fromJson(Map<String, Object?> json) =>
      _$TagSingleFromJson(json);

  final TagRead data;

  Map<String, Object?> toJson() => _$TagSingleToJson(this);
}
