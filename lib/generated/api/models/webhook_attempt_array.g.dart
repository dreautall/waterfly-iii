// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_attempt_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookAttemptArray _$WebhookAttemptArrayFromJson(Map<String, dynamic> json) =>
    WebhookAttemptArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => WebhookAttemptRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptArrayToJson(
        WebhookAttemptArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
