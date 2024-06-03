// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'webhook.dart';

part 'webhook_read.g.dart';

@JsonSerializable()
class WebhookRead {
  const WebhookRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory WebhookRead.fromJson(Map<String, Object?> json) =>
      _$WebhookReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Webhook attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$WebhookReadToJson(this);
}
