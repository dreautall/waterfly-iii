// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'internal_exception_response.g.dart';

@JsonSerializable()
class InternalExceptionResponse {
  const InternalExceptionResponse({
    this.message,
    this.exception,
  });

  factory InternalExceptionResponse.fromJson(Map<String, Object?> json) =>
      _$InternalExceptionResponseFromJson(json);

  final String? message;
  final String? exception;

  Map<String, Object?> toJson() => _$InternalExceptionResponseToJson(this);
}
