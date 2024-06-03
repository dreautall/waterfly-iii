// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'available_budget_read.dart';
import 'meta.dart';

part 'available_budget_array.g.dart';

@JsonSerializable()
class AvailableBudgetArray {
  const AvailableBudgetArray({
    required this.data,
    required this.meta,
  });

  factory AvailableBudgetArray.fromJson(Map<String, Object?> json) =>
      _$AvailableBudgetArrayFromJson(json);

  final List<AvailableBudgetRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$AvailableBudgetArrayToJson(this);
}
