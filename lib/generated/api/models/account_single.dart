// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_read.dart';

part 'account_single.g.dart';

@JsonSerializable()
class AccountSingle {
  const AccountSingle({
    required this.data,
  });
  
  factory AccountSingle.fromJson(Map<String, Object?> json) => _$AccountSingleFromJson(json);
  
  final AccountRead data;

  Map<String, Object?> toJson() => _$AccountSingleToJson(this);
}
