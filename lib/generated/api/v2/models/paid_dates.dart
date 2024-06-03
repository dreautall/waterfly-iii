// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'paid_dates.g.dart';

@JsonSerializable()
class PaidDates {
  const PaidDates({
    this.transactionGroupId,
    this.transactionJournalId,
    this.date,
  });

  factory PaidDates.fromJson(Map<String, Object?> json) =>
      _$PaidDatesFromJson(json);

  /// Transaction group ID of the paid bill.
  @JsonKey(name: 'transaction_group_id')
  final String? transactionGroupId;

  /// Transaction journal ID of the paid bill.
  @JsonKey(name: 'transaction_journal_id')
  final String? transactionJournalId;

  /// Date the bill was paid.
  final DateTime? date;

  Map<String, Object?> toJson() => _$PaidDatesToJson(this);
}
