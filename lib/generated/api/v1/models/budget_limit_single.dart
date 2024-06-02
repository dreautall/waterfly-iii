// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_limit_read.dart';

part 'budget_limit_single.g.dart';

@JsonSerializable()
class BudgetLimitSingle {
  const BudgetLimitSingle({
    required this.data,
  });
  
  factory BudgetLimitSingle.fromJson(Map<String, Object?> json) => _$BudgetLimitSingleFromJson(json);
  
  final BudgetLimitRead data;

  Map<String, Object?> toJson() => _$BudgetLimitSingleToJson(this);
}
