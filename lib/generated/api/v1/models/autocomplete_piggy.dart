// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_piggy.g.dart';

@JsonSerializable()
class AutocompletePiggy {
  const AutocompletePiggy({
    required this.id,
    required this.name,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyDecimalPlaces,
    required this.objectGroupId,
    required this.objectGroupTitle,
  });
  
  factory AutocompletePiggy.fromJson(Map<String, Object?> json) => _$AutocompletePiggyFromJson(json);
  
  final String id;

  /// Name of the piggy bank found by an auto-complete search.
  final String name;

  /// Currency ID for this piggy bank.
  @JsonKey(name: 'currency_id')
  final String currencyId;

  /// Currency code for this piggy bank.
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  /// Currency name for the currency used by this account.
  @JsonKey(name: 'currency_name')
  final String currencyName;
  @JsonKey(name: 'currency_decimal_places')
  final int currencyDecimalPlaces;

  /// The group ID of the group this object is part of. NULL if no group.
  @JsonKey(name: 'object_group_id')
  final String? objectGroupId;

  /// The name of the group. NULL if no group.
  @JsonKey(name: 'object_group_title')
  final String? objectGroupTitle;

  Map<String, Object?> toJson() => _$AutocompletePiggyToJson(this);
}
