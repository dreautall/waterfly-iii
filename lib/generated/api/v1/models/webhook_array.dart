// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'webhook_read.dart';

part 'webhook_array.g.dart';

@JsonSerializable()
class WebhookArray {
  const WebhookArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory WebhookArray.fromJson(Map<String, Object?> json) =>
      _$WebhookArrayFromJson(json);

  final List<WebhookRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$WebhookArrayToJson(this);
}
