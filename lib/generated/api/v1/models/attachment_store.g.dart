// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentStore _$AttachmentStoreFromJson(Map<String, dynamic> json) =>
    AttachmentStore(
      filename: json['filename'] as String,
      attachableType:
          AttachableType.fromJson(json['attachable_type'] as String),
      attachableId: json['attachable_id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentStoreToJson(AttachmentStore instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'attachable_type': _$AttachableTypeEnumMap[instance.attachableType]!,
      'attachable_id': instance.attachableId,
      'title': instance.title,
      'notes': instance.notes,
    };

const _$AttachableTypeEnumMap = {
  AttachableType.account: 'Account',
  AttachableType.budget: 'Budget',
  AttachableType.bill: 'Bill',
  AttachableType.transactionJournal: 'TransactionJournal',
  AttachableType.piggyBank: 'PiggyBank',
  AttachableType.tag: 'Tag',
  AttachableType.$unknown: r'$unknown',
};
