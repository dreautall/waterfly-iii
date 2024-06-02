// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'currency_v2.g.dart';

@JsonSerializable()
class CurrencyV2 {
  const CurrencyV2({
    required this.createdAt,
    required this.updatedAt,
    required this.defaultValue,
    required this.code,
    required this.name,
    required this.symbol,
    required this.decimalPlaces,
    this.enabled = true,
  });
  
  factory CurrencyV2.fromJson(Map<String, Object?> json) => _$CurrencyV2FromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Defaults to true
  final bool enabled;

  /// Make this currency the default currency.
  /// The name has been replaced because it contains a keyword. Original name: `default`.
  @JsonKey(name: 'default')
  final bool defaultValue;
  final String code;
  final String name;
  final String symbol;

  /// Supports 0-12 decimals.
  @JsonKey(name: 'decimal_places')
  final int decimalPlaces;

  Map<String, Object?> toJson() => _$CurrencyV2ToJson(this);
}
