// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cron_result_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CronResultRow _$CronResultRowFromJson(Map<String, dynamic> json) =>
    CronResultRow(
      jobFired: json['job_fired'] as bool?,
      jobSucceeded: json['job_succeeded'] as bool?,
      jobErrored: json['job_errored'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CronResultRowToJson(CronResultRow instance) =>
    <String, dynamic>{
      'job_fired': instance.jobFired,
      'job_succeeded': instance.jobSucceeded,
      'job_errored': instance.jobErrored,
      'message': instance.message,
    };
