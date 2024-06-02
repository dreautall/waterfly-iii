// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_v2_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetV2Read _$BudgetV2ReadFromJson(Map<String, dynamic> json) => BudgetV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: BudgetV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ReadToJson(BudgetV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
