// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillStore _$BillStoreFromJson(Map<String, dynamic> json) => BillStore(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      date: DateTime.parse(json['date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      extensionDate: DateTime.parse(json['extension_date'] as String),
      repeatFreq: BillRepeatFrequency.fromJson(json['repeat_freq'] as String),
      skip: (json['skip'] as num).toInt(),
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$BillStoreToJson(BillStore instance) => <String, dynamic>{
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'name': instance.name,
      'amount_min': instance.amountMin,
      'amount_max': instance.amountMax,
      'date': instance.date.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'extension_date': instance.extensionDate.toIso8601String(),
      'repeat_freq': _$BillRepeatFrequencyEnumMap[instance.repeatFreq]!,
      'skip': instance.skip,
      'active': instance.active,
      'notes': instance.notes,
      'object_group_id': instance.objectGroupId,
      'object_group_title': instance.objectGroupTitle,
    };

const _$BillRepeatFrequencyEnumMap = {
  BillRepeatFrequency.weekly: 'weekly',
  BillRepeatFrequency.monthly: 'monthly',
  BillRepeatFrequency.quarterly: 'quarterly',
  BillRepeatFrequency.halfYear: 'half-year',
  BillRepeatFrequency.yearly: 'yearly',
  BillRepeatFrequency.$unknown: r'$unknown',
};
