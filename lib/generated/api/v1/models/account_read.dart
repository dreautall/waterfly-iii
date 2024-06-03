// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account.dart';

part 'account_read.g.dart';

@JsonSerializable()
class AccountRead {
  const AccountRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory AccountRead.fromJson(Map<String, Object?> json) =>
      _$AccountReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Account attributes;

  Map<String, Object?> toJson() => _$AccountReadToJson(this);
}
