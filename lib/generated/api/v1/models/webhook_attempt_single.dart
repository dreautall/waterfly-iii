// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_attempt_read.dart';

part 'webhook_attempt_single.g.dart';

@JsonSerializable()
class WebhookAttemptSingle {
  const WebhookAttemptSingle({
    required this.data,
  });
  
  factory WebhookAttemptSingle.fromJson(Map<String, Object?> json) => _$WebhookAttemptSingleFromJson(json);
  
  final WebhookAttemptRead data;

  Map<String, Object?> toJson() => _$WebhookAttemptSingleToJson(this);
}
