// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_type_property.dart';

part 'transaction_split_update.g.dart';

@JsonSerializable()
class TransactionSplitUpdate {
  const TransactionSplitUpdate({
    required this.budgetId,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    required this.order,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyDecimalPlaces,
    required this.foreignAmount,
    required this.foreignCurrencyId,
    required this.foreignCurrencyCode,
    required this.foreignCurrencySymbol,
    required this.foreignCurrencyDecimalPlaces,
    required this.transactionJournalId,
    required this.budgetName,
    required this.categoryId,
    required this.categoryName,
    required this.sourceId,
    required this.sourceName,
    required this.sourceIban,
    required this.destinationId,
    required this.destinationName,
    required this.destinationIban,
    required this.reconciled,
    required this.billId,
    required this.billName,
    required this.tags,
    required this.notes,
    required this.internalReference,
    required this.invoiceDate,
    required this.externalUrl,
    required this.bunqPaymentId,
    required this.sepaCc,
    required this.sepaCtOp,
    required this.sepaCtId,
    required this.sepaDb,
    required this.sepaCountry,
    required this.sepaEp,
    required this.sepaCi,
    required this.sepaBatchId,
    required this.interestDate,
    required this.bookDate,
    required this.processDate,
    required this.dueDate,
    required this.paymentDate,
    required this.externalId,
  });

  factory TransactionSplitUpdate.fromJson(Map<String, Object?> json) =>
      _$TransactionSplitUpdateFromJson(json);

  /// Transaction journal ID of current transaction (split).
  @JsonKey(name: 'transaction_journal_id')
  final String transactionJournalId;
  final TransactionTypeProperty type;

  /// Date of the transaction
  final DateTime date;

  /// Amount of the transaction.
  final String amount;

  /// Description of the transaction.
  final String description;

  /// Order of this entry in the list of transactions.
  final int? order;

  /// Currency ID. Default is the source account's currency, or the user's default currency. Can be used instead of currency_code.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// Currency code. Default is the source account's currency, or the user's default currency. Can be used instead of currency_id.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @JsonKey(name: 'currency_name')
  final String currencyName;

  /// Number of decimals used in this currency.
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// The amount in a foreign currency.
  @JsonKey(name: 'foreign_amount')
  final String? foreignAmount;

  /// Currency ID of the foreign currency. Default is null. Is required when you submit a foreign amount.
  @JsonKey(name: 'foreign_currency_id')
  final String? foreignCurrencyId;

  /// Currency code of the foreign currency. Default is NULL. Can be used instead of the foreign_currency_id, but this or the ID is required when submitting a foreign amount.
  @JsonKey(name: 'foreign_currency_code')
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol')
  final String? foreignCurrencySymbol;

  /// Number of decimals in the currency
  @JsonKey(name: 'foreign_currency_decimal_places')
  final int? foreignCurrencyDecimalPlaces;

  /// The budget ID for this transaction.
  @JsonKey(name: 'budget_id')
  final String? budgetId;

  /// The name of the budget to be used. If the budget name is unknown, the ID will be used or the value will be ignored.
  @JsonKey(name: 'budget_name')
  final String? budgetName;

  /// The category ID for this transaction.
  @JsonKey(name: 'category_id')
  final String? categoryId;

  /// The name of the category to be used. If the category is unknown, it will be created. If the ID and the name point to different categories, the ID overrules the name.
  @JsonKey(name: 'category_name')
  final String? categoryName;

  /// ID of the source account. For a withdrawal or a transfer, this must always be an asset account. For deposits, this must be a revenue account.
  @JsonKey(name: 'source_id')
  final String? sourceId;

  /// Name of the source account. For a withdrawal or a transfer, this must always be an asset account. For deposits, this must be a revenue account. Can be used instead of the source_id. If the transaction is a deposit, the source_name can be filled in freely: the account will be created based on the name.
  @JsonKey(name: 'source_name')
  final String? sourceName;
  @JsonKey(name: 'source_iban')
  final String? sourceIban;

  /// ID of the destination account. For a deposit or a transfer, this must always be an asset account. For withdrawals this must be an expense account.
  @JsonKey(name: 'destination_id')
  final String? destinationId;

  /// Name of the destination account. You can submit the name instead of the ID. For everything except transfers, the account will be auto-generated if unknown, so submitting a name is enough.
  @JsonKey(name: 'destination_name')
  final String? destinationName;
  @JsonKey(name: 'destination_iban')
  final String? destinationIban;

  /// If the transaction has been reconciled already. When you set this, the amount can no longer be edited by the user.
  final bool reconciled;

  /// Optional. Use either this or the bill_name
  @JsonKey(name: 'bill_id')
  final String? billId;

  /// Optional. Use either this or the bill_id
  @JsonKey(name: 'bill_name')
  final String? billName;

  /// Array of tags.
  final List<String>? tags;
  final String? notes;

  /// Reference to internal reference of other systems.
  @JsonKey(name: 'internal_reference')
  final String? internalReference;

  /// Reference to external ID in other systems.
  @JsonKey(name: 'external_id')
  final String? externalId;

  /// External, custom URL for this transaction.
  @JsonKey(name: 'external_url')
  final String? externalUrl;

  /// Internal ID of bunq transaction.
  @JsonKey(name: 'bunq_payment_id')
  final String? bunqPaymentId;

  /// SEPA Clearing Code
  @JsonKey(name: 'sepa_cc')
  final String? sepaCc;

  /// SEPA Opposing Account Identifier
  @JsonKey(name: 'sepa_ct_op')
  final String? sepaCtOp;

  /// SEPA end-to-end Identifier
  @JsonKey(name: 'sepa_ct_id')
  final String? sepaCtId;

  /// SEPA mandate identifier
  @JsonKey(name: 'sepa_db')
  final String? sepaDb;

  /// SEPA Country
  @JsonKey(name: 'sepa_country')
  final String? sepaCountry;

  /// SEPA External Purpose indicator
  @JsonKey(name: 'sepa_ep')
  final String? sepaEp;

  /// SEPA Creditor Identifier
  @JsonKey(name: 'sepa_ci')
  final String? sepaCi;

  /// SEPA Batch ID
  @JsonKey(name: 'sepa_batch_id')
  final String? sepaBatchId;
  @JsonKey(name: 'interest_date')
  final DateTime? interestDate;
  @JsonKey(name: 'book_date')
  final DateTime? bookDate;
  @JsonKey(name: 'process_date')
  final DateTime? processDate;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'payment_date')
  final DateTime? paymentDate;
  @JsonKey(name: 'invoice_date')
  final DateTime? invoiceDate;

  Map<String, Object?> toJson() => _$TransactionSplitUpdateToJson(this);
}
