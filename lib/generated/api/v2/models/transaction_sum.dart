// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'transaction_sum.g.dart';

@JsonSerializable()
class TransactionSum {
  const TransactionSum({
    required this.currencyId,
    required this.currencyName,
    required this.currencySymbol,
    required this.currencyCode,
    required this.currencyDecimalPlaces,
    required this.nativeCurrencyId,
    required this.nativeCurrencyName,
    required this.nativeCurrencySymbol,
    required this.nativeCurrencyCode,
    required this.nativeCurrencyDecimalPlaces,
    required this.sum,
    required this.nativeSum,
  });

  factory TransactionSum.fromJson(Map<String, Object?> json) =>
      _$TransactionSumFromJson(json);

  /// ID of the currency of this sum.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Currency name associated with this sum.
  @JsonKey(name: 'currency_name')
  final String currencyName;

  /// Currency symbol associated with this sum.
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Currency code associated with this sum.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Number of decimal places for the currency associated with this sum.
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// The ID of the user's native (default) currency.
  @JsonKey(name: 'native_currency_id')
  final String nativeCurrencyId;

  /// The name of the user's native (default) currency
  @JsonKey(name: 'native_currency_name')
  final String nativeCurrencyName;

  /// Currency symbol associated with this amount.
  @JsonKey(name: 'native_currency_symbol')
  final String nativeCurrencySymbol;

  /// The currency code of the user's native (default) currency.
  @JsonKey(name: 'native_currency_code')
  final String nativeCurrencyCode;

  /// Number of decimal places for this currency.
  @JsonKey(name: 'native_currency_decimal_places')
  final int nativeCurrencyDecimalPlaces;

  /// Sum as a string. Can also be negative
  final String sum;

  /// Sum as a string, expressed in the user's native (default) currency. Can also be negative
  @JsonKey(name: 'native_sum')
  final String nativeSum;

  Map<String, Object?> toJson() => _$TransactionSumToJson(this);
}
