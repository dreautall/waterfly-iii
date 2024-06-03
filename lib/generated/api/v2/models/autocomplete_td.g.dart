// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_td.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteTD _$AutocompleteTDFromJson(Map<String, dynamic> json) =>
    AutocompleteTD(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      transactionJournalId: json['transaction_journal_id'] as String?,
    );

Map<String, dynamic> _$AutocompleteTDToJson(AutocompleteTD instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_journal_id': instance.transactionJournalId,
      'name': instance.name,
      'description': instance.description,
    };
