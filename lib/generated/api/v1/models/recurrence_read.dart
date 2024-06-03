// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'recurrence.dart';

part 'recurrence_read.g.dart';

@JsonSerializable()
class RecurrenceRead {
  const RecurrenceRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RecurrenceRead.fromJson(Map<String, Object?> json) =>
      _$RecurrenceReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Recurrence attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$RecurrenceReadToJson(this);
}
