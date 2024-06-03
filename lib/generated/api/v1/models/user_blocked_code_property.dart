// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// If you say the user must be blocked, this will be the reason code.
@JsonEnum()
enum UserBlockedCodeProperty {
  @JsonValue('email_changed')
  emailChanged('email_changed'),

  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const UserBlockedCodeProperty(this.json);

  factory UserBlockedCodeProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
