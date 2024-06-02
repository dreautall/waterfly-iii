// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'recurrence_repetition_update.dart';
import 'recurrence_transaction_update.dart';

part 'recurrence_update.g.dart';

@JsonSerializable()
class RecurrenceUpdate {
  const RecurrenceUpdate({
    required this.title,
    required this.description,
    required this.firstDate,
    required this.repeatUntil,
    required this.nrOfRepetitions,
    required this.applyRules,
    required this.active,
    required this.notes,
    required this.repetitions,
    required this.transactions,
  });
  
  factory RecurrenceUpdate.fromJson(Map<String, Object?> json) => _$RecurrenceUpdateFromJson(json);
  
  final String title;

  /// Not to be confused with the description of the actual transaction(s) being created.
  final String description;

  /// First time the recurring transaction will fire.
  @JsonKey(name: 'first_date')
  final DateTime firstDate;

  /// Date until the recurring transaction can fire. After that date, it's basically inactive. Use either this field or repetitions.
  @JsonKey(name: 'repeat_until')
  final DateTime? repeatUntil;

  /// Max number of created transactions. Use either this field or repeat_until.
  @JsonKey(name: 'nr_of_repetitions')
  final int? nrOfRepetitions;

  /// Whether or not to fire the rules after the creation of a transaction.
  @JsonKey(name: 'apply_rules')
  final bool applyRules;

  /// If the recurrence is even active.
  final bool active;
  final String? notes;
  final List<RecurrenceRepetitionUpdate> repetitions;
  final List<RecurrenceTransactionUpdate> transactions;

  Map<String, Object?> toJson() => _$RecurrenceUpdateToJson(this);
}
