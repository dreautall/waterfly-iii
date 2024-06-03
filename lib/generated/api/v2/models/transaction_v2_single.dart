// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'transaction_v2_read.dart';

part 'transaction_v2_single.g.dart';

@JsonSerializable()
class TransactionV2Single {
  const TransactionV2Single({
    required this.data,
  });

  factory TransactionV2Single.fromJson(Map<String, Object?> json) =>
      _$TransactionV2SingleFromJson(json);

  final TransactionV2Read data;

  Map<String, Object?> toJson() => _$TransactionV2SingleToJson(this);
}
