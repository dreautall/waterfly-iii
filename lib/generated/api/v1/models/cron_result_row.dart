// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'cron_result_row.g.dart';

@JsonSerializable()
class CronResultRow {
  const CronResultRow({
    required this.jobFired,
    required this.jobSucceeded,
    required this.jobErrored,
    required this.message,
  });

  factory CronResultRow.fromJson(Map<String, Object?> json) =>
      _$CronResultRowFromJson(json);

  /// This value tells you if this specific cron job actually fired. It may not fire. Some cron jobs.
  /// only fire every 24 hours, for example.
  ///
  @JsonKey(name: 'job_fired')
  final bool? jobFired;

  /// This value tells you if this specific cron job actually did something. The job may fire but not.
  /// change anything.
  ///
  @JsonKey(name: 'job_succeeded')
  final bool? jobSucceeded;

  /// If the cron job ran into some kind of an error, this value will be true.
  @JsonKey(name: 'job_errored')
  final bool? jobErrored;

  /// If the cron job ran into some kind of an error, this value will be the error message. The success message.
  /// if the job actually ran OK.
  ///
  final String? message;

  Map<String, Object?> toJson() => _$CronResultRowToJson(this);
}
