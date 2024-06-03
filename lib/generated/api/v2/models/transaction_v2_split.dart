// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'account_type_property.dart';
import 'transaction_type_property.dart';

part 'transaction_v2_split.g.dart';

@JsonSerializable()
class TransactionV2Split {
  const TransactionV2Split({
    required this.destinationId,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    required this.sourceId,
    this.foreignCurrencyCode,
    this.nativeAmount,
    this.foreignAmount,
    this.nativeForeignAmount,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyName,
    this.nativeCurrencyDecimalPlaces,
    this.foreignCurrencyId,
    this.user,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    this.transactionJournalId,
    this.order,
    this.sourceName,
    this.sourceIban,
    this.sourceType,
    this.userGroup,
    this.destinationName,
    this.destinationIban,
    this.destinationType,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.billId,
    this.billName,
    this.reconciled,
    this.notes,
    this.invoiceDate,
    this.internalReference,
    this.externalId,
    this.externalUrl,
    this.originalSource,
    this.recurrenceId,
    this.recurrenceTotal,
    this.recurrenceCount,
    this.importHashV2,
    this.sepaCc,
    this.sepaCtOp,
    this.sepaCtId,
    this.sepaDb,
    this.sepaCountry,
    this.sepaEp,
    this.sepaCi,
    this.sepaBatchId,
    this.interestDate,
    this.bookDate,
    this.processDate,
    this.dueDate,
    this.paymentDate,
    this.tags,
  });

  factory TransactionV2Split.fromJson(Map<String, Object?> json) =>
      _$TransactionV2SplitFromJson(json);

  /// User ID
  final String? user;

  /// User group ID
  @JsonKey(name: 'user_group')
  final String? userGroup;

  /// ID of the underlying transaction journal. Each transaction consists of a transaction group (see the top ID) and one or more journals.
  /// making up the splits of the transaction.
  ///
  @JsonKey(name: 'transaction_journal_id')
  final String? transactionJournalId;
  final TransactionTypeProperty type;

  /// Date of the transaction
  final DateTime date;

  /// Order of this entry in the list of transactions.
  final int? order;

  /// Amount of the transaction.
  final String amount;

  /// Amount of the transaction in the user's native currency.
  @JsonKey(name: 'native_amount')
  final String? nativeAmount;

  /// The amount in a foreign currency.
  @JsonKey(name: 'foreign_amount')
  final String? foreignAmount;

  /// The amount in a foreign currency, in the user's native currency
  @JsonKey(name: 'native_foreign_amount')
  final String? nativeForeignAmount;

  /// Currency ID. Default is the source account's currency, or the user's default currency. Can be used instead of currency_code.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// Currency code. Default is the source account's currency, or the user's default currency. Can be used instead of currency_id.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;
  @JsonKey(name: 'currency_name')
  final String? currencyName;

  /// Number of decimals used in this currency.
  @JsonKey(name: 'currency_decimal_places')
  final int? currencyDecimalPlaces;

  /// Currency ID of the user's native currency.
  @JsonKey(name: 'native_currency_id')
  final String? nativeCurrencyId;

  /// Currency code of the user's native currency.
  @JsonKey(name: 'native_currency_code')
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol')
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_name')
  final String? nativeCurrencyName;

  /// Number of decimals used in this currency.
  @JsonKey(name: 'native_currency_decimal_places')
  final int? nativeCurrencyDecimalPlaces;

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

  /// Description of the transaction.
  final String description;

  /// ID of the source account. For a withdrawal or a transfer, this must always be an asset account. For deposits, this must be a revenue account.
  @JsonKey(name: 'source_id')
  final String? sourceId;

  /// Name of the source account. For a withdrawal or a transfer, this must always be an asset account. For deposits, this must be a revenue account. Can be used instead of the source_id. If the transaction is a deposit, the source_name can be filled in freely: the account will be created based on the name.
  @JsonKey(name: 'source_name')
  final String? sourceName;
  @JsonKey(name: 'source_iban')
  final String? sourceIban;
  @JsonKey(name: 'source_type')
  final AccountTypeProperty? sourceType;

  /// ID of the destination account. For a deposit or a transfer, this must always be an asset account. For withdrawals this must be an expense account.
  @JsonKey(name: 'destination_id')
  final String? destinationId;

  /// Name of the destination account. You can submit the name instead of the ID. For everything except transfers, the account will be auto-generated if unknown, so submitting a name is enough.
  @JsonKey(name: 'destination_name')
  final String? destinationName;
  @JsonKey(name: 'destination_iban')
  final String? destinationIban;
  @JsonKey(name: 'destination_type')
  final AccountTypeProperty? destinationType;

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

  /// Optional. Use either this or the bill_name
  @JsonKey(name: 'bill_id')
  final String? billId;

  /// Optional. Use either this or the bill_id
  @JsonKey(name: 'bill_name')
  final String? billName;

  /// If the transaction has been reconciled already. When you set this, the amount can no longer be edited by the user.
  final bool? reconciled;
  final String? notes;

  /// Array of tags.
  final List<String>? tags;

  /// Reference to internal reference of other systems.
  @JsonKey(name: 'internal_reference')
  final String? internalReference;

  /// Reference to external ID in other systems.
  @JsonKey(name: 'external_id')
  final String? externalId;

  /// External, custom URL for this transaction.
  @JsonKey(name: 'external_url')
  final String? externalUrl;

  /// System generated identifier for original creator of transaction.
  @JsonKey(name: 'original_source')
  final String? originalSource;

  /// Reference to recurrence that made the transaction.
  @JsonKey(name: 'recurrence_id')
  final String? recurrenceId;

  /// Total number of transactions expected to be created by this recurrence repetition. Will be 0 if infinite.
  @JsonKey(name: 'recurrence_total')
  final int? recurrenceTotal;

  /// The # of the current transaction created under this recurrence.
  @JsonKey(name: 'recurrence_count')
  final int? recurrenceCount;

  /// Hash value of original import transaction (for duplicate detection).
  @JsonKey(name: 'import_hash_v2')
  final String? importHashV2;

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

  Map<String, Object?> toJson() => _$TransactionV2SplitToJson(this);
}
