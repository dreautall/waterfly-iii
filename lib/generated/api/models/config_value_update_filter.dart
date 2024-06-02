// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ConfigValueUpdateFilter {
  /// Incorrect name has been replaced. Original name: `configuration.is_demo_site`.
  @JsonValue('configuration.is_demo_site')
  undefined0('configuration.is_demo_site'),
  /// Incorrect name has been replaced. Original name: `configuration.permission_update_check`.
  @JsonValue('configuration.permission_update_check')
  undefined1('configuration.permission_update_check'),
  /// Incorrect name has been replaced. Original name: `configuration.last_update_check`.
  @JsonValue('configuration.last_update_check')
  undefined2('configuration.last_update_check'),
  /// Incorrect name has been replaced. Original name: `configuration.single_user_mode`.
  @JsonValue('configuration.single_user_mode')
  undefined3('configuration.single_user_mode'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ConfigValueUpdateFilter(this.json);

  factory ConfigValueUpdateFilter.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
