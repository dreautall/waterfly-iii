// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_transaction_type.g.dart';

@JsonSerializable()
class AutocompleteTransactionType {
  const AutocompleteTransactionType({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AutocompleteTransactionType.fromJson(Map<String, Object?> json) =>
      _$AutocompleteTransactionTypeFromJson(json);

  final String id;

  /// Type of the object found by an auto-complete search.
  final String name;

  /// Name of the object found by an auto-complete search.
  final String type;

  Map<String, Object?> toJson() => _$AutocompleteTransactionTypeToJson(this);
}
