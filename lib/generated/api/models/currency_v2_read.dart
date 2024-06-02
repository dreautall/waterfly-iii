// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'currency_v2.dart';

part 'currency_v2_read.g.dart';

@JsonSerializable()
class CurrencyV2Read {
  const CurrencyV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });
  
  factory CurrencyV2Read.fromJson(Map<String, Object?> json) => _$CurrencyV2ReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final CurrencyV2 attributes;

  Map<String, Object?> toJson() => _$CurrencyV2ReadToJson(this);
}
