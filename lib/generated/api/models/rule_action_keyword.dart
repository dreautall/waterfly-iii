// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// The type of thing this action will do. A limited set is possible.
@JsonEnum()
enum RuleActionKeyword {
  @JsonValue('user_action')
  userAction('user_action'),
  @JsonValue('set_category')
  setCategory('set_category'),
  @JsonValue('clear_category')
  clearCategory('clear_category'),
  @JsonValue('set_budget')
  setBudget('set_budget'),
  @JsonValue('clear_budget')
  clearBudget('clear_budget'),
  @JsonValue('add_tag')
  addTag('add_tag'),
  @JsonValue('remove_tag')
  removeTag('remove_tag'),
  @JsonValue('remove_all_tags')
  removeAllTags('remove_all_tags'),
  @JsonValue('set_description')
  setDescription('set_description'),
  @JsonValue('append_description')
  appendDescription('append_description'),
  @JsonValue('prepend_description')
  prependDescription('prepend_description'),
  @JsonValue('set_source_account')
  setSourceAccount('set_source_account'),
  @JsonValue('set_destination_account')
  setDestinationAccount('set_destination_account'),
  @JsonValue('set_notes')
  setNotes('set_notes'),
  @JsonValue('append_notes')
  appendNotes('append_notes'),
  @JsonValue('prepend_notes')
  prependNotes('prepend_notes'),
  @JsonValue('clear_notes')
  clearNotes('clear_notes'),
  @JsonValue('link_to_bill')
  linkToBill('link_to_bill'),
  @JsonValue('convert_withdrawal')
  convertWithdrawal('convert_withdrawal'),
  @JsonValue('convert_deposit')
  convertDeposit('convert_deposit'),
  @JsonValue('convert_transfer')
  convertTransfer('convert_transfer'),
  @JsonValue('delete_transaction')
  deleteTransaction('delete_transaction'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RuleActionKeyword(this.json);

  factory RuleActionKeyword.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
