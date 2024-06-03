// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bad_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadRequestResponse _$BadRequestResponseFromJson(Map<String, dynamic> json) =>
    BadRequestResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$BadRequestResponseToJson(BadRequestResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };
