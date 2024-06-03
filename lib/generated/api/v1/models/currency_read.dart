// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'currency_read.g.dart';

@JsonSerializable()
class CurrencyRead {
  const CurrencyRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory CurrencyRead.fromJson(Map<String, Object?> json) =>
      _$CurrencyReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Currency attributes;

  Map<String, Object?> toJson() => _$CurrencyReadToJson(this);
}
