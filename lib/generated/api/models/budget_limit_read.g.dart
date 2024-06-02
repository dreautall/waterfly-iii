// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitRead _$BudgetLimitReadFromJson(Map<String, dynamic> json) =>
    BudgetLimitRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          BudgetLimit.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitReadToJson(BudgetLimitRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
