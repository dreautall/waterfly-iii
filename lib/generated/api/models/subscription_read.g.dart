// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionRead _$SubscriptionReadFromJson(Map<String, dynamic> json) =>
    SubscriptionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Subscription.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionReadToJson(SubscriptionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
