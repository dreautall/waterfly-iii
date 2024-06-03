// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_type_property.dart';

part 'recurrence_transaction.g.dart';

@JsonSerializable()
class RecurrenceTransaction {
  const RecurrenceTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.foreignAmount,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.foreignCurrencyId,
    required this.foreignCurrencyCode,
    required this.foreignCurrencySymbol,
    required this.foreignCurrencyDecimalPlaces,
    required this.budgetId,
    required this.budgetName,
    required this.categoryId,
    required this.categoryName,
    required this.sourceId,
    required this.sourceName,
    required this.sourceIban,
    required this.sourceType,
    required this.destinationId,
    required this.destinationName,
    required this.destinationIban,
    required this.destinationType,
    required this.tags,
    required this.piggyBankId,
    required this.piggyBankName,
    required this.billId,
    required this.billName,
  });

  factory RecurrenceTransaction.fromJson(Map<String, Object?> json) =>
      _$RecurrenceTransactionFromJson(json);

  final String id;
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
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals in the currency
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// Submit either a foreign_currency_id or a foreign_currency_code, or neither.
  @JsonKey(name: 'foreign_currency_id')
  final String? foreignCurrencyId;

  /// Submit either a foreign_currency_id or a foreign_currency_code, or neither.
  @JsonKey(name: 'foreign_currency_code')
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol')
  final String? foreignCurrencySymbol;

  /// Number of decimals in the currency
  @JsonKey(name: 'foreign_currency_decimal_places')
  final int? foreignCurrencyDecimalPlaces;

  /// The budget ID for this transaction.
  @JsonKey(name: 'budget_id')
  final String budgetId;

  /// The name of the budget to be used. If the budget name is unknown, the ID will be used or the value will be ignored.
  @JsonKey(name: 'budget_name')
  final String? budgetName;

  /// Category ID for this transaction.
  @JsonKey(name: 'category_id')
  final String categoryId;

  /// Category name for this transaction.
  @JsonKey(name: 'category_name')
  final String categoryName;

  /// ID of the source account. Submit either this or source_name.
  @JsonKey(name: 'source_id')
  final String sourceId;

  /// Name of the source account. Submit either this or source_id.
  @JsonKey(name: 'source_name')
  final String sourceName;
  @JsonKey(name: 'source_iban')
  final String? sourceIban;
  @JsonKey(name: 'source_type')
  final AccountTypeProperty sourceType;

  /// ID of the destination account. Submit either this or destination_name.
  @JsonKey(name: 'destination_id')
  final String destinationId;

  /// Name of the destination account. Submit either this or destination_id.
  @JsonKey(name: 'destination_name')
  final String destinationName;
  @JsonKey(name: 'destination_iban')
  final String? destinationIban;
  @JsonKey(name: 'destination_type')
  final AccountTypeProperty destinationType;

  /// Array of tags.
  final List<String>? tags;

  /// Optional. Use either this or the piggy_bank_name
  @JsonKey(name: 'piggy_bank_id')
  final String? piggyBankId;

  /// Optional. Use either this or the piggy_bank_id
  @JsonKey(name: 'piggy_bank_name')
  final String? piggyBankName;

  /// Optional. Use either this or the bill_name
  @JsonKey(name: 'bill_id')
  final String? billId;

  /// Optional. Use either this or the bill_id
  @JsonKey(name: 'bill_name')
  final String? billName;

  Map<String, Object?> toJson() => _$RecurrenceTransactionToJson(this);
}
