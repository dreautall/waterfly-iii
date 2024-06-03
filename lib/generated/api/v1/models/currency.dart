// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    this.enabled = true,
    this.createdAt,
    this.updatedAt,
    this.defaultValue,
    this.decimalPlaces,
  });

  factory Currency.fromJson(Map<String, Object?> json) =>
      _$CurrencyFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// Defaults to true
  final bool enabled;

  /// Make this currency the default currency.
  /// The name has been replaced because it contains a keyword. Original name: `default`.
  @JsonKey(name: 'default')
  final bool? defaultValue;
  final String code;
  final String name;
  final String symbol;

  /// Supports 0-16 decimals.
  @JsonKey(name: 'decimal_places')
  final int? decimalPlaces;

  Map<String, Object?> toJson() => _$CurrencyToJson(this);
}
