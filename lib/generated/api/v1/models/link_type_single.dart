// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'link_type_read.dart';

part 'link_type_single.g.dart';

@JsonSerializable()
class LinkTypeSingle {
  const LinkTypeSingle({
    required this.data,
  });
  
  factory LinkTypeSingle.fromJson(Map<String, Object?> json) => _$LinkTypeSingleFromJson(json);
  
  final LinkTypeRead data;

  Map<String, Object?> toJson() => _$LinkTypeSingleToJson(this);
}
