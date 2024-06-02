// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'net_worth_item.g.dart';

@JsonSerializable()
class NetWorthItem {
  const NetWorthItem({
    required this.balance,
    required this.nativeBalance,
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
  });
  
  factory NetWorthItem.fromJson(Map<String, Object?> json) => _$NetWorthItemFromJson(json);
  
  /// The net worth as a string in the indicated currency (see below). Can also be negative
  final String balance;

  /// The net worth as a string in the native currency. Can also be negative
  @JsonKey(name: 'native_balance')
  final String nativeBalance;

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

  Map<String, Object?> toJson() => _$NetWorthItemToJson(this);
}
