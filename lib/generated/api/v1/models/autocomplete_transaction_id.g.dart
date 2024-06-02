// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_transaction_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteTransactionID _$AutocompleteTransactionIDFromJson(
        Map<String, dynamic> json) =>
    AutocompleteTransactionID(
      id: json['id'] as String,
      transactionGroupId: json['transaction_group_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteTransactionIDToJson(
        AutocompleteTransactionID instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_group_id': instance.transactionGroupId,
      'name': instance.name,
      'description': instance.description,
    };
