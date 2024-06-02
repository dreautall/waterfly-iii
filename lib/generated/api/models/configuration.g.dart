// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      title: ConfigValueFilter.fromJson(json['title'] as String),
      value:
          PolymorphicProperty.fromJson(json['value'] as Map<String, dynamic>),
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'title': _$ConfigValueFilterEnumMap[instance.title]!,
      'value': instance.value,
      'editable': instance.editable,
    };

const _$ConfigValueFilterEnumMap = {
  ConfigValueFilter.undefined0: 'configuration.is_demo_site',
  ConfigValueFilter.undefined1: 'configuration.permission_update_check',
  ConfigValueFilter.undefined2: 'configuration.last_update_check',
  ConfigValueFilter.undefined3: 'configuration.single_user_mode',
  ConfigValueFilter.undefined4: 'firefly.version',
  ConfigValueFilter.undefined5: 'firefly.api_version',
  ConfigValueFilter.undefined6: 'firefly.default_location',
  ConfigValueFilter.undefined7: 'firefly.account_to_transaction',
  ConfigValueFilter.undefined8: 'firefly.allowed_opposing_types',
  ConfigValueFilter.undefined9: 'firefly.accountRoles',
  ConfigValueFilter.undefined10: 'firefly.valid_liabilities',
  ConfigValueFilter.undefined11: 'firefly.interest_periods',
  ConfigValueFilter.undefined12: 'firefly.enable_external_map',
  ConfigValueFilter.undefined13: 'firefly.expected_source_types',
  ConfigValueFilter.undefined14: 'app.timezone',
  ConfigValueFilter.undefined15: 'firefly.bill_periods',
  ConfigValueFilter.undefined16: 'firefly.credit_card_types',
  ConfigValueFilter.undefined17: 'firefly.languages',
  ConfigValueFilter.undefined18: 'firefly.valid_view_ranges',
  ConfigValueFilter.$unknown: r'$unknown',
};
