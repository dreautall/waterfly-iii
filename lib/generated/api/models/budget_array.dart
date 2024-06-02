// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_read.dart';
import 'meta.dart';

part 'budget_array.g.dart';

@JsonSerializable()
class BudgetArray {
  const BudgetArray({
    required this.data,
    required this.meta,
  });
  
  factory BudgetArray.fromJson(Map<String, Object?> json) => _$BudgetArrayFromJson(json);
  
  final List<BudgetRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$BudgetArrayToJson(this);
}
