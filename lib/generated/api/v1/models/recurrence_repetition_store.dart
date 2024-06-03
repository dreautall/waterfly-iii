// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'recurrence_repetition_type.dart';

part 'recurrence_repetition_store.g.dart';

@JsonSerializable()
class RecurrenceRepetitionStore {
  const RecurrenceRepetitionStore({
    required this.type,
    required this.moment,
    required this.skip,
    required this.weekend,
  });

  factory RecurrenceRepetitionStore.fromJson(Map<String, Object?> json) =>
      _$RecurrenceRepetitionStoreFromJson(json);

  final RecurrenceRepetitionType type;

  /// Information that defined the type of repetition.
  /// - For 'daily', this is empty.
  /// - For 'weekly', it is day of the week between 1 and 7 (Monday - Sunday).
  /// - For 'ndom', it is '1,2' or '4,5' or something else, where the first number is the week in the month, and the second number is the day in the week (between 1 and 7). '2,3' means: the 2nd Wednesday of the month.
  /// - For 'monthly' it is the day of the month (1 - 31).
  /// - For yearly, it is a full date, ie '2018-09-17'. The year you use does not matter.
  ///
  final String moment;

  /// How many occurrences to skip. 0 means skip nothing. 1 means every other.
  final int skip;

  /// How to respond when the recurring transaction falls in the weekend. Possible values:.
  /// 1. Do nothing, just create it.
  /// 2. Create no transaction.
  /// 3. Skip to the previous Friday.
  /// 4. Skip to the next Monday.
  ///
  final int weekend;

  Map<String, Object?> toJson() => _$RecurrenceRepetitionStoreToJson(this);
}
