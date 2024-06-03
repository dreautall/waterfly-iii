// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// How often the bill must be paid.
@JsonEnum()
enum BillRepeatFrequency {
  @JsonValue('weekly')
  weekly('weekly'),
  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('quarterly')
  quarterly('quarterly'),
  @JsonValue('half-year')
  halfYear('half-year'),
  @JsonValue('yearly')
  yearly('yearly'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const BillRepeatFrequency(this.json);

  factory BillRepeatFrequency.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
