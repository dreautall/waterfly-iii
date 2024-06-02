// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceStore _$RecurrenceStoreFromJson(Map<String, dynamic> json) =>
    RecurrenceStore(
      type: RecurrenceTransactionType.fromJson(json['type'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      firstDate: DateTime.parse(json['first_date'] as String),
      repeatUntil: json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
      nrOfRepetitions: (json['nr_of_repetitions'] as num?)?.toInt(),
      applyRules: json['apply_rules'] as bool,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      repetitions: (json['repetitions'] as List<dynamic>)
          .map((e) =>
              RecurrenceRepetitionStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) =>
              RecurrenceTransactionStore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecurrenceStoreToJson(RecurrenceStore instance) =>
    <String, dynamic>{
      'type': _$RecurrenceTransactionTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'first_date': instance.firstDate.toIso8601String(),
      'repeat_until': instance.repeatUntil?.toIso8601String(),
      'nr_of_repetitions': instance.nrOfRepetitions,
      'apply_rules': instance.applyRules,
      'active': instance.active,
      'notes': instance.notes,
      'repetitions': instance.repetitions,
      'transactions': instance.transactions,
    };

const _$RecurrenceTransactionTypeEnumMap = {
  RecurrenceTransactionType.withdrawal: 'withdrawal',
  RecurrenceTransactionType.transfer: 'transfer',
  RecurrenceTransactionType.deposit: 'deposit',
  RecurrenceTransactionType.$unknown: r'$unknown',
};
