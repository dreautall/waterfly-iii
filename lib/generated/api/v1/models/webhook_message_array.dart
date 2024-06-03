// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'webhook_message_read.dart';

part 'webhook_message_array.g.dart';

@JsonSerializable()
class WebhookMessageArray {
  const WebhookMessageArray({
    required this.data,
    required this.meta,
  });

  factory WebhookMessageArray.fromJson(Map<String, Object?> json) =>
      _$WebhookMessageArrayFromJson(json);

  final List<WebhookMessageRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$WebhookMessageArrayToJson(this);
}
