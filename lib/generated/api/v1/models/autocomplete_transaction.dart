// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_transaction.g.dart';

@JsonSerializable()
class AutocompleteTransaction {
  const AutocompleteTransaction({
    required this.id,
    required this.transactionGroupId,
    required this.name,
    required this.description,
  });

  factory AutocompleteTransaction.fromJson(Map<String, Object?> json) =>
      _$AutocompleteTransactionFromJson(json);

  /// The ID of a transaction journal (basically a single split).
  final String id;

  /// The ID of the underlying transaction group.
  @JsonKey(name: 'transaction_group_id')
  final String transactionGroupId;

  /// Transaction description
  final String name;

  /// Transaction description
  final String description;

  Map<String, Object?> toJson() => _$AutocompleteTransactionToJson(this);
}
