// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'recurrence_repetition_store.dart';
import 'recurrence_transaction_store.dart';
import 'recurrence_transaction_type.dart';

part 'recurrence_store.g.dart';

@JsonSerializable()
class RecurrenceStore {
  const RecurrenceStore({
    required this.type,
    required this.title,
    required this.firstDate,
    required this.repeatUntil,
    required this.repetitions,
    required this.transactions,
    this.description,
    this.nrOfRepetitions,
    this.applyRules,
    this.active,
    this.notes,
  });

  factory RecurrenceStore.fromJson(Map<String, Object?> json) =>
      _$RecurrenceStoreFromJson(json);

  final RecurrenceTransactionType type;
  final String title;

  /// Not to be confused with the description of the actual transaction(s) being created.
  final String? description;

  /// First time the recurring transaction will fire. Must be after today.
  @JsonKey(name: 'first_date')
  final DateTime firstDate;

  /// Date until the recurring transaction can fire. Use either this field or repetitions.
  @JsonKey(name: 'repeat_until')
  final DateTime? repeatUntil;

  /// Max number of created transactions. Use either this field or repeat_until.
  @JsonKey(name: 'nr_of_repetitions')
  final int? nrOfRepetitions;

  /// Whether or not to fire the rules after the creation of a transaction.
  @JsonKey(name: 'apply_rules')
  final bool? applyRules;

  /// If the recurrence is even active.
  final bool? active;
  final String? notes;
  final List<RecurrenceRepetitionStore> repetitions;
  final List<RecurrenceTransactionStore> transactions;

  Map<String, Object?> toJson() => _$RecurrenceStoreToJson(this);
}
