// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankEvent _$PiggyBankEventFromJson(Map<String, dynamic> json) =>
    PiggyBankEvent(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      amount: json['amount'] as String?,
      transactionJournalId: json['transaction_journal_id'] as String?,
      transactionGroupId: json['transaction_group_id'] as String?,
    );

Map<String, dynamic> _$PiggyBankEventToJson(PiggyBankEvent instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'amount': instance.amount,
      'transaction_journal_id': instance.transactionJournalId,
      'transaction_group_id': instance.transactionGroupId,
    };
