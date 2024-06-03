// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'subscription_read.dart';

part 'subscription_array.g.dart';

@JsonSerializable()
class SubscriptionArray {
  const SubscriptionArray({
    required this.data,
    required this.meta,
  });

  factory SubscriptionArray.fromJson(Map<String, Object?> json) =>
      _$SubscriptionArrayFromJson(json);

  final List<SubscriptionRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$SubscriptionArrayToJson(this);
}
