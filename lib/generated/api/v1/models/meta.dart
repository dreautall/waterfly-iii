// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'pagination.dart';

part 'meta.g.dart';

@JsonSerializable()
class Meta {
  const Meta({
    required this.pagination,
  });
  
  factory Meta.fromJson(Map<String, Object?> json) => _$MetaFromJson(json);
  
  final Pagination pagination;

  Map<String, Object?> toJson() => _$MetaToJson(this);
}
