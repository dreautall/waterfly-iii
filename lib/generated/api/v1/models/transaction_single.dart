// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_read.dart';

part 'transaction_single.g.dart';

@JsonSerializable()
class TransactionSingle {
  const TransactionSingle({
    required this.data,
  });
  
  factory TransactionSingle.fromJson(Map<String, Object?> json) => _$TransactionSingleFromJson(json);
  
  final TransactionRead data;

  Map<String, Object?> toJson() => _$TransactionSingleToJson(this);
}
