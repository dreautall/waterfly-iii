// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_read.dart';
import 'meta.dart';

part 'account_array.g.dart';

@JsonSerializable()
class AccountArray {
  const AccountArray({
    required this.data,
    required this.meta,
  });
  
  factory AccountArray.fromJson(Map<String, Object?> json) => _$AccountArrayFromJson(json);
  
  final List<AccountRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$AccountArrayToJson(this);
}
