// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_limit_read_v2.dart';
import 'meta.dart';

part 'budget_limit_v2_array.g.dart';

@JsonSerializable()
class BudgetLimitV2Array {
  const BudgetLimitV2Array({
    required this.data,
    required this.meta,
  });

  factory BudgetLimitV2Array.fromJson(Map<String, Object?> json) =>
      _$BudgetLimitV2ArrayFromJson(json);

  final List<BudgetLimitReadV2> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$BudgetLimitV2ArrayToJson(this);
}
