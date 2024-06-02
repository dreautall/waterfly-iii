// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_split_store.dart';

part 'transaction_store.g.dart';

@JsonSerializable()
class TransactionStore {
  const TransactionStore({
    required this.errorIfDuplicateHash,
    required this.applyRules,
    required this.groupTitle,
    required this.transactions,
    this.fireWebhooks = true,
  });
  
  factory TransactionStore.fromJson(Map<String, Object?> json) => _$TransactionStoreFromJson(json);
  
  /// Break if the submitted transaction exists already.
  @JsonKey(name: 'error_if_duplicate_hash')
  final bool errorIfDuplicateHash;

  /// Whether or not to apply rules when submitting transaction.
  @JsonKey(name: 'apply_rules')
  final bool applyRules;

  /// Whether or not to fire the webhooks that are related to this event.
  @JsonKey(name: 'fire_webhooks')
  final bool fireWebhooks;

  /// Title of the transaction if it has been split in more than one piece. Empty otherwise.
  @JsonKey(name: 'group_title')
  final String? groupTitle;
  final List<TransactionSplitStore> transactions;

  Map<String, Object?> toJson() => _$TransactionStoreToJson(this);
}
