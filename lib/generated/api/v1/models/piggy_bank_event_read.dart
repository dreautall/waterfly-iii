// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'piggy_bank_event.dart';

part 'piggy_bank_event_read.g.dart';

@JsonSerializable()
class PiggyBankEventRead {
  const PiggyBankEventRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankEventRead.fromJson(Map<String, Object?> json) =>
      _$PiggyBankEventReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final PiggyBankEvent attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$PiggyBankEventReadToJson(this);
}
