// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteTransaction _$AutocompleteTransactionFromJson(
        Map<String, dynamic> json) =>
    AutocompleteTransaction(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      transactionGroupId: json['transaction_group_id'] as String?,
    );

Map<String, dynamic> _$AutocompleteTransactionToJson(
        AutocompleteTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_group_id': instance.transactionGroupId,
      'name': instance.name,
      'description': instance.description,
    };
