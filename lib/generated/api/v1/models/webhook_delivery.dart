// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Format of the delivered response.
@JsonEnum()
enum WebhookDelivery {
  /// The name has been replaced because it contains a keyword. Original name: `JSON`.
  @JsonValue('JSON')
  valueJson('JSON'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const WebhookDelivery(this.json);

  factory WebhookDelivery.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
