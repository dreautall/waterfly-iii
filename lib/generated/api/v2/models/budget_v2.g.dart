// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetV2 _$BudgetV2FromJson(Map<String, dynamic> json) => BudgetV2(
      name: json['name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BudgetV2ToJson(BudgetV2 instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
      'active': instance.active,
      'order': instance.order,
    };
