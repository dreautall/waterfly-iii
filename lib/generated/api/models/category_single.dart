// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'category_read.dart';

part 'category_single.g.dart';

@JsonSerializable()
class CategorySingle {
  const CategorySingle({
    required this.data,
  });
  
  factory CategorySingle.fromJson(Map<String, Object?> json) => _$CategorySingleFromJson(json);
  
  final CategoryRead data;

  Map<String, Object?> toJson() => _$CategorySingleToJson(this);
}
