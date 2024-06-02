// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_v2.dart';

part 'account_v2_read.g.dart';

@JsonSerializable()
class AccountV2Read {
  const AccountV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory AccountV2Read.fromJson(Map<String, Object?> json) => _$AccountV2ReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final AccountV2 attributes;

  Map<String, Object?> toJson() => _$AccountV2ReadToJson(this);
}
