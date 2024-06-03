// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_message_read.dart';

part 'webhook_message_single.g.dart';

@JsonSerializable()
class WebhookMessageSingle {
  const WebhookMessageSingle({
    required this.data,
  });

  factory WebhookMessageSingle.fromJson(Map<String, Object?> json) =>
      _$WebhookMessageSingleFromJson(json);

  final WebhookMessageRead data;

  Map<String, Object?> toJson() => _$WebhookMessageSingleToJson(this);
}
