// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_transaction_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceTransactionStore _$RecurrenceTransactionStoreFromJson(
        Map<String, dynamic> json) =>
    RecurrenceTransactionStore(
      description: json['description'] as String,
      amount: json['amount'] as String,
      sourceId: json['source_id'] as String,
      destinationId: json['destination_id'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      budgetId: json['budget_id'] as String?,
      categoryId: json['category_id'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      piggyBankId: json['piggy_bank_id'] as String?,
      billId: json['bill_id'] as String?,
    );

Map<String, dynamic> _$RecurrenceTransactionStoreToJson(
        RecurrenceTransactionStore instance) =>
    <String, dynamic>{
      'description': instance.description,
      'amount': instance.amount,
      'foreign_amount': instance.foreignAmount,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'foreign_currency_id': instance.foreignCurrencyId,
      'foreign_currency_code': instance.foreignCurrencyCode,
      'budget_id': instance.budgetId,
      'category_id': instance.categoryId,
      'source_id': instance.sourceId,
      'destination_id': instance.destinationId,
      'tags': instance.tags,
      'piggy_bank_id': instance.piggyBankId,
      'bill_id': instance.billId,
    };
