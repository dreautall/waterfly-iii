// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Webhook _$WebhookFromJson(Map<String, dynamic> json) => Webhook(
      title: json['title'] as String,
      trigger: WebhookTrigger.fromJson(json['trigger'] as String),
      response: WebhookResponse.fromJson(json['response'] as String),
      delivery: WebhookDelivery.fromJson(json['delivery'] as String),
      url: json['url'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool?,
      secret: json['secret'] as String?,
    );

Map<String, dynamic> _$WebhookToJson(Webhook instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'active': instance.active,
      'title': instance.title,
      'secret': instance.secret,
      'trigger': _$WebhookTriggerEnumMap[instance.trigger]!,
      'response': _$WebhookResponseEnumMap[instance.response]!,
      'delivery': _$WebhookDeliveryEnumMap[instance.delivery]!,
      'url': instance.url,
    };

const _$WebhookTriggerEnumMap = {
  WebhookTrigger.storeTransaction: 'STORE_TRANSACTION',
  WebhookTrigger.updateTransaction: 'UPDATE_TRANSACTION',
  WebhookTrigger.destroyTransaction: 'DESTROY_TRANSACTION',
  WebhookTrigger.$unknown: r'$unknown',
};

const _$WebhookResponseEnumMap = {
  WebhookResponse.transactions: 'TRANSACTIONS',
  WebhookResponse.accounts: 'ACCOUNTS',
  WebhookResponse.none: 'NONE',
  WebhookResponse.$unknown: r'$unknown',
};

const _$WebhookDeliveryEnumMap = {
  WebhookDelivery.valueJson: 'JSON',
  WebhookDelivery.$unknown: r'$unknown',
};
