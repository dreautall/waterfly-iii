// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_action_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleActionUpdate _$RuleActionUpdateFromJson(Map<String, dynamic> json) =>
    RuleActionUpdate(
      type: RuleActionKeyword.fromJson(json['type'] as String),
      value: json['value'] as String?,
      order: (json['order'] as num).toInt(),
      active: json['active'] as bool,
      stopProcessing: json['stop_processing'] as bool,
    );

Map<String, dynamic> _$RuleActionUpdateToJson(RuleActionUpdate instance) =>
    <String, dynamic>{
      'type': _$RuleActionKeywordEnumMap[instance.type]!,
      'value': instance.value,
      'order': instance.order,
      'active': instance.active,
      'stop_processing': instance.stopProcessing,
    };

const _$RuleActionKeywordEnumMap = {
  RuleActionKeyword.userAction: 'user_action',
  RuleActionKeyword.setCategory: 'set_category',
  RuleActionKeyword.clearCategory: 'clear_category',
  RuleActionKeyword.setBudget: 'set_budget',
  RuleActionKeyword.clearBudget: 'clear_budget',
  RuleActionKeyword.addTag: 'add_tag',
  RuleActionKeyword.removeTag: 'remove_tag',
  RuleActionKeyword.removeAllTags: 'remove_all_tags',
  RuleActionKeyword.setDescription: 'set_description',
  RuleActionKeyword.appendDescription: 'append_description',
  RuleActionKeyword.prependDescription: 'prepend_description',
  RuleActionKeyword.setSourceAccount: 'set_source_account',
  RuleActionKeyword.setDestinationAccount: 'set_destination_account',
  RuleActionKeyword.setNotes: 'set_notes',
  RuleActionKeyword.appendNotes: 'append_notes',
  RuleActionKeyword.prependNotes: 'prepend_notes',
  RuleActionKeyword.clearNotes: 'clear_notes',
  RuleActionKeyword.linkToBill: 'link_to_bill',
  RuleActionKeyword.convertWithdrawal: 'convert_withdrawal',
  RuleActionKeyword.convertDeposit: 'convert_deposit',
  RuleActionKeyword.convertTransfer: 'convert_transfer',
  RuleActionKeyword.deleteTransaction: 'delete_transaction',
  RuleActionKeyword.$unknown: r'$unknown',
};
