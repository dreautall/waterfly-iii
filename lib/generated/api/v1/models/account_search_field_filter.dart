// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum AccountSearchFieldFilter {
  @JsonValue('all')
  all('all'),
  @JsonValue('iban')
  iban('iban'),
  @JsonValue('name')
  name('name'),
  @JsonValue('number')
  number('number'),
  @JsonValue('id')
  id('id'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const AccountSearchFieldFilter(this.json);

  factory AccountSearchFieldFilter.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
