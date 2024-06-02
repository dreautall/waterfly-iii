// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_split_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSplitUpdate _$TransactionSplitUpdateFromJson(
        Map<String, dynamic> json) =>
    TransactionSplitUpdate(
      budgetId: json['budget_id'] as String?,
      type: TransactionTypeProperty.fromJson(json['type'] as String),
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as String,
      description: json['description'] as String,
      order: (json['order'] as num?)?.toInt(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      foreignAmount: json['foreign_amount'] as String?,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          (json['foreign_currency_decimal_places'] as num?)?.toInt(),
      transactionJournalId: json['transaction_journal_id'] as String,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      sourceId: json['source_id'] as String?,
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      destinationId: json['destination_id'] as String?,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      reconciled: json['reconciled'] as bool,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      internalReference: json['internal_reference'] as String?,
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
      externalUrl: json['external_url'] as String?,
      bunqPaymentId: json['bunq_payment_id'] as String?,
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
      externalId: json['external_id'] as String?,
    );

Map<String, dynamic> _$TransactionSplitUpdateToJson(
        TransactionSplitUpdate instance) =>
    <String, dynamic>{
      'transaction_journal_id': instance.transactionJournalId,
      'type': _$TransactionTypePropertyEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
      'order': instance.order,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_name': instance.currencyName,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'foreign_amount': instance.foreignAmount,
      'foreign_currency_id': instance.foreignCurrencyId,
      'foreign_currency_code': instance.foreignCurrencyCode,
      'foreign_currency_symbol': instance.foreignCurrencySymbol,
      'foreign_currency_decimal_places': instance.foreignCurrencyDecimalPlaces,
      'budget_id': instance.budgetId,
      'budget_name': instance.budgetName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'source_id': instance.sourceId,
      'source_name': instance.sourceName,
      'source_iban': instance.sourceIban,
      'destination_id': instance.destinationId,
      'destination_name': instance.destinationName,
      'destination_iban': instance.destinationIban,
      'reconciled': instance.reconciled,
      'bill_id': instance.billId,
      'bill_name': instance.billName,
      'tags': instance.tags,
      'notes': instance.notes,
      'internal_reference': instance.internalReference,
      'external_id': instance.externalId,
      'external_url': instance.externalUrl,
      'bunq_payment_id': instance.bunqPaymentId,
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
