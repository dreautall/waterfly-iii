// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_message_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookMessageArray _$WebhookMessageArrayFromJson(Map<String, dynamic> json) =>
    WebhookMessageArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => WebhookMessageRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageArrayToJson(
        WebhookMessageArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
