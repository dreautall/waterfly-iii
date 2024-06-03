// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'piggy_bank.g.dart';

@JsonSerializable()
class PiggyBank {
  const PiggyBank({
    required this.accountId,
    required this.name,
    required this.targetAmount,
    this.createdAt,
    this.updatedAt,
    this.accountName,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.percentage,
    this.currentAmount,
    this.leftToSave,
    this.savePerMonth,
    this.startDate,
    this.targetDate,
    this.order,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
  });

  factory PiggyBank.fromJson(Map<String, Object?> json) =>
      _$PiggyBankFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// The ID of the asset account this piggy bank is connected to.
  @JsonKey(name: 'account_id')
  final String accountId;

  /// The name of the asset account this piggy bank is connected to.
  @JsonKey(name: 'account_name')
  final String? accountName;
  final String name;
  @JsonKey(name: 'currency_id')
  final String? currencyId;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// Number of decimals supported by the currency
  @JsonKey(name: 'currency_decimal_places')
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'target_amount')
  final String? targetAmount;
  final double? percentage;
  @JsonKey(name: 'current_amount')
  final String? currentAmount;
  @JsonKey(name: 'left_to_save')
  final String? leftToSave;
  @JsonKey(name: 'save_per_month')
  final String? savePerMonth;

  /// The date you started with this piggy bank.
  @JsonKey(name: 'start_date')
  final DateTime? startDate;

  /// The date you intend to finish saving money.
  @JsonKey(name: 'target_date')
  final DateTime? targetDate;
  final int? order;
  final bool? active;
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

  Map<String, Object?> toJson() => _$PiggyBankToJson(this);
}
