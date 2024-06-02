// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookArray _$WebhookArrayFromJson(Map<String, dynamic> json) => WebhookArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => WebhookRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookArrayToJson(WebhookArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
