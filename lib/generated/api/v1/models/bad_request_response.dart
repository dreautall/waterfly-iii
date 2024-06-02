// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'bad_request_response.g.dart';

@JsonSerializable()
class BadRequestResponse {
  const BadRequestResponse({
    required this.message,
    required this.exception,
  });
  
  factory BadRequestResponse.fromJson(Map<String, Object?> json) => _$BadRequestResponseFromJson(json);
  
  final String message;
  final String exception;

  Map<String, Object?> toJson() => _$BadRequestResponseToJson(this);
}
