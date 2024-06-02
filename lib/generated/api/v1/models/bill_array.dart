// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'bill_read.dart';
import 'meta.dart';

part 'bill_array.g.dart';

@JsonSerializable()
class BillArray {
  const BillArray({
    required this.data,
    required this.meta,
  });
  
  factory BillArray.fromJson(Map<String, Object?> json) => _$BillArrayFromJson(json);
  
  final List<BillRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$BillArrayToJson(this);
}
