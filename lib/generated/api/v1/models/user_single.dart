// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'user_read.dart';

part 'user_single.g.dart';

@JsonSerializable()
class UserSingle {
  const UserSingle({
    required this.data,
  });
  
  factory UserSingle.fromJson(Map<String, Object?> json) => _$UserSingleFromJson(json);
  
  final UserRead data;

  Map<String, Object?> toJson() => _$UserSingleToJson(this);
}
