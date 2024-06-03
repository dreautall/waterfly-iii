// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency_read.dart';
import 'meta.dart';
import 'page_link.dart';

part 'currency_array.g.dart';

@JsonSerializable()
class CurrencyArray {
  const CurrencyArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory CurrencyArray.fromJson(Map<String, Object?> json) =>
      _$CurrencyArrayFromJson(json);

  final List<CurrencyRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$CurrencyArrayToJson(this);
}
