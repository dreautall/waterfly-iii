// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_dates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidDates _$PaidDatesFromJson(Map<String, dynamic> json) => PaidDates(
      transactionGroupId: json['transaction_group_id'] as String,
      transactionJournalId: json['transaction_journal_id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$PaidDatesToJson(PaidDates instance) => <String, dynamic>{
      'transaction_group_id': instance.transactionGroupId,
      'transaction_journal_id': instance.transactionJournalId,
      'date': instance.date.toIso8601String(),
    };
