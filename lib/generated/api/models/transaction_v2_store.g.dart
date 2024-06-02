// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2Store _$TransactionV2StoreFromJson(Map<String, dynamic> json) =>
    TransactionV2Store(
      errorIfDuplicateHash: json['error_if_duplicate_hash'] as bool,
      applyRules: json['apply_rules'] as bool,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) =>
              TransactionV2SplitStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
    );

Map<String, dynamic> _$TransactionV2StoreToJson(TransactionV2Store instance) =>
    <String, dynamic>{
      'error_if_duplicate_hash': instance.errorIfDuplicateHash,
      'apply_rules': instance.applyRules,
      'fire_webhooks': instance.fireWebhooks,
      'group_title': instance.groupTitle,
      'transactions': instance.transactions,
    };
