// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Mandatory when type is liability. Period over which the interest is calculated.
@JsonEnum()
enum InterestPeriodProperty {
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
  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const InterestPeriodProperty(this.json);

  factory InterestPeriodProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
