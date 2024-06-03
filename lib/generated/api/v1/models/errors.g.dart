// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      blocked:
          (json['blocked'] as List<dynamic>?)?.map((e) => e as String).toList(),
      role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
      blockedCode: (json['blocked_code'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
      iban: (json['iban'] as List<dynamic>?)?.map((e) => e as String).toList(),
      start:
          (json['start'] as List<dynamic>?)?.map((e) => e as String).toList(),
      end: (json['end'] as List<dynamic>?)?.map((e) => e as String).toList(),
      date: (json['date'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
      'email': instance.email,
      'blocked': instance.blocked,
      'role': instance.role,
      'blocked_code': instance.blockedCode,
      'name': instance.name,
      'type': instance.type,
      'iban': instance.iban,
      'start': instance.start,
      'end': instance.end,
      'date': instance.date,
    };
