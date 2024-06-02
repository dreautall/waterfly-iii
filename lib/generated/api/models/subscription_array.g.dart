// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionArray _$SubscriptionArrayFromJson(Map<String, dynamic> json) =>
    SubscriptionArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => SubscriptionRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionArrayToJson(SubscriptionArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
