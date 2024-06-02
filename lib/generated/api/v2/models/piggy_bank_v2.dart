// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'piggy_bank_v2.g.dart';

@JsonSerializable()
class PiggyBankV2 {
  const PiggyBankV2({
    required this.createdAt,
    required this.updatedAt,
    required this.accountId,
    required this.accountName,
    required this.name,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.nativeCurrencyId,
    required this.nativeCurrencyCode,
    required this.nativeCurrencySymbol,
    required this.nativeCurrencyDecimalPlaces,
    required this.currentAmount,
    required this.nativeCurrentAmount,
    required this.targetAmount,
    required this.nativeTargetAmount,
    required this.percentage,
    required this.leftToSave,
    required this.nativeLeftToSave,
    required this.savePerMonth,
    required this.nativeSavePerMonth,
    required this.startDate,
    required this.targetDate,
    required this.order,
    required this.active,
    required this.notes,
    required this.objectGroupId,
    required this.objectGroupOrder,
    required this.objectGroupTitle,
  });
  
  factory PiggyBankV2.fromJson(Map<String, Object?> json) => _$PiggyBankV2FromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The ID of the asset account this piggy bank is connected to.
  @JsonKey(name: 'account_id')
  final String accountId;

  /// The name of the asset account this piggy bank is connected to.
  @JsonKey(name: 'account_name')
  final String accountName;
  final String name;
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id')
  final String nativeCurrencyId;
  @JsonKey(name: 'native_currency_code')
  final String nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol')
  final String nativeCurrencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'native_currency_decimal_places')
  final int nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'current_amount')
  final String currentAmount;
  @JsonKey(name: 'native_current_amount')
  final String nativeCurrentAmount;
  @JsonKey(name: 'target_amount')
  final String? targetAmount;
  @JsonKey(name: 'native_target_amount')
  final String? nativeTargetAmount;
  final double? percentage;
  @JsonKey(name: 'left_to_save')
  final String? leftToSave;
  @JsonKey(name: 'native_left_to_save')
  final String? nativeLeftToSave;
  @JsonKey(name: 'save_per_month')
  final String? savePerMonth;
  @JsonKey(name: 'native_save_per_month')
  final String? nativeSavePerMonth;

  /// The date you started with this piggy bank.
  @JsonKey(name: 'start_date')
  final DateTime startDate;

  /// The date you intend to finish saving money.
  @JsonKey(name: 'target_date')
  final DateTime? targetDate;
  final int order;
  final bool active;
  final String? notes;

  /// The group ID of the group this object is part of. NULL if no group.
  @JsonKey(name: 'object_group_id')
  final String? objectGroupId;

  /// The order of the group. At least 1, for the highest sorting.
  @JsonKey(name: 'object_group_order')
  final int? objectGroupOrder;

  /// The name of the group. NULL if no group.
  @JsonKey(name: 'object_group_title')
  final String? objectGroupTitle;

  Map<String, Object?> toJson() => _$PiggyBankV2ToJson(this);
}
