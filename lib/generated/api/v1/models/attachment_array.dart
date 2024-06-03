// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'attachment_read.dart';
import 'meta.dart';

part 'attachment_array.g.dart';

@JsonSerializable()
class AttachmentArray {
  const AttachmentArray({
    required this.data,
    required this.meta,
  });

  factory AttachmentArray.fromJson(Map<String, Object?> json) =>
      _$AttachmentArrayFromJson(json);

  final List<AttachmentRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$AttachmentArrayToJson(this);
}
