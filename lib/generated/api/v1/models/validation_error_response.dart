// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'errors.dart';

part 'validation_error_response.g.dart';

@JsonSerializable()
class ValidationErrorResponse {
  const ValidationErrorResponse({
    required this.message,
    required this.errors,
  });
  
  factory ValidationErrorResponse.fromJson(Map<String, Object?> json) => _$ValidationErrorResponseFromJson(json);
  
  final String message;
  final Errors errors;

  Map<String, Object?> toJson() => _$ValidationErrorResponseToJson(this);
}
