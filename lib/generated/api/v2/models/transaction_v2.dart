// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_v2_split.dart';

part 'transaction_v2.g.dart';

@JsonSerializable()
class TransactionV2 {
  const TransactionV2({
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.userGroup,
    required this.groupTitle,
    required this.transactions,
  });

  factory TransactionV2.fromJson(Map<String, Object?> json) =>
      _$TransactionV2FromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// User ID
  final String user;

  /// User group ID
  @JsonKey(name: 'user_group')
  final String userGroup;

  /// Title of the transaction if it has been split in more than one piece. Empty otherwise.
  @JsonKey(name: 'group_title')
  final String? groupTitle;
  final List<TransactionV2Split> transactions;

  Map<String, Object?> toJson() => _$TransactionV2ToJson(this);
}
