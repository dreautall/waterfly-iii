// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link_v2.dart';
import 'transaction_v2_read.dart';

part 'transaction_v2_array.g.dart';

@JsonSerializable()
class TransactionV2Array {
  const TransactionV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory TransactionV2Array.fromJson(Map<String, Object?> json) =>
      _$TransactionV2ArrayFromJson(json);

  final List<TransactionV2Read> data;
  final Meta meta;
  final PageLinkV2 links;

  Map<String, Object?> toJson() => _$TransactionV2ArrayToJson(this);
}
