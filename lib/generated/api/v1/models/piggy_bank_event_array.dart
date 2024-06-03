// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'piggy_bank_event_read.dart';

part 'piggy_bank_event_array.g.dart';

@JsonSerializable()
class PiggyBankEventArray {
  const PiggyBankEventArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PiggyBankEventArray.fromJson(Map<String, Object?> json) =>
      _$PiggyBankEventArrayFromJson(json);

  final List<PiggyBankEventRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$PiggyBankEventArrayToJson(this);
}
