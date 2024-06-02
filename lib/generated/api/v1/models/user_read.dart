// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'object_link.dart';
import 'user.dart';

part 'user_read.g.dart';

@JsonSerializable()
class UserRead {
  const UserRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });
  
  factory UserRead.fromJson(Map<String, Object?> json) => _$UserReadFromJson(json);
  
  /// Immutable value
  final String type;
  final String id;
  final User attributes;
  final ObjectLink links;

  Map<String, Object?> toJson() => _$UserReadToJson(this);
}
