// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'piggy_bank_read.dart';

part 'piggy_bank_single.g.dart';

@JsonSerializable()
class PiggyBankSingle {
  const PiggyBankSingle({
    required this.data,
  });
  
  factory PiggyBankSingle.fromJson(Map<String, Object?> json) => _$PiggyBankSingleFromJson(json);
  
  final PiggyBankRead data;

  Map<String, Object?> toJson() => _$PiggyBankSingleToJson(this);
}
