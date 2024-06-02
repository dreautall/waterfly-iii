// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_budget_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableBudgetArray _$AvailableBudgetArrayFromJson(
        Map<String, dynamic> json) =>
    AvailableBudgetArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => AvailableBudgetRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetArrayToJson(
        AvailableBudgetArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
