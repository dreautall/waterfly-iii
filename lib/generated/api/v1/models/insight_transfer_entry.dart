// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'insight_transfer_entry.g.dart';

@JsonSerializable()
class InsightTransferEntry {
  const InsightTransferEntry({
    required this.id,
    required this.name,
    required this.difference,
    required this.differenceFloat,
    required this.inValue,
    required this.inFloat,
    required this.out,
    required this.outFloat,
    required this.currencyId,
    required this.currencyCode,
  });

  factory InsightTransferEntry.fromJson(Map<String, Object?> json) =>
      _$InsightTransferEntryFromJson(json);

  /// This ID is a reference to the original object.
  final String id;

  /// This is the name of the object.
  final String name;

  /// The total amount transferred between start date and end date, a number defined as a string, for this asset account.
  final String difference;

  /// The total amount transferred between start date and end date, a number as a float, for this asset account. May have rounding errors.
  @JsonKey(name: 'difference_float')
  final double differenceFloat;

  /// The total amount transferred TO this account between start date and end date, a number defined as a string, for this asset account.
  /// The name has been replaced because it contains a keyword. Original name: `in`.
  @JsonKey(name: 'in')
  final String inValue;

  /// The total amount transferred FROM this account between start date and end date, a number as a float, for this asset account. May have rounding errors.
  @JsonKey(name: 'in_float')
  final double inFloat;

  /// The total amount transferred FROM this account between start date and end date, a number defined as a string, for this asset account.
  final String out;

  /// The total amount transferred TO this account between start date and end date, a number as a float, for this asset account. May have rounding errors.
  @JsonKey(name: 'out_float')
  final double outFloat;

  /// The currency ID of the expenses listed for this account.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// The currency code of the expenses listed for this account.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  Map<String, Object?> toJson() => _$InsightTransferEntryToJson(this);
}
