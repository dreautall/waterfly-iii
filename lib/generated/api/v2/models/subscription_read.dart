// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'subscription.dart';

part 'subscription_read.g.dart';

@JsonSerializable()
class SubscriptionRead {
  const SubscriptionRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory SubscriptionRead.fromJson(Map<String, Object?> json) => _$SubscriptionReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final Subscription attributes;

  Map<String, Object?> toJson() => _$SubscriptionReadToJson(this);
}
