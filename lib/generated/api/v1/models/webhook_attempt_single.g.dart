// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_attempt_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookAttemptSingle _$WebhookAttemptSingleFromJson(
        Map<String, dynamic> json) =>
    WebhookAttemptSingle(
      data: WebhookAttemptRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptSingleToJson(
        WebhookAttemptSingle instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
