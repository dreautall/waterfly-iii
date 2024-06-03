// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Which action is necessary for the rule to fire? Use either store-journal or update-journal.
@JsonEnum()
enum RuleTriggerType {
  @JsonValue('store-journal')
  storeJournal('store-journal'),
  @JsonValue('update-journal')
  updateJournal('update-journal'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RuleTriggerType(this.json);

  factory RuleTriggerType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
