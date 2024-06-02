// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link_v2.dart';
import 'transaction_v2.dart';

part 'transaction_v2_read.g.dart';

@JsonSerializable()
class TransactionV2Read {
  const TransactionV2Read({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });
  
  factory TransactionV2Read.fromJson(Map<String, Object?> json) => _$TransactionV2ReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final TransactionV2 attributes;
  final ObjectLinkV2 links;

  Map<String, Object?> toJson() => _$TransactionV2ReadToJson(this);
}
