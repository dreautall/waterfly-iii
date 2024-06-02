// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'page_link.dart';
import 'user_read.dart';

part 'user_array.g.dart';

@JsonSerializable()
class UserArray {
  const UserArray({
    required this.data,
    required this.meta,
    required this.links,
  });
  
  factory UserArray.fromJson(Map<String, Object?> json) => _$UserArrayFromJson(json);
  
  final List<UserRead> data;
  final Meta meta;
  final PageLink links;

  Map<String, Object?> toJson() => _$UserArrayToJson(this);
}
