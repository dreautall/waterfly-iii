// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'transaction_read.dart';

part 'transaction_array.g.dart';

@JsonSerializable()
class TransactionArray {
  const TransactionArray({
    required this.data,
    required this.meta,
    required this.links,
  });
  
  factory TransactionArray.fromJson(Map<String, Object?> json) => _$TransactionArrayFromJson(json);
  
  final List<TransactionRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$TransactionArrayToJson(this);
}
