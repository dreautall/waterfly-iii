// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_limit_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetLimitArray _$BudgetLimitArrayFromJson(Map<String, dynamic> json) =>
    BudgetLimitArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => BudgetLimitRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitArrayToJson(BudgetLimitArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
