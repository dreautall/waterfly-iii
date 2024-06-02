// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'piggy_bank_store.g.dart';

@JsonSerializable()
class PiggyBankStore {
  const PiggyBankStore({
    required this.name,
    required this.accountId,
    required this.targetAmount,
    required this.currentAmount,
    required this.startDate,
    required this.targetDate,
    required this.order,
    required this.active,
    required this.notes,
    required this.objectGroupId,
    required this.objectGroupTitle,
  });
  
  factory PiggyBankStore.fromJson(Map<String, Object?> json) => _$PiggyBankStoreFromJson(json);
  
  final String name;

  /// The ID of the asset account this piggy bank is connected to.
  @JsonKey(name: 'account_id')
  final String accountId;
  @JsonKey(name: 'target_amount')
  final String? targetAmount;
  @JsonKey(name: 'current_amount')
  final String currentAmount;

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

  /// The name of the group. NULL if no group.
  @JsonKey(name: 'object_group_title')
  final String? objectGroupTitle;

  Map<String, Object?> toJson() => _$PiggyBankStoreToJson(this);
}
