// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      version: json['version'] as String,
      apiVersion: json['api_version'] as String,
      phpVersion: json['php_version'] as String,
      os: json['os'] as String,
      driver: json['driver'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'version': instance.version,
      'api_version': instance.apiVersion,
      'php_version': instance.phpVersion,
      'os': instance.os,
      'driver': instance.driver,
    };
