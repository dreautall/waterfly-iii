// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cron_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CronResult _$CronResultFromJson(Map<String, dynamic> json) => CronResult(
      recurringTransactions: CronResultRow.fromJson(
          json['recurring_transactions'] as Map<String, dynamic>),
      autoBudgets:
          CronResultRow.fromJson(json['auto_budgets'] as Map<String, dynamic>),
      telemetry:
          CronResultRow.fromJson(json['telemetry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CronResultToJson(CronResult instance) =>
    <String, dynamic>{
      'recurring_transactions': instance.recurringTransactions,
      'auto_budgets': instance.autoBudgets,
      'telemetry': instance.telemetry,
    };
