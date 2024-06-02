// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// If the currency must be the default for the user. You can only submit TRUE. Submitting FALSE will not drop this currency as the default currency, because then the system would be without one.
/// The name has been replaced because it contains a keyword. Original name: `default`.
@JsonEnum()
enum CurrencyUpdateDefaultEnum {
  /// The name has been replaced because it contains a keyword. Original name: `true`.
  @JsonValue('true')
  valueTrue('true'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const CurrencyUpdateDefaultEnum(this.json);

  factory CurrencyUpdateDefaultEnum.fromJson(bool json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final bool? json;
}
