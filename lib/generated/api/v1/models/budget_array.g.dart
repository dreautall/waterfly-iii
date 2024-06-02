// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetArray _$BudgetArrayFromJson(Map<String, dynamic> json) => BudgetArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => BudgetRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetArrayToJson(BudgetArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
