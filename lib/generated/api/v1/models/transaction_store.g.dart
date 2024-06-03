// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionStore _$TransactionStoreFromJson(Map<String, dynamic> json) =>
    TransactionStore(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionSplitStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      errorIfDuplicateHash: json['error_if_duplicate_hash'] as bool?,
      applyRules: json['apply_rules'] as bool?,
      groupTitle: json['group_title'] as String?,
    );

Map<String, dynamic> _$TransactionStoreToJson(TransactionStore instance) =>
    <String, dynamic>{
      'error_if_duplicate_hash': instance.errorIfDuplicateHash,
      'apply_rules': instance.applyRules,
      'fire_webhooks': instance.fireWebhooks,
      'group_title': instance.groupTitle,
      'transactions': instance.transactions,
    };
