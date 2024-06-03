// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PeriodProperty {
  @JsonValue('1D')
  value1D('1D'),
  @JsonValue('1W')
  value1W('1W'),
  @JsonValue('1M')
  value1M('1M'),
  @JsonValue('3M')
  value3M('3M'),
  @JsonValue('6M')
  value6M('6M'),
  @JsonValue('1Y')
  value1Y('1Y'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const PeriodProperty(this.json);

  factory PeriodProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
