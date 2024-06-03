// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link_v2.dart';
import 'piggy_bank_v2.dart';

part 'piggy_bank_v2_read.g.dart';

@JsonSerializable()
class PiggyBankV2Read {
  const PiggyBankV2Read({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankV2Read.fromJson(Map<String, Object?> json) =>
      _$PiggyBankV2ReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final PiggyBankV2 attributes;
  final ObjectLinkV2 links;

  Map<String, Object?> toJson() => _$PiggyBankV2ReadToJson(this);
}
