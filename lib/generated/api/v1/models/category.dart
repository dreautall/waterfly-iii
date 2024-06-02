// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'category_earned.dart';
import 'category_spent.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  const Category({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.notes,
    required this.spent,
    required this.earned,
  });
  
  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String name;
  final String? notes;
  final List<CategorySpent> spent;
  final List<CategoryEarned> earned;

  Map<String, Object?> toJson() => _$CategoryToJson(this);
}
