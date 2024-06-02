// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRead _$CurrencyReadFromJson(Map<String, dynamic> json) => CurrencyRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Currency.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyReadToJson(CurrencyRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
