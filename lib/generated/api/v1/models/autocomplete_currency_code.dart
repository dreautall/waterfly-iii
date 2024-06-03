// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_currency_code.g.dart';

@JsonSerializable()
class AutocompleteCurrencyCode {
  const AutocompleteCurrencyCode({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });

  factory AutocompleteCurrencyCode.fromJson(Map<String, Object?> json) =>
      _$AutocompleteCurrencyCodeFromJson(json);

  final String id;

  /// Currency name with the code between brackets.
  final String name;

  /// Currency code.
  final String code;
  final String symbol;
  @JsonKey(name: 'decimal_places')
  final int decimalPlaces;

  Map<String, Object?> toJson() => _$AutocompleteCurrencyCodeToJson(this);
}
