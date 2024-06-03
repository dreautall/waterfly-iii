// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_read.dart';

part 'budget_single.g.dart';

@JsonSerializable()
class BudgetSingle {
  const BudgetSingle({
    required this.data,
  });

  factory BudgetSingle.fromJson(Map<String, Object?> json) =>
      _$BudgetSingleFromJson(json);

  final BudgetRead data;

  Map<String, Object?> toJson() => _$BudgetSingleToJson(this);
}
