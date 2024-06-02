// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'budget_limit_v2.dart';

part 'budget_limit_read_v2.g.dart';

@JsonSerializable()
class BudgetLimitReadV2 {
  const BudgetLimitReadV2({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory BudgetLimitReadV2.fromJson(Map<String, Object?> json) => _$BudgetLimitReadV2FromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final BudgetLimitV2 attributes;

  Map<String, Object?> toJson() => _$BudgetLimitReadV2ToJson(this);
}
