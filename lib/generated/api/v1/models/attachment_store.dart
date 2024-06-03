// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'attachable_type.dart';

part 'attachment_store.g.dart';

@JsonSerializable()
class AttachmentStore {
  const AttachmentStore({
    required this.filename,
    required this.attachableType,
    required this.attachableId,
    this.title,
    this.notes,
  });

  factory AttachmentStore.fromJson(Map<String, Object?> json) =>
      _$AttachmentStoreFromJson(json);

  final String filename;
  @JsonKey(name: 'attachable_type')
  final AttachableType attachableType;

  /// ID of the model this attachment is linked to.
  @JsonKey(name: 'attachable_id')
  final String attachableId;
  final String? title;
  final String? notes;

  Map<String, Object?> toJson() => _$AttachmentStoreToJson(this);
}
