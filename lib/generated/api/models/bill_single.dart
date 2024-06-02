// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'bill_read.dart';

part 'bill_single.g.dart';

@JsonSerializable()
class BillSingle {
  const BillSingle({
    required this.data,
  });
  
  factory BillSingle.fromJson(Map<String, Object?> json) => _$BillSingleFromJson(json);
  
  final BillRead data;

  Map<String, Object?> toJson() => _$BillSingleToJson(this);
}
