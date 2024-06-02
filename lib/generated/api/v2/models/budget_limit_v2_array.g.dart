// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_v2_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitV2Array _$BudgetLimitV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetLimitV2Array(
      data: (json['data'] as List<dynamic>)
          .map((e) => BudgetLimitReadV2.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitV2ArrayToJson(BudgetLimitV2Array instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
