// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'insight_group_entry.g.dart';

@JsonSerializable()
class InsightGroupEntry {
  const InsightGroupEntry({
    this.id,
    this.name,
    this.difference,
    this.differenceFloat,
    this.currencyId,
    this.currencyCode,
  });

  factory InsightGroupEntry.fromJson(Map<String, Object?> json) =>
      _$InsightGroupEntryFromJson(json);

  /// This ID is a reference to the original object.
  final String? id;

  /// This is the name of the object.
  final String? name;

  /// The amount spent or earned between start date and end date, a number defined as a string, for this object and all asset accounts.
  final String? difference;

  /// The amount spent or earned between start date and end date, a number as a float, for this object and all asset accounts. May have rounding errors.
  @JsonKey(name: 'difference_float')
  final double? differenceFloat;

  /// The currency ID of the expenses listed for this account.
  @JsonKey(name: 'currency_id')
  final String? currencyId;

  /// The currency code of the expenses listed for this account.
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  Map<String, Object?> toJson() => _$InsightGroupEntryToJson(this);
}
