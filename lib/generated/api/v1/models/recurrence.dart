// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'recurrence_repetition.dart';
import 'recurrence_transaction.dart';
import 'recurrence_transaction_type.dart';

part 'recurrence.g.dart';

@JsonSerializable()
class Recurrence {
  const Recurrence({
    this.createdAt,
    this.updatedAt,
    this.type,
    this.title,
    this.description,
    this.firstDate,
    this.latestDate,
    this.repeatUntil,
    this.nrOfRepetitions,
    this.applyRules,
    this.active,
    this.notes,
    this.repetitions,
    this.transactions,
  });

  factory Recurrence.fromJson(Map<String, Object?> json) =>
      _$RecurrenceFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final RecurrenceTransactionType? type;
  final String? title;

  /// Not to be confused with the description of the actual transaction(s) being created.
  final String? description;

  /// First time the recurring transaction will fire. Must be after today.
  @JsonKey(name: 'first_date')
  final DateTime? firstDate;

  /// Last time the recurring transaction has fired.
  @JsonKey(name: 'latest_date')
  final DateTime? latestDate;

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
  final List<RecurrenceRepetition>? repetitions;
  final List<RecurrenceTransaction>? transactions;

  Map<String, Object?> toJson() => _$RecurrenceToJson(this);
}
