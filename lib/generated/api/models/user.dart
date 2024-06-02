// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'user_blocked_code_property.dart';
import 'user_role_property.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.blocked,
    required this.blockedCode,
    required this.role,
  });
  
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The new users email address.
  final String email;

  /// Boolean to indicate if the user is blocked.
  final bool blocked;
  @JsonKey(name: 'blocked_code')
  final UserBlockedCodeProperty blockedCode;
  final UserRoleProperty role;

  Map<String, Object?> toJson() => _$UserToJson(this);
}
