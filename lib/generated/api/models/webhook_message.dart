// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'webhook_message.g.dart';

@JsonSerializable()
class WebhookMessage {
  const WebhookMessage({
    required this.createdAt,
    required this.updatedAt,
    required this.sent,
    required this.errored,
    required this.webhookId,
    required this.uuid,
    required this.message,
  });
  
  factory WebhookMessage.fromJson(Map<String, Object?> json) => _$WebhookMessageFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// If this message is sent yet.
  final bool sent;

  /// If this message has errored out.
  final bool errored;

  /// The ID of the webhook this message belongs to.
  @JsonKey(name: 'webhook_id')
  final String webhookId;

  /// Long UUID string for identification of this webhook message.
  final String uuid;

  /// The actual message that is sent or will be sent as JSON string.
  final String? message;

  Map<String, Object?> toJson() => _$WebhookMessageToJson(this);
}
