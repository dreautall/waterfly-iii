// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'recurrence_transaction_store.g.dart';

@JsonSerializable()
class RecurrenceTransactionStore {
  const RecurrenceTransactionStore({
    required this.description,
    required this.amount,
    required this.foreignAmount,
    required this.currencyId,
    required this.currencyCode,
    required this.foreignCurrencyId,
    required this.foreignCurrencyCode,
    required this.budgetId,
    required this.categoryId,
    required this.sourceId,
    required this.destinationId,
    required this.tags,
    required this.piggyBankId,
    required this.billId,
  });

  factory RecurrenceTransactionStore.fromJson(Map<String, Object?> json) =>
      _$RecurrenceTransactionStoreFromJson(json);

  final String description;

  /// Amount of the transaction.
  final String amount;

  /// Foreign amount of the transaction.
  @JsonKey(name: 'foreign_amount')
  final String? foreignAmount;

  /// Submit either a currency_id or a currency_code.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Submit either a currency_id or a currency_code.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Submit either a foreign_currency_id or a foreign_currency_code, or neither.
  @JsonKey(name: 'foreign_currency_id')
  final String? foreignCurrencyId;

  /// Submit either a foreign_currency_id or a foreign_currency_code, or neither.
  @JsonKey(name: 'foreign_currency_code')
  final String? foreignCurrencyCode;

  /// The budget ID for this transaction.
  @JsonKey(name: 'budget_id')
  final String budgetId;

  /// Category ID for this transaction.
  @JsonKey(name: 'category_id')
  final String categoryId;

  /// ID of the source account.
  @JsonKey(name: 'source_id')
  final String sourceId;

  /// ID of the destination account.
  @JsonKey(name: 'destination_id')
  final String destinationId;

  /// Array of tags.
  final List<String>? tags;

  /// Optional.
  @JsonKey(name: 'piggy_bank_id')
  final String? piggyBankId;

  /// Optional.
  @JsonKey(name: 'bill_id')
  final String? billId;

  Map<String, Object?> toJson() => _$RecurrenceTransactionStoreToJson(this);
}
