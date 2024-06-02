// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSingle _$TransactionSingleFromJson(Map<String, dynamic> json) =>
    TransactionSingle(
      data: TransactionRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionSingleToJson(TransactionSingle instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
