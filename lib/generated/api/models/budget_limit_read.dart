// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_limit.dart';

part 'budget_limit_read.g.dart';

@JsonSerializable()
class BudgetLimitRead {
  const BudgetLimitRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory BudgetLimitRead.fromJson(Map<String, Object?> json) => _$BudgetLimitReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final BudgetLimit attributes;

  Map<String, Object?> toJson() => _$BudgetLimitReadToJson(this);
}
