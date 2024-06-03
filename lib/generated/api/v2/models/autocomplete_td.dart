// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_td.g.dart';

@JsonSerializable()
class AutocompleteTD {
  const AutocompleteTD({
    required this.id,
    required this.transactionJournalId,
    required this.name,
    required this.description,
  });

  factory AutocompleteTD.fromJson(Map<String, Object?> json) =>
      _$AutocompleteTDFromJson(json);

  /// The ID of the transaction group.
  final String id;

  /// The ID of a transaction journal (basically a single split).
  @JsonKey(name: 'transaction_journal_id')
  final String transactionJournalId;

  /// Transaction description
  final String name;

  /// Transaction description
  final String description;

  Map<String, Object?> toJson() => _$AutocompleteTDToJson(this);
}
