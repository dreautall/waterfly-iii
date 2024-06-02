// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_v2_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyV2Read _$CurrencyV2ReadFromJson(Map<String, dynamic> json) =>
    CurrencyV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          CurrencyV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyV2ReadToJson(CurrencyV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
    };
