// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'transaction_link.dart';

part 'transaction_link_read.g.dart';

@JsonSerializable()
class TransactionLinkRead {
  const TransactionLinkRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });
  
  factory TransactionLinkRead.fromJson(Map<String, Object?> json) => _$TransactionLinkReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final TransactionLink attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$TransactionLinkReadToJson(this);
}
