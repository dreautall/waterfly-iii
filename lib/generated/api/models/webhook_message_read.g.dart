// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_message_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookMessageRead _$WebhookMessageReadFromJson(Map<String, dynamic> json) =>
    WebhookMessageRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          WebhookMessage.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageReadToJson(WebhookMessageRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
