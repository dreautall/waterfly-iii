// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_read_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitReadV2 _$BudgetLimitReadV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitReadV2(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          BudgetLimitV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitReadV2ToJson(BudgetLimitReadV2 instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
