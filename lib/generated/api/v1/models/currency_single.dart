// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency_read.dart';

part 'currency_single.g.dart';

@JsonSerializable()
class CurrencySingle {
  const CurrencySingle({
    required this.data,
  });

  factory CurrencySingle.fromJson(Map<String, Object?> json) =>
      _$CurrencySingleFromJson(json);

  final CurrencyRead data;

  Map<String, Object?> toJson() => _$CurrencySingleToJson(this);
}
