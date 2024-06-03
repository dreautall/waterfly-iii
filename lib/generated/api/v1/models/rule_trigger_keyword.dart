// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// The type of thing this trigger responds to. A limited set is possible
@JsonEnum()
enum RuleTriggerKeyword {
  @JsonValue('from_account_starts')
  fromAccountStarts('from_account_starts'),
  @JsonValue('from_account_ends')
  fromAccountEnds('from_account_ends'),
  @JsonValue('from_account_is')
  fromAccountIs('from_account_is'),
  @JsonValue('from_account_contains')
  fromAccountContains('from_account_contains'),
  @JsonValue('to_account_starts')
  toAccountStarts('to_account_starts'),
  @JsonValue('to_account_ends')
  toAccountEnds('to_account_ends'),
  @JsonValue('to_account_is')
  toAccountIs('to_account_is'),
  @JsonValue('to_account_contains')
  toAccountContains('to_account_contains'),
  @JsonValue('amount_less')
  amountLess('amount_less'),
  @JsonValue('amount_exactly')
  amountExactly('amount_exactly'),
  @JsonValue('amount_more')
  amountMore('amount_more'),
  @JsonValue('description_starts')
  descriptionStarts('description_starts'),
  @JsonValue('description_ends')
  descriptionEnds('description_ends'),
  @JsonValue('description_contains')
  descriptionContains('description_contains'),
  @JsonValue('description_is')
  descriptionIs('description_is'),
  @JsonValue('transaction_type')
  transactionType('transaction_type'),
  @JsonValue('category_is')
  categoryIs('category_is'),
  @JsonValue('budget_is')
  budgetIs('budget_is'),
  @JsonValue('tag_is')
  tagIs('tag_is'),
  @JsonValue('currency_is')
  currencyIs('currency_is'),
  @JsonValue('has_attachments')
  hasAttachments('has_attachments'),
  @JsonValue('has_no_category')
  hasNoCategory('has_no_category'),
  @JsonValue('has_any_category')
  hasAnyCategory('has_any_category'),
  @JsonValue('has_no_budget')
  hasNoBudget('has_no_budget'),
  @JsonValue('has_any_budget')
  hasAnyBudget('has_any_budget'),
  @JsonValue('has_no_tag')
  hasNoTag('has_no_tag'),
  @JsonValue('has_any_tag')
  hasAnyTag('has_any_tag'),
  @JsonValue('notes_contains')
  notesContains('notes_contains'),
  @JsonValue('notes_start')
  notesStart('notes_start'),
  @JsonValue('notes_end')
  notesEnd('notes_end'),
  @JsonValue('notes_are')
  notesAre('notes_are'),
  @JsonValue('no_notes')
  noNotes('no_notes'),
  @JsonValue('any_notes')
  anyNotes('any_notes'),
  @JsonValue('source_account_is')
  sourceAccountIs('source_account_is'),
  @JsonValue('destination_account_is')
  destinationAccountIs('destination_account_is'),
  @JsonValue('source_account_starts')
  sourceAccountStarts('source_account_starts'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RuleTriggerKeyword(this.json);

  factory RuleTriggerKeyword.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
