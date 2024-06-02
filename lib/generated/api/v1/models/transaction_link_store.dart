// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'transaction_link_store.g.dart';

@JsonSerializable()
class TransactionLinkStore {
  const TransactionLinkStore({
    required this.linkTypeId,
    required this.linkTypeName,
    required this.inwardId,
    required this.outwardId,
    required this.notes,
  });
  
  factory TransactionLinkStore.fromJson(Map<String, Object?> json) => _$TransactionLinkStoreFromJson(json);
  
  /// The link type ID to use. You can also use the link_type_name field.
  @JsonKey(name: 'link_type_id')
  final String linkTypeId;

  /// The link type name to use. You can also use the link_type_id field.
  @JsonKey(name: 'link_type_name')
  final String linkTypeName;

  /// The inward transaction transaction_journal_id for the link. This becomes the 'is paid by' transaction of the set.
  @JsonKey(name: 'inward_id')
  final String inwardId;

  /// The outward transaction transaction_journal_id for the link. This becomes the 'pays for' transaction of the set.
  @JsonKey(name: 'outward_id')
  final String outwardId;

  /// Optional. Some notes.
  final String? notes;

  Map<String, Object?> toJson() => _$TransactionLinkStoreToJson(this);
}
