// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookAttempt _$WebhookAttemptFromJson(Map<String, dynamic> json) =>
    WebhookAttempt(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      webhookMessageId: json['webhook_message_id'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      logs: json['logs'] as String?,
      response: json['response'] as String?,
    );

Map<String, dynamic> _$WebhookAttemptToJson(WebhookAttempt instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'webhook_message_id': instance.webhookMessageId,
      'status_code': instance.statusCode,
      'logs': instance.logs,
      'response': instance.response,
    };
