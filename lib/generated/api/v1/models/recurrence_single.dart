// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'recurrence_read.dart';

part 'recurrence_single.g.dart';

@JsonSerializable()
class RecurrenceSingle {
  const RecurrenceSingle({
    required this.data,
  });

  factory RecurrenceSingle.fromJson(Map<String, Object?> json) =>
      _$RecurrenceSingleFromJson(json);

  final RecurrenceRead data;

  Map<String, Object?> toJson() => _$RecurrenceSingleToJson(this);
}
