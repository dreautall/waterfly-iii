// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'attachment_update.g.dart';

@JsonSerializable()
class AttachmentUpdate {
  const AttachmentUpdate({
    required this.filename,
    required this.title,
    required this.notes,
  });

  factory AttachmentUpdate.fromJson(Map<String, Object?> json) =>
      _$AttachmentUpdateFromJson(json);

  final String filename;
  final String title;
  final String? notes;

  Map<String, Object?> toJson() => _$AttachmentUpdateToJson(this);
}
