// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// The type of the repetition. ndom means: the n-th weekday of the month, where you can also specify which day of the week.
@JsonEnum()
enum RecurrenceRepetitionType {
  @JsonValue('daily')
  daily('daily'),
  @JsonValue('weekly')
  weekly('weekly'),
  @JsonValue('ndom')
  ndom('ndom'),
  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('yearly')
  yearly('yearly'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RecurrenceRepetitionType(this.json);

  factory RecurrenceRepetitionType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
