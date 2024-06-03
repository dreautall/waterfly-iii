// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2_split.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2Split _$TransactionV2SplitFromJson(Map<String, dynamic> json) =>
    TransactionV2Split(
      destinationId: json['destination_id'] as String?,
      type: TransactionTypeProperty.fromJson(json['type'] as String),
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as String,
      description: json['description'] as String,
      sourceId: json['source_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      nativeAmount: json['native_amount'] as String?,
      foreignAmount: json['foreign_amount'] as String?,
      nativeForeignAmount: json['native_foreign_amount'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyName: json['native_currency_name'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      user: json['user'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          (json['foreign_currency_decimal_places'] as num?)?.toInt(),
      transactionJournalId: json['transaction_journal_id'] as String?,
      order: (json['order'] as num?)?.toInt(),
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      sourceType: json['source_type'] == null
          ? null
          : AccountTypeProperty.fromJson(json['source_type'] as String),
      userGroup: json['user_group'] as String?,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      destinationType: json['destination_type'] == null
          ? null
          : AccountTypeProperty.fromJson(json['destination_type'] as String),
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      reconciled: json['reconciled'] as bool?,
      notes: json['notes'] as String?,
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
      internalReference: json['internal_reference'] as String?,
      externalId: json['external_id'] as String?,
      externalUrl: json['external_url'] as String?,
      originalSource: json['original_source'] as String?,
      recurrenceId: json['recurrence_id'] as String?,
      recurrenceTotal: (json['recurrence_total'] as num?)?.toInt(),
      recurrenceCount: (json['recurrence_count'] as num?)?.toInt(),
      importHashV2: json['import_hash_v2'] as String?,
      sepaCc: json['sepa_cc'] as String?,
      sepaCtOp: json['sepa_ct_op'] as String?,
      sepaCtId: json['sepa_ct_id'] as String?,
      sepaDb: json['sepa_db'] as String?,
      sepaCountry: json['sepa_country'] as String?,
      sepaEp: json['sepa_ep'] as String?,
      sepaCi: json['sepa_ci'] as String?,
      sepaBatchId: json['sepa_batch_id'] as String?,
      interestDate: json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
      bookDate: json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
      processDate: json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TransactionV2SplitToJson(TransactionV2Split instance) =>
    <String, dynamic>{
      'user': instance.user,
      'user_group': instance.userGroup,
      'transaction_journal_id': instance.transactionJournalId,
      'type': _$TransactionTypePropertyEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'order': instance.order,
      'amount': instance.amount,
      'native_amount': instance.nativeAmount,
      'foreign_amount': instance.foreignAmount,
      'native_foreign_amount': instance.nativeForeignAmount,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_name': instance.currencyName,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'native_currency_id': instance.nativeCurrencyId,
      'native_currency_code': instance.nativeCurrencyCode,
      'native_currency_symbol': instance.nativeCurrencySymbol,
      'native_currency_name': instance.nativeCurrencyName,
      'native_currency_decimal_places': instance.nativeCurrencyDecimalPlaces,
      'foreign_currency_id': instance.foreignCurrencyId,
      'foreign_currency_code': instance.foreignCurrencyCode,
      'foreign_currency_symbol': instance.foreignCurrencySymbol,
      'foreign_currency_decimal_places': instance.foreignCurrencyDecimalPlaces,
      'description': instance.description,
      'source_id': instance.sourceId,
      'source_name': instance.sourceName,
      'source_iban': instance.sourceIban,
      'source_type': _$AccountTypePropertyEnumMap[instance.sourceType],
      'destination_id': instance.destinationId,
      'destination_name': instance.destinationName,
      'destination_iban': instance.destinationIban,
      'destination_type':
          _$AccountTypePropertyEnumMap[instance.destinationType],
      'budget_id': instance.budgetId,
      'budget_name': instance.budgetName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'bill_id': instance.billId,
      'bill_name': instance.billName,
      'reconciled': instance.reconciled,
      'notes': instance.notes,
      'tags': instance.tags,
      'internal_reference': instance.internalReference,
      'external_id': instance.externalId,
      'external_url': instance.externalUrl,
      'original_source': instance.originalSource,
      'recurrence_id': instance.recurrenceId,
      'recurrence_total': instance.recurrenceTotal,
      'recurrence_count': instance.recurrenceCount,
      'import_hash_v2': instance.importHashV2,
      'sepa_cc': instance.sepaCc,
      'sepa_ct_op': instance.sepaCtOp,
      'sepa_ct_id': instance.sepaCtId,
      'sepa_db': instance.sepaDb,
      'sepa_country': instance.sepaCountry,
      'sepa_ep': instance.sepaEp,
      'sepa_ci': instance.sepaCi,
      'sepa_batch_id': instance.sepaBatchId,
      'interest_date': instance.interestDate?.toIso8601String(),
      'book_date': instance.bookDate?.toIso8601String(),
      'process_date': instance.processDate?.toIso8601String(),
      'due_date': instance.dueDate?.toIso8601String(),
      'payment_date': instance.paymentDate?.toIso8601String(),
      'invoice_date': instance.invoiceDate?.toIso8601String(),
    };

const _$TransactionTypePropertyEnumMap = {
  TransactionTypeProperty.withdrawal: 'withdrawal',
  TransactionTypeProperty.deposit: 'deposit',
  TransactionTypeProperty.transfer: 'transfer',
  TransactionTypeProperty.reconciliation: 'reconciliation',
  TransactionTypeProperty.openingBalance: 'opening balance',
  TransactionTypeProperty.$unknown: r'$unknown',
};

const _$AccountTypePropertyEnumMap = {
  AccountTypeProperty.defaultAccount: 'Default account',
  AccountTypeProperty.cashAccount: 'Cash account',
  AccountTypeProperty.assetAccount: 'Asset account',
  AccountTypeProperty.expenseAccount: 'Expense account',
  AccountTypeProperty.revenueAccount: 'Revenue account',
  AccountTypeProperty.initialBalanceAccount: 'Initial balance account',
  AccountTypeProperty.beneficiaryAccount: 'Beneficiary account',
  AccountTypeProperty.importAccount: 'Import account',
  AccountTypeProperty.reconciliationAccount: 'Reconciliation account',
  AccountTypeProperty.loan: 'Loan',
  AccountTypeProperty.debt: 'Debt',
  AccountTypeProperty.mortgage: 'Mortgage',
  AccountTypeProperty.$unknown: r'$unknown',
};
