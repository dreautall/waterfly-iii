// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'recurrence_read.dart';

part 'recurrence_array.g.dart';

@JsonSerializable()
class RecurrenceArray {
  const RecurrenceArray({
    required this.data,
    required this.meta,
    required this.links,
  });
  
  factory RecurrenceArray.fromJson(Map<String, Object?> json) => _$RecurrenceArrayFromJson(json);
  
  final List<RecurrenceRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$RecurrenceArrayToJson(this);
}
