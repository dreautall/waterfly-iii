// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'errors.g.dart';

@JsonSerializable()
class Errors {
  const Errors({
    required this.email,
    required this.blocked,
    required this.role,
    required this.blockedCode,
    required this.name,
    required this.type,
    required this.iban,
    required this.start,
    required this.end,
    required this.date,
  });

  factory Errors.fromJson(Map<String, Object?> json) => _$ErrorsFromJson(json);

  final List<String> email;
  final List<String> blocked;
  final List<String> role;
  @JsonKey(name: 'blocked_code')
  final List<String> blockedCode;
  final List<String> name;
  final List<String> type;
  final List<String> iban;
  final List<String> start;
  final List<String> end;
  final List<String> date;

  Map<String, Object?> toJson() => _$ErrorsToJson(this);
}
