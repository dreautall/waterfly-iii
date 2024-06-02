// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_delivery.dart';
import 'webhook_response.dart';
import 'webhook_trigger.dart';

part 'webhook_store.g.dart';

@JsonSerializable()
class WebhookStore {
  const WebhookStore({
    required this.active,
    required this.title,
    required this.trigger,
    required this.response,
    required this.delivery,
    required this.url,
  });
  
  factory WebhookStore.fromJson(Map<String, Object?> json) => _$WebhookStoreFromJson(json);
  
  /// Boolean to indicate if the webhook is active
  final bool active;

  /// A title for the webhook for easy recognition.
  final String title;
  final WebhookTrigger trigger;
  final WebhookResponse response;
  final WebhookDelivery delivery;

  /// The URL of the webhook. Has to start with `https`.
  final String url;

  Map<String, Object?> toJson() => _$WebhookStoreToJson(this);
}
