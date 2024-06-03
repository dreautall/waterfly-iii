// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// 'credit' indicates somebody owes you the liability. 'debit' Indicates you owe this debt yourself. Works only for liabiltiies.
@JsonEnum()
enum LiabilityDirectionProperty {
  @JsonValue('credit')
  credit('credit'),
  @JsonValue('debit')
  debit('debit'),

  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const LiabilityDirectionProperty(this.json);

  factory LiabilityDirectionProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
