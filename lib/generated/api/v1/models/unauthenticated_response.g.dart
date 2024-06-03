// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unauthenticated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnauthenticatedResponse _$UnauthenticatedResponseFromJson(
        Map<String, dynamic> json) =>
    UnauthenticatedResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$UnauthenticatedResponseToJson(
        UnauthenticatedResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };
