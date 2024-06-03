// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'category_read.g.dart';

@JsonSerializable()
class CategoryRead {
  const CategoryRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory CategoryRead.fromJson(Map<String, Object?> json) =>
      _$CategoryReadFromJson(json);

  /// Immutable value
  final String type;
  final String id;
  final Category attributes;

  Map<String, Object?> toJson() => _$CategoryReadToJson(this);
}
