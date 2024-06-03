// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'net_worth_item.dart';

part 'net_worth_array.g.dart';

/// The 'currency_code' refers to either the net worth amount of that currency the user has, OR to 'native' in which it is a (converted) sum of ALL currencies.
@JsonSerializable()
class NetWorthArray {
  const NetWorthArray({
    required this.currencyCode,
  });

  factory NetWorthArray.fromJson(Map<String, Object?> json) =>
      _$NetWorthArrayFromJson(json);

  @JsonKey(name: 'currency_code')
  final NetWorthItem currencyCode;

  Map<String, Object?> toJson() => _$NetWorthArrayToJson(this);
}
