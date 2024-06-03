// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookUpdate _$WebhookUpdateFromJson(Map<String, dynamic> json) =>
    WebhookUpdate(
      active: json['active'] as bool?,
      title: json['title'] as String?,
      secret: json['secret'] as String?,
      trigger: json['trigger'] == null
          ? null
          : WebhookTrigger.fromJson(json['trigger'] as String),
      response: json['response'] == null
          ? null
          : WebhookResponse.fromJson(json['response'] as String),
      delivery: json['delivery'] == null
          ? null
          : WebhookDelivery.fromJson(json['delivery'] as String),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$WebhookUpdateToJson(WebhookUpdate instance) =>
    <String, dynamic>{
      'active': instance.active,
      'title': instance.title,
      'secret': instance.secret,
      'trigger': _$WebhookTriggerEnumMap[instance.trigger],
      'response': _$WebhookResponseEnumMap[instance.response],
      'delivery': _$WebhookDeliveryEnumMap[instance.delivery],
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
