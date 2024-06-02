// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'available_budget_read.dart';

part 'available_budget_single.g.dart';

@JsonSerializable()
class AvailableBudgetSingle {
  const AvailableBudgetSingle({
    required this.data,
  });
  
  factory AvailableBudgetSingle.fromJson(Map<String, Object?> json) => _$AvailableBudgetSingleFromJson(json);
  
  final AvailableBudgetRead data;

  Map<String, Object?> toJson() => _$AvailableBudgetSingleToJson(this);
}
