// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_rule_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteRuleGroup _$AutocompleteRuleGroupFromJson(
        Map<String, dynamic> json) =>
    AutocompleteRuleGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AutocompleteRuleGroupToJson(
        AutocompleteRuleGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
