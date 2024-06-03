// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_role_property.dart';
import 'credit_card_type_property.dart';
import 'interest_period_property.dart';
import 'liability_type_property.dart';

part 'account_update.g.dart';

@JsonSerializable()
class AccountUpdate {
  const AccountUpdate({
    required this.name,
    this.active = true,
    this.includeNetWorth = true,
    this.iban,
    this.bic,
    this.accountNumber,
    this.openingBalance,
    this.openingBalanceDate,
    this.virtualBalance,
    this.currencyId,
    this.currencyCode,
    this.order,
    this.accountRole,
    this.creditCardType,
    this.monthlyPaymentDate,
    this.liabilityType,
    this.interest,
    this.interestPeriod,
    this.notes,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory AccountUpdate.fromJson(Map<String, Object?> json) =>
      _$AccountUpdateFromJson(json);

  final String name;
  final String? iban;
  final String? bic;
  @JsonKey(name: 'account_number')
  final String? accountNumber;
  @JsonKey(name: 'opening_balance')
  final String? openingBalance;
  @JsonKey(name: 'opening_balance_date')
  final DateTime? openingBalanceDate;
  @JsonKey(name: 'virtual_balance')
  final String? virtualBalance;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// Use either currency_id or currency_code. Defaults to the user's default currency.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  /// If omitted, defaults to true.
  final bool active;

  /// Order of the account
  final int? order;

  /// If omitted, defaults to true.
  @JsonKey(name: 'include_net_worth')
  final bool includeNetWorth;
  @JsonKey(name: 'account_role')
  final AccountRoleProperty? accountRole;
  @JsonKey(name: 'credit_card_type')
  final CreditCardTypeProperty? creditCardType;

  /// Mandatory when the account_role is ccAsset. Moment at which CC payment installments are asked for by the bank.
  @JsonKey(name: 'monthly_payment_date')
  final DateTime? monthlyPaymentDate;
  @JsonKey(name: 'liability_type')
  final LiabilityTypeProperty? liabilityType;

  /// Mandatory when type is liability. Interest percentage.
  final String? interest;
  @JsonKey(name: 'interest_period')
  final InterestPeriodProperty? interestPeriod;
  final String? notes;

  /// Latitude of the account's location, if applicable. Can be used to draw a map. If omitted, the existing location will be kept. If submitted as NULL, the current location will be removed.
  final double? latitude;

  /// Latitude of the account's location, if applicable. Can be used to draw a map. If omitted, the existing location will be kept. If submitted as NULL, the current location will be removed.
  final double? longitude;

  /// Zoom level for the map, if drawn. This to set the box right. Unfortunately this is a proprietary value because each map provider has different zoom levels. If omitted, the existing location will be kept. If submitted as NULL, the current location will be removed.
  @JsonKey(name: 'zoom_level')
  final int? zoomLevel;

  Map<String, Object?> toJson() => _$AccountUpdateToJson(this);
}
