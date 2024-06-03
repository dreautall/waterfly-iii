// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'insight_total_entry.g.dart';

@JsonSerializable()
class InsightTotalEntry {
  const InsightTotalEntry({
    this.difference,
    this.differenceFloat,
    this.currencyId,
    this.currencyCode,
  });

  factory InsightTotalEntry.fromJson(Map<String, Object?> json) =>
      _$InsightTotalEntryFromJson(json);

  /// The amount spent between start date and end date, defined as a string, for this expense account and all asset accounts.
  final String? difference;

  /// The amount spent between start date and end date, defined as a string, for this expense account and all asset accounts. This number is a float (double) and may have rounding errors.
  @JsonKey(name: 'difference_float')
  final double? differenceFloat;

  /// The currency ID of the expenses listed for this expense account.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// The currency code of the expenses listed for this expense account.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  Map<String, Object?> toJson() => _$InsightTotalEntryToJson(this);
}
