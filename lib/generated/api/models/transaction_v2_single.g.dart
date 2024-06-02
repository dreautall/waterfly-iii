// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2Single _$TransactionV2SingleFromJson(Map<String, dynamic> json) =>
    TransactionV2Single(
      data: TransactionV2Read.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionV2SingleToJson(
        TransactionV2Single instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
