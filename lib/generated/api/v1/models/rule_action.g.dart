// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleAction _$RuleActionFromJson(Map<String, dynamic> json) => RuleAction(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: RuleActionKeyword.fromJson(json['type'] as String),
      value: json['value'] as String?,
      order: (json['order'] as num).toInt(),
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleActionToJson(RuleAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
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
