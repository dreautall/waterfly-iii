// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'basic_summary_entry.g.dart';

@JsonSerializable()
class BasicSummaryEntry {
  const BasicSummaryEntry({
    required this.key,
    required this.title,
    required this.monetaryValue,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.valueParsed,
    required this.localIcon,
    required this.subTitle,
  });

  factory BasicSummaryEntry.fromJson(Map<String, Object?> json) =>
      _$BasicSummaryEntryFromJson(json);

  /// This is a reference to the type of info shared, not influenced by translations or user preferences. The EUR value is a reference to the currency code. Possibilities are: balance-in-ABC, spent-in-ABC, earned-in-ABC, bills-paid-in-ABC, bills-unpaid-in-ABC, left-to-spend-in-ABC and net-worth-in-ABC.
  final String key;

  /// A translated title for the information shared.
  final String title;

  /// The amount as a float.
  @JsonKey(name: 'monetary_value')
  final double monetaryValue;

  /// The currency ID of the associated currency.
  @JsonKey(name: 'currency_id')
  final String currencyId;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Number of decimals for the associated currency.
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// The amount formatted according to the users locale
  @JsonKey(name: 'value_parsed')
  final String valueParsed;

  /// Reference to a font-awesome icon without the fa- part.
  @JsonKey(name: 'local_icon')
  final String localIcon;

  /// A short explanation of the amounts origin. Already formatted according to the locale of the user or translated, if relevant.
  @JsonKey(name: 'sub_title')
  final String subTitle;

  Map<String, Object?> toJson() => _$BasicSummaryEntryToJson(this);
}
