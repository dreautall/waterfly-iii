// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link_v2.dart';
import 'piggy_bank_v2_read.dart';

part 'piggy_bank_v2_array.g.dart';

@JsonSerializable()
class PiggyBankV2Array {
  const PiggyBankV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PiggyBankV2Array.fromJson(Map<String, Object?> json) =>
      _$PiggyBankV2ArrayFromJson(json);

  final List<PiggyBankV2Read> data;
  final Meta meta;
  final PageLinkV2 links;

  Map<String, Object?> toJson() => _$PiggyBankV2ArrayToJson(this);
}
