// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// The type of auto-budget that Firefly III must create.
@JsonEnum()
enum AutoBudgetType {
  @JsonValue('reset')
  reset('reset'),
  @JsonValue('rollover')
  rollover('rollover'),
  @JsonValue('none')
  none('none'),

  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const AutoBudgetType(this.json);

  factory AutoBudgetType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
