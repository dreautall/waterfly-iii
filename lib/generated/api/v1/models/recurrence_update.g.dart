// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceUpdate _$RecurrenceUpdateFromJson(Map<String, dynamic> json) =>
    RecurrenceUpdate(
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
              RecurrenceRepetitionUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) =>
              RecurrenceTransactionUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecurrenceUpdateToJson(RecurrenceUpdate instance) =>
    <String, dynamic>{
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
