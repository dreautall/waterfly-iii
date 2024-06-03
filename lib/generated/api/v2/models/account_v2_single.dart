// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_v2_read.dart';

part 'account_v2_single.g.dart';

@JsonSerializable()
class AccountV2Single {
  const AccountV2Single({
    required this.data,
  });

  factory AccountV2Single.fromJson(Map<String, Object?> json) =>
      _$AccountV2SingleFromJson(json);

  final AccountV2Read data;

  Map<String, Object?> toJson() => _$AccountV2SingleToJson(this);
}
