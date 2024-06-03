// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TransactionTypeFilter {
  @JsonValue('all')
  all('all'),
  @JsonValue('withdrawal')
  withdrawal('withdrawal'),
  @JsonValue('withdrawals')
  withdrawals('withdrawals'),
  @JsonValue('expense')
  expense('expense'),
  @JsonValue('deposit')
  deposit('deposit'),
  @JsonValue('deposits')
  deposits('deposits'),
  @JsonValue('income')
  income('income'),
  @JsonValue('transfer')
  transfer('transfer'),
  @JsonValue('transfers')
  transfers('transfers'),
  @JsonValue('opening_balance')
  openingBalance('opening_balance'),
  @JsonValue('reconciliation')
  reconciliation('reconciliation'),
  @JsonValue('special')
  special('special'),
  @JsonValue('specials')
  specials('specials'),

  /// The name has been replaced because it contains a keyword. Original name: `default`.
  @JsonValue('default')
  valueDefault('default'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const TransactionTypeFilter(this.json);

  factory TransactionTypeFilter.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
