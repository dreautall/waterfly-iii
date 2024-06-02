// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piggy_bank_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiggyBankStore _$PiggyBankStoreFromJson(Map<String, dynamic> json) =>
    PiggyBankStore(
      name: json['name'] as String,
      accountId: json['account_id'] as String,
      targetAmount: json['target_amount'] as String?,
      currentAmount: json['current_amount'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num).toInt(),
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankStoreToJson(PiggyBankStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'account_id': instance.accountId,
      'target_amount': instance.targetAmount,
      'current_amount': instance.currentAmount,
      'start_date': instance.startDate.toIso8601String(),
      'target_date': instance.targetDate?.toIso8601String(),
      'order': instance.order,
      'active': instance.active,
      'notes': instance.notes,
      'object_group_id': instance.objectGroupId,
      'object_group_title': instance.objectGroupTitle,
    };
