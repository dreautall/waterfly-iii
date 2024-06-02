// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'piggy_bank_read.dart';

part 'piggy_bank_array.g.dart';

@JsonSerializable()
class PiggyBankArray {
  const PiggyBankArray({
    required this.data,
    required this.meta,
    required this.links,
  });
  
  factory PiggyBankArray.fromJson(Map<String, Object?> json) => _$PiggyBankArrayFromJson(json);
  
  final List<PiggyBankRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$PiggyBankArrayToJson(this);
}
