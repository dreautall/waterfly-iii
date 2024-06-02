// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'bill.dart';

part 'bill_read.g.dart';

@JsonSerializable()
class BillRead {
  const BillRead({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory BillRead.fromJson(Map<String, Object?> json) => _$BillReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final Bill attributes;

  Map<String, Object?> toJson() => _$BillReadToJson(this);
}
