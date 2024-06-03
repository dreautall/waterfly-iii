// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_message.dart';

part 'webhook_message_read.g.dart';

@JsonSerializable()
class WebhookMessageRead {
  const WebhookMessageRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory WebhookMessageRead.fromJson(Map<String, Object?> json) =>
      _$WebhookMessageReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final WebhookMessage attributes;

  Map<String, Object?> toJson() => _$WebhookMessageReadToJson(this);
}
