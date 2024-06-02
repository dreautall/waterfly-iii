// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      notes: json['notes'] as String?,
      spent: (json['spent'] as List<dynamic>)
          .map((e) => CategorySpent.fromJson(e as Map<String, dynamic>))
          .toList(),
      earned: (json['earned'] as List<dynamic>)
          .map((e) => CategoryEarned.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'notes': instance.notes,
      'spent': instance.spent,
      'earned': instance.earned,
    };
