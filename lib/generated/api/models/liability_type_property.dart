// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Mandatory when type is liability. Specifies the exact type.
@JsonEnum()
enum LiabilityTypeProperty {
  @JsonValue('loan')
  loan('loan'),
  @JsonValue('debt')
  debt('debt'),
  @JsonValue('mortgage')
  mortgage('mortgage'),
  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const LiabilityTypeProperty(this.json);

  factory LiabilityTypeProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
