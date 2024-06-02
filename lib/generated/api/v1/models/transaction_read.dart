// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'transaction.dart';

part 'transaction_read.g.dart';

@JsonSerializable()
class TransactionRead {
  const TransactionRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });
  
  factory TransactionRead.fromJson(Map<String, Object?> json) => _$TransactionReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final Transaction attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$TransactionReadToJson(this);
}
