// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_account.g.dart';

@JsonSerializable()
class AutocompleteAccount {
  const AutocompleteAccount({
    required this.id,
    required this.name,
    required this.nameWithBalance,
    required this.type,
    required this.currencyId,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
  });
  
  factory AutocompleteAccount.fromJson(Map<String, Object?> json) => _$AutocompleteAccountFromJson(json);
  
  final String id;

  /// Name of the account found by an auto-complete search.
  final String name;

  /// Asset accounts and liabilities have a second field with the given date's account balance.
  @JsonKey(name: 'name_with_balance')
  final String nameWithBalance;

  /// Account type of the account found by the auto-complete search.
  final String type;

  /// ID for the currency used by this account.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Currency name for the currency used by this account.
  @JsonKey(name: 'currency_name')
  final String currencyName;

  /// Currency code for the currency used by this account.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Currency symbol for the currency used by this account.
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimal places for the currency used by this account.
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  Map<String, Object?> toJson() => _$AutocompleteAccountToJson(this);
}
