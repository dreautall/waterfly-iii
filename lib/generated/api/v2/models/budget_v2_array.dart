// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_v2_read.dart';
import 'meta.dart';

part 'budget_v2_array.g.dart';

@JsonSerializable()
class BudgetV2Array {
  const BudgetV2Array({
    required this.data,
    required this.meta,
  });

  factory BudgetV2Array.fromJson(Map<String, Object?> json) =>
      _$BudgetV2ArrayFromJson(json);

  final List<BudgetV2Read> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$BudgetV2ArrayToJson(this);
}
