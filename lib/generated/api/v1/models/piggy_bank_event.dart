// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'piggy_bank_event.g.dart';

@JsonSerializable()
class PiggyBankEvent {
  const PiggyBankEvent({
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.amount,
    required this.transactionJournalId,
    required this.transactionGroupId,
  });

  factory PiggyBankEvent.fromJson(Map<String, Object?> json) =>
      _$PiggyBankEventFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;
  final String amount;

  /// The journal associated with the event.
  @JsonKey(name: 'transaction_journal_id')
  final String? transactionJournalId;

  /// The transaction group associated with the event.
  @JsonKey(name: 'transaction_group_id')
  final String? transactionGroupId;

  Map<String, Object?> toJson() => _$PiggyBankEventToJson(this);
}
