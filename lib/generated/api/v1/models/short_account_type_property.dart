// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Can only be one one these account types. import, initial-balance and reconciliation cannot be set manually.
@JsonEnum()
enum ShortAccountTypeProperty {
  @JsonValue('asset')
  asset('asset'),
  @JsonValue('expense')
  expense('expense'),
  /// The name has been replaced because it contains a keyword. Original name: `import`.
  @JsonValue('import')
  valueImport('import'),
  @JsonValue('revenue')
  revenue('revenue'),
  @JsonValue('cash')
  cash('cash'),
  @JsonValue('liability')
  liability('liability'),
  @JsonValue('liabilities')
  liabilities('liabilities'),
  @JsonValue('initial-balance')
  initialBalance('initial-balance'),
  @JsonValue('reconciliation')
  reconciliation('reconciliation'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ShortAccountTypeProperty(this.json);

  factory ShortAccountTypeProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
