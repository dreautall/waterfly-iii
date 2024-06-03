// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_bill.g.dart';

@JsonSerializable()
class AutocompleteBill {
  const AutocompleteBill({
    required this.id,
    required this.name,
    this.active,
  });

  factory AutocompleteBill.fromJson(Map<String, Object?> json) =>
      _$AutocompleteBillFromJson(json);

  final String id;

  /// Name of the bill found by an auto-complete search.
  final String name;

  /// Is the bill active or not?
  final bool? active;

  Map<String, Object?> toJson() => _$AutocompleteBillToJson(this);
}
