// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'category_read.dart';
import 'meta.dart';

part 'category_array.g.dart';

@JsonSerializable()
class CategoryArray {
  const CategoryArray({
    required this.data,
    required this.meta,
  });

  factory CategoryArray.fromJson(Map<String, Object?> json) =>
      _$CategoryArrayFromJson(json);

  final List<CategoryRead> data;
  final Meta meta;

  Map<String, Object?> toJson() => _$CategoryArrayToJson(this);
}
