// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// The trigger for the webhook.
@JsonEnum()
enum WebhookTrigger {
  @JsonValue('STORE_TRANSACTION')
  storeTransaction('STORE_TRANSACTION'),
  @JsonValue('UPDATE_TRANSACTION')
  updateTransaction('UPDATE_TRANSACTION'),
  @JsonValue('DESTROY_TRANSACTION')
  destroyTransaction('DESTROY_TRANSACTION'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const WebhookTrigger(this.json);

  factory WebhookTrigger.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
