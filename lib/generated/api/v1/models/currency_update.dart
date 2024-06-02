// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency_update_default_enum.dart';

part 'currency_update.g.dart';

@JsonSerializable()
class CurrencyUpdate {
  const CurrencyUpdate({
    required this.enabled,
    required this.defaultEnum,
    required this.code,
    required this.name,
    required this.symbol,
    required this.decimalPlaces,
  });
  
  factory CurrencyUpdate.fromJson(Map<String, Object?> json) => _$CurrencyUpdateFromJson(json);
  
  /// If the currency is enabled
  final bool enabled;

  /// If the currency must be the default for the user. You can only submit TRUE. Submitting FALSE will not drop this currency as the default currency, because then the system would be without one.
  /// The name has been replaced because it contains a keyword. Original name: `default`.
  @JsonKey(name: 'default')
  final CurrencyUpdateDefaultEnum defaultEnum;

  /// The currency code
  final String code;

  /// The currency name
  final String name;

  /// The currency symbol
  final String symbol;

  /// How many decimals to use when displaying this currency. Between 0 and 16.
  @JsonKey(name: 'decimal_places')
  final int decimalPlaces;

  Map<String, Object?> toJson() => _$CurrencyUpdateToJson(this);
}
