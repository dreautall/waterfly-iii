// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency_v2_read.dart';
import 'meta.dart';
import 'page_link_v2.dart';

part 'currency_v2_array.g.dart';

@JsonSerializable()
class CurrencyV2Array {
  const CurrencyV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory CurrencyV2Array.fromJson(Map<String, Object?> json) =>
      _$CurrencyV2ArrayFromJson(json);

  final List<CurrencyV2Read> data;
  final Meta meta;
  final PageLinkV2 links;

  Map<String, Object?> toJson() => _$CurrencyV2ArrayToJson(this);
}
