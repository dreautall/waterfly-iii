// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'unauthenticated_response.g.dart';

@JsonSerializable()
class UnauthenticatedResponse {
  const UnauthenticatedResponse({
    required this.message,
    required this.exception,
  });

  factory UnauthenticatedResponse.fromJson(Map<String, Object?> json) =>
      _$UnauthenticatedResponseFromJson(json);

  final String message;
  final String exception;

  Map<String, Object?> toJson() => _$UnauthenticatedResponseToJson(this);
}
