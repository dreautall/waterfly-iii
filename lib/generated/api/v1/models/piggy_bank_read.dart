// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'piggy_bank.dart';

part 'piggy_bank_read.g.dart';

@JsonSerializable()
class PiggyBankRead {
  const PiggyBankRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankRead.fromJson(Map<String, Object?> json) =>
      _$PiggyBankReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final PiggyBank attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$PiggyBankReadToJson(this);
}
