// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget.dart';

part 'budget_read.g.dart';

@JsonSerializable()
class BudgetRead {
  const BudgetRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory BudgetRead.fromJson(Map<String, Object?> json) => _$BudgetReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final Budget attributes;

  Map<String, Object?> toJson() => _$BudgetReadToJson(this);
}
