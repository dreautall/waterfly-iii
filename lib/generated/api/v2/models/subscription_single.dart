// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'subscription_read.dart';

part 'subscription_single.g.dart';

@JsonSerializable()
class SubscriptionSingle {
  const SubscriptionSingle({
    required this.data,
  });
  
  factory SubscriptionSingle.fromJson(Map<String, Object?> json) => _$SubscriptionSingleFromJson(json);
  
  final SubscriptionRead data;

  Map<String, Object?> toJson() => _$SubscriptionSingleToJson(this);
}
