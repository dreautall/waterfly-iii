// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookSingle _$WebhookSingleFromJson(Map<String, dynamic> json) =>
    WebhookSingle(
      data: WebhookRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookSingleToJson(WebhookSingle instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
