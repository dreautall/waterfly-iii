// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_currency.g.dart';

@JsonSerializable()
class AutocompleteCurrency {
  const AutocompleteCurrency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });

  factory AutocompleteCurrency.fromJson(Map<String, Object?> json) =>
      _$AutocompleteCurrencyFromJson(json);

  final String id;

  /// Currency name.
  final String name;

  /// Currency code.
  final String code;
  final String symbol;
  @JsonKey(name: 'decimal_places')
  final int decimalPlaces;

  Map<String, Object?> toJson() => _$AutocompleteCurrencyToJson(this);
}
