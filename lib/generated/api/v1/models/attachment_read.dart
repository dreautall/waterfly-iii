// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'attachment.dart';
import 'object_link.dart';

part 'attachment_read.g.dart';

@JsonSerializable()
class AttachmentRead {
  const AttachmentRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory AttachmentRead.fromJson(Map<String, Object?> json) =>
      _$AttachmentReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Attachment attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$AttachmentReadToJson(this);
}
