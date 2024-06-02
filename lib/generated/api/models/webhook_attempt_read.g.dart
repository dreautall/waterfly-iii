// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_attempt_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookAttemptRead _$WebhookAttemptReadFromJson(Map<String, dynamic> json) =>
    WebhookAttemptRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          WebhookAttempt.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptReadToJson(WebhookAttemptRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
