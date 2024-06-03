// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'not_found_response.g.dart';

@JsonSerializable()
class NotFoundResponse {
  const NotFoundResponse({
    this.message,
    this.exception,
  });

  factory NotFoundResponse.fromJson(Map<String, Object?> json) =>
      _$NotFoundResponseFromJson(json);

  final String? message;
  final String? exception;

  Map<String, Object?> toJson() => _$NotFoundResponseToJson(this);
}
