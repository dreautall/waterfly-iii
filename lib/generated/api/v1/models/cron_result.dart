// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'cron_result_row.dart';

part 'cron_result.g.dart';

@JsonSerializable()
class CronResult {
  const CronResult({
    required this.recurringTransactions,
    required this.autoBudgets,
    required this.telemetry,
  });

  factory CronResult.fromJson(Map<String, Object?> json) =>
      _$CronResultFromJson(json);

  @JsonKey(name: 'recurring_transactions')
  final CronResultRow recurringTransactions;
  @JsonKey(name: 'auto_budgets')
  final CronResultRow autoBudgets;
  final CronResultRow telemetry;

  Map<String, Object?> toJson() => _$CronResultToJson(this);
}
