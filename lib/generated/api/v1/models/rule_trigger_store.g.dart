// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_trigger_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleTriggerStore _$RuleTriggerStoreFromJson(Map<String, dynamic> json) =>
    RuleTriggerStore(
      type: RuleTriggerKeyword.fromJson(json['type'] as String),
      value: json['value'] as String,
      active: json['active'] as bool? ?? true,
      prohibited: json['prohibited'] as bool? ?? false,
      stopProcessing: json['stop_processing'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RuleTriggerStoreToJson(RuleTriggerStore instance) =>
    <String, dynamic>{
      'type': _$RuleTriggerKeywordEnumMap[instance.type]!,
      'value': instance.value,
      'order': instance.order,
      'active': instance.active,
      'prohibited': instance.prohibited,
      'stop_processing': instance.stopProcessing,
    };

const _$RuleTriggerKeywordEnumMap = {
  RuleTriggerKeyword.fromAccountStarts: 'from_account_starts',
  RuleTriggerKeyword.fromAccountEnds: 'from_account_ends',
  RuleTriggerKeyword.fromAccountIs: 'from_account_is',
  RuleTriggerKeyword.fromAccountContains: 'from_account_contains',
  RuleTriggerKeyword.toAccountStarts: 'to_account_starts',
  RuleTriggerKeyword.toAccountEnds: 'to_account_ends',
  RuleTriggerKeyword.toAccountIs: 'to_account_is',
  RuleTriggerKeyword.toAccountContains: 'to_account_contains',
  RuleTriggerKeyword.amountLess: 'amount_less',
  RuleTriggerKeyword.amountExactly: 'amount_exactly',
  RuleTriggerKeyword.amountMore: 'amount_more',
  RuleTriggerKeyword.descriptionStarts: 'description_starts',
  RuleTriggerKeyword.descriptionEnds: 'description_ends',
  RuleTriggerKeyword.descriptionContains: 'description_contains',
  RuleTriggerKeyword.descriptionIs: 'description_is',
  RuleTriggerKeyword.transactionType: 'transaction_type',
  RuleTriggerKeyword.categoryIs: 'category_is',
  RuleTriggerKeyword.budgetIs: 'budget_is',
  RuleTriggerKeyword.tagIs: 'tag_is',
  RuleTriggerKeyword.currencyIs: 'currency_is',
  RuleTriggerKeyword.hasAttachments: 'has_attachments',
  RuleTriggerKeyword.hasNoCategory: 'has_no_category',
  RuleTriggerKeyword.hasAnyCategory: 'has_any_category',
  RuleTriggerKeyword.hasNoBudget: 'has_no_budget',
  RuleTriggerKeyword.hasAnyBudget: 'has_any_budget',
  RuleTriggerKeyword.hasNoTag: 'has_no_tag',
  RuleTriggerKeyword.hasAnyTag: 'has_any_tag',
  RuleTriggerKeyword.notesContains: 'notes_contains',
  RuleTriggerKeyword.notesStart: 'notes_start',
  RuleTriggerKeyword.notesEnd: 'notes_end',
  RuleTriggerKeyword.notesAre: 'notes_are',
  RuleTriggerKeyword.noNotes: 'no_notes',
  RuleTriggerKeyword.anyNotes: 'any_notes',
  RuleTriggerKeyword.sourceAccountIs: 'source_account_is',
  RuleTriggerKeyword.destinationAccountIs: 'destination_account_is',
  RuleTriggerKeyword.sourceAccountStarts: 'source_account_starts',
  RuleTriggerKeyword.$unknown: r'$unknown',
};
