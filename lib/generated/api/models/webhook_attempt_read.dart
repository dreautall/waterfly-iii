// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_attempt.dart';

part 'webhook_attempt_read.g.dart';

@JsonSerializable()
class WebhookAttemptRead {
  const WebhookAttemptRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory WebhookAttemptRead.fromJson(Map<String, Object?> json) => _$WebhookAttemptReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final WebhookAttempt attributes;

  Map<String, Object?> toJson() => _$WebhookAttemptReadToJson(this);
}
