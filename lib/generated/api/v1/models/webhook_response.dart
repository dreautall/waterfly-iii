// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Indicator for what Firefly III will deliver to the webhook URL.
@JsonEnum()
enum WebhookResponse {
  @JsonValue('TRANSACTIONS')
  transactions('TRANSACTIONS'),
  @JsonValue('ACCOUNTS')
  accounts('ACCOUNTS'),
  @JsonValue('NONE')
  none('NONE'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const WebhookResponse(this.json);

  factory WebhookResponse.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
