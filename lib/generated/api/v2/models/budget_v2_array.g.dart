// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_v2_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetV2Array _$BudgetV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetV2Array(
      data: (json['data'] as List<dynamic>)
          .map((e) => BudgetV2Read.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ArrayToJson(BudgetV2Array instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
