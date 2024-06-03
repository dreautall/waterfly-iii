// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionV2 _$TransactionV2FromJson(Map<String, dynamic> json) =>
    TransactionV2(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionV2Split.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: json['user'] as String?,
      userGroup: json['user_group'] as String?,
      groupTitle: json['group_title'] as String?,
    );

Map<String, dynamic> _$TransactionV2ToJson(TransactionV2 instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'user_group': instance.userGroup,
      'group_title': instance.groupTitle,
      'transactions': instance.transactions,
    };
