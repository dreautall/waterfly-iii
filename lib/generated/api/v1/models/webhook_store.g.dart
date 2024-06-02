// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookStore _$WebhookStoreFromJson(Map<String, dynamic> json) => WebhookStore(
      active: json['active'] as bool,
      title: json['title'] as String,
      trigger: WebhookTrigger.fromJson(json['trigger'] as String),
      response: WebhookResponse.fromJson(json['response'] as String),
      delivery: WebhookDelivery.fromJson(json['delivery'] as String),
      url: json['url'] as String,
    );

Map<String, dynamic> _$WebhookStoreToJson(WebhookStore instance) =>
    <String, dynamic>{
      'active': instance.active,
      'title': instance.title,
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
