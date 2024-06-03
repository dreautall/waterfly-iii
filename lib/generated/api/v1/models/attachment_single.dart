// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'attachment_read.dart';

part 'attachment_single.g.dart';

@JsonSerializable()
class AttachmentSingle {
  const AttachmentSingle({
    required this.data,
  });

  factory AttachmentSingle.fromJson(Map<String, Object?> json) =>
      _$AttachmentSingleFromJson(json);

  final AttachmentRead data;

  Map<String, Object?> toJson() => _$AttachmentSingleToJson(this);
}
