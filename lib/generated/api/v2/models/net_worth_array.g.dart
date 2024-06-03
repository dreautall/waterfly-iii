// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_worth_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetWorthArray _$NetWorthArrayFromJson(Map<String, dynamic> json) =>
    NetWorthArray(
      currencyCode: json['currency_code'] == null
          ? null
          : NetWorthItem.fromJson(
              json['currency_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetWorthArrayToJson(NetWorthArray instance) =>
    <String, dynamic>{
      'currency_code': instance.currencyCode,
    };
