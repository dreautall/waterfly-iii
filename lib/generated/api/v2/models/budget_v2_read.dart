// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_v2.dart';

part 'budget_v2_read.g.dart';

@JsonSerializable()
class BudgetV2Read {
  const BudgetV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BudgetV2Read.fromJson(Map<String, Object?> json) =>
      _$BudgetV2ReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final BudgetV2 attributes;

  Map<String, Object?> toJson() => _$BudgetV2ReadToJson(this);
}
