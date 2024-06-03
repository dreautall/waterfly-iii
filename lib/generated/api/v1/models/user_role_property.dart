// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Role for the user. Can be empty or omitted.
@JsonEnum()
enum UserRoleProperty {
  @JsonValue('owner')
  owner('owner'),
  @JsonValue('demo')
  demo('demo'),

  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const UserRoleProperty(this.json);

  factory UserRoleProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
