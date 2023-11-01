// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountArray _$AccountArrayFromJson(Map<String, dynamic> json) => AccountArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AccountRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountArrayToJson(AccountArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

AttachmentArray _$AttachmentArrayFromJson(Map<String, dynamic> json) =>
    AttachmentArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AttachmentRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttachmentArrayToJson(AttachmentArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

AvailableBudgetArray _$AvailableBudgetArrayFromJson(
        Map<String, dynamic> json) =>
    AvailableBudgetArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  AvailableBudgetRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetArrayToJson(
        AvailableBudgetArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BillArray _$BillArrayFromJson(Map<String, dynamic> json) => BillArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BillRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillArrayToJson(BillArray instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetArray _$BudgetArrayFromJson(Map<String, dynamic> json) => BudgetArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BudgetRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetArrayToJson(BudgetArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetLimitArray _$BudgetLimitArrayFromJson(Map<String, dynamic> json) =>
    BudgetLimitArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BudgetLimitRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitArrayToJson(BudgetLimitArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

CategoryArray _$CategoryArrayFromJson(Map<String, dynamic> json) =>
    CategoryArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CategoryRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryArrayToJson(CategoryArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

CurrencyArray _$CurrencyArrayFromJson(Map<String, dynamic> json) =>
    CurrencyArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CurrencyRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyArrayToJson(CurrencyArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

LinkTypeArray _$LinkTypeArrayFromJson(Map<String, dynamic> json) =>
    LinkTypeArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => LinkTypeRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkTypeArrayToJson(LinkTypeArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

ObjectGroupArray _$ObjectGroupArrayFromJson(Map<String, dynamic> json) =>
    ObjectGroupArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ObjectGroupRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectGroupArrayToJson(ObjectGroupArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

PiggyBankArray _$PiggyBankArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PiggyBankRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankArrayToJson(PiggyBankArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

PiggyBankEventArray _$PiggyBankEventArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankEventArray(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => PiggyBankEventRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankEventArrayToJson(
        PiggyBankEventArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

PreferenceArray _$PreferenceArrayFromJson(Map<String, dynamic> json) =>
    PreferenceArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PreferenceRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceArrayToJson(PreferenceArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

RecurrenceArray _$RecurrenceArrayFromJson(Map<String, dynamic> json) =>
    RecurrenceArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => RecurrenceRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecurrenceArrayToJson(RecurrenceArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

RuleArray _$RuleArrayFromJson(Map<String, dynamic> json) => RuleArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => RuleRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleArrayToJson(RuleArray instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

RuleGroupArray _$RuleGroupArrayFromJson(Map<String, dynamic> json) =>
    RuleGroupArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => RuleGroupRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleGroupArrayToJson(RuleGroupArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

TagArray _$TagArrayFromJson(Map<String, dynamic> json) => TagArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TagRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagArrayToJson(TagArray instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

TransactionLinkArray _$TransactionLinkArrayFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  TransactionLinkRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionLinkArrayToJson(
        TransactionLinkArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

UserArray _$UserArrayFromJson(Map<String, dynamic> json) => UserArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => UserRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserArrayToJson(UserArray instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

WebhookArray _$WebhookArrayFromJson(Map<String, dynamic> json) => WebhookArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => WebhookRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookArrayToJson(WebhookArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

WebhookAttemptArray _$WebhookAttemptArrayFromJson(Map<String, dynamic> json) =>
    WebhookAttemptArray(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => WebhookAttemptRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptArrayToJson(
        WebhookAttemptArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

WebhookMessageArray _$WebhookMessageArrayFromJson(Map<String, dynamic> json) =>
    WebhookMessageArray(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => WebhookMessageRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageArrayToJson(
        WebhookMessageArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

AutocompleteAccount _$AutocompleteAccountFromJson(Map<String, dynamic> json) =>
    AutocompleteAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      nameWithBalance: json['name_with_balance'] as String,
      type: json['type'] as String,
      currencyId: json['currency_id'] as String,
      currencyName: json['currency_name'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
    );

Map<String, dynamic> _$AutocompleteAccountToJson(
        AutocompleteAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_with_balance': instance.nameWithBalance,
      'type': instance.type,
      'currency_id': instance.currencyId,
      'currency_name': instance.currencyName,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
    };

AutocompleteBill _$AutocompleteBillFromJson(Map<String, dynamic> json) =>
    AutocompleteBill(
      id: json['id'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$AutocompleteBillToJson(AutocompleteBill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
    };

AutocompleteBudget _$AutocompleteBudgetFromJson(Map<String, dynamic> json) =>
    AutocompleteBudget(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AutocompleteBudgetToJson(AutocompleteBudget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

AutocompleteCategory _$AutocompleteCategoryFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCategory(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AutocompleteCategoryToJson(
        AutocompleteCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

AutocompleteCurrency _$AutocompleteCurrencyFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCurrency(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: json['decimal_places'] as int,
    );

Map<String, dynamic> _$AutocompleteCurrencyToJson(
        AutocompleteCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

AutocompleteCurrencyCode _$AutocompleteCurrencyCodeFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCurrencyCode(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: json['decimal_places'] as int,
    );

Map<String, dynamic> _$AutocompleteCurrencyCodeToJson(
        AutocompleteCurrencyCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

AutocompleteObjectGroup _$AutocompleteObjectGroupFromJson(
        Map<String, dynamic> json) =>
    AutocompleteObjectGroup(
      id: json['id'] as String,
      title: json['title'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AutocompleteObjectGroupToJson(
        AutocompleteObjectGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
    };

AutocompletePiggy _$AutocompletePiggyFromJson(Map<String, dynamic> json) =>
    AutocompletePiggy(
      id: json['id'] as String,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$AutocompletePiggyToJson(AutocompletePiggy instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_name': instance.currencyName,
    'currency_decimal_places': instance.currencyDecimalPlaces,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

AutocompletePiggyBalance _$AutocompletePiggyBalanceFromJson(
        Map<String, dynamic> json) =>
    AutocompletePiggyBalance(
      id: json['id'] as String,
      name: json['name'] as String,
      nameWithBalance: json['name_with_balance'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$AutocompletePiggyBalanceToJson(
    AutocompletePiggyBalance instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'name_with_balance': instance.nameWithBalance,
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

AutocompleteRecurrence _$AutocompleteRecurrenceFromJson(
        Map<String, dynamic> json) =>
    AutocompleteRecurrence(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteRecurrenceToJson(
        AutocompleteRecurrence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

AutocompleteRule _$AutocompleteRuleFromJson(Map<String, dynamic> json) =>
    AutocompleteRule(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteRuleToJson(AutocompleteRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

AutocompleteRuleGroup _$AutocompleteRuleGroupFromJson(
        Map<String, dynamic> json) =>
    AutocompleteRuleGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteRuleGroupToJson(
        AutocompleteRuleGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

AutocompleteTag _$AutocompleteTagFromJson(Map<String, dynamic> json) =>
    AutocompleteTag(
      id: json['id'] as String,
      name: json['name'] as String,
      tag: json['tag'] as String,
    );

Map<String, dynamic> _$AutocompleteTagToJson(AutocompleteTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag': instance.tag,
    };

AutocompleteTransaction _$AutocompleteTransactionFromJson(
        Map<String, dynamic> json) =>
    AutocompleteTransaction(
      id: json['id'] as String,
      transactionGroupId: json['transaction_group_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteTransactionToJson(
        AutocompleteTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_group_id': instance.transactionGroupId,
      'name': instance.name,
      'description': instance.description,
    };

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

AutocompleteTransactionType _$AutocompleteTransactionTypeFromJson(
        Map<String, dynamic> json) =>
    AutocompleteTransactionType(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AutocompleteTransactionTypeToJson(
        AutocompleteTransactionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };

ChartDataPoint _$ChartDataPointFromJson(Map<String, dynamic> json) =>
    ChartDataPoint(
      key: json['key'] as String,
    );

Map<String, dynamic> _$ChartDataPointToJson(ChartDataPoint instance) =>
    <String, dynamic>{
      'key': instance.key,
    };

ChartDataSet _$ChartDataSetFromJson(Map<String, dynamic> json) => ChartDataSet(
      label: json['label'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      type: json['type'] as String,
      yAxisID: json['yAxisID'] as int,
      entries: json['entries'] as Object,
    );

Map<String, dynamic> _$ChartDataSetToJson(ChartDataSet instance) =>
    <String, dynamic>{
      'label': instance.label,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'type': instance.type,
      'yAxisID': instance.yAxisID,
      'entries': instance.entries,
    };

InsightGroupEntry _$InsightGroupEntryFromJson(Map<String, dynamic> json) =>
    InsightGroupEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightGroupEntryToJson(InsightGroupEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };

InsightTotalEntry _$InsightTotalEntryFromJson(Map<String, dynamic> json) =>
    InsightTotalEntry(
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightTotalEntryToJson(InsightTotalEntry instance) =>
    <String, dynamic>{
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };

InsightTransferEntry _$InsightTransferEntryFromJson(
        Map<String, dynamic> json) =>
    InsightTransferEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      difference: json['difference'] as String,
      differenceFloat: (json['difference_float'] as num).toDouble(),
      $in: json['in'] as String,
      inFloat: (json['in_float'] as num).toDouble(),
      out: json['out'] as String,
      outFloat: (json['out_float'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$InsightTransferEntryToJson(
        InsightTransferEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difference': instance.difference,
      'difference_float': instance.differenceFloat,
      'in': instance.$in,
      'in_float': instance.inFloat,
      'out': instance.out,
      'out_float': instance.outFloat,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
    };

AccountRead _$AccountReadFromJson(Map<String, dynamic> json) => AccountRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Account.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountReadToJson(AccountRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

AccountSingle _$AccountSingleFromJson(Map<String, dynamic> json) =>
    AccountSingle(
      data: AccountRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountSingleToJson(AccountSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

AttachmentRead _$AttachmentReadFromJson(Map<String, dynamic> json) =>
    AttachmentRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Attachment.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttachmentReadToJson(AttachmentRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

AttachmentSingle _$AttachmentSingleFromJson(Map<String, dynamic> json) =>
    AttachmentSingle(
      data: AttachmentRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttachmentSingleToJson(AttachmentSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

AvailableBudgetRead _$AvailableBudgetReadFromJson(Map<String, dynamic> json) =>
    AvailableBudgetRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          AvailableBudget.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetReadToJson(
        AvailableBudgetRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

AvailableBudgetSingle _$AvailableBudgetSingleFromJson(
        Map<String, dynamic> json) =>
    AvailableBudgetSingle(
      data: AvailableBudgetRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetSingleToJson(
        AvailableBudgetSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

BillRead _$BillReadFromJson(Map<String, dynamic> json) => BillRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Bill.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillReadToJson(BillRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

BillSingle _$BillSingleFromJson(Map<String, dynamic> json) => BillSingle(
      data: BillRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillSingleToJson(BillSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

BudgetLimitRead _$BudgetLimitReadFromJson(Map<String, dynamic> json) =>
    BudgetLimitRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          BudgetLimit.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitReadToJson(BudgetLimitRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

BudgetLimitSingle _$BudgetLimitSingleFromJson(Map<String, dynamic> json) =>
    BudgetLimitSingle(
      data: BudgetLimitRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitSingleToJson(BudgetLimitSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

BudgetRead _$BudgetReadFromJson(Map<String, dynamic> json) => BudgetRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Budget.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetReadToJson(BudgetRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

BudgetSingle _$BudgetSingleFromJson(Map<String, dynamic> json) => BudgetSingle(
      data: BudgetRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetSingleToJson(BudgetSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CategoryRead _$CategoryReadFromJson(Map<String, dynamic> json) => CategoryRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Category.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryReadToJson(CategoryRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

CategorySingle _$CategorySingleFromJson(Map<String, dynamic> json) =>
    CategorySingle(
      data: CategoryRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategorySingleToJson(CategorySingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ConfigurationSingle _$ConfigurationSingleFromJson(Map<String, dynamic> json) =>
    ConfigurationSingle(
      data: Configuration.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigurationSingleToJson(
        ConfigurationSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CurrencyRead _$CurrencyReadFromJson(Map<String, dynamic> json) => CurrencyRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Currency.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyReadToJson(CurrencyRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

CurrencySingle _$CurrencySingleFromJson(Map<String, dynamic> json) =>
    CurrencySingle(
      data: CurrencyRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencySingleToJson(CurrencySingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

LinkTypeRead _$LinkTypeReadFromJson(Map<String, dynamic> json) => LinkTypeRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: LinkType.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkTypeReadToJson(LinkTypeRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

LinkTypeSingle _$LinkTypeSingleFromJson(Map<String, dynamic> json) =>
    LinkTypeSingle(
      data: LinkTypeRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkTypeSingleToJson(LinkTypeSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ObjectGroupRead _$ObjectGroupReadFromJson(Map<String, dynamic> json) =>
    ObjectGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          ObjectGroup.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectGroupReadToJson(ObjectGroupRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ObjectGroupSingle _$ObjectGroupSingleFromJson(Map<String, dynamic> json) =>
    ObjectGroupSingle(
      data: ObjectGroupRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectGroupSingleToJson(ObjectGroupSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

PiggyBankEventRead _$PiggyBankEventReadFromJson(Map<String, dynamic> json) =>
    PiggyBankEventRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBankEvent.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankEventReadToJson(PiggyBankEventRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

PiggyBankRead _$PiggyBankReadFromJson(Map<String, dynamic> json) =>
    PiggyBankRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBank.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankReadToJson(PiggyBankRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

PiggyBankSingle _$PiggyBankSingleFromJson(Map<String, dynamic> json) =>
    PiggyBankSingle(
      data: PiggyBankRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankSingleToJson(PiggyBankSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

PreferenceRead _$PreferenceReadFromJson(Map<String, dynamic> json) =>
    PreferenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Preference.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceReadToJson(PreferenceRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

PreferenceSingle _$PreferenceSingleFromJson(Map<String, dynamic> json) =>
    PreferenceSingle(
      data: PreferenceRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceSingleToJson(PreferenceSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

RecurrenceRead _$RecurrenceReadFromJson(Map<String, dynamic> json) =>
    RecurrenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Recurrence.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecurrenceReadToJson(RecurrenceRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

RecurrenceSingle _$RecurrenceSingleFromJson(Map<String, dynamic> json) =>
    RecurrenceSingle(
      data: RecurrenceRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecurrenceSingleToJson(RecurrenceSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

RuleGroupRead _$RuleGroupReadFromJson(Map<String, dynamic> json) =>
    RuleGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          RuleGroup.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleGroupReadToJson(RuleGroupRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

RuleGroupSingle _$RuleGroupSingleFromJson(Map<String, dynamic> json) =>
    RuleGroupSingle(
      data: RuleGroupRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleGroupSingleToJson(RuleGroupSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

RuleRead _$RuleReadFromJson(Map<String, dynamic> json) => RuleRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Rule.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleReadToJson(RuleRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

RuleSingle _$RuleSingleFromJson(Map<String, dynamic> json) => RuleSingle(
      data: RuleRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleSingleToJson(RuleSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

TagRead _$TagReadFromJson(Map<String, dynamic> json) => TagRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: TagModel.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagReadToJson(TagRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

TagSingle _$TagSingleFromJson(Map<String, dynamic> json) => TagSingle(
      data: TagRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagSingleToJson(TagSingle instance) => <String, dynamic>{
      'data': instance.data.toJson(),
    };

TransactionLinkRead _$TransactionLinkReadFromJson(Map<String, dynamic> json) =>
    TransactionLinkRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          TransactionLink.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionLinkReadToJson(
        TransactionLinkRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

TransactionLinkSingle _$TransactionLinkSingleFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkSingle(
      data: TransactionLinkRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionLinkSingleToJson(
        TransactionLinkSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

TransactionSingle _$TransactionSingleFromJson(Map<String, dynamic> json) =>
    TransactionSingle(
      data: TransactionRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionSingleToJson(TransactionSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UserRead _$UserReadFromJson(Map<String, dynamic> json) => UserRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: User.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserReadToJson(UserRead instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

WebhookAttemptRead _$WebhookAttemptReadFromJson(Map<String, dynamic> json) =>
    WebhookAttemptRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          WebhookAttempt.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptReadToJson(WebhookAttemptRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

WebhookAttemptSingle _$WebhookAttemptSingleFromJson(
        Map<String, dynamic> json) =>
    WebhookAttemptSingle(
      data: WebhookAttemptRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptSingleToJson(
        WebhookAttemptSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

WebhookMessageRead _$WebhookMessageReadFromJson(Map<String, dynamic> json) =>
    WebhookMessageRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          WebhookMessage.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageReadToJson(WebhookMessageRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

WebhookMessageSingle _$WebhookMessageSingleFromJson(
        Map<String, dynamic> json) =>
    WebhookMessageSingle(
      data: WebhookMessageRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageSingleToJson(
        WebhookMessageSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

WebhookRead _$WebhookReadFromJson(Map<String, dynamic> json) => WebhookRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Webhook.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookReadToJson(WebhookRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

WebhookSingle _$WebhookSingleFromJson(Map<String, dynamic> json) =>
    WebhookSingle(
      data: WebhookRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookSingleToJson(WebhookSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool? ?? true,
      order: json['order'] as int?,
      name: json['name'] as String,
      type: shortAccountTypePropertyFromJson(json['type']),
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      currentBalance: json['current_balance'] as String,
      currentBalanceDate:
          DateTime.parse(json['current_balance_date'] as String),
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String,
      currentDebt: json['current_debt'] as String?,
      openingBalanceDate: json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String,
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      creditCardType: creditCardTypeNullableFromJson(json['credit_card_type']),
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: liabilityTypeNullableFromJson(json['liability_type']),
      liabilityDirection:
          liabilityDirectionNullableFromJson(json['liability_direction']),
      interest: json['interest'] as String?,
      interestPeriod: interestPeriodNullableFromJson(json['interest_period']),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'active': instance.active,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('order', instance.order);
  val['name'] = instance.name;
  writeNotNull('type', shortAccountTypePropertyToJson(instance.type));
  writeNotNull(
      'account_role', accountRolePropertyNullableToJson(instance.accountRole));
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  val['currency_symbol'] = instance.currencySymbol;
  val['currency_decimal_places'] = instance.currencyDecimalPlaces;
  val['current_balance'] = instance.currentBalance;
  val['current_balance_date'] = instance.currentBalanceDate.toIso8601String();
  writeNotNull('iban', instance.iban);
  writeNotNull('bic', instance.bic);
  writeNotNull('account_number', instance.accountNumber);
  val['opening_balance'] = instance.openingBalance;
  writeNotNull('current_debt', instance.currentDebt);
  writeNotNull(
      'opening_balance_date', instance.openingBalanceDate?.toIso8601String());
  val['virtual_balance'] = instance.virtualBalance;
  val['include_net_worth'] = instance.includeNetWorth;
  writeNotNull('credit_card_type',
      creditCardTypeNullableToJson(instance.creditCardType));
  writeNotNull(
      'monthly_payment_date', instance.monthlyPaymentDate?.toIso8601String());
  writeNotNull(
      'liability_type', liabilityTypeNullableToJson(instance.liabilityType));
  writeNotNull('liability_direction',
      liabilityDirectionNullableToJson(instance.liabilityDirection));
  writeNotNull('interest', instance.interest);
  writeNotNull(
      'interest_period', interestPeriodNullableToJson(instance.interestPeriod));
  writeNotNull('notes', instance.notes);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

AccountStore _$AccountStoreFromJson(Map<String, dynamic> json) => AccountStore(
      name: json['name'] as String,
      type: shortAccountTypePropertyFromJson(json['type']),
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String,
      openingBalanceDate: json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      active: json['active'] as bool? ?? true,
      order: json['order'] as int,
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      creditCardType: creditCardTypeNullableFromJson(json['credit_card_type']),
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: liabilityTypeNullableFromJson(json['liability_type']),
      liabilityDirection:
          liabilityDirectionNullableFromJson(json['liability_direction']),
      interest: json['interest'] as String?,
      interestPeriod: interestPeriodNullableFromJson(json['interest_period']),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$AccountStoreToJson(AccountStore instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', shortAccountTypePropertyToJson(instance.type));
  writeNotNull('iban', instance.iban);
  writeNotNull('bic', instance.bic);
  writeNotNull('account_number', instance.accountNumber);
  val['opening_balance'] = instance.openingBalance;
  writeNotNull(
      'opening_balance_date', instance.openingBalanceDate?.toIso8601String());
  val['virtual_balance'] = instance.virtualBalance;
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  val['active'] = instance.active;
  val['order'] = instance.order;
  val['include_net_worth'] = instance.includeNetWorth;
  writeNotNull(
      'account_role', accountRolePropertyNullableToJson(instance.accountRole));
  writeNotNull('credit_card_type',
      creditCardTypeNullableToJson(instance.creditCardType));
  writeNotNull(
      'monthly_payment_date', instance.monthlyPaymentDate?.toIso8601String());
  writeNotNull(
      'liability_type', liabilityTypeNullableToJson(instance.liabilityType));
  writeNotNull('liability_direction',
      liabilityDirectionNullableToJson(instance.liabilityDirection));
  writeNotNull('interest', instance.interest);
  writeNotNull(
      'interest_period', interestPeriodNullableToJson(instance.interestPeriod));
  writeNotNull('notes', instance.notes);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

AccountUpdate _$AccountUpdateFromJson(Map<String, dynamic> json) =>
    AccountUpdate(
      name: json['name'] as String,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String,
      openingBalanceDate: json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      active: json['active'] as bool? ?? true,
      order: json['order'] as int,
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      creditCardType: creditCardTypeNullableFromJson(json['credit_card_type']),
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: liabilityTypeNullableFromJson(json['liability_type']),
      interest: json['interest'] as String?,
      interestPeriod: interestPeriodNullableFromJson(json['interest_period']),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$AccountUpdateToJson(AccountUpdate instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('iban', instance.iban);
  writeNotNull('bic', instance.bic);
  writeNotNull('account_number', instance.accountNumber);
  val['opening_balance'] = instance.openingBalance;
  writeNotNull(
      'opening_balance_date', instance.openingBalanceDate?.toIso8601String());
  val['virtual_balance'] = instance.virtualBalance;
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  val['active'] = instance.active;
  val['order'] = instance.order;
  val['include_net_worth'] = instance.includeNetWorth;
  writeNotNull(
      'account_role', accountRolePropertyNullableToJson(instance.accountRole));
  writeNotNull('credit_card_type',
      creditCardTypeNullableToJson(instance.creditCardType));
  writeNotNull(
      'monthly_payment_date', instance.monthlyPaymentDate?.toIso8601String());
  writeNotNull(
      'liability_type', liabilityTypeNullableToJson(instance.liabilityType));
  writeNotNull('interest', instance.interest);
  writeNotNull(
      'interest_period', interestPeriodNullableToJson(instance.interestPeriod));
  writeNotNull('notes', instance.notes);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      attachableType: attachableTypeFromJson(json['attachable_type']),
      attachableId: json['attachable_id'] as String,
      md5: json['md5'] as String,
      filename: json['filename'] as String,
      downloadUrl: json['download_url'] as String,
      uploadUrl: json['upload_url'] as String,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
      mime: json['mime'] as String,
      size: json['size'] as int,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'attachable_type', attachableTypeToJson(instance.attachableType));
  val['attachable_id'] = instance.attachableId;
  val['md5'] = instance.md5;
  val['filename'] = instance.filename;
  val['download_url'] = instance.downloadUrl;
  val['upload_url'] = instance.uploadUrl;
  writeNotNull('title', instance.title);
  writeNotNull('notes', instance.notes);
  val['mime'] = instance.mime;
  val['size'] = instance.size;
  return val;
}

AttachmentStore _$AttachmentStoreFromJson(Map<String, dynamic> json) =>
    AttachmentStore(
      filename: json['filename'] as String,
      attachableType: attachableTypeFromJson(json['attachable_type']),
      attachableId: json['attachable_id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentStoreToJson(AttachmentStore instance) {
  final val = <String, dynamic>{
    'filename': instance.filename,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'attachable_type', attachableTypeToJson(instance.attachableType));
  val['attachable_id'] = instance.attachableId;
  val['title'] = instance.title;
  writeNotNull('notes', instance.notes);
  return val;
}

AttachmentUpdate _$AttachmentUpdateFromJson(Map<String, dynamic> json) =>
    AttachmentUpdate(
      filename: json['filename'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentUpdateToJson(AttachmentUpdate instance) {
  final val = <String, dynamic>{
    'filename': instance.filename,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

AvailableBudget _$AvailableBudgetFromJson(Map<String, dynamic> json) =>
    AvailableBudget(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      amount: json['amount'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      spentInBudgets: (json['spent_in_budgets'] as List<dynamic>?)
              ?.map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      spentOutsideBudget: (json['spent_outside_budget'] as List<dynamic>?)
              ?.map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AvailableBudgetToJson(AvailableBudget instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'amount': instance.amount,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'spent_in_budgets':
          instance.spentInBudgets.map((e) => e.toJson()).toList(),
      'spent_outside_budget':
          instance.spentOutsideBudget.map((e) => e.toJson()).toList(),
    };

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      date: DateTime.parse(json['date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      extensionDate: json['extension_date'] == null
          ? null
          : DateTime.parse(json['extension_date'] as String),
      repeatFreq: billRepeatFrequencyFromJson(json['repeat_freq']),
      skip: json['skip'] as int,
      active: json['active'] as bool,
      order: json['order'] as int,
      notes: json['notes'] as String?,
      nextExpectedMatch: json['next_expected_match'] == null
          ? null
          : DateTime.parse(json['next_expected_match'] as String),
      nextExpectedMatchDiff: json['next_expected_match_diff'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: json['object_group_order'] as int?,
      objectGroupTitle: json['object_group_title'] as String?,
      payDates: (json['pay_dates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          [],
      paidDates: (json['paid_dates'] as List<dynamic>)
          .map((e) => Bill$PaidDates$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BillToJson(Bill instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'name': instance.name,
    'amount_min': instance.amountMin,
    'amount_max': instance.amountMax,
    'date': instance.date.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('extension_date', instance.extensionDate?.toIso8601String());
  writeNotNull('repeat_freq', billRepeatFrequencyToJson(instance.repeatFreq));
  val['skip'] = instance.skip;
  val['active'] = instance.active;
  val['order'] = instance.order;
  writeNotNull('notes', instance.notes);
  writeNotNull(
      'next_expected_match', instance.nextExpectedMatch?.toIso8601String());
  writeNotNull('next_expected_match_diff', instance.nextExpectedMatchDiff);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_order', instance.objectGroupOrder);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  val['pay_dates'] = instance.payDates.map((e) => e.toIso8601String()).toList();
  val['paid_dates'] = instance.paidDates.map((e) => e.toJson()).toList();
  return val;
}

BillStore _$BillStoreFromJson(Map<String, dynamic> json) => BillStore(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      date: DateTime.parse(json['date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      extensionDate: DateTime.parse(json['extension_date'] as String),
      repeatFreq: billRepeatFrequencyFromJson(json['repeat_freq']),
      skip: json['skip'] as int,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$BillStoreToJson(BillStore instance) {
  final val = <String, dynamic>{
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'name': instance.name,
    'amount_min': instance.amountMin,
    'amount_max': instance.amountMax,
    'date': instance.date.toIso8601String(),
    'end_date': instance.endDate.toIso8601String(),
    'extension_date': instance.extensionDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('repeat_freq', billRepeatFrequencyToJson(instance.repeatFreq));
  val['skip'] = instance.skip;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

BillUpdate _$BillUpdateFromJson(Map<String, dynamic> json) => BillUpdate(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      date: DateTime.parse(json['date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      extensionDate: DateTime.parse(json['extension_date'] as String),
      repeatFreq: billRepeatFrequencyFromJson(json['repeat_freq']),
      skip: json['skip'] as int,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$BillUpdateToJson(BillUpdate instance) {
  final val = <String, dynamic>{
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'name': instance.name,
    'amount_min': instance.amountMin,
    'amount_max': instance.amountMax,
    'date': instance.date.toIso8601String(),
    'end_date': instance.endDate.toIso8601String(),
    'extension_date': instance.extensionDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('repeat_freq', billRepeatFrequencyToJson(instance.repeatFreq));
  val['skip'] = instance.skip;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      order: json['order'] as int,
      autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
      autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
      autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      autoBudgetPeriod:
          autoBudgetPeriodNullableFromJson(json['auto_budget_period']),
      spent: (json['spent'] as List<dynamic>?)
              ?.map((e) => BudgetSpent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'name': instance.name,
    'active': instance.active,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  val['order'] = instance.order;
  writeNotNull('auto_budget_type',
      autoBudgetTypeNullableToJson(instance.autoBudgetType));
  writeNotNull('auto_budget_currency_id', instance.autoBudgetCurrencyId);
  writeNotNull('auto_budget_currency_code', instance.autoBudgetCurrencyCode);
  writeNotNull('auto_budget_amount', instance.autoBudgetAmount);
  writeNotNull('auto_budget_period',
      autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod));
  val['spent'] = instance.spent.map((e) => e.toJson()).toList();
  return val;
}

BudgetStore _$BudgetStoreFromJson(Map<String, dynamic> json) => BudgetStore(
      name: json['name'] as String,
      active: json['active'] as bool,
      order: json['order'] as int,
      notes: json['notes'] as String?,
      autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
      autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
      autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      autoBudgetPeriod:
          autoBudgetPeriodNullableFromJson(json['auto_budget_period']),
    );

Map<String, dynamic> _$BudgetStoreToJson(BudgetStore instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'active': instance.active,
    'order': instance.order,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  writeNotNull('auto_budget_type',
      autoBudgetTypeNullableToJson(instance.autoBudgetType));
  writeNotNull('auto_budget_currency_id', instance.autoBudgetCurrencyId);
  writeNotNull('auto_budget_currency_code', instance.autoBudgetCurrencyCode);
  writeNotNull('auto_budget_amount', instance.autoBudgetAmount);
  writeNotNull('auto_budget_period',
      autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod));
  return val;
}

BudgetUpdate _$BudgetUpdateFromJson(Map<String, dynamic> json) => BudgetUpdate(
      name: json['name'] as String,
      active: json['active'] as bool,
      order: json['order'] as int,
      notes: json['notes'] as String?,
      autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
      autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
      autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      autoBudgetPeriod:
          autoBudgetPeriodNullableFromJson(json['auto_budget_period']),
    );

Map<String, dynamic> _$BudgetUpdateToJson(BudgetUpdate instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'active': instance.active,
    'order': instance.order,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  writeNotNull('auto_budget_type',
      autoBudgetTypeNullableToJson(instance.autoBudgetType));
  writeNotNull('auto_budget_currency_id', instance.autoBudgetCurrencyId);
  writeNotNull('auto_budget_currency_code', instance.autoBudgetCurrencyCode);
  writeNotNull('auto_budget_amount', instance.autoBudgetAmount);
  writeNotNull('auto_budget_period',
      autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod));
  return val;
}

BudgetLimit _$BudgetLimitFromJson(Map<String, dynamic> json) => BudgetLimit(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencyName: json['currency_name'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      budgetId: json['budget_id'] as String,
      period: json['period'] as String?,
      amount: json['amount'] as String,
      spent: json['spent'] as String?,
    );

Map<String, dynamic> _$BudgetLimitToJson(BudgetLimit instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'start': instance.start.toIso8601String(),
    'end': instance.end.toIso8601String(),
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_name': instance.currencyName,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'budget_id': instance.budgetId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('period', instance.period);
  val['amount'] = instance.amount;
  writeNotNull('spent', instance.spent);
  return val;
}

BudgetLimitStore _$BudgetLimitStoreFromJson(Map<String, dynamic> json) =>
    BudgetLimitStore(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      budgetId: json['budget_id'] as String,
      start: DateTime.parse(json['start'] as String),
      period: json['period'] as String?,
      end: DateTime.parse(json['end'] as String),
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$BudgetLimitStoreToJson(BudgetLimitStore instance) {
  final val = <String, dynamic>{
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'budget_id': instance.budgetId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('start', _dateToJson(instance.start));
  writeNotNull('period', instance.period);
  writeNotNull('end', _dateToJson(instance.end));
  val['amount'] = instance.amount;
  return val;
}

BudgetSpent _$BudgetSpentFromJson(Map<String, dynamic> json) => BudgetSpent(
      sum: json['sum'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
    );

Map<String, dynamic> _$BudgetSpentToJson(BudgetSpent instance) =>
    <String, dynamic>{
      'sum': instance.sum,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      notes: json['notes'] as String?,
      spent: (json['spent'] as List<dynamic>?)
              ?.map((e) => CategorySpent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      earned: (json['earned'] as List<dynamic>?)
              ?.map((e) => CategoryEarned.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  val['spent'] = instance.spent.map((e) => e.toJson()).toList();
  val['earned'] = instance.earned.map((e) => e.toJson()).toList();
  return val;
}

CategoryUpdate _$CategoryUpdateFromJson(Map<String, dynamic> json) =>
    CategoryUpdate(
      name: json['name'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CategoryUpdateToJson(CategoryUpdate instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

CategoryEarned _$CategoryEarnedFromJson(Map<String, dynamic> json) =>
    CategoryEarned(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      sum: json['sum'] as String,
    );

Map<String, dynamic> _$CategoryEarnedToJson(CategoryEarned instance) =>
    <String, dynamic>{
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'sum': instance.sum,
    };

CategorySpent _$CategorySpentFromJson(Map<String, dynamic> json) =>
    CategorySpent(
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      sum: json['sum'] as String,
    );

Map<String, dynamic> _$CategorySpentToJson(CategorySpent instance) =>
    <String, dynamic>{
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'sum': instance.sum,
    };

ObjectGroup _$ObjectGroupFromJson(Map<String, dynamic> json) => ObjectGroup(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      order: json['order'] as int,
    );

Map<String, dynamic> _$ObjectGroupToJson(ObjectGroup instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'order': instance.order,
    };

ObjectGroupUpdate _$ObjectGroupUpdateFromJson(Map<String, dynamic> json) =>
    ObjectGroupUpdate(
      title: json['title'] as String,
      order: json['order'] as int,
    );

Map<String, dynamic> _$ObjectGroupUpdateToJson(ObjectGroupUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'order': instance.order,
    };

PiggyBank _$PiggyBankFromJson(Map<String, dynamic> json) => PiggyBank(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      accountId: json['account_id'] as String,
      accountName: json['account_name'] as String,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      targetAmount: json['target_amount'] as String,
      percentage: (json['percentage'] as num?)?.toDouble(),
      currentAmount: json['current_amount'] as String,
      leftToSave: json['left_to_save'] as String?,
      savePerMonth: json['save_per_month'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: json['order'] as int,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: json['object_group_order'] as int?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankToJson(PiggyBank instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'account_id': instance.accountId,
    'account_name': instance.accountName,
    'name': instance.name,
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'target_amount': instance.targetAmount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('percentage', instance.percentage);
  val['current_amount'] = instance.currentAmount;
  writeNotNull('left_to_save', instance.leftToSave);
  writeNotNull('save_per_month', instance.savePerMonth);
  writeNotNull('start_date', _dateToJson(instance.startDate));
  writeNotNull('target_date', _dateToJson(instance.targetDate));
  val['order'] = instance.order;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_order', instance.objectGroupOrder);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

PiggyBankStore _$PiggyBankStoreFromJson(Map<String, dynamic> json) =>
    PiggyBankStore(
      name: json['name'] as String,
      accountId: json['account_id'] as String,
      targetAmount: json['target_amount'] as String,
      currentAmount: json['current_amount'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: json['order'] as int,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankStoreToJson(PiggyBankStore instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'account_id': instance.accountId,
    'target_amount': instance.targetAmount,
    'current_amount': instance.currentAmount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('start_date', _dateToJson(instance.startDate));
  writeNotNull('target_date', _dateToJson(instance.targetDate));
  val['order'] = instance.order;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

PiggyBankUpdate _$PiggyBankUpdateFromJson(Map<String, dynamic> json) =>
    PiggyBankUpdate(
      name: json['name'] as String,
      accountId: json['account_id'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      targetAmount: json['target_amount'] as String?,
      currentAmount: json['current_amount'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: json['order'] as int,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankUpdateToJson(PiggyBankUpdate instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'account_id': instance.accountId,
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('target_amount', instance.targetAmount);
  val['current_amount'] = instance.currentAmount;
  writeNotNull('start_date', _dateToJson(instance.startDate));
  writeNotNull('target_date', _dateToJson(instance.targetDate));
  val['order'] = instance.order;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

PiggyBankEvent _$PiggyBankEventFromJson(Map<String, dynamic> json) =>
    PiggyBankEvent(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      amount: json['amount'] as String,
      transactionJournalId: json['transaction_journal_id'] as String?,
      transactionGroupId: json['transaction_group_id'] as String?,
    );

Map<String, dynamic> _$PiggyBankEventToJson(PiggyBankEvent instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction_journal_id', instance.transactionJournalId);
  writeNotNull('transaction_group_id', instance.transactionGroupId);
  return val;
}

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'data': instance.data.toJson(),
    };

PreferenceUpdate _$PreferenceUpdateFromJson(Map<String, dynamic> json) =>
    PreferenceUpdate(
      data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceUpdateToJson(PreferenceUpdate instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

Recurrence _$RecurrenceFromJson(Map<String, dynamic> json) => Recurrence(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: recurrenceTransactionTypeFromJson(json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      firstDate: DateTime.parse(json['first_date'] as String),
      latestDate: json['latest_date'] == null
          ? null
          : DateTime.parse(json['latest_date'] as String),
      repeatUntil: json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
      nrOfRepetitions: json['nr_of_repetitions'] as int?,
      applyRules: json['apply_rules'] as bool,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      repetitions: (json['repetitions'] as List<dynamic>?)
              ?.map((e) =>
                  RecurrenceRepetition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) =>
                  RecurrenceTransaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecurrenceToJson(Recurrence instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', recurrenceTransactionTypeToJson(instance.type));
  val['title'] = instance.title;
  val['description'] = instance.description;
  writeNotNull('first_date', _dateToJson(instance.firstDate));
  writeNotNull('latest_date', _dateToJson(instance.latestDate));
  writeNotNull('repeat_until', _dateToJson(instance.repeatUntil));
  writeNotNull('nr_of_repetitions', instance.nrOfRepetitions);
  val['apply_rules'] = instance.applyRules;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  val['repetitions'] = instance.repetitions.map((e) => e.toJson()).toList();
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

RecurrenceStore _$RecurrenceStoreFromJson(Map<String, dynamic> json) =>
    RecurrenceStore(
      type: recurrenceTransactionTypeFromJson(json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      firstDate: DateTime.parse(json['first_date'] as String),
      repeatUntil: DateTime.parse(json['repeat_until'] as String),
      nrOfRepetitions: json['nr_of_repetitions'] as int?,
      applyRules: json['apply_rules'] as bool,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      repetitions: (json['repetitions'] as List<dynamic>?)
              ?.map((e) =>
                  RecurrenceRepetitionStore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => RecurrenceTransactionStore.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecurrenceStoreToJson(RecurrenceStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', recurrenceTransactionTypeToJson(instance.type));
  val['title'] = instance.title;
  val['description'] = instance.description;
  writeNotNull('first_date', _dateToJson(instance.firstDate));
  writeNotNull('repeat_until', _dateToJson(instance.repeatUntil));
  writeNotNull('nr_of_repetitions', instance.nrOfRepetitions);
  val['apply_rules'] = instance.applyRules;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  val['repetitions'] = instance.repetitions.map((e) => e.toJson()).toList();
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

RecurrenceUpdate _$RecurrenceUpdateFromJson(Map<String, dynamic> json) =>
    RecurrenceUpdate(
      title: json['title'] as String,
      description: json['description'] as String,
      firstDate: DateTime.parse(json['first_date'] as String),
      repeatUntil: json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
      nrOfRepetitions: json['nr_of_repetitions'] as int?,
      applyRules: json['apply_rules'] as bool,
      active: json['active'] as bool,
      notes: json['notes'] as String?,
      repetitions: (json['repetitions'] as List<dynamic>?)
              ?.map((e) => RecurrenceRepetitionUpdate.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => RecurrenceTransactionUpdate.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecurrenceUpdateToJson(RecurrenceUpdate instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'description': instance.description,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_date', _dateToJson(instance.firstDate));
  writeNotNull('repeat_until', _dateToJson(instance.repeatUntil));
  writeNotNull('nr_of_repetitions', instance.nrOfRepetitions);
  val['apply_rules'] = instance.applyRules;
  val['active'] = instance.active;
  writeNotNull('notes', instance.notes);
  val['repetitions'] = instance.repetitions.map((e) => e.toJson()).toList();
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

RecurrenceRepetition _$RecurrenceRepetitionFromJson(
        Map<String, dynamic> json) =>
    RecurrenceRepetition(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: recurrenceRepetitionTypeFromJson(json['type']),
      moment: json['moment'] as String,
      skip: json['skip'] as int,
      weekend: json['weekend'] as int,
      description: json['description'] as String,
      occurrences: (json['occurrences'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecurrenceRepetitionToJson(
    RecurrenceRepetition instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', recurrenceRepetitionTypeToJson(instance.type));
  val['moment'] = instance.moment;
  val['skip'] = instance.skip;
  val['weekend'] = instance.weekend;
  val['description'] = instance.description;
  val['occurrences'] =
      instance.occurrences.map((e) => e.toIso8601String()).toList();
  return val;
}

RecurrenceRepetitionStore _$RecurrenceRepetitionStoreFromJson(
        Map<String, dynamic> json) =>
    RecurrenceRepetitionStore(
      type: recurrenceRepetitionTypeFromJson(json['type']),
      moment: json['moment'] as String,
      skip: json['skip'] as int,
      weekend: json['weekend'] as int,
    );

Map<String, dynamic> _$RecurrenceRepetitionStoreToJson(
    RecurrenceRepetitionStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', recurrenceRepetitionTypeToJson(instance.type));
  val['moment'] = instance.moment;
  val['skip'] = instance.skip;
  val['weekend'] = instance.weekend;
  return val;
}

RecurrenceRepetitionUpdate _$RecurrenceRepetitionUpdateFromJson(
        Map<String, dynamic> json) =>
    RecurrenceRepetitionUpdate(
      type: recurrenceRepetitionTypeFromJson(json['type']),
      moment: json['moment'] as String,
      skip: json['skip'] as int,
      weekend: json['weekend'] as int,
    );

Map<String, dynamic> _$RecurrenceRepetitionUpdateToJson(
    RecurrenceRepetitionUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', recurrenceRepetitionTypeToJson(instance.type));
  val['moment'] = instance.moment;
  val['skip'] = instance.skip;
  val['weekend'] = instance.weekend;
  return val;
}

RecurrenceTransaction _$RecurrenceTransactionFromJson(
        Map<String, dynamic> json) =>
    RecurrenceTransaction(
      id: json['id'] as String,
      description: json['description'] as String,
      amount: json['amount'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          json['foreign_currency_decimal_places'] as int?,
      budgetId: json['budget_id'] as String,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      sourceId: json['source_id'] as String,
      sourceName: json['source_name'] as String,
      sourceIban: json['source_iban'] as String?,
      sourceType: accountTypePropertyFromJson(json['source_type']),
      destinationId: json['destination_id'] as String,
      destinationName: json['destination_name'] as String,
      destinationIban: json['destination_iban'] as String?,
      destinationType: accountTypePropertyFromJson(json['destination_type']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      piggyBankId: json['piggy_bank_id'] as String?,
      piggyBankName: json['piggy_bank_name'] as String?,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
    );

Map<String, dynamic> _$RecurrenceTransactionToJson(
    RecurrenceTransaction instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'description': instance.description,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('foreign_amount', instance.foreignAmount);
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  val['currency_symbol'] = instance.currencySymbol;
  val['currency_decimal_places'] = instance.currencyDecimalPlaces;
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('foreign_currency_symbol', instance.foreignCurrencySymbol);
  writeNotNull(
      'foreign_currency_decimal_places', instance.foreignCurrencyDecimalPlaces);
  val['budget_id'] = instance.budgetId;
  writeNotNull('budget_name', instance.budgetName);
  val['category_id'] = instance.categoryId;
  val['category_name'] = instance.categoryName;
  val['source_id'] = instance.sourceId;
  val['source_name'] = instance.sourceName;
  writeNotNull('source_iban', instance.sourceIban);
  writeNotNull('source_type', accountTypePropertyToJson(instance.sourceType));
  val['destination_id'] = instance.destinationId;
  val['destination_name'] = instance.destinationName;
  writeNotNull('destination_iban', instance.destinationIban);
  writeNotNull(
      'destination_type', accountTypePropertyToJson(instance.destinationType));
  writeNotNull('tags', instance.tags);
  writeNotNull('piggy_bank_id', instance.piggyBankId);
  writeNotNull('piggy_bank_name', instance.piggyBankName);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  return val;
}

RecurrenceTransactionStore _$RecurrenceTransactionStoreFromJson(
        Map<String, dynamic> json) =>
    RecurrenceTransactionStore(
      description: json['description'] as String,
      amount: json['amount'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      budgetId: json['budget_id'] as String,
      categoryId: json['category_id'] as String,
      sourceId: json['source_id'] as String,
      destinationId: json['destination_id'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      piggyBankId: json['piggy_bank_id'] as String?,
      billId: json['bill_id'] as String?,
    );

Map<String, dynamic> _$RecurrenceTransactionStoreToJson(
    RecurrenceTransactionStore instance) {
  final val = <String, dynamic>{
    'description': instance.description,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('foreign_amount', instance.foreignAmount);
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  val['budget_id'] = instance.budgetId;
  val['category_id'] = instance.categoryId;
  val['source_id'] = instance.sourceId;
  val['destination_id'] = instance.destinationId;
  writeNotNull('tags', instance.tags);
  writeNotNull('piggy_bank_id', instance.piggyBankId);
  writeNotNull('bill_id', instance.billId);
  return val;
}

RecurrenceTransactionUpdate _$RecurrenceTransactionUpdateFromJson(
        Map<String, dynamic> json) =>
    RecurrenceTransactionUpdate(
      id: json['id'] as String,
      description: json['description'] as String,
      amount: json['amount'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      budgetId: json['budget_id'] as String,
      categoryId: json['category_id'] as String,
      sourceId: json['source_id'] as String,
      destinationId: json['destination_id'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      piggyBankId: json['piggy_bank_id'] as String?,
      billId: json['bill_id'] as String?,
    );

Map<String, dynamic> _$RecurrenceTransactionUpdateToJson(
    RecurrenceTransactionUpdate instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'description': instance.description,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('foreign_amount', instance.foreignAmount);
  val['currency_id'] = instance.currencyId;
  val['currency_code'] = instance.currencyCode;
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  val['budget_id'] = instance.budgetId;
  val['category_id'] = instance.categoryId;
  val['source_id'] = instance.sourceId;
  val['destination_id'] = instance.destinationId;
  writeNotNull('tags', instance.tags);
  writeNotNull('piggy_bank_id', instance.piggyBankId);
  writeNotNull('bill_id', instance.billId);
  return val;
}

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      ruleGroupId: json['rule_group_id'] as String,
      ruleGroupTitle: json['rule_group_title'] as String,
      order: json['order'] as int,
      trigger: ruleTriggerTypeFromJson(json['trigger']),
      active: json['active'] as bool? ?? true,
      strict: json['strict'] as bool,
      stopProcessing: json['stop_processing'] as bool? ?? false,
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => RuleTrigger.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => RuleAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RuleToJson(Rule instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'title': instance.title,
    'description': instance.description,
    'rule_group_id': instance.ruleGroupId,
    'rule_group_title': instance.ruleGroupTitle,
    'order': instance.order,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', ruleTriggerTypeToJson(instance.trigger));
  val['active'] = instance.active;
  val['strict'] = instance.strict;
  val['stop_processing'] = instance.stopProcessing;
  val['triggers'] = instance.triggers.map((e) => e.toJson()).toList();
  val['actions'] = instance.actions.map((e) => e.toJson()).toList();
  return val;
}

RuleStore _$RuleStoreFromJson(Map<String, dynamic> json) => RuleStore(
      title: json['title'] as String,
      description: json['description'] as String,
      ruleGroupId: json['rule_group_id'] as String,
      ruleGroupTitle: json['rule_group_title'] as String,
      order: json['order'] as int,
      trigger: ruleTriggerTypeFromJson(json['trigger']),
      active: json['active'] as bool? ?? true,
      strict: json['strict'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool,
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => RuleTriggerStore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => RuleActionStore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RuleStoreToJson(RuleStore instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'description': instance.description,
    'rule_group_id': instance.ruleGroupId,
    'rule_group_title': instance.ruleGroupTitle,
    'order': instance.order,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', ruleTriggerTypeToJson(instance.trigger));
  val['active'] = instance.active;
  val['strict'] = instance.strict;
  val['stop_processing'] = instance.stopProcessing;
  val['triggers'] = instance.triggers.map((e) => e.toJson()).toList();
  val['actions'] = instance.actions.map((e) => e.toJson()).toList();
  return val;
}

RuleUpdate _$RuleUpdateFromJson(Map<String, dynamic> json) => RuleUpdate(
      title: json['title'] as String,
      description: json['description'] as String,
      ruleGroupId: json['rule_group_id'] as String,
      order: json['order'] as int,
      trigger: ruleTriggerTypeFromJson(json['trigger']),
      active: json['active'] as bool? ?? true,
      strict: json['strict'] as bool,
      stopProcessing: json['stop_processing'] as bool? ?? false,
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map(
                  (e) => RuleTriggerUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => RuleActionUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RuleUpdateToJson(RuleUpdate instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'description': instance.description,
    'rule_group_id': instance.ruleGroupId,
    'order': instance.order,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', ruleTriggerTypeToJson(instance.trigger));
  val['active'] = instance.active;
  val['strict'] = instance.strict;
  val['stop_processing'] = instance.stopProcessing;
  val['triggers'] = instance.triggers.map((e) => e.toJson()).toList();
  val['actions'] = instance.actions.map((e) => e.toJson()).toList();
  return val;
}

RuleAction _$RuleActionFromJson(Map<String, dynamic> json) => RuleAction(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: ruleActionKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: json['order'] as int,
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleActionToJson(RuleAction instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleActionKeywordToJson(instance.type));
  val['value'] = instance.value;
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

RuleActionStore _$RuleActionStoreFromJson(Map<String, dynamic> json) =>
    RuleActionStore(
      type: ruleActionKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: json['order'] as int,
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleActionStoreToJson(RuleActionStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleActionKeywordToJson(instance.type));
  val['value'] = instance.value;
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

RuleActionUpdate _$RuleActionUpdateFromJson(Map<String, dynamic> json) =>
    RuleActionUpdate(
      type: ruleActionKeywordFromJson(json['type']),
      value: json['value'] as String?,
      order: json['order'] as int,
      active: json['active'] as bool,
      stopProcessing: json['stop_processing'] as bool,
    );

Map<String, dynamic> _$RuleActionUpdateToJson(RuleActionUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleActionKeywordToJson(instance.type));
  writeNotNull('value', instance.value);
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

RuleGroup _$RuleGroupFromJson(Map<String, dynamic> json) => RuleGroup(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      description: json['description'] as String?,
      order: json['order'] as int,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$RuleGroupToJson(RuleGroup instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['order'] = instance.order;
  val['active'] = instance.active;
  return val;
}

RuleGroupStore _$RuleGroupStoreFromJson(Map<String, dynamic> json) =>
    RuleGroupStore(
      title: json['title'] as String,
      description: json['description'] as String?,
      order: json['order'] as int,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$RuleGroupStoreToJson(RuleGroupStore instance) {
  final val = <String, dynamic>{
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['order'] = instance.order;
  val['active'] = instance.active;
  return val;
}

RuleGroupUpdate _$RuleGroupUpdateFromJson(Map<String, dynamic> json) =>
    RuleGroupUpdate(
      title: json['title'] as String,
      description: json['description'] as String?,
      order: json['order'] as int,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$RuleGroupUpdateToJson(RuleGroupUpdate instance) {
  final val = <String, dynamic>{
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['order'] = instance.order;
  val['active'] = instance.active;
  return val;
}

RuleTrigger _$RuleTriggerFromJson(Map<String, dynamic> json) => RuleTrigger(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: ruleTriggerKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: json['order'] as int,
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleTriggerToJson(RuleTrigger instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleTriggerKeywordToJson(instance.type));
  val['value'] = instance.value;
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

RuleTriggerStore _$RuleTriggerStoreFromJson(Map<String, dynamic> json) =>
    RuleTriggerStore(
      type: ruleTriggerKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: json['order'] as int,
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleTriggerStoreToJson(RuleTriggerStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleTriggerKeywordToJson(instance.type));
  val['value'] = instance.value;
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

RuleTriggerUpdate _$RuleTriggerUpdateFromJson(Map<String, dynamic> json) =>
    RuleTriggerUpdate(
      type: ruleTriggerKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: json['order'] as int,
      active: json['active'] as bool,
      stopProcessing: json['stop_processing'] as bool,
    );

Map<String, dynamic> _$RuleTriggerUpdateToJson(RuleTriggerUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', ruleTriggerKeywordToJson(instance.type));
  val['value'] = instance.value;
  val['order'] = instance.order;
  val['active'] = instance.active;
  val['stop_processing'] = instance.stopProcessing;
  return val;
}

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      tag: json['tag'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'tag': instance.tag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('date', _dateToJson(instance.date));
  writeNotNull('description', instance.description);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

TagModelStore _$TagModelStoreFromJson(Map<String, dynamic> json) =>
    TagModelStore(
      tag: json['tag'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$TagModelStoreToJson(TagModelStore instance) {
  final val = <String, dynamic>{
    'tag': instance.tag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('date', _dateToJson(instance.date));
  writeNotNull('description', instance.description);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

TagModelUpdate _$TagModelUpdateFromJson(Map<String, dynamic> json) =>
    TagModelUpdate(
      tag: json['tag'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
    );

Map<String, dynamic> _$TagModelUpdateToJson(TagModelUpdate instance) {
  final val = <String, dynamic>{
    'tag': instance.tag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('date', _dateToJson(instance.date));
  writeNotNull('description', instance.description);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  return val;
}

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      enabled: json['enabled'] as bool? ?? true,
      $default: json['default'] as bool,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: json['decimal_places'] as int,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'enabled': instance.enabled,
      'default': instance.$default,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

CurrencyStore _$CurrencyStoreFromJson(Map<String, dynamic> json) =>
    CurrencyStore(
      enabled: json['enabled'] as bool? ?? true,
      $default: json['default'] as bool,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: json['decimal_places'] as int,
    );

Map<String, dynamic> _$CurrencyStoreToJson(CurrencyStore instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'default': instance.$default,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

CurrencyUpdate _$CurrencyUpdateFromJson(Map<String, dynamic> json) =>
    CurrencyUpdate(
      enabled: json['enabled'] as bool,
      $default: json['default'] as bool,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: json['decimal_places'] as int,
    );

Map<String, dynamic> _$CurrencyUpdateToJson(CurrencyUpdate instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'default': instance.$default,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': instance.decimalPlaces,
    };

TransactionStore _$TransactionStoreFromJson(Map<String, dynamic> json) =>
    TransactionStore(
      errorIfDuplicateHash: json['error_if_duplicate_hash'] as bool,
      applyRules: json['apply_rules'] as bool,
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) =>
                  TransactionSplitStore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionStoreToJson(TransactionStore instance) {
  final val = <String, dynamic>{
    'error_if_duplicate_hash': instance.errorIfDuplicateHash,
    'apply_rules': instance.applyRules,
    'fire_webhooks': instance.fireWebhooks,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

TransactionUpdate _$TransactionUpdateFromJson(Map<String, dynamic> json) =>
    TransactionUpdate(
      applyRules: json['apply_rules'] as bool,
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) =>
                  TransactionSplitUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionUpdateToJson(TransactionUpdate instance) {
  final val = <String, dynamic>{
    'apply_rules': instance.applyRules,
    'fire_webhooks': instance.fireWebhooks,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

TransactionLink _$TransactionLinkFromJson(Map<String, dynamic> json) =>
    TransactionLink(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      linkTypeId: json['link_type_id'] as String,
      linkTypeName: json['link_type_name'] as String,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkToJson(TransactionLink instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'link_type_id': instance.linkTypeId,
    'link_type_name': instance.linkTypeName,
    'inward_id': instance.inwardId,
    'outward_id': instance.outwardId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

TransactionLinkStore _$TransactionLinkStoreFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkStore(
      linkTypeId: json['link_type_id'] as String,
      linkTypeName: json['link_type_name'] as String,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkStoreToJson(
    TransactionLinkStore instance) {
  final val = <String, dynamic>{
    'link_type_id': instance.linkTypeId,
    'link_type_name': instance.linkTypeName,
    'inward_id': instance.inwardId,
    'outward_id': instance.outwardId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

TransactionLinkUpdate _$TransactionLinkUpdateFromJson(
        Map<String, dynamic> json) =>
    TransactionLinkUpdate(
      linkTypeId: json['link_type_id'] as String,
      linkTypeName: json['link_type_name'] as String,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkUpdateToJson(
    TransactionLinkUpdate instance) {
  final val = <String, dynamic>{
    'link_type_id': instance.linkTypeId,
    'link_type_name': instance.linkTypeName,
    'inward_id': instance.inwardId,
    'outward_id': instance.outwardId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}

LinkType _$LinkTypeFromJson(Map<String, dynamic> json) => LinkType(
      name: json['name'] as String,
      inward: json['inward'] as String,
      outward: json['outward'] as String,
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$LinkTypeToJson(LinkType instance) => <String, dynamic>{
      'name': instance.name,
      'inward': instance.inward,
      'outward': instance.outward,
      'editable': instance.editable,
    };

LinkTypeUpdate _$LinkTypeUpdateFromJson(Map<String, dynamic> json) =>
    LinkTypeUpdate(
      name: json['name'] as String,
      inward: json['inward'] as String,
      outward: json['outward'] as String,
    );

Map<String, dynamic> _$LinkTypeUpdateToJson(LinkTypeUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'inward': instance.inward,
      'outward': instance.outward,
    };

TransactionSplitStore _$TransactionSplitStoreFromJson(
        Map<String, dynamic> json) =>
    TransactionSplitStore(
      type: transactionTypePropertyFromJson(json['type']),
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as String,
      description: json['description'] as String,
      order: json['order'] as int?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      foreignAmount: json['foreign_amount'] as String?,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      sourceId: json['source_id'] as String?,
      sourceName: json['source_name'] as String?,
      destinationId: json['destination_id'] as String?,
      destinationName: json['destination_name'] as String?,
      reconciled: json['reconciled'] as bool,
      piggyBankId: json['piggy_bank_id'] as int,
      piggyBankName: json['piggy_bank_name'] as String,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      notes: json['notes'] as String?,
      internalReference: json['internal_reference'] as String?,
      externalId: json['external_id'] as String?,
      externalUrl: json['external_url'] as String?,
      bunqPaymentId: json['bunq_payment_id'] as String?,
      sepaCc: json['sepa_cc'] as String?,
      sepaCtOp: json['sepa_ct_op'] as String?,
      sepaCtId: json['sepa_ct_id'] as String?,
      sepaDb: json['sepa_db'] as String?,
      sepaCountry: json['sepa_country'] as String?,
      sepaEp: json['sepa_ep'] as String?,
      sepaCi: json['sepa_ci'] as String?,
      sepaBatchId: json['sepa_batch_id'] as String?,
      interestDate: json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
      bookDate: json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
      processDate: json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
    );

Map<String, dynamic> _$TransactionSplitStoreToJson(
    TransactionSplitStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', transactionTypePropertyToJson(instance.type));
  val['date'] = instance.date.toIso8601String();
  val['amount'] = instance.amount;
  val['description'] = instance.description;
  writeNotNull('order', instance.order);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('foreign_amount', instance.foreignAmount);
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('budget_name', instance.budgetName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('source_id', instance.sourceId);
  writeNotNull('source_name', instance.sourceName);
  writeNotNull('destination_id', instance.destinationId);
  writeNotNull('destination_name', instance.destinationName);
  val['reconciled'] = instance.reconciled;
  val['piggy_bank_id'] = instance.piggyBankId;
  val['piggy_bank_name'] = instance.piggyBankName;
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  writeNotNull('tags', instance.tags);
  writeNotNull('notes', instance.notes);
  writeNotNull('internal_reference', instance.internalReference);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_url', instance.externalUrl);
  writeNotNull('bunq_payment_id', instance.bunqPaymentId);
  writeNotNull('sepa_cc', instance.sepaCc);
  writeNotNull('sepa_ct_op', instance.sepaCtOp);
  writeNotNull('sepa_ct_id', instance.sepaCtId);
  writeNotNull('sepa_db', instance.sepaDb);
  writeNotNull('sepa_country', instance.sepaCountry);
  writeNotNull('sepa_ep', instance.sepaEp);
  writeNotNull('sepa_ci', instance.sepaCi);
  writeNotNull('sepa_batch_id', instance.sepaBatchId);
  writeNotNull('interest_date', instance.interestDate?.toIso8601String());
  writeNotNull('book_date', instance.bookDate?.toIso8601String());
  writeNotNull('process_date', instance.processDate?.toIso8601String());
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('payment_date', instance.paymentDate?.toIso8601String());
  writeNotNull('invoice_date', instance.invoiceDate?.toIso8601String());
  return val;
}

TransactionSplitUpdate _$TransactionSplitUpdateFromJson(
        Map<String, dynamic> json) =>
    TransactionSplitUpdate(
      transactionJournalId: json['transaction_journal_id'] as String,
      type: transactionTypePropertyFromJson(json['type']),
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as String,
      description: json['description'] as String,
      order: json['order'] as int?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      foreignAmount: json['foreign_amount'] as String?,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          json['foreign_currency_decimal_places'] as int?,
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      sourceId: json['source_id'] as String?,
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      destinationId: json['destination_id'] as String?,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      reconciled: json['reconciled'] as bool,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      notes: json['notes'] as String?,
      internalReference: json['internal_reference'] as String?,
      externalId: json['external_id'] as String?,
      externalUrl: json['external_url'] as String?,
      bunqPaymentId: json['bunq_payment_id'] as String?,
      sepaCc: json['sepa_cc'] as String?,
      sepaCtOp: json['sepa_ct_op'] as String?,
      sepaCtId: json['sepa_ct_id'] as String?,
      sepaDb: json['sepa_db'] as String?,
      sepaCountry: json['sepa_country'] as String?,
      sepaEp: json['sepa_ep'] as String?,
      sepaCi: json['sepa_ci'] as String?,
      sepaBatchId: json['sepa_batch_id'] as String?,
      interestDate: json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
      bookDate: json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
      processDate: json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
    );

Map<String, dynamic> _$TransactionSplitUpdateToJson(
    TransactionSplitUpdate instance) {
  final val = <String, dynamic>{
    'transaction_journal_id': instance.transactionJournalId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', transactionTypePropertyToJson(instance.type));
  val['date'] = instance.date.toIso8601String();
  val['amount'] = instance.amount;
  val['description'] = instance.description;
  writeNotNull('order', instance.order);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  val['currency_symbol'] = instance.currencySymbol;
  val['currency_name'] = instance.currencyName;
  val['currency_decimal_places'] = instance.currencyDecimalPlaces;
  writeNotNull('foreign_amount', instance.foreignAmount);
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('foreign_currency_symbol', instance.foreignCurrencySymbol);
  writeNotNull(
      'foreign_currency_decimal_places', instance.foreignCurrencyDecimalPlaces);
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('budget_name', instance.budgetName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('source_id', instance.sourceId);
  writeNotNull('source_name', instance.sourceName);
  writeNotNull('source_iban', instance.sourceIban);
  writeNotNull('destination_id', instance.destinationId);
  writeNotNull('destination_name', instance.destinationName);
  writeNotNull('destination_iban', instance.destinationIban);
  val['reconciled'] = instance.reconciled;
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  writeNotNull('tags', instance.tags);
  writeNotNull('notes', instance.notes);
  writeNotNull('internal_reference', instance.internalReference);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_url', instance.externalUrl);
  writeNotNull('bunq_payment_id', instance.bunqPaymentId);
  writeNotNull('sepa_cc', instance.sepaCc);
  writeNotNull('sepa_ct_op', instance.sepaCtOp);
  writeNotNull('sepa_ct_id', instance.sepaCtId);
  writeNotNull('sepa_db', instance.sepaDb);
  writeNotNull('sepa_country', instance.sepaCountry);
  writeNotNull('sepa_ep', instance.sepaEp);
  writeNotNull('sepa_ci', instance.sepaCi);
  writeNotNull('sepa_batch_id', instance.sepaBatchId);
  writeNotNull('interest_date', instance.interestDate?.toIso8601String());
  writeNotNull('book_date', instance.bookDate?.toIso8601String());
  writeNotNull('process_date', instance.processDate?.toIso8601String());
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('payment_date', instance.paymentDate?.toIso8601String());
  writeNotNull('invoice_date', instance.invoiceDate?.toIso8601String());
  return val;
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      email: json['email'] as String,
      blocked: json['blocked'] as bool,
      blockedCode:
          userBlockedCodePropertyNullableFromJson(json['blocked_code']),
      role: userRolePropertyNullableFromJson(json['role']),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'email': instance.email,
    'blocked': instance.blocked,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blocked_code',
      userBlockedCodePropertyNullableToJson(instance.blockedCode));
  writeNotNull('role', userRolePropertyNullableToJson(instance.role));
  return val;
}

Webhook _$WebhookFromJson(Map<String, dynamic> json) => Webhook(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool,
      title: json['title'] as String,
      secret: json['secret'] as String,
      trigger: webhookTriggerFromJson(json['trigger']),
      response: webhookResponseFromJson(json['response']),
      delivery: webhookDeliveryFromJson(json['delivery']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$WebhookToJson(Webhook instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'active': instance.active,
    'title': instance.title,
    'secret': instance.secret,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', webhookTriggerToJson(instance.trigger));
  writeNotNull('response', webhookResponseToJson(instance.response));
  writeNotNull('delivery', webhookDeliveryToJson(instance.delivery));
  val['url'] = instance.url;
  return val;
}

WebhookStore _$WebhookStoreFromJson(Map<String, dynamic> json) => WebhookStore(
      active: json['active'] as bool,
      title: json['title'] as String,
      trigger: webhookTriggerFromJson(json['trigger']),
      response: webhookResponseFromJson(json['response']),
      delivery: webhookDeliveryFromJson(json['delivery']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$WebhookStoreToJson(WebhookStore instance) {
  final val = <String, dynamic>{
    'active': instance.active,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', webhookTriggerToJson(instance.trigger));
  writeNotNull('response', webhookResponseToJson(instance.response));
  writeNotNull('delivery', webhookDeliveryToJson(instance.delivery));
  val['url'] = instance.url;
  return val;
}

WebhookUpdate _$WebhookUpdateFromJson(Map<String, dynamic> json) =>
    WebhookUpdate(
      active: json['active'] as bool,
      title: json['title'] as String,
      secret: json['secret'] as String,
      trigger: webhookTriggerFromJson(json['trigger']),
      response: webhookResponseFromJson(json['response']),
      delivery: webhookDeliveryFromJson(json['delivery']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$WebhookUpdateToJson(WebhookUpdate instance) {
  final val = <String, dynamic>{
    'active': instance.active,
    'title': instance.title,
    'secret': instance.secret,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('trigger', webhookTriggerToJson(instance.trigger));
  writeNotNull('response', webhookResponseToJson(instance.response));
  writeNotNull('delivery', webhookDeliveryToJson(instance.delivery));
  val['url'] = instance.url;
  return val;
}

WebhookAttempt _$WebhookAttemptFromJson(Map<String, dynamic> json) =>
    WebhookAttempt(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      webhookMessageId: json['webhook_message_id'] as String,
      statusCode: json['status_code'] as int?,
      logs: json['logs'] as String?,
      response: json['response'] as String?,
    );

Map<String, dynamic> _$WebhookAttemptToJson(WebhookAttempt instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'webhook_message_id': instance.webhookMessageId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status_code', instance.statusCode);
  writeNotNull('logs', instance.logs);
  writeNotNull('response', instance.response);
  return val;
}

WebhookMessage _$WebhookMessageFromJson(Map<String, dynamic> json) =>
    WebhookMessage(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      sent: json['sent'] as bool,
      errored: json['errored'] as bool,
      webhookId: json['webhook_id'] as String,
      uuid: json['uuid'] as String,
      $string: json['string'] as String?,
    );

Map<String, dynamic> _$WebhookMessageToJson(WebhookMessage instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'sent': instance.sent,
    'errored': instance.errored,
    'webhook_id': instance.webhookId,
    'uuid': instance.uuid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('string', instance.$string);
  return val;
}

PolymorphicProperty _$PolymorphicPropertyFromJson(Map<String, dynamic> json) =>
    PolymorphicProperty();

Map<String, dynamic> _$PolymorphicPropertyToJson(
        PolymorphicProperty instance) =>
    <String, dynamic>{};

BasicSummary _$BasicSummaryFromJson(Map<String, dynamic> json) =>
    BasicSummary();

Map<String, dynamic> _$BasicSummaryToJson(BasicSummary instance) =>
    <String, dynamic>{};

BasicSummaryEntry _$BasicSummaryEntryFromJson(Map<String, dynamic> json) =>
    BasicSummaryEntry(
      key: json['key'] as String,
      title: json['title'] as String,
      monetaryValue: (json['monetary_value'] as num).toDouble(),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      valueParsed: json['value_parsed'] as String,
      localIcon: json['local_icon'] as String,
      subTitle: json['sub_title'] as String,
    );

Map<String, dynamic> _$BasicSummaryEntryToJson(BasicSummaryEntry instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'monetary_value': instance.monetaryValue,
      'currency_id': instance.currencyId,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'currency_decimal_places': instance.currencyDecimalPlaces,
      'value_parsed': instance.valueParsed,
      'local_icon': instance.localIcon,
      'sub_title': instance.subTitle,
    };

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      title: configValueFilterFromJson(json['title']),
      value:
          PolymorphicProperty.fromJson(json['value'] as Map<String, dynamic>),
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', configValueFilterToJson(instance.title));
  val['value'] = instance.value.toJson();
  val['editable'] = instance.editable;
  return val;
}

ConfigurationUpdate _$ConfigurationUpdateFromJson(Map<String, dynamic> json) =>
    ConfigurationUpdate(
      value:
          PolymorphicProperty.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigurationUpdateToJson(
        ConfigurationUpdate instance) =>
    <String, dynamic>{
      'value': instance.value.toJson(),
    };

CronResult _$CronResultFromJson(Map<String, dynamic> json) => CronResult(
      recurringTransactions: CronResultRow.fromJson(
          json['recurring_transactions'] as Map<String, dynamic>),
      autoBudgets:
          CronResultRow.fromJson(json['auto_budgets'] as Map<String, dynamic>),
      telemetry:
          CronResultRow.fromJson(json['telemetry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CronResultToJson(CronResult instance) =>
    <String, dynamic>{
      'recurring_transactions': instance.recurringTransactions.toJson(),
      'auto_budgets': instance.autoBudgets.toJson(),
      'telemetry': instance.telemetry.toJson(),
    };

CronResultRow _$CronResultRowFromJson(Map<String, dynamic> json) =>
    CronResultRow(
      jobFired: json['job_fired'] as bool?,
      jobSucceeded: json['job_succeeded'] as bool?,
      jobErrored: json['job_errored'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CronResultRowToJson(CronResultRow instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_fired', instance.jobFired);
  writeNotNull('job_succeeded', instance.jobSucceeded);
  writeNotNull('job_errored', instance.jobErrored);
  writeNotNull('message', instance.message);
  return val;
}

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
      data: SystemInfo$Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UserSingle _$UserSingleFromJson(Map<String, dynamic> json) => UserSingle(
      data: UserRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSingleToJson(UserSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

TransactionArray _$TransactionArrayFromJson(Map<String, dynamic> json) =>
    TransactionArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TransactionRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionArrayToJson(TransactionArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

TransactionRead _$TransactionReadFromJson(Map<String, dynamic> json) =>
    TransactionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Transaction.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionReadToJson(TransactionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination:
          Meta$Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'pagination': instance.pagination.toJson(),
    };

ObjectLink _$ObjectLinkFromJson(Map<String, dynamic> json) => ObjectLink(
      self: json['self'] as String,
    );

Map<String, dynamic> _$ObjectLinkToJson(ObjectLink instance) =>
    <String, dynamic>{
      'self': instance.self,
    };

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
      self: json['self'] as String,
      first: json['first'] as String,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      last: json['last'] as String,
    );

Map<String, dynamic> _$PageLinkToJson(PageLink instance) {
  final val = <String, dynamic>{
    'self': instance.self,
    'first': instance.first,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('next', instance.next);
  writeNotNull('prev', instance.prev);
  val['last'] = instance.last;
  return val;
}

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] as String,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionSplit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'user': instance.user,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

TransactionSplit _$TransactionSplitFromJson(Map<String, dynamic> json) =>
    TransactionSplit(
      user: json['user'] as String,
      transactionJournalId: json['transaction_journal_id'] as String,
      type: transactionTypePropertyFromJson(json['type']),
      date: DateTime.parse(json['date'] as String),
      order: json['order'] as int?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          json['foreign_currency_decimal_places'] as int?,
      amount: json['amount'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      description: json['description'] as String,
      sourceId: json['source_id'] as String,
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      sourceType: accountTypePropertyFromJson(json['source_type']),
      destinationId: json['destination_id'] as String,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      destinationType: accountTypePropertyFromJson(json['destination_type']),
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      reconciled: json['reconciled'] as bool,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      internalReference: json['internal_reference'] as String?,
      externalId: json['external_id'] as String?,
      externalUrl: json['external_url'] as String?,
      originalSource: json['original_source'] as String?,
      recurrenceId: json['recurrence_id'] as String?,
      recurrenceTotal: json['recurrence_total'] as int?,
      recurrenceCount: json['recurrence_count'] as int?,
      bunqPaymentId: json['bunq_payment_id'] as String?,
      importHashV2: json['import_hash_v2'] as String?,
      sepaCc: json['sepa_cc'] as String?,
      sepaCtOp: json['sepa_ct_op'] as String?,
      sepaCtId: json['sepa_ct_id'] as String?,
      sepaDb: json['sepa_db'] as String?,
      sepaCountry: json['sepa_country'] as String?,
      sepaEp: json['sepa_ep'] as String?,
      sepaCi: json['sepa_ci'] as String?,
      sepaBatchId: json['sepa_batch_id'] as String?,
      interestDate: json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
      bookDate: json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
      processDate: json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
      hasAttachments: json['has_attachments'] as bool,
    );

Map<String, dynamic> _$TransactionSplitToJson(TransactionSplit instance) {
  final val = <String, dynamic>{
    'user': instance.user,
    'transaction_journal_id': instance.transactionJournalId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', transactionTypePropertyToJson(instance.type));
  val['date'] = instance.date.toIso8601String();
  writeNotNull('order', instance.order);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  val['currency_symbol'] = instance.currencySymbol;
  val['currency_name'] = instance.currencyName;
  val['currency_decimal_places'] = instance.currencyDecimalPlaces;
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('foreign_currency_symbol', instance.foreignCurrencySymbol);
  writeNotNull(
      'foreign_currency_decimal_places', instance.foreignCurrencyDecimalPlaces);
  val['amount'] = instance.amount;
  writeNotNull('foreign_amount', instance.foreignAmount);
  val['description'] = instance.description;
  val['source_id'] = instance.sourceId;
  writeNotNull('source_name', instance.sourceName);
  writeNotNull('source_iban', instance.sourceIban);
  writeNotNull('source_type', accountTypePropertyToJson(instance.sourceType));
  val['destination_id'] = instance.destinationId;
  writeNotNull('destination_name', instance.destinationName);
  writeNotNull('destination_iban', instance.destinationIban);
  writeNotNull(
      'destination_type', accountTypePropertyToJson(instance.destinationType));
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('budget_name', instance.budgetName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  val['reconciled'] = instance.reconciled;
  writeNotNull('notes', instance.notes);
  writeNotNull('tags', instance.tags);
  writeNotNull('internal_reference', instance.internalReference);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_url', instance.externalUrl);
  writeNotNull('original_source', instance.originalSource);
  writeNotNull('recurrence_id', instance.recurrenceId);
  writeNotNull('recurrence_total', instance.recurrenceTotal);
  writeNotNull('recurrence_count', instance.recurrenceCount);
  writeNotNull('bunq_payment_id', instance.bunqPaymentId);
  writeNotNull('import_hash_v2', instance.importHashV2);
  writeNotNull('sepa_cc', instance.sepaCc);
  writeNotNull('sepa_ct_op', instance.sepaCtOp);
  writeNotNull('sepa_ct_id', instance.sepaCtId);
  writeNotNull('sepa_db', instance.sepaDb);
  writeNotNull('sepa_country', instance.sepaCountry);
  writeNotNull('sepa_ep', instance.sepaEp);
  writeNotNull('sepa_ci', instance.sepaCi);
  writeNotNull('sepa_batch_id', instance.sepaBatchId);
  writeNotNull('interest_date', instance.interestDate?.toIso8601String());
  writeNotNull('book_date', instance.bookDate?.toIso8601String());
  writeNotNull('process_date', instance.processDate?.toIso8601String());
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('payment_date', instance.paymentDate?.toIso8601String());
  writeNotNull('invoice_date', instance.invoiceDate?.toIso8601String());
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  val['has_attachments'] = instance.hasAttachments;
  return val;
}

BadRequest _$BadRequestFromJson(Map<String, dynamic> json) => BadRequest(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$BadRequestToJson(BadRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

InternalException _$InternalExceptionFromJson(Map<String, dynamic> json) =>
    InternalException(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$InternalExceptionToJson(InternalException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

NotFound _$NotFoundFromJson(Map<String, dynamic> json) => NotFound(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$NotFoundToJson(NotFound instance) => <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

Unauthenticated _$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    Unauthenticated(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$UnauthenticatedToJson(Unauthenticated instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      message: json['message'] as String,
      errors: ValidationError$Errors.fromJson(
          json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors.toJson(),
    };

Bill$PaidDates$Item _$Bill$PaidDates$ItemFromJson(Map<String, dynamic> json) =>
    Bill$PaidDates$Item(
      transactionGroupId: json['transaction_group_id'] as String,
      transactionJournalId: json['transaction_journal_id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$Bill$PaidDates$ItemToJson(
        Bill$PaidDates$Item instance) =>
    <String, dynamic>{
      'transaction_group_id': instance.transactionGroupId,
      'transaction_journal_id': instance.transactionJournalId,
      'date': instance.date.toIso8601String(),
    };

SystemInfo$Data _$SystemInfo$DataFromJson(Map<String, dynamic> json) =>
    SystemInfo$Data(
      version: json['version'] as String,
      apiVersion: json['api_version'] as String,
      phpVersion: json['php_version'] as String,
      os: json['os'] as String,
      driver: json['driver'] as String,
    );

Map<String, dynamic> _$SystemInfo$DataToJson(SystemInfo$Data instance) =>
    <String, dynamic>{
      'version': instance.version,
      'api_version': instance.apiVersion,
      'php_version': instance.phpVersion,
      'os': instance.os,
      'driver': instance.driver,
    };

Meta$Pagination _$Meta$PaginationFromJson(Map<String, dynamic> json) =>
    Meta$Pagination(
      total: json['total'] as int,
      count: json['count'] as int,
      perPage: json['per_page'] as int,
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
    );

Map<String, dynamic> _$Meta$PaginationToJson(Meta$Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
    };

ValidationError$Errors _$ValidationError$ErrorsFromJson(
        Map<String, dynamic> json) =>
    ValidationError$Errors(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      blocked: (json['blocked'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      role:
          (json['role'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      blockedCode: (json['blocked_code'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      name:
          (json['name'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      type:
          (json['type'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      iban:
          (json['iban'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      start:
          (json['start'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      end: (json['end'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      date:
          (json['date'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$ValidationError$ErrorsToJson(
        ValidationError$Errors instance) =>
    <String, dynamic>{
      'email': instance.email,
      'blocked': instance.blocked,
      'role': instance.role,
      'blocked_code': instance.blockedCode,
      'name': instance.name,
      'type': instance.type,
      'iban': instance.iban,
      'start': instance.start,
      'end': instance.end,
      'date': instance.date,
    };
