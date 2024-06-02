// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionUpdate _$TransactionUpdateFromJson(Map<String, dynamic> json) =>
    TransactionUpdate(
      applyRules: json['apply_rules'] as bool,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>)
          .map(
              (e) => TransactionSplitUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
    );

Map<String, dynamic> _$TransactionUpdateToJson(TransactionUpdate instance) =>
    <String, dynamic>{
      'apply_rules': instance.applyRules,
      'fire_webhooks': instance.fireWebhooks,
      'group_title': instance.groupTitle,
      'transactions': instance.transactions,
    };
