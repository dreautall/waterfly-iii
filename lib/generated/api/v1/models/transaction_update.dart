// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_split_update.dart';

part 'transaction_update.g.dart';

@JsonSerializable()
class TransactionUpdate {
  const TransactionUpdate({
    required this.applyRules,
    required this.groupTitle,
    required this.transactions,
    this.fireWebhooks = true,
  });

  factory TransactionUpdate.fromJson(Map<String, Object?> json) =>
      _$TransactionUpdateFromJson(json);

  /// Whether or not to apply rules when submitting transaction.
  @JsonKey(name: 'apply_rules')
  final bool applyRules;

  /// Whether or not to fire the webhooks that are related to this event.
  @JsonKey(name: 'fire_webhooks')
  final bool fireWebhooks;

  /// Title of the transaction if it has been split in more than one piece. Empty otherwise.
  @JsonKey(name: 'group_title')
  final String? groupTitle;
  final List<TransactionSplitUpdate> transactions;

  Map<String, Object?> toJson() => _$TransactionUpdateToJson(this);
}
