// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_role_property.dart';
import 'short_account_type_property.dart';

part 'account_v2.g.dart';

@JsonSerializable()
class AccountV2 {
  const AccountV2({
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    required this.name,
    required this.iban,
    required this.type,
    required this.accountRole,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.nativeCurrencyId,
    required this.nativeCurrencyCode,
    required this.nativeCurrencySymbol,
    required this.nativeCurrencyDecimalPlaces,
    required this.currentBalance,
    required this.nativeCurrentBalance,
    required this.currentBalanceDate,
    this.active = true,
  });

  factory AccountV2.fromJson(Map<String, Object?> json) =>
      _$AccountV2FromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// If omitted, defaults to true.
  final bool active;

  /// Order of the account. Is NULL if account is not asset or liability.
  final int? order;
  final String name;
  final String? iban;
  final ShortAccountTypeProperty type;
  @JsonKey(name: 'account_role')
  final AccountRoleProperty accountRole;

  /// Account currency ID.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Account currency code.
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// User's native currency id.
  @JsonKey(name: 'native_currency_id')
  final String nativeCurrencyId;

  /// User's native currency code.
  @JsonKey(name: 'native_currency_code')
  final String nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol')
  final String nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_decimal_places')
  final int nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'current_balance')
  final String currentBalance;

  /// Balance in native currency
  @JsonKey(name: 'native_current_balance')
  final String nativeCurrentBalance;

  /// The timestamp for this date is always 23:59:59, to indicate it's the balance at the very END of that particular day.
  @JsonKey(name: 'current_balance_date')
  final DateTime currentBalanceDate;

  Map<String, Object?> toJson() => _$AccountV2ToJson(this);
}
