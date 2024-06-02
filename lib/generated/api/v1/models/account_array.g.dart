// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountArray _$AccountArrayFromJson(Map<String, dynamic> json) => AccountArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => AccountRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountArrayToJson(AccountArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
