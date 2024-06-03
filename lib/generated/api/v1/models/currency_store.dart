// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'currency_store.g.dart';

@JsonSerializable()
class CurrencyStore {
  const CurrencyStore({
    required this.defaultValue,
    required this.code,
    required this.name,
    required this.symbol,
    required this.decimalPlaces,
    this.enabled = true,
  });

  factory CurrencyStore.fromJson(Map<String, Object?> json) =>
      _$CurrencyStoreFromJson(json);

  /// Defaults to true
  final bool enabled;

  /// Make this currency the default currency. You can set this value to FALSE, in which case nothing will change to the default currency. If you set it to TRUE, the current default currency will no longer be the default currency.
  /// The name has been replaced because it contains a keyword. Original name: `default`.
  @JsonKey(name: 'default')
  final bool defaultValue;
  final String code;
  final String name;
  final String symbol;

  /// Supports 0-16 decimals.
  @JsonKey(name: 'decimal_places')
  final int decimalPlaces;

  Map<String, Object?> toJson() => _$CurrencyStoreToJson(this);
}
