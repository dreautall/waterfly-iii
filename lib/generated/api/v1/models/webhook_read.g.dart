// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookRead _$WebhookReadFromJson(Map<String, dynamic> json) => WebhookRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Webhook.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$WebhookReadToJson(WebhookRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
