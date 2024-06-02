// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'webhook_read.dart';

part 'webhook_single.g.dart';

@JsonSerializable()
class WebhookSingle {
  const WebhookSingle({
    required this.data,
  });
  
  factory WebhookSingle.fromJson(Map<String, Object?> json) => _$WebhookSingleFromJson(json);
  
  final WebhookRead data;

  Map<String, Object?> toJson() => _$WebhookSingleToJson(this);
}
