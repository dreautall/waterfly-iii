// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'budget_v2.g.dart';

@JsonSerializable()
class BudgetV2 {
  const BudgetV2({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.active,
    required this.order,
  });

  factory BudgetV2.fromJson(Map<String, Object?> json) =>
      _$BudgetV2FromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String name;
  final bool active;
  final int order;

  Map<String, Object?> toJson() => _$BudgetV2ToJson(this);
}
