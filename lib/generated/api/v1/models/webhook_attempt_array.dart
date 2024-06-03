// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'webhook_attempt_read.dart';

part 'webhook_attempt_array.g.dart';

@JsonSerializable()
class WebhookAttemptArray {
  const WebhookAttemptArray({
    required this.data,
    required this.meta,
  });

  factory WebhookAttemptArray.fromJson(Map<String, Object?> json) =>
      _$WebhookAttemptArrayFromJson(json);

  final List<WebhookAttemptRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$WebhookAttemptArrayToJson(this);
}
