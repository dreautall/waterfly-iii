// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_split.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  const Transaction({
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.groupTitle,
    required this.transactions,
  });
  
  factory Transaction.fromJson(Map<String, Object?> json) => _$TransactionFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// User ID
  final String user;

  /// Title of the transaction if it has been split in more than one piece. Empty otherwise.
  @JsonKey(name: 'group_title')
  final String? groupTitle;
  final List<TransactionSplit> transactions;

  Map<String, Object?> toJson() => _$TransactionToJson(this);
}
