// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_link_read.dart';

part 'transaction_link_single.g.dart';

@JsonSerializable()
class TransactionLinkSingle {
  const TransactionLinkSingle({
    required this.data,
  });
  
  factory TransactionLinkSingle.fromJson(Map<String, Object?> json) => _$TransactionLinkSingleFromJson(json);
  
  final TransactionLinkRead data;

  Map<String, Object?> toJson() => _$TransactionLinkSingleToJson(this);
}
