// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_limit_read.dart';
import 'meta.dart';

part 'budget_limit_array.g.dart';

@JsonSerializable()
class BudgetLimitArray {
  const BudgetLimitArray({
    required this.data,
    required this.meta,
  });

  factory BudgetLimitArray.fromJson(Map<String, Object?> json) =>
      _$BudgetLimitArrayFromJson(json);

  final List<BudgetLimitRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$BudgetLimitArrayToJson(this);
}
