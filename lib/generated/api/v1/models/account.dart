// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_role_property.dart';
import 'credit_card_type_property.dart';
import 'interest_period_property.dart';
import 'liability_direction_property.dart';
import 'liability_type_property.dart';
import 'short_account_type_property.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  const Account({
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    required this.name,
    required this.type,
    required this.accountRole,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.currentBalance,
    required this.currentBalanceDate,
    required this.iban,
    required this.bic,
    required this.accountNumber,
    required this.openingBalance,
    required this.currentDebt,
    required this.openingBalanceDate,
    required this.virtualBalance,
    required this.creditCardType,
    required this.monthlyPaymentDate,
    required this.liabilityType,
    required this.liabilityDirection,
    required this.interest,
    required this.interestPeriod,
    required this.notes,
    required this.latitude,
    required this.longitude,
    required this.zoomLevel,
    this.active = true,
    this.includeNetWorth = true,
  });

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// If omitted, defaults to true.
  final bool active;

  /// Order of the account. Is NULL if account is not asset or liability.
  final int? order;
  final String name;
  final ShortAccountTypeProperty type;
  @JsonKey(name: 'account_role')
  final AccountRoleProperty accountRole;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;
  @JsonKey(name: 'current_balance')
  final String currentBalance;

  /// The timestamp for this date is always 23:59:59, to indicate it's the balance at the very END of that particular day.
  @JsonKey(name: 'current_balance_date')
  final DateTime currentBalanceDate;
  final String? iban;
  final String? bic;
  @JsonKey(name: 'account_number')
  final String? accountNumber;

  /// Represents the opening balance, the initial amount this account holds.
  @JsonKey(name: 'opening_balance')
  final String openingBalance;

  /// Represents the current debt for liabilities.
  @JsonKey(name: 'current_debt')
  final String? currentDebt;

  /// Represents the date of the opening balance.
  @JsonKey(name: 'opening_balance_date')
  final DateTime? openingBalanceDate;
  @JsonKey(name: 'virtual_balance')
  final String virtualBalance;

  /// If omitted, defaults to true.
  @JsonKey(name: 'include_net_worth')
  final bool includeNetWorth;
  @JsonKey(name: 'credit_card_type')
  final CreditCardTypeProperty creditCardType;

  /// Mandatory when the account_role is ccAsset. Moment at which CC payment installments are asked for by the bank.
  @JsonKey(name: 'monthly_payment_date')
  final DateTime? monthlyPaymentDate;
  @JsonKey(name: 'liability_type')
  final LiabilityTypeProperty liabilityType;
  @JsonKey(name: 'liability_direction')
  final LiabilityDirectionProperty liabilityDirection;

  /// Mandatory when type is liability. Interest percentage.
  final String? interest;
  @JsonKey(name: 'interest_period')
  final InterestPeriodProperty interestPeriod;
  final String? notes;

  /// Latitude of the accounts's location, if applicable. Can be used to draw a map.
  final double? latitude;

  /// Latitude of the accounts's location, if applicable. Can be used to draw a map.
  final double? longitude;

  /// Zoom level for the map, if drawn. This to set the box right. Unfortunately this is a proprietary value because each map provider has different zoom levels.
  @JsonKey(name: 'zoom_level')
  final int? zoomLevel;

  Map<String, Object?> toJson() => _$AccountToJson(this);
}
