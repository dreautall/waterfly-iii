// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_exception_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternalExceptionResponse _$InternalExceptionResponseFromJson(
        Map<String, dynamic> json) =>
    InternalExceptionResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$InternalExceptionResponseToJson(
        InternalExceptionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };
