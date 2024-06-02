// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookMessage _$WebhookMessageFromJson(Map<String, dynamic> json) =>
    WebhookMessage(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      sent: json['sent'] as bool,
      errored: json['errored'] as bool,
      webhookId: json['webhook_id'] as String,
      uuid: json['uuid'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$WebhookMessageToJson(WebhookMessage instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'sent': instance.sent,
      'errored': instance.errored,
      'webhook_id': instance.webhookId,
      'uuid': instance.uuid,
      'message': instance.message,
    };
