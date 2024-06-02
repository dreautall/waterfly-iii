// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'attachable_type.dart';

part 'attachment.g.dart';

@JsonSerializable()
class Attachment {
  const Attachment({
    required this.createdAt,
    required this.updatedAt,
    required this.attachableType,
    required this.attachableId,
    required this.md5,
    required this.filename,
    required this.downloadUrl,
    required this.uploadUrl,
    required this.title,
    required this.notes,
    required this.mime,
    required this.size,
  });
  
  factory Attachment.fromJson(Map<String, Object?> json) => _$AttachmentFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'attachable_type')
  final AttachableType attachableType;

  /// ID of the model this attachment is linked to.
  @JsonKey(name: 'attachable_id')
  final String attachableId;

  /// MD5 hash of the file for basic duplicate detection.
  final String md5;
  final String filename;
  @JsonKey(name: 'download_url')
  final String downloadUrl;
  @JsonKey(name: 'upload_url')
  final String uploadUrl;
  final String? title;
  final String? notes;
  final String mime;
  final int size;

  Map<String, Object?> toJson() => _$AttachmentToJson(this);
}
