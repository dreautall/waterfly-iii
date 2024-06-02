// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_type_property.dart';

part 'transaction_v2_split_store.g.dart';

@JsonSerializable()
class TransactionV2SplitStore {
  const TransactionV2SplitStore({
    required this.sourceId,
    required this.date,
    required this.amount,
    required this.description,
    required this.order,
    required this.currencyId,
    required this.currencyCode,
    required this.foreignAmount,
    required this.foreignCurrencyId,
    required this.foreignCurrencyCode,
    required this.budgetId,
    required this.budgetName,
    required this.categoryId,
    required this.categoryName,
    required this.type,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.reconciled,
    required this.piggyBankId,
    required this.piggyBankName,
    required this.billId,
    required this.billName,
    required this.tags,
    required this.notes,
    required this.internalReference,
    required this.externalId,
    required this.externalUrl,
    required this.invoiceDate,
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
    required this.bunqPaymentId,
  });
  
  factory TransactionV2SplitStore.fromJson(Map<String, Object?> json) => _$TransactionV2SplitStoreFromJson(json);
  
  final TransactionTypeProperty type;

  /// Date of the transaction
  final DateTime date;

  /// Amount of the transaction.
  final String amount;

  /// Description of the transaction.
  final String description;

  /// Order of this entry in the list of transactions.
  final int? order;

  /// Currency ID. Default is the source account's currency, or the user's default currency. The value you submit may be overruled by the source or destination account.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// Currency code. Default is the source account's currency, or the user's default currency. The value you submit may be overruled by the source or destination account.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  /// The amount in a foreign currency.
  @JsonKey(name: 'foreign_amount')
  final String? foreignAmount;

  /// Currency ID of the foreign currency. Default is null. Is required when you submit a foreign amount.
  @JsonKey(name: 'foreign_currency_id')
  final String? foreignCurrencyId;

  /// Currency code of the foreign currency. Default is NULL. Can be used instead of the foreign_currency_id, but this or the ID is required when submitting a foreign amount.
  @JsonKey(name: 'foreign_currency_code')
  final String? foreignCurrencyCode;

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

  /// ID of the destination account. For a deposit or a transfer, this must always be an asset account. For withdrawals this must be an expense account.
  @JsonKey(name: 'destination_id')
  final String? destinationId;

  /// Name of the destination account. You can submit the name instead of the ID. For everything except transfers, the account will be auto-generated if unknown, so submitting a name is enough.
  @JsonKey(name: 'destination_name')
  final String? destinationName;

  /// If the transaction has been reconciled already. When you set this, the amount can no longer be edited by the user.
  final bool reconciled;

  /// Optional. Use either this or the piggy_bank_name
  @JsonKey(name: 'piggy_bank_id')
  final int? piggyBankId;

  /// Optional. Use either this or the piggy_bank_id
  @JsonKey(name: 'piggy_bank_name')
  final String? piggyBankName;

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

  /// Internal ID of bunq transaction. Field is no longer used but still works.
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

  Map<String, Object?> toJson() => _$TransactionV2SplitStoreToJson(this);
}
