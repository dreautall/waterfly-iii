// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_message_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookMessageSingle _$WebhookMessageSingleFromJson(
        Map<String, dynamic> json) =>
    WebhookMessageSingle(
      data: WebhookMessageRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageSingleToJson(
        WebhookMessageSingle instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
