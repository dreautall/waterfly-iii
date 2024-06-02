// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetRead _$BudgetReadFromJson(Map<String, dynamic> json) => BudgetRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Budget.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetReadToJson(BudgetRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
