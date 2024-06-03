// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'webhook_attempt.g.dart';

@JsonSerializable()
class WebhookAttempt {
  const WebhookAttempt({
    required this.createdAt,
    required this.updatedAt,
    required this.webhookMessageId,
    required this.statusCode,
    required this.logs,
    required this.response,
  });

  factory WebhookAttempt.fromJson(Map<String, Object?> json) =>
      _$WebhookAttemptFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The ID of the webhook message this attempt belongs to.
  @JsonKey(name: 'webhook_message_id')
  final String webhookMessageId;

  /// The HTTP status code of the error, if any.
  @JsonKey(name: 'status_code')
  final int? statusCode;

  /// Internal log for this attempt. May contain sensitive user data.
  final String? logs;

  /// Webhook receiver response for this attempt, if any. May contain sensitive user data.
  final String? response;

  Map<String, Object?> toJson() => _$WebhookAttemptToJson(this);
}
