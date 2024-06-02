// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_budget_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableBudgetRead _$AvailableBudgetReadFromJson(Map<String, dynamic> json) =>
    AvailableBudgetRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          AvailableBudget.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetReadToJson(
        AvailableBudgetRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
