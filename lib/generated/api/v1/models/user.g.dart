// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      blocked: json['blocked'] as bool?,
      blockedCode: json['blocked_code'] == null
          ? null
          : UserBlockedCodeProperty.fromJson(json['blocked_code'] as String),
      role: json['role'] == null
          ? null
          : UserRoleProperty.fromJson(json['role'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'email': instance.email,
      'blocked': instance.blocked,
      'blocked_code': _$UserBlockedCodePropertyEnumMap[instance.blockedCode],
      'role': _$UserRolePropertyEnumMap[instance.role],
    };

const _$UserBlockedCodePropertyEnumMap = {
  UserBlockedCodeProperty.emailChanged: 'email_changed',
  UserBlockedCodeProperty.valueNull: 'null',
  UserBlockedCodeProperty.$unknown: r'$unknown',
};

const _$UserRolePropertyEnumMap = {
  UserRoleProperty.owner: 'owner',
  UserRoleProperty.demo: 'demo',
  UserRoleProperty.valueNull: 'null',
  UserRoleProperty.$unknown: r'$unknown',
};
