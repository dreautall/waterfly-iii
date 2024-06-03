// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'category_update.g.dart';

@JsonSerializable()
class CategoryUpdate {
  const CategoryUpdate({
    required this.name,
    required this.notes,
  });

  factory CategoryUpdate.fromJson(Map<String, Object?> json) =>
      _$CategoryUpdateFromJson(json);

  final String name;
  final String? notes;

  Map<String, Object?> toJson() => _$CategoryUpdateToJson(this);
}
