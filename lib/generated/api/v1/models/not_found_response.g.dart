// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_found_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    NotFoundResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$NotFoundResponseToJson(NotFoundResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };
