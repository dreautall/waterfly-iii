// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountArray _$AccountArrayFromJson(Map<String, dynamic> json) => AccountArray(
  data:
      (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
  Map<String, dynamic> json,
) => AvailableBudgetArray(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => AvailableBudgetRead.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AvailableBudgetArrayToJson(
  AvailableBudgetArray instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};

BillArray _$BillArrayFromJson(Map<String, dynamic> json) => BillArray(
  data:
      (json['data'] as List<dynamic>?)
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
  data:
      (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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

CurrencyExchangeRateArray _$CurrencyExchangeRateArrayFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateArray(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => CurrencyExchangeRateRead.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrencyExchangeRateArrayToJson(
  CurrencyExchangeRateArray instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
  'links': instance.links.toJson(),
};

LinkTypeArray _$LinkTypeArrayFromJson(Map<String, dynamic> json) =>
    LinkTypeArray(
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => PiggyBankEventRead.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankEventArrayToJson(
  PiggyBankEventArray instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
  'links': instance.links.toJson(),
};

PreferenceArray _$PreferenceArrayFromJson(Map<String, dynamic> json) =>
    PreferenceArray(
      data:
          (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
  data:
      (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
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
  data:
      (json['data'] as List<dynamic>?)
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

TransactionArray _$TransactionArrayFromJson(Map<String, dynamic> json) =>
    TransactionArray(
      data:
          (json['data'] as List<dynamic>?)
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

TransactionLinkArray _$TransactionLinkArrayFromJson(
  Map<String, dynamic> json,
) => TransactionLinkArray(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TransactionLinkRead.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionLinkArrayToJson(
  TransactionLinkArray instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
  'links': instance.links.toJson(),
};

UserArray _$UserArrayFromJson(Map<String, dynamic> json) => UserArray(
  data:
      (json['data'] as List<dynamic>?)
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

UserGroupArray _$UserGroupArrayFromJson(Map<String, dynamic> json) =>
    UserGroupArray(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UserGroupRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupArrayToJson(UserGroupArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

WebhookArray _$WebhookArrayFromJson(Map<String, dynamic> json) => WebhookArray(
  data:
      (json['data'] as List<dynamic>?)
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
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => WebhookAttemptRead.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookAttemptArrayToJson(
  WebhookAttemptArray instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};

WebhookMessageArray _$WebhookMessageArrayFromJson(Map<String, dynamic> json) =>
    WebhookMessageArray(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => WebhookMessageRead.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookMessageArrayToJson(
  WebhookMessageArray instance,
) => <String, dynamic>{
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
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
      accountCurrencyId: json['account_currency_id'] as String?,
      accountCurrencyName: json['account_currency_name'] as String?,
      accountCurrencyCode: json['account_currency_code'] as String?,
      accountCurrencySymbol: json['account_currency_symbol'] as String?,
      accountCurrencyDecimalPlaces:
          (json['account_currency_decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AutocompleteAccountToJson(
  AutocompleteAccount instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_with_balance': instance.nameWithBalance,
  'type': instance.type,
  'currency_id': instance.currencyId,
  'currency_name': instance.currencyName,
  'currency_code': instance.currencyCode,
  'currency_symbol': instance.currencySymbol,
  'currency_decimal_places': instance.currencyDecimalPlaces,
  if (instance.accountCurrencyId case final value?)
    'account_currency_id': value,
  if (instance.accountCurrencyName case final value?)
    'account_currency_name': value,
  if (instance.accountCurrencyCode case final value?)
    'account_currency_code': value,
  if (instance.accountCurrencySymbol case final value?)
    'account_currency_symbol': value,
  if (instance.accountCurrencyDecimalPlaces case final value?)
    'account_currency_decimal_places': value,
};

AutocompleteBill _$AutocompleteBillFromJson(Map<String, dynamic> json) =>
    AutocompleteBill(
      id: json['id'] as String,
      name: json['name'] as String,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$AutocompleteBillToJson(AutocompleteBill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.active case final value?) 'active': value,
    };

AutocompleteBudget _$AutocompleteBudgetFromJson(Map<String, dynamic> json) =>
    AutocompleteBudget(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$AutocompleteBudgetToJson(AutocompleteBudget instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

AutocompleteCategory _$AutocompleteCategoryFromJson(
  Map<String, dynamic> json,
) => AutocompleteCategory(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$AutocompleteCategoryToJson(
  AutocompleteCategory instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

AutocompleteCurrency _$AutocompleteCurrencyFromJson(
  Map<String, dynamic> json,
) => AutocompleteCurrency(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  symbol: json['symbol'] as String,
  decimalPlaces: (json['decimal_places'] as num).toInt(),
);

Map<String, dynamic> _$AutocompleteCurrencyToJson(
  AutocompleteCurrency instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'symbol': instance.symbol,
  'decimal_places': instance.decimalPlaces,
};

AutocompleteCurrencyCode _$AutocompleteCurrencyCodeFromJson(
  Map<String, dynamic> json,
) => AutocompleteCurrencyCode(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  symbol: json['symbol'] as String,
  decimalPlaces: (json['decimal_places'] as num).toInt(),
);

Map<String, dynamic> _$AutocompleteCurrencyCodeToJson(
  AutocompleteCurrencyCode instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'symbol': instance.symbol,
  'decimal_places': instance.decimalPlaces,
};

AutocompleteObjectGroup _$AutocompleteObjectGroupFromJson(
  Map<String, dynamic> json,
) => AutocompleteObjectGroup(
  id: json['id'] as String,
  title: json['title'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$AutocompleteObjectGroupToJson(
  AutocompleteObjectGroup instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'name': instance.name,
};

AutocompletePiggy _$AutocompletePiggyFromJson(Map<String, dynamic> json) =>
    AutocompletePiggy(
      id: json['id'] as String,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$AutocompletePiggyToJson(
  AutocompletePiggy instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

AutocompletePiggyBalance _$AutocompletePiggyBalanceFromJson(
  Map<String, dynamic> json,
) => AutocompletePiggyBalance(
  id: json['id'] as String,
  name: json['name'] as String,
  nameWithBalance: json['name_with_balance'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  objectGroupId: json['object_group_id'] as String?,
  objectGroupTitle: json['object_group_title'] as String?,
);

Map<String, dynamic> _$AutocompletePiggyBalanceToJson(
  AutocompletePiggyBalance instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.nameWithBalance case final value?) 'name_with_balance': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

AutocompleteRecurrence _$AutocompleteRecurrenceFromJson(
  Map<String, dynamic> json,
) => AutocompleteRecurrence(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$AutocompleteRecurrenceToJson(
  AutocompleteRecurrence instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
};

AutocompleteRule _$AutocompleteRuleFromJson(Map<String, dynamic> json) =>
    AutocompleteRule(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AutocompleteRuleToJson(AutocompleteRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
    };

AutocompleteRuleGroup _$AutocompleteRuleGroupFromJson(
  Map<String, dynamic> json,
) => AutocompleteRuleGroup(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$AutocompleteRuleGroupToJson(
  AutocompleteRuleGroup instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
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
  Map<String, dynamic> json,
) => AutocompleteTransaction(
  id: json['id'] as String,
  transactionGroupId: json['transaction_group_id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$AutocompleteTransactionToJson(
  AutocompleteTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  if (instance.transactionGroupId case final value?)
    'transaction_group_id': value,
  'name': instance.name,
  'description': instance.description,
};

AutocompleteTransactionID _$AutocompleteTransactionIDFromJson(
  Map<String, dynamic> json,
) => AutocompleteTransactionID(
  id: json['id'] as String,
  transactionGroupId: json['transaction_group_id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$AutocompleteTransactionIDToJson(
  AutocompleteTransactionID instance,
) => <String, dynamic>{
  'id': instance.id,
  if (instance.transactionGroupId case final value?)
    'transaction_group_id': value,
  'name': instance.name,
  'description': instance.description,
};

AutocompleteTransactionType _$AutocompleteTransactionTypeFromJson(
  Map<String, dynamic> json,
) => AutocompleteTransactionType(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$AutocompleteTransactionTypeToJson(
  AutocompleteTransactionType instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
};

ChartDataPoint _$ChartDataPointFromJson(Map<String, dynamic> json) =>
    ChartDataPoint(key: json['key'] as String?);

Map<String, dynamic> _$ChartDataPointToJson(ChartDataPoint instance) =>
    <String, dynamic>{if (instance.key case final value?) 'key': value};

ChartDataSet _$ChartDataSetFromJson(Map<String, dynamic> json) => ChartDataSet(
  label: json['label'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  startDate:
      json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
  type: json['type'] as String?,
  period: chartDatasetPeriodPropertyNullableFromJson(json['period']),
  yAxisID: (json['yAxisID'] as num?)?.toInt(),
  entries: json['entries'],
  pcEntries: json['pc_entries'],
);

Map<String, dynamic> _$ChartDataSetToJson(
  ChartDataSet instance,
) => <String, dynamic>{
  if (instance.label case final value?) 'label': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
  if (instance.startDate?.toIso8601String() case final value?)
    'start_date': value,
  if (instance.endDate?.toIso8601String() case final value?) 'end_date': value,
  if (instance.type case final value?) 'type': value,
  if (chartDatasetPeriodPropertyNullableToJson(instance.period)
      case final value?)
    'period': value,
  if (instance.yAxisID case final value?) 'yAxisID': value,
  if (instance.entries case final value?) 'entries': value,
  if (instance.pcEntries case final value?) 'pc_entries': value,
};

InsightGroupEntry _$InsightGroupEntryFromJson(Map<String, dynamic> json) =>
    InsightGroupEntry(
      id: json['id'] as String?,
      name: json['name'] as String?,
      difference: json['difference'] as String?,
      differenceFloat: (json['difference_float'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
    );

Map<String, dynamic> _$InsightGroupEntryToJson(InsightGroupEntry instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.difference case final value?) 'difference': value,
      if (instance.differenceFloat case final value?) 'difference_float': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
    };

InsightTotalEntry _$InsightTotalEntryFromJson(Map<String, dynamic> json) =>
    InsightTotalEntry(
      difference: json['difference'] as String?,
      differenceFloat: (json['difference_float'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
    );

Map<String, dynamic> _$InsightTotalEntryToJson(InsightTotalEntry instance) =>
    <String, dynamic>{
      if (instance.difference case final value?) 'difference': value,
      if (instance.differenceFloat case final value?) 'difference_float': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
    };

InsightTransferEntry _$InsightTransferEntryFromJson(
  Map<String, dynamic> json,
) => InsightTransferEntry(
  id: json['id'] as String?,
  name: json['name'] as String?,
  difference: json['difference'] as String?,
  differenceFloat: (json['difference_float'] as num?)?.toDouble(),
  $in: json['in'] as String?,
  inFloat: (json['in_float'] as num?)?.toDouble(),
  out: json['out'] as String?,
  outFloat: (json['out_float'] as num?)?.toDouble(),
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
);

Map<String, dynamic> _$InsightTransferEntryToJson(
  InsightTransferEntry instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.name case final value?) 'name': value,
  if (instance.difference case final value?) 'difference': value,
  if (instance.differenceFloat case final value?) 'difference_float': value,
  if (instance.$in case final value?) 'in': value,
  if (instance.inFloat case final value?) 'in_float': value,
  if (instance.out case final value?) 'out': value,
  if (instance.outFloat case final value?) 'out_float': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
};

CategoryRead _$CategoryReadFromJson(Map<String, dynamic> json) => CategoryRead(
  type: json['type'] as String,
  id: json['id'] as String,
  attributes: CategoryProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
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
    <String, dynamic>{'data': instance.data.toJson()};

ConfigurationSingle _$ConfigurationSingleFromJson(Map<String, dynamic> json) =>
    ConfigurationSingle(
      data: Configuration.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigurationSingleToJson(
  ConfigurationSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

CurrencyRead _$CurrencyReadFromJson(Map<String, dynamic> json) => CurrencyRead(
  type: json['type'] as String,
  id: json['id'] as String,
  attributes: CurrencyProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
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
    <String, dynamic>{'data': instance.data.toJson()};

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
    <String, dynamic>{'data': instance.data.toJson()};

ObjectGroupRead _$ObjectGroupReadFromJson(Map<String, dynamic> json) =>
    ObjectGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: ObjectGroup.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

PiggyBankEventRead _$PiggyBankEventReadFromJson(Map<String, dynamic> json) =>
    PiggyBankEventRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: PiggyBankEventProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
      attributes: PiggyBankProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

PreferenceRead _$PreferenceReadFromJson(Map<String, dynamic> json) =>
    PreferenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Preference.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

RecurrenceRead _$RecurrenceReadFromJson(Map<String, dynamic> json) =>
    RecurrenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: RecurrenceProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

RuleGroupRead _$RuleGroupReadFromJson(Map<String, dynamic> json) =>
    RuleGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: RuleGroup.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

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

RuleSingle _$RuleSingleFromJson(Map<String, dynamic> json) =>
    RuleSingle(data: RuleRead.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$RuleSingleToJson(RuleSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

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

TagSingle _$TagSingleFromJson(Map<String, dynamic> json) =>
    TagSingle(data: TagRead.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$TagSingleToJson(TagSingle instance) => <String, dynamic>{
  'data': instance.data.toJson(),
};

TransactionLinkRead _$TransactionLinkReadFromJson(Map<String, dynamic> json) =>
    TransactionLinkRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: TransactionLink.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionLinkReadToJson(
  TransactionLinkRead instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'links': instance.links.toJson(),
};

TransactionLinkSingle _$TransactionLinkSingleFromJson(
  Map<String, dynamic> json,
) => TransactionLinkSingle(
  data: TransactionLinkRead.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionLinkSingleToJson(
  TransactionLinkSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

TransactionRead _$TransactionReadFromJson(Map<String, dynamic> json) =>
    TransactionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: Transaction.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionReadToJson(TransactionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

TransactionSingle _$TransactionSingleFromJson(Map<String, dynamic> json) =>
    TransactionSingle(
      data: TransactionRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionSingleToJson(TransactionSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

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
      attributes: WebhookAttempt.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WebhookAttemptReadToJson(WebhookAttemptRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

WebhookAttemptSingle _$WebhookAttemptSingleFromJson(
  Map<String, dynamic> json,
) => WebhookAttemptSingle(
  data: WebhookAttemptRead.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WebhookAttemptSingleToJson(
  WebhookAttemptSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

WebhookMessageRead _$WebhookMessageReadFromJson(Map<String, dynamic> json) =>
    WebhookMessageRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: WebhookMessage.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WebhookMessageReadToJson(WebhookMessageRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

WebhookMessageSingle _$WebhookMessageSingleFromJson(
  Map<String, dynamic> json,
) => WebhookMessageSingle(
  data: WebhookMessageRead.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WebhookMessageSingleToJson(
  WebhookMessageSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

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
    <String, dynamic>{'data': instance.data.toJson()};

AccountProperties _$AccountPropertiesFromJson(Map<String, dynamic> json) =>
    AccountProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt(),
      name: json['name'] as String,
      type: shortAccountTypePropertyFromJson(json['type']),
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyName: json['primary_currency_name'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
      primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
      primaryCurrencyDecimalPlaces:
          (json['primary_currency_decimal_places'] as num?)?.toInt(),
      currentBalance: json['current_balance'] as String?,
      pcCurrentBalance: json['pc_current_balance'] as String?,
      openingBalance: json['opening_balance'] as String?,
      pcOpeningBalance: json['pc_opening_balance'] as String?,
      virtualBalance: json['virtual_balance'] as String?,
      pcVirtualBalance: json['pc_virtual_balance'] as String?,
      debtAmount: json['debt_amount'] as String?,
      pcDebtAmount: json['pc_debt_amount'] as String?,
      currentBalanceDate:
          json['current_balance_date'] == null
              ? null
              : DateTime.parse(json['current_balance_date'] as String),
      notes: json['notes'] as String?,
      monthlyPaymentDate:
          json['monthly_payment_date'] == null
              ? null
              : DateTime.parse(json['monthly_payment_date'] as String),
      creditCardType: creditCardTypePropertyNullableFromJson(
        json['credit_card_type'],
      ),
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      openingBalanceDate:
          json['opening_balance_date'] == null
              ? null
              : DateTime.parse(json['opening_balance_date'] as String),
      liabilityType: liabilityTypePropertyNullableFromJson(
        json['liability_type'],
      ),
      liabilityDirection: liabilityDirectionPropertyNullableFromJson(
        json['liability_direction'],
      ),
      interest: json['interest'] as String?,
      interestPeriod: interestPeriodPropertyNullableFromJson(
        json['interest_period'],
      ),
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
      lastActivity:
          json['last_activity'] == null
              ? null
              : DateTime.parse(json['last_activity'] as String),
    );

Map<String, dynamic> _$AccountPropertiesToJson(
  AccountProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  'name': instance.name,
  if (shortAccountTypePropertyToJson(instance.type) case final value?)
    'type': value,
  if (accountRolePropertyNullableToJson(instance.accountRole) case final value?)
    'account_role': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupOrder case final value?) 'object_group_order': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.currentBalance case final value?) 'current_balance': value,
  if (instance.pcCurrentBalance case final value?) 'pc_current_balance': value,
  if (instance.openingBalance case final value?) 'opening_balance': value,
  if (instance.pcOpeningBalance case final value?) 'pc_opening_balance': value,
  if (instance.virtualBalance case final value?) 'virtual_balance': value,
  if (instance.pcVirtualBalance case final value?) 'pc_virtual_balance': value,
  if (instance.debtAmount case final value?) 'debt_amount': value,
  if (instance.pcDebtAmount case final value?) 'pc_debt_amount': value,
  if (instance.currentBalanceDate?.toIso8601String() case final value?)
    'current_balance_date': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.monthlyPaymentDate?.toIso8601String() case final value?)
    'monthly_payment_date': value,
  if (creditCardTypePropertyNullableToJson(instance.creditCardType)
      case final value?)
    'credit_card_type': value,
  if (instance.accountNumber case final value?) 'account_number': value,
  if (instance.iban case final value?) 'iban': value,
  if (instance.bic case final value?) 'bic': value,
  if (instance.openingBalanceDate?.toIso8601String() case final value?)
    'opening_balance_date': value,
  if (liabilityTypePropertyNullableToJson(instance.liabilityType)
      case final value?)
    'liability_type': value,
  if (liabilityDirectionPropertyNullableToJson(instance.liabilityDirection)
      case final value?)
    'liability_direction': value,
  if (instance.interest case final value?) 'interest': value,
  if (interestPeriodPropertyNullableToJson(instance.interestPeriod)
      case final value?)
    'interest_period': value,
  if (instance.includeNetWorth case final value?) 'include_net_worth': value,
  if (instance.longitude case final value?) 'longitude': value,
  if (instance.latitude case final value?) 'latitude': value,
  if (instance.zoomLevel case final value?) 'zoom_level': value,
  if (instance.lastActivity?.toIso8601String() case final value?)
    'last_activity': value,
};

AccountRead _$AccountReadFromJson(Map<String, dynamic> json) => AccountRead(
  type: json['type'] as String,
  id: json['id'] as String,
  attributes: AccountProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
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
    <String, dynamic>{'data': instance.data.toJson()};

AccountStore _$AccountStoreFromJson(Map<String, dynamic> json) => AccountStore(
  name: json['name'] as String,
  type: shortAccountTypePropertyFromJson(json['type']),
  iban: json['iban'] as String?,
  bic: json['bic'] as String?,
  accountNumber: json['account_number'] as String?,
  openingBalance: json['opening_balance'] as String?,
  openingBalanceDate:
      json['opening_balance_date'] == null
          ? null
          : DateTime.parse(json['opening_balance_date'] as String),
  virtualBalance: json['virtual_balance'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  active: json['active'] as bool? ?? true,
  order: (json['order'] as num?)?.toInt(),
  includeNetWorth: json['include_net_worth'] as bool? ?? true,
  accountRole: accountRolePropertyNullableFromJson(json['account_role']),
  creditCardType: creditCardTypePropertyNullableFromJson(
    json['credit_card_type'],
  ),
  monthlyPaymentDate:
      json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
  liabilityType: liabilityTypePropertyNullableFromJson(json['liability_type']),
  liabilityDirection: liabilityDirectionPropertyNullableFromJson(
    json['liability_direction'],
  ),
  interest: json['interest'] as String?,
  interestPeriod: interestPeriodPropertyNullableFromJson(
    json['interest_period'],
  ),
  notes: json['notes'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  zoomLevel: (json['zoom_level'] as num?)?.toInt(),
);

Map<String, dynamic> _$AccountStoreToJson(
  AccountStore instance,
) => <String, dynamic>{
  'name': instance.name,
  if (shortAccountTypePropertyToJson(instance.type) case final value?)
    'type': value,
  if (instance.iban case final value?) 'iban': value,
  if (instance.bic case final value?) 'bic': value,
  if (instance.accountNumber case final value?) 'account_number': value,
  if (instance.openingBalance case final value?) 'opening_balance': value,
  if (instance.openingBalanceDate?.toIso8601String() case final value?)
    'opening_balance_date': value,
  if (instance.virtualBalance case final value?) 'virtual_balance': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  if (instance.includeNetWorth case final value?) 'include_net_worth': value,
  if (accountRolePropertyNullableToJson(instance.accountRole) case final value?)
    'account_role': value,
  if (creditCardTypePropertyNullableToJson(instance.creditCardType)
      case final value?)
    'credit_card_type': value,
  if (instance.monthlyPaymentDate?.toIso8601String() case final value?)
    'monthly_payment_date': value,
  if (liabilityTypePropertyNullableToJson(instance.liabilityType)
      case final value?)
    'liability_type': value,
  if (liabilityDirectionPropertyNullableToJson(instance.liabilityDirection)
      case final value?)
    'liability_direction': value,
  if (instance.interest case final value?) 'interest': value,
  if (interestPeriodPropertyNullableToJson(instance.interestPeriod)
      case final value?)
    'interest_period': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.latitude case final value?) 'latitude': value,
  if (instance.longitude case final value?) 'longitude': value,
  if (instance.zoomLevel case final value?) 'zoom_level': value,
};

AccountUpdate _$AccountUpdateFromJson(Map<String, dynamic> json) =>
    AccountUpdate(
      name: json['name'] as String,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String?,
      openingBalanceDate:
          json['opening_balance_date'] == null
              ? null
              : DateTime.parse(json['opening_balance_date'] as String),
      virtualBalance: json['virtual_balance'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      active: json['active'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt(),
      includeNetWorth: json['include_net_worth'] as bool? ?? true,
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      creditCardType: creditCardTypePropertyNullableFromJson(
        json['credit_card_type'],
      ),
      monthlyPaymentDate:
          json['monthly_payment_date'] == null
              ? null
              : DateTime.parse(json['monthly_payment_date'] as String),
      liabilityType: liabilityTypePropertyNullableFromJson(
        json['liability_type'],
      ),
      interest: json['interest'] as String?,
      interestPeriod: interestPeriodPropertyNullableFromJson(
        json['interest_period'],
      ),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountUpdateToJson(
  AccountUpdate instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.iban case final value?) 'iban': value,
  if (instance.bic case final value?) 'bic': value,
  if (instance.accountNumber case final value?) 'account_number': value,
  if (instance.openingBalance case final value?) 'opening_balance': value,
  if (instance.openingBalanceDate?.toIso8601String() case final value?)
    'opening_balance_date': value,
  if (instance.virtualBalance case final value?) 'virtual_balance': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  if (instance.includeNetWorth case final value?) 'include_net_worth': value,
  if (accountRolePropertyNullableToJson(instance.accountRole) case final value?)
    'account_role': value,
  if (creditCardTypePropertyNullableToJson(instance.creditCardType)
      case final value?)
    'credit_card_type': value,
  if (instance.monthlyPaymentDate?.toIso8601String() case final value?)
    'monthly_payment_date': value,
  if (liabilityTypePropertyNullableToJson(instance.liabilityType)
      case final value?)
    'liability_type': value,
  if (instance.interest case final value?) 'interest': value,
  if (interestPeriodPropertyNullableToJson(instance.interestPeriod)
      case final value?)
    'interest_period': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.latitude case final value?) 'latitude': value,
  if (instance.longitude case final value?) 'longitude': value,
  if (instance.zoomLevel case final value?) 'zoom_level': value,
};

ArrayEntryWithCurrencyAndSum _$ArrayEntryWithCurrencyAndSumFromJson(
  Map<String, dynamic> json,
) => ArrayEntryWithCurrencyAndSum(
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  sum: json['sum'] as String?,
);

Map<String, dynamic> _$ArrayEntryWithCurrencyAndSumToJson(
  ArrayEntryWithCurrencyAndSum instance,
) => <String, dynamic>{
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.sum case final value?) 'sum': value,
};

AttachmentProperties _$AttachmentPropertiesFromJson(
  Map<String, dynamic> json,
) => AttachmentProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  attachableType: attachableTypeNullableFromJson(json['attachable_type']),
  attachableId: json['attachable_id'] as String?,
  hash: json['hash'] as String?,
  filename: json['filename'] as String?,
  downloadUrl: json['download_url'] as String?,
  uploadUrl: json['upload_url'] as String?,
  title: json['title'] as String?,
  notes: json['notes'] as String?,
  mime: json['mime'] as String?,
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$AttachmentPropertiesToJson(
  AttachmentProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (attachableTypeNullableToJson(instance.attachableType) case final value?)
    'attachable_type': value,
  if (instance.attachableId case final value?) 'attachable_id': value,
  if (instance.hash case final value?) 'hash': value,
  if (instance.filename case final value?) 'filename': value,
  if (instance.downloadUrl case final value?) 'download_url': value,
  if (instance.uploadUrl case final value?) 'upload_url': value,
  if (instance.title case final value?) 'title': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.mime case final value?) 'mime': value,
  if (instance.size case final value?) 'size': value,
};

AttachmentRead _$AttachmentReadFromJson(Map<String, dynamic> json) =>
    AttachmentRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: AttachmentProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

AttachmentStore _$AttachmentStoreFromJson(Map<String, dynamic> json) =>
    AttachmentStore(
      filename: json['filename'] as String,
      attachableType: attachableTypeFromJson(json['attachable_type']),
      attachableId: json['attachable_id'] as String,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentStoreToJson(AttachmentStore instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      if (attachableTypeToJson(instance.attachableType) case final value?)
        'attachable_type': value,
      'attachable_id': instance.attachableId,
      if (instance.title case final value?) 'title': value,
      if (instance.notes case final value?) 'notes': value,
    };

AttachmentUpdate _$AttachmentUpdateFromJson(Map<String, dynamic> json) =>
    AttachmentUpdate(
      filename: json['filename'] as String?,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentUpdateToJson(AttachmentUpdate instance) =>
    <String, dynamic>{
      if (instance.filename case final value?) 'filename': value,
      if (instance.title case final value?) 'title': value,
      if (instance.notes case final value?) 'notes': value,
    };

AvailableBudgetProperties _$AvailableBudgetPropertiesFromJson(
  Map<String, dynamic> json,
) => AvailableBudgetProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  amount: json['amount'] as String?,
  pcAmount: json['pc_amount'] as String?,
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  spentInBudgets:
      (json['spent_in_budgets'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  pcSpentInBudgets:
      (json['pc_spent_in_budgets'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  spentOutsideBudgets:
      (json['spent_outside_budgets'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  pcSpentOutsideBudgets:
      (json['pc_spent_outside_budgets'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$AvailableBudgetPropertiesToJson(
  AvailableBudgetProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.start?.toIso8601String() case final value?) 'start': value,
  if (instance.end?.toIso8601String() case final value?) 'end': value,
  if (instance.spentInBudgets?.map((e) => e.toJson()).toList()
      case final value?)
    'spent_in_budgets': value,
  if (instance.pcSpentInBudgets?.map((e) => e.toJson()).toList()
      case final value?)
    'pc_spent_in_budgets': value,
  if (instance.spentOutsideBudgets?.map((e) => e.toJson()).toList()
      case final value?)
    'spent_outside_budgets': value,
  if (instance.pcSpentOutsideBudgets?.map((e) => e.toJson()).toList()
      case final value?)
    'pc_spent_outside_budgets': value,
};

AvailableBudgetRead _$AvailableBudgetReadFromJson(Map<String, dynamic> json) =>
    AvailableBudgetRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: AvailableBudgetProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AvailableBudgetReadToJson(
  AvailableBudgetRead instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
};

AvailableBudgetSingle _$AvailableBudgetSingleFromJson(
  Map<String, dynamic> json,
) => AvailableBudgetSingle(
  data: AvailableBudgetRead.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AvailableBudgetSingleToJson(
  AvailableBudgetSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

BillProperties _$BillPropertiesFromJson(Map<String, dynamic> json) =>
    BillProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String?,
      objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyName: json['primary_currency_name'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
      primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
      primaryCurrencyDecimalPlaces:
          (json['primary_currency_decimal_places'] as num?)?.toInt(),
      amountMin: json['amount_min'] as String?,
      pcAmountMin: json['pc_amount_min'] as String?,
      amountMax: json['amount_max'] as String?,
      pcAmountMax: json['pc_amount_max'] as String?,
      amountAvg: json['amount_avg'] as String?,
      pcAmountAvg: json['pc_amount_avg'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      endDate:
          json['end_date'] == null
              ? null
              : DateTime.parse(json['end_date'] as String),
      extensionDate:
          json['extension_date'] == null
              ? null
              : DateTime.parse(json['extension_date'] as String),
      repeatFreq: billRepeatFrequencyNullableFromJson(json['repeat_freq']),
      skip: (json['skip'] as num?)?.toInt(),
      active: json['active'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id']?.toString(),
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      paidDates:
          (json['paid_dates'] as List<dynamic>?)
              ?.map(
                (e) => BillProperties$PaidDates$Item.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      payDates:
          (json['pay_dates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          [],
      nextExpectedMatch:
          json['next_expected_match'] == null
              ? null
              : DateTime.parse(json['next_expected_match'] as String),
      nextExpectedMatchDiff: json['next_expected_match_diff'] as String?,
    );

Map<String, dynamic> _$BillPropertiesToJson(
  BillProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.name case final value?) 'name': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.amountMin case final value?) 'amount_min': value,
  if (instance.pcAmountMin case final value?) 'pc_amount_min': value,
  if (instance.amountMax case final value?) 'amount_max': value,
  if (instance.pcAmountMax case final value?) 'pc_amount_max': value,
  if (instance.amountAvg case final value?) 'amount_avg': value,
  if (instance.pcAmountAvg case final value?) 'pc_amount_avg': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
  if (instance.endDate?.toIso8601String() case final value?) 'end_date': value,
  if (instance.extensionDate?.toIso8601String() case final value?)
    'extension_date': value,
  if (billRepeatFrequencyNullableToJson(instance.repeatFreq) case final value?)
    'repeat_freq': value,
  if (instance.skip case final value?) 'skip': value,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupOrder case final value?) 'object_group_order': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
  if (instance.paidDates?.map((e) => e.toJson()).toList() case final value?)
    'paid_dates': value,
  if (instance.payDates?.map((e) => e.toIso8601String()).toList()
      case final value?)
    'pay_dates': value,
  if (instance.nextExpectedMatch?.toIso8601String() case final value?)
    'next_expected_match': value,
  if (instance.nextExpectedMatchDiff case final value?)
    'next_expected_match_diff': value,
};

BillRead _$BillReadFromJson(Map<String, dynamic> json) => BillRead(
  type: json['type'] as String,
  id: json['id'] as String,
  attributes: BillProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$BillReadToJson(BillRead instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
};

BillSingle _$BillSingleFromJson(Map<String, dynamic> json) =>
    BillSingle(data: BillRead.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$BillSingleToJson(BillSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

BillStore _$BillStoreFromJson(Map<String, dynamic> json) => BillStore(
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  name: json['name'] as String,
  amountMin: json['amount_min'] as String,
  amountMax: json['amount_max'] as String,
  date: DateTime.parse(json['date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
  extensionDate:
      json['extension_date'] == null
          ? null
          : DateTime.parse(json['extension_date'] as String),
  repeatFreq: billRepeatFrequencyFromJson(json['repeat_freq']),
  skip: (json['skip'] as num?)?.toInt(),
  active: json['active'] as bool?,
  notes: json['notes'] as String?,
  objectGroupId: json['object_group_id'] as String?,
  objectGroupTitle: json['object_group_title'] as String?,
);

Map<String, dynamic> _$BillStoreToJson(BillStore instance) => <String, dynamic>{
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  'name': instance.name,
  'amount_min': instance.amountMin,
  'amount_max': instance.amountMax,
  'date': instance.date.toIso8601String(),
  if (instance.endDate?.toIso8601String() case final value?) 'end_date': value,
  if (instance.extensionDate?.toIso8601String() case final value?)
    'extension_date': value,
  if (billRepeatFrequencyToJson(instance.repeatFreq) case final value?)
    'repeat_freq': value,
  if (instance.skip case final value?) 'skip': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

BillUpdate _$BillUpdateFromJson(Map<String, dynamic> json) => BillUpdate(
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  name: json['name'] as String,
  amountMin: json['amount_min'] as String?,
  amountMax: json['amount_max'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
  extensionDate:
      json['extension_date'] == null
          ? null
          : DateTime.parse(json['extension_date'] as String),
  repeatFreq: billRepeatFrequencyNullableFromJson(json['repeat_freq']),
  skip: (json['skip'] as num?)?.toInt(),
  active: json['active'] as bool?,
  notes: json['notes'] as String?,
  objectGroupId: json['object_group_id'] as String?,
  objectGroupTitle: json['object_group_title'] as String?,
);

Map<String, dynamic> _$BillUpdateToJson(
  BillUpdate instance,
) => <String, dynamic>{
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  'name': instance.name,
  if (instance.amountMin case final value?) 'amount_min': value,
  if (instance.amountMax case final value?) 'amount_max': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
  if (instance.endDate?.toIso8601String() case final value?) 'end_date': value,
  if (instance.extensionDate?.toIso8601String() case final value?)
    'extension_date': value,
  if (billRepeatFrequencyNullableToJson(instance.repeatFreq) case final value?)
    'repeat_freq': value,
  if (instance.skip case final value?) 'skip': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

BudgetProperties _$BudgetPropertiesFromJson(Map<String, dynamic> json) =>
    BudgetProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool?,
      name: json['name'] as String,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
      autoBudgetPeriod: autoBudgetPeriodNullableFromJson(
        json['auto_budget_period'],
      ),
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyName: json['primary_currency_name'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
      primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
      primaryCurrencyDecimalPlaces:
          (json['primary_currency_decimal_places'] as num?)?.toInt(),
      autoBudgetAmount: json['auto_budget_amount'] as String?,
      pcAutoBudgetAmount: json['pc_auto_budget_amount'] as String?,
      spent:
          (json['spent'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      pcSpent:
          (json['pc_spent'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$BudgetPropertiesToJson(
  BudgetProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.active case final value?) 'active': value,
  'name': instance.name,
  if (instance.order case final value?) 'order': value,
  if (instance.notes case final value?) 'notes': value,
  if (autoBudgetTypeNullableToJson(instance.autoBudgetType) case final value?)
    'auto_budget_type': value,
  if (autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod)
      case final value?)
    'auto_budget_period': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupOrder case final value?) 'object_group_order': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.autoBudgetAmount case final value?) 'auto_budget_amount': value,
  if (instance.pcAutoBudgetAmount case final value?)
    'pc_auto_budget_amount': value,
  if (instance.spent?.map((e) => e.toJson()).toList() case final value?)
    'spent': value,
  if (instance.pcSpent?.map((e) => e.toJson()).toList() case final value?)
    'pc_spent': value,
};

BudgetRead _$BudgetReadFromJson(Map<String, dynamic> json) => BudgetRead(
  type: json['type'] as String,
  id: json['id'] as String,
  attributes: BudgetProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
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
    <String, dynamic>{'data': instance.data.toJson()};

BudgetStore _$BudgetStoreFromJson(Map<String, dynamic> json) => BudgetStore(
  name: json['name'] as String,
  active: json['active'] as bool?,
  order: (json['order'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
  autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
  autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
  autoBudgetAmount: json['auto_budget_amount'] as String?,
  autoBudgetPeriod: autoBudgetPeriodNullableFromJson(
    json['auto_budget_period'],
  ),
);

Map<String, dynamic> _$BudgetStoreToJson(
  BudgetStore instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  if (instance.notes case final value?) 'notes': value,
  if (autoBudgetTypeNullableToJson(instance.autoBudgetType) case final value?)
    'auto_budget_type': value,
  if (instance.autoBudgetCurrencyId case final value?)
    'auto_budget_currency_id': value,
  if (instance.autoBudgetCurrencyCode case final value?)
    'auto_budget_currency_code': value,
  if (instance.autoBudgetAmount case final value?) 'auto_budget_amount': value,
  if (autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod)
      case final value?)
    'auto_budget_period': value,
};

BudgetUpdate _$BudgetUpdateFromJson(Map<String, dynamic> json) => BudgetUpdate(
  name: json['name'] as String,
  active: json['active'] as bool?,
  order: (json['order'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  autoBudgetType: autoBudgetTypeNullableFromJson(json['auto_budget_type']),
  autoBudgetCurrencyId: json['auto_budget_currency_id'] as String?,
  autoBudgetCurrencyCode: json['auto_budget_currency_code'] as String?,
  autoBudgetAmount: json['auto_budget_amount'] as String?,
  autoBudgetPeriod: autoBudgetPeriodNullableFromJson(
    json['auto_budget_period'],
  ),
);

Map<String, dynamic> _$BudgetUpdateToJson(
  BudgetUpdate instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.active case final value?) 'active': value,
  if (instance.order case final value?) 'order': value,
  if (instance.notes case final value?) 'notes': value,
  if (autoBudgetTypeNullableToJson(instance.autoBudgetType) case final value?)
    'auto_budget_type': value,
  if (instance.autoBudgetCurrencyId case final value?)
    'auto_budget_currency_id': value,
  if (instance.autoBudgetCurrencyCode case final value?)
    'auto_budget_currency_code': value,
  if (instance.autoBudgetAmount case final value?) 'auto_budget_amount': value,
  if (autoBudgetPeriodNullableToJson(instance.autoBudgetPeriod)
      case final value?)
    'auto_budget_period': value,
};

BudgetLimitProperties _$BudgetLimitPropertiesFromJson(
  Map<String, dynamic> json,
) => BudgetLimitProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  budgetId: json['budget_id'] as String?,
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  amount: json['amount'] as String?,
  pcAmount: json['pc_amount'] as String?,
  period: json['period'] as String?,
  spent:
      (json['spent'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  pcSpent:
      (json['pc_spent'] as List<dynamic>?)
          ?.map(
            (e) => ArrayEntryWithCurrencyAndSum.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$BudgetLimitPropertiesToJson(
  BudgetLimitProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.start?.toIso8601String() case final value?) 'start': value,
  if (instance.end?.toIso8601String() case final value?) 'end': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.period case final value?) 'period': value,
  if (instance.spent?.map((e) => e.toJson()).toList() case final value?)
    'spent': value,
  if (instance.pcSpent?.map((e) => e.toJson()).toList() case final value?)
    'pc_spent': value,
  if (instance.notes case final value?) 'notes': value,
};

BudgetLimitRead _$BudgetLimitReadFromJson(Map<String, dynamic> json) =>
    BudgetLimitRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: BudgetLimitProperties.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
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
    <String, dynamic>{'data': instance.data.toJson()};

BudgetLimitStore _$BudgetLimitStoreFromJson(Map<String, dynamic> json) =>
    BudgetLimitStore(
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      budgetId: json['budget_id'] as String?,
      start: DateTime.parse(json['start'] as String),
      period: json['period'] as String?,
      end: DateTime.parse(json['end'] as String),
      amount: json['amount'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BudgetLimitStoreToJson(BudgetLimitStore instance) =>
    <String, dynamic>{
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.budgetId case final value?) 'budget_id': value,
      if (_dateToJson(instance.start) case final value?) 'start': value,
      if (instance.period case final value?) 'period': value,
      if (_dateToJson(instance.end) case final value?) 'end': value,
      'amount': instance.amount,
      if (instance.notes case final value?) 'notes': value,
    };

BudgetLimitUpdate _$BudgetLimitUpdateFromJson(
  Map<String, dynamic> json,
) => BudgetLimitUpdate(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  budgetId: json['budget_id'] as String?,
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  period: json['period'] as String?,
  amount: json['amount'] as String?,
  pcAmount: json['pc_amount'] as String?,
  spent: json['spent'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$BudgetLimitUpdateToJson(BudgetLimitUpdate instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.start?.toIso8601String() case final value?) 'start': value,
      if (instance.end?.toIso8601String() case final value?) 'end': value,
      if (instance.budgetId case final value?) 'budget_id': value,
      if (instance.objectHasCurrencySetting case final value?)
        'object_has_currency_setting': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyName case final value?) 'currency_name': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.primaryCurrencyId case final value?)
        'primary_currency_id': value,
      if (instance.primaryCurrencyName case final value?)
        'primary_currency_name': value,
      if (instance.primaryCurrencyCode case final value?)
        'primary_currency_code': value,
      if (instance.primaryCurrencySymbol case final value?)
        'primary_currency_symbol': value,
      if (instance.primaryCurrencyDecimalPlaces case final value?)
        'primary_currency_decimal_places': value,
      if (instance.period case final value?) 'period': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.pcAmount case final value?) 'pc_amount': value,
      if (instance.spent case final value?) 'spent': value,
      if (instance.notes case final value?) 'notes': value,
    };

CategoryProperties _$CategoryPropertiesFromJson(Map<String, dynamic> json) =>
    CategoryProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      notes: json['notes'] as String?,
      objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyName: json['primary_currency_name'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
      primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
      primaryCurrencyDecimalPlaces:
          (json['primary_currency_decimal_places'] as num?)?.toInt(),
      spent:
          (json['spent'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      pcSpent:
          (json['pc_spent'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      earned:
          (json['earned'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      pcEarned:
          (json['pc_earned'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      transferred:
          (json['transferred'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      pcTransferred:
          (json['pc_transferred'] as List<dynamic>?)
              ?.map(
                (e) => ArrayEntryWithCurrencyAndSum.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$CategoryPropertiesToJson(
  CategoryProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'name': instance.name,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.spent?.map((e) => e.toJson()).toList() case final value?)
    'spent': value,
  if (instance.pcSpent?.map((e) => e.toJson()).toList() case final value?)
    'pc_spent': value,
  if (instance.earned?.map((e) => e.toJson()).toList() case final value?)
    'earned': value,
  if (instance.pcEarned?.map((e) => e.toJson()).toList() case final value?)
    'pc_earned': value,
  if (instance.transferred?.map((e) => e.toJson()).toList() case final value?)
    'transferred': value,
  if (instance.pcTransferred?.map((e) => e.toJson()).toList() case final value?)
    'pc_transferred': value,
};

CategoryStore _$CategoryStoreFromJson(Map<String, dynamic> json) =>
    CategoryStore(
      name: json['name'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CategoryStoreToJson(CategoryStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      if (instance.notes case final value?) 'notes': value,
    };

CategoryUpdate _$CategoryUpdateFromJson(Map<String, dynamic> json) =>
    CategoryUpdate(
      name: json['name'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CategoryUpdateToJson(CategoryUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      if (instance.notes case final value?) 'notes': value,
    };

CurrencyExchangeProperties _$CurrencyExchangePropertiesFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  fromCurrencyId: json['from_currency_id'] as String?,
  fromCurrencyName: json['from_currency_name'] as String?,
  fromCurrencyCode: json['from_currency_code'] as String?,
  fromCurrencySymbol: json['from_currency_symbol'] as String?,
  fromCurrencyDecimalPlaces:
      (json['from_currency_decimal_places'] as num?)?.toInt(),
  toCurrencyId: json['to_currency_id'] as String?,
  toCurrencyName: json['to_currency_name'] as String?,
  toCurrencyCode: json['to_currency_code'] as String?,
  toCurrencySymbol: json['to_currency_symbol'] as String?,
  toCurrencyDecimalPlaces:
      (json['to_currency_decimal_places'] as num?)?.toInt(),
  rate: json['rate'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$CurrencyExchangePropertiesToJson(
  CurrencyExchangeProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.fromCurrencyId case final value?) 'from_currency_id': value,
  if (instance.fromCurrencyName case final value?) 'from_currency_name': value,
  if (instance.fromCurrencyCode case final value?) 'from_currency_code': value,
  if (instance.fromCurrencySymbol case final value?)
    'from_currency_symbol': value,
  if (instance.fromCurrencyDecimalPlaces case final value?)
    'from_currency_decimal_places': value,
  if (instance.toCurrencyId case final value?) 'to_currency_id': value,
  if (instance.toCurrencyName case final value?) 'to_currency_name': value,
  if (instance.toCurrencyCode case final value?) 'to_currency_code': value,
  if (instance.toCurrencySymbol case final value?) 'to_currency_symbol': value,
  if (instance.toCurrencyDecimalPlaces case final value?)
    'to_currency_decimal_places': value,
  if (instance.rate case final value?) 'rate': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
};

CurrencyExchangeRateRead _$CurrencyExchangeRateReadFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateRead(
  type: json['type'] as String?,
  id: json['id'] as String?,
  attributes:
      json['attributes'] == null
          ? null
          : CurrencyExchangeProperties.fromJson(
            json['attributes'] as Map<String, dynamic>,
          ),
  links:
      json['links'] == null
          ? null
          : ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrencyExchangeRateReadToJson(
  CurrencyExchangeRateRead instance,
) => <String, dynamic>{
  if (instance.type case final value?) 'type': value,
  if (instance.id case final value?) 'id': value,
  if (instance.attributes?.toJson() case final value?) 'attributes': value,
  if (instance.links?.toJson() case final value?) 'links': value,
};

CurrencyExchangeRateSingle _$CurrencyExchangeRateSingleFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateSingle(
  data: CurrencyExchangeRateRead.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrencyExchangeRateSingleToJson(
  CurrencyExchangeRateSingle instance,
) => <String, dynamic>{'data': instance.data.toJson()};

CurrencyExchangeRateStore _$CurrencyExchangeRateStoreFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateStore(
  from: json['from'] as String,
  to: json['to'] as String,
  rate: json['rate'] as String?,
);

Map<String, dynamic> _$CurrencyExchangeRateStoreToJson(
  CurrencyExchangeRateStore instance,
) => <String, dynamic>{
  'from': instance.from,
  'to': instance.to,
  if (instance.rate case final value?) 'rate': value,
};

CurrencyExchangeRateStoreByDate _$CurrencyExchangeRateStoreByDateFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateStoreByDate(
  from: json['from'] as String,
  rates: json['rates'] as Map<String, dynamic>,
);

Map<String, dynamic> _$CurrencyExchangeRateStoreByDateToJson(
  CurrencyExchangeRateStoreByDate instance,
) => <String, dynamic>{'from': instance.from, 'rates': instance.rates};

CurrencyExchangeRateStoreByPair _$CurrencyExchangeRateStoreByPairFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateStoreByPair();

Map<String, dynamic> _$CurrencyExchangeRateStoreByPairToJson(
  CurrencyExchangeRateStoreByPair instance,
) => <String, dynamic>{};

CurrencyExchangeRateUpdate _$CurrencyExchangeRateUpdateFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateUpdate(
  date: DateTime.parse(json['date'] as String),
  rate: json['rate'] as String,
  from: json['from'] as String?,
  to: json['to'] as String?,
);

Map<String, dynamic> _$CurrencyExchangeRateUpdateToJson(
  CurrencyExchangeRateUpdate instance,
) => <String, dynamic>{
  if (_dateToJson(instance.date) case final value?) 'date': value,
  'rate': instance.rate,
  if (instance.from case final value?) 'from': value,
  if (instance.to case final value?) 'to': value,
};

CurrencyExchangeRateUpdateNoDate _$CurrencyExchangeRateUpdateNoDateFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateUpdateNoDate(rate: json['rate'] as String);

Map<String, dynamic> _$CurrencyExchangeRateUpdateNoDateToJson(
  CurrencyExchangeRateUpdateNoDate instance,
) => <String, dynamic>{'rate': instance.rate};

ObjectGroup _$ObjectGroupFromJson(Map<String, dynamic> json) => ObjectGroup(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$ObjectGroupToJson(ObjectGroup instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'title': instance.title,
      'order': instance.order,
    };

ObjectGroupUpdate _$ObjectGroupUpdateFromJson(Map<String, dynamic> json) =>
    ObjectGroupUpdate(
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ObjectGroupUpdateToJson(ObjectGroupUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      if (instance.order case final value?) 'order': value,
    };

ObjectLink _$ObjectLinkFromJson(Map<String, dynamic> json) =>
    ObjectLink(self: json['self'] as String?);

Map<String, dynamic> _$ObjectLinkToJson(ObjectLink instance) =>
    <String, dynamic>{if (instance.self case final value?) 'self': value};

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
  self: json['self'] as String?,
  first: json['first'] as String?,
  next: json['next'] as String?,
  prev: json['prev'] as String?,
  last: json['last'] as String?,
);

Map<String, dynamic> _$PageLinkToJson(PageLink instance) => <String, dynamic>{
  if (instance.self case final value?) 'self': value,
  if (instance.first case final value?) 'first': value,
  if (instance.next case final value?) 'next': value,
  if (instance.prev case final value?) 'prev': value,
  if (instance.last case final value?) 'last': value,
};

PiggyBankAccountRead _$PiggyBankAccountReadFromJson(
  Map<String, dynamic> json,
) => PiggyBankAccountRead(
  accountId: json['account_id'] as String?,
  name: json['name'] as String?,
  currentAmount: json['current_amount'] as String?,
  pcCurrentAmount: json['pc_current_amount'] as String?,
);

Map<String, dynamic> _$PiggyBankAccountReadToJson(
  PiggyBankAccountRead instance,
) => <String, dynamic>{
  if (instance.accountId case final value?) 'account_id': value,
  if (instance.name case final value?) 'name': value,
  if (instance.currentAmount case final value?) 'current_amount': value,
  if (instance.pcCurrentAmount case final value?) 'pc_current_amount': value,
};

PiggyBankAccountStore _$PiggyBankAccountStoreFromJson(
  Map<String, dynamic> json,
) => PiggyBankAccountStore(
  id: json['id'] as String?,
  name: json['name'] as String?,
  currentAmount: json['current_amount'] as String?,
);

Map<String, dynamic> _$PiggyBankAccountStoreToJson(
  PiggyBankAccountStore instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.name case final value?) 'name': value,
  if (instance.currentAmount case final value?) 'current_amount': value,
};

PiggyBankAccountUpdate _$PiggyBankAccountUpdateFromJson(
  Map<String, dynamic> json,
) => PiggyBankAccountUpdate(
  accountId: json['account_id'] as String?,
  name: json['name'] as String?,
  currentAmount: json['current_amount'] as String?,
);

Map<String, dynamic> _$PiggyBankAccountUpdateToJson(
  PiggyBankAccountUpdate instance,
) => <String, dynamic>{
  if (instance.accountId case final value?) 'account_id': value,
  if (instance.name case final value?) 'name': value,
  if (instance.currentAmount case final value?) 'current_amount': value,
};

PiggyBankProperties _$PiggyBankPropertiesFromJson(Map<String, dynamic> json) =>
    PiggyBankProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      percentage: (json['percentage'] as num?)?.toDouble(),
      startDate:
          json['start_date'] == null
              ? null
              : DateTime.parse(json['start_date'] as String),
      targetDate:
          json['target_date'] == null
              ? null
              : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map(
                (e) => PiggyBankAccountRead.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyName: json['primary_currency_name'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
      primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
      primaryCurrencyDecimalPlaces:
          (json['primary_currency_decimal_places'] as num?)?.toInt(),
      targetAmount: json['target_amount'] as String?,
      pcTargetAmount: json['pc_target_amount'] as String?,
      currentAmount: json['current_amount'] as String?,
      pcCurrentAmount: json['pc_current_amount'] as String?,
      leftToSave: json['left_to_save'] as String?,
      pcLeftToSave: json['pc_left_to_save'] as String?,
      savePerMonth: json['save_per_month'] as String?,
      pcSavePerMonth: json['pc_save_per_month'] as String?,
    );

Map<String, dynamic> _$PiggyBankPropertiesToJson(
  PiggyBankProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'name': instance.name,
  if (instance.percentage case final value?) 'percentage': value,
  if (instance.startDate?.toIso8601String() case final value?)
    'start_date': value,
  if (instance.targetDate?.toIso8601String() case final value?)
    'target_date': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupOrder case final value?) 'object_group_order': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
  if (instance.accounts?.map((e) => e.toJson()).toList() case final value?)
    'accounts': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.targetAmount case final value?) 'target_amount': value,
  if (instance.pcTargetAmount case final value?) 'pc_target_amount': value,
  if (instance.currentAmount case final value?) 'current_amount': value,
  if (instance.pcCurrentAmount case final value?) 'pc_current_amount': value,
  if (instance.leftToSave case final value?) 'left_to_save': value,
  if (instance.pcLeftToSave case final value?) 'pc_left_to_save': value,
  if (instance.savePerMonth case final value?) 'save_per_month': value,
  if (instance.pcSavePerMonth case final value?) 'pc_save_per_month': value,
};

PiggyBankStore _$PiggyBankStoreFromJson(Map<String, dynamic> json) =>
    PiggyBankStore(
      name: json['name'] as String,
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PiggyBankAccountStore.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      targetAmount: json['target_amount'] as String?,
      currentAmount: json['current_amount'] as String?,
      startDate:
          json['start_date'] == null
              ? null
              : DateTime.parse(json['start_date'] as String),
      targetDate:
          json['target_date'] == null
              ? null
              : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankStoreToJson(
  PiggyBankStore instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.accounts?.map((e) => e.toJson()).toList() case final value?)
    'accounts': value,
  if (instance.targetAmount case final value?) 'target_amount': value,
  if (instance.currentAmount case final value?) 'current_amount': value,
  if (_dateToJson(instance.startDate) case final value?) 'start_date': value,
  if (_dateToJson(instance.targetDate) case final value?) 'target_date': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

PiggyBankUpdate _$PiggyBankUpdateFromJson(Map<String, dynamic> json) =>
    PiggyBankUpdate(
      name: json['name'] as String?,
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PiggyBankAccountUpdate.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      targetAmount: json['target_amount'] as String?,
      startDate:
          json['start_date'] == null
              ? null
              : DateTime.parse(json['start_date'] as String),
      targetDate:
          json['target_date'] == null
              ? null
              : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankUpdateToJson(
  PiggyBankUpdate instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.accounts?.map((e) => e.toJson()).toList() case final value?)
    'accounts': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.targetAmount case final value?) 'target_amount': value,
  if (_dateToJson(instance.startDate) case final value?) 'start_date': value,
  if (_dateToJson(instance.targetDate) case final value?) 'target_date': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.objectGroupId case final value?) 'object_group_id': value,
  if (instance.objectGroupTitle case final value?) 'object_group_title': value,
};

PiggyBankEventProperties _$PiggyBankEventPropertiesFromJson(
  Map<String, dynamic> json,
) => PiggyBankEventProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  amount: json['amount'] as String?,
  pcAmount: json['pc_amount'] as String?,
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  transactionJournalId: json['transaction_journal_id'] as String?,
  transactionGroupId: json['transaction_group_id'] as String?,
);

Map<String, dynamic> _$PiggyBankEventPropertiesToJson(
  PiggyBankEventProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.transactionJournalId case final value?)
    'transaction_journal_id': value,
  if (instance.transactionGroupId case final value?)
    'transaction_group_id': value,
};

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  name: json['name'] as String,
  data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'name': instance.name,
      'data': instance.data.toJson(),
    };

PreferenceUpdate _$PreferenceUpdateFromJson(Map<String, dynamic> json) =>
    PreferenceUpdate(
      data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceUpdateToJson(PreferenceUpdate instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

RecurrenceProperties _$RecurrencePropertiesFromJson(
  Map<String, dynamic> json,
) => RecurrenceProperties(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  type: recurrenceTransactionTypeNullableFromJson(json['type']),
  title: json['title'] as String?,
  description: json['description'] as String?,
  firstDate:
      json['first_date'] == null
          ? null
          : DateTime.parse(json['first_date'] as String),
  latestDate:
      json['latest_date'] == null
          ? null
          : DateTime.parse(json['latest_date'] as String),
  repeatUntil:
      json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
  applyRules: json['apply_rules'] as bool?,
  active: json['active'] as bool?,
  nrOfRepetitions: (json['nr_of_repetitions'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  repetitions:
      (json['repetitions'] as List<dynamic>?)
          ?.map((e) => RecurrenceRepetition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map(
            (e) => RecurrenceTransaction.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$RecurrencePropertiesToJson(
  RecurrenceProperties instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (recurrenceTransactionTypeNullableToJson(instance.type) case final value?)
    'type': value,
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (_dateToJson(instance.firstDate) case final value?) 'first_date': value,
  if (_dateToJson(instance.latestDate) case final value?) 'latest_date': value,
  if (_dateToJson(instance.repeatUntil) case final value?)
    'repeat_until': value,
  if (instance.applyRules case final value?) 'apply_rules': value,
  if (instance.active case final value?) 'active': value,
  if (instance.nrOfRepetitions case final value?) 'nr_of_repetitions': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.repetitions?.map((e) => e.toJson()).toList() case final value?)
    'repetitions': value,
  if (instance.transactions?.map((e) => e.toJson()).toList() case final value?)
    'transactions': value,
};

RecurrenceStore _$RecurrenceStoreFromJson(
  Map<String, dynamic> json,
) => RecurrenceStore(
  type: recurrenceTransactionTypeFromJson(json['type']),
  title: json['title'] as String,
  description: json['description'] as String?,
  firstDate: DateTime.parse(json['first_date'] as String),
  repeatUntil:
      json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
  nrOfRepetitions: (json['nr_of_repetitions'] as num?)?.toInt(),
  applyRules: json['apply_rules'] as bool?,
  active: json['active'] as bool?,
  notes: json['notes'] as String?,
  repetitions:
      (json['repetitions'] as List<dynamic>?)
          ?.map(
            (e) =>
                RecurrenceRepetitionStore.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map(
            (e) =>
                RecurrenceTransactionStore.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$RecurrenceStoreToJson(
  RecurrenceStore instance,
) => <String, dynamic>{
  if (recurrenceTransactionTypeToJson(instance.type) case final value?)
    'type': value,
  'title': instance.title,
  if (instance.description case final value?) 'description': value,
  if (_dateToJson(instance.firstDate) case final value?) 'first_date': value,
  if (_dateToJson(instance.repeatUntil) case final value?)
    'repeat_until': value,
  if (instance.nrOfRepetitions case final value?) 'nr_of_repetitions': value,
  if (instance.applyRules case final value?) 'apply_rules': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  'repetitions': instance.repetitions.map((e) => e.toJson()).toList(),
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
};

RecurrenceUpdate _$RecurrenceUpdateFromJson(
  Map<String, dynamic> json,
) => RecurrenceUpdate(
  title: json['title'] as String?,
  description: json['description'] as String?,
  firstDate:
      json['first_date'] == null
          ? null
          : DateTime.parse(json['first_date'] as String),
  repeatUntil:
      json['repeat_until'] == null
          ? null
          : DateTime.parse(json['repeat_until'] as String),
  nrOfRepetitions: (json['nr_of_repetitions'] as num?)?.toInt(),
  applyRules: json['apply_rules'] as bool?,
  active: json['active'] as bool?,
  notes: json['notes'] as String?,
  repetitions:
      (json['repetitions'] as List<dynamic>?)
          ?.map(
            (e) =>
                RecurrenceRepetitionUpdate.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map(
            (e) =>
                RecurrenceTransactionUpdate.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$RecurrenceUpdateToJson(
  RecurrenceUpdate instance,
) => <String, dynamic>{
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (_dateToJson(instance.firstDate) case final value?) 'first_date': value,
  if (_dateToJson(instance.repeatUntil) case final value?)
    'repeat_until': value,
  if (instance.nrOfRepetitions case final value?) 'nr_of_repetitions': value,
  if (instance.applyRules case final value?) 'apply_rules': value,
  if (instance.active case final value?) 'active': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.repetitions?.map((e) => e.toJson()).toList() case final value?)
    'repetitions': value,
  if (instance.transactions?.map((e) => e.toJson()).toList() case final value?)
    'transactions': value,
};

RecurrenceRepetition _$RecurrenceRepetitionFromJson(
  Map<String, dynamic> json,
) => RecurrenceRepetition(
  id: json['id'] as String?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  type: recurrenceRepetitionTypeFromJson(json['type']),
  moment: json['moment'] as String,
  skip: (json['skip'] as num?)?.toInt(),
  weekend: (json['weekend'] as num?)?.toInt(),
  description: json['description'] as String?,
  occurrences:
      (json['occurrences'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList() ??
      [],
);

Map<String, dynamic> _$RecurrenceRepetitionToJson(
  RecurrenceRepetition instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (recurrenceRepetitionTypeToJson(instance.type) case final value?)
    'type': value,
  'moment': instance.moment,
  if (instance.skip case final value?) 'skip': value,
  if (instance.weekend case final value?) 'weekend': value,
  if (instance.description case final value?) 'description': value,
  if (instance.occurrences?.map((e) => e.toIso8601String()).toList()
      case final value?)
    'occurrences': value,
};

RecurrenceRepetitionStore _$RecurrenceRepetitionStoreFromJson(
  Map<String, dynamic> json,
) => RecurrenceRepetitionStore(
  type: recurrenceRepetitionTypeFromJson(json['type']),
  moment: json['moment'] as String,
  skip: (json['skip'] as num?)?.toInt(),
  weekend: (json['weekend'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecurrenceRepetitionStoreToJson(
  RecurrenceRepetitionStore instance,
) => <String, dynamic>{
  if (recurrenceRepetitionTypeToJson(instance.type) case final value?)
    'type': value,
  'moment': instance.moment,
  if (instance.skip case final value?) 'skip': value,
  if (instance.weekend case final value?) 'weekend': value,
};

RecurrenceRepetitionUpdate _$RecurrenceRepetitionUpdateFromJson(
  Map<String, dynamic> json,
) => RecurrenceRepetitionUpdate(
  type: recurrenceRepetitionTypeNullableFromJson(json['type']),
  moment: json['moment'] as String?,
  skip: (json['skip'] as num?)?.toInt(),
  weekend: (json['weekend'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecurrenceRepetitionUpdateToJson(
  RecurrenceRepetitionUpdate instance,
) => <String, dynamic>{
  if (recurrenceRepetitionTypeNullableToJson(instance.type) case final value?)
    'type': value,
  if (instance.moment case final value?) 'moment': value,
  if (instance.skip case final value?) 'skip': value,
  if (instance.weekend case final value?) 'weekend': value,
};

RecurrenceTransaction _$RecurrenceTransactionFromJson(
  Map<String, dynamic> json,
) => RecurrenceTransaction(
  id: json['id'] as String?,
  description: json['description'] as String,
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  amount: json['amount'] as String,
  pcAmount: json['pc_amount'] as String?,
  foreignAmount: json['foreign_amount'] as String?,
  pcForeignAmount: json['pc_foreign_amount'] as String?,
  foreignCurrencyId: json['foreign_currency_id'] as String?,
  foreignCurrencyName: json['foreign_currency_name'] as String?,
  foreignCurrencyCode: json['foreign_currency_code'] as String?,
  foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
  foreignCurrencyDecimalPlaces:
      (json['foreign_currency_decimal_places'] as num?)?.toInt(),
  budgetId: json['budget_id'] as String?,
  budgetName: json['budget_name'] as String?,
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
  sourceId: json['source_id'] as String?,
  sourceName: json['source_name'] as String?,
  sourceIban: json['source_iban'] as String?,
  sourceType: accountTypePropertyNullableFromJson(json['source_type']),
  destinationId: json['destination_id'] as String?,
  destinationName: json['destination_name'] as String?,
  destinationIban: json['destination_iban'] as String?,
  destinationType: accountTypePropertyNullableFromJson(
    json['destination_type'],
  ),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  piggyBankId: json['piggy_bank_id'] as String?,
  piggyBankName: json['piggy_bank_name'] as String?,
  subscriptionId: json['subscription_id'] as String?,
  subscriptionName: json['subscription_name'] as String?,
);

Map<String, dynamic> _$RecurrenceTransactionToJson(
  RecurrenceTransaction instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'description': instance.description,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  'amount': instance.amount,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.pcForeignAmount case final value?) 'pc_foreign_amount': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.foreignCurrencyName case final value?)
    'foreign_currency_name': value,
  if (instance.foreignCurrencyCode case final value?)
    'foreign_currency_code': value,
  if (instance.foreignCurrencySymbol case final value?)
    'foreign_currency_symbol': value,
  if (instance.foreignCurrencyDecimalPlaces case final value?)
    'foreign_currency_decimal_places': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.budgetName case final value?) 'budget_name': value,
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.categoryName case final value?) 'category_name': value,
  if (instance.sourceId case final value?) 'source_id': value,
  if (instance.sourceName case final value?) 'source_name': value,
  if (instance.sourceIban case final value?) 'source_iban': value,
  if (accountTypePropertyNullableToJson(instance.sourceType) case final value?)
    'source_type': value,
  if (instance.destinationId case final value?) 'destination_id': value,
  if (instance.destinationName case final value?) 'destination_name': value,
  if (instance.destinationIban case final value?) 'destination_iban': value,
  if (accountTypePropertyNullableToJson(instance.destinationType)
      case final value?)
    'destination_type': value,
  if (instance.tags case final value?) 'tags': value,
  if (instance.piggyBankId case final value?) 'piggy_bank_id': value,
  if (instance.piggyBankName case final value?) 'piggy_bank_name': value,
  if (instance.subscriptionId case final value?) 'subscription_id': value,
  if (instance.subscriptionName case final value?) 'subscription_name': value,
};

RecurrenceTransactionStore _$RecurrenceTransactionStoreFromJson(
  Map<String, dynamic> json,
) => RecurrenceTransactionStore(
  description: json['description'] as String,
  amount: json['amount'] as String,
  foreignAmount: json['foreign_amount'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  foreignCurrencyId: json['foreign_currency_id'] as String?,
  foreignCurrencyCode: json['foreign_currency_code'] as String?,
  budgetId: json['budget_id'] as String?,
  categoryId: json['category_id'] as String?,
  sourceId: json['source_id'] as String,
  destinationId: json['destination_id'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  piggyBankId: json['piggy_bank_id'] as String?,
  billId: json['bill_id'] as String?,
);

Map<String, dynamic> _$RecurrenceTransactionStoreToJson(
  RecurrenceTransactionStore instance,
) => <String, dynamic>{
  'description': instance.description,
  'amount': instance.amount,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.foreignCurrencyCode case final value?)
    'foreign_currency_code': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.categoryId case final value?) 'category_id': value,
  'source_id': instance.sourceId,
  'destination_id': instance.destinationId,
  if (instance.tags case final value?) 'tags': value,
  if (instance.piggyBankId case final value?) 'piggy_bank_id': value,
  if (instance.billId case final value?) 'bill_id': value,
};

RecurrenceTransactionUpdate _$RecurrenceTransactionUpdateFromJson(
  Map<String, dynamic> json,
) => RecurrenceTransactionUpdate(
  id: json['id'] as String,
  description: json['description'] as String?,
  amount: json['amount'] as String?,
  foreignAmount: json['foreign_amount'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  foreignCurrencyId: json['foreign_currency_id'] as String?,
  budgetId: json['budget_id'] as String?,
  categoryId: json['category_id'] as String?,
  sourceId: json['source_id'] as String?,
  destinationId: json['destination_id'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  piggyBankId: json['piggy_bank_id'] as String?,
  billId: json['bill_id'] as String?,
);

Map<String, dynamic> _$RecurrenceTransactionUpdateToJson(
  RecurrenceTransactionUpdate instance,
) => <String, dynamic>{
  'id': instance.id,
  if (instance.description case final value?) 'description': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.sourceId case final value?) 'source_id': value,
  if (instance.destinationId case final value?) 'destination_id': value,
  if (instance.tags case final value?) 'tags': value,
  if (instance.piggyBankId case final value?) 'piggy_bank_id': value,
  if (instance.billId case final value?) 'bill_id': value,
};

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  description: json['description'] as String?,
  ruleGroupId: json['rule_group_id'] as String,
  ruleGroupTitle: json['rule_group_title'] as String?,
  order: (json['order'] as num?)?.toInt(),
  trigger: ruleTriggerTypeFromJson(json['trigger']),
  active: json['active'] as bool? ?? true,
  strict: json['strict'] as bool?,
  stopProcessing: json['stop_processing'] as bool? ?? false,
  triggers:
      (json['triggers'] as List<dynamic>?)
          ?.map((e) => RuleTrigger.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => RuleAction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'title': instance.title,
  if (instance.description case final value?) 'description': value,
  'rule_group_id': instance.ruleGroupId,
  if (instance.ruleGroupTitle case final value?) 'rule_group_title': value,
  if (instance.order case final value?) 'order': value,
  if (ruleTriggerTypeToJson(instance.trigger) case final value?)
    'trigger': value,
  if (instance.active case final value?) 'active': value,
  if (instance.strict case final value?) 'strict': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
  'triggers': instance.triggers.map((e) => e.toJson()).toList(),
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

RuleStore _$RuleStoreFromJson(Map<String, dynamic> json) => RuleStore(
  title: json['title'] as String,
  description: json['description'] as String?,
  ruleGroupId: json['rule_group_id'] as String,
  ruleGroupTitle: json['rule_group_title'] as String?,
  order: (json['order'] as num?)?.toInt(),
  trigger: ruleTriggerTypeFromJson(json['trigger']),
  active: json['active'] as bool? ?? true,
  strict: json['strict'] as bool? ?? true,
  stopProcessing: json['stop_processing'] as bool?,
  triggers:
      (json['triggers'] as List<dynamic>?)
          ?.map((e) => RuleTriggerStore.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => RuleActionStore.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$RuleStoreToJson(RuleStore instance) => <String, dynamic>{
  'title': instance.title,
  if (instance.description case final value?) 'description': value,
  'rule_group_id': instance.ruleGroupId,
  if (instance.ruleGroupTitle case final value?) 'rule_group_title': value,
  if (instance.order case final value?) 'order': value,
  if (ruleTriggerTypeToJson(instance.trigger) case final value?)
    'trigger': value,
  if (instance.active case final value?) 'active': value,
  if (instance.strict case final value?) 'strict': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
  'triggers': instance.triggers.map((e) => e.toJson()).toList(),
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

RuleUpdate _$RuleUpdateFromJson(Map<String, dynamic> json) => RuleUpdate(
  title: json['title'] as String?,
  description: json['description'] as String?,
  ruleGroupId: json['rule_group_id'] as String?,
  order: (json['order'] as num?)?.toInt(),
  trigger: ruleTriggerTypeNullableFromJson(json['trigger']),
  active: json['active'] as bool? ?? true,
  strict: json['strict'] as bool?,
  stopProcessing: json['stop_processing'] as bool? ?? false,
  triggers:
      (json['triggers'] as List<dynamic>?)
          ?.map((e) => RuleTriggerUpdate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => RuleActionUpdate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$RuleUpdateToJson(RuleUpdate instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.description case final value?) 'description': value,
      if (instance.ruleGroupId case final value?) 'rule_group_id': value,
      if (instance.order case final value?) 'order': value,
      if (ruleTriggerTypeNullableToJson(instance.trigger) case final value?)
        'trigger': value,
      if (instance.active case final value?) 'active': value,
      if (instance.strict case final value?) 'strict': value,
      if (instance.stopProcessing case final value?) 'stop_processing': value,
      if (instance.triggers?.map((e) => e.toJson()).toList() case final value?)
        'triggers': value,
      if (instance.actions?.map((e) => e.toJson()).toList() case final value?)
        'actions': value,
    };

RuleAction _$RuleActionFromJson(Map<String, dynamic> json) => RuleAction(
  id: json['id'] as String?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  type: ruleActionKeywordFromJson(json['type']),
  $value: json['value'] as String?,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  stopProcessing: json['stop_processing'] as bool? ?? false,
);

Map<String, dynamic> _$RuleActionToJson(
  RuleAction instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (ruleActionKeywordToJson(instance.type) case final value?) 'type': value,
  if (instance.$value case final value?) 'value': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
};

RuleActionStore _$RuleActionStoreFromJson(Map<String, dynamic> json) =>
    RuleActionStore(
      type: ruleActionKeywordFromJson(json['type']),
      $value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleActionStoreToJson(
  RuleActionStore instance,
) => <String, dynamic>{
  if (ruleActionKeywordToJson(instance.type) case final value?) 'type': value,
  if (instance.$value case final value?) 'value': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
};

RuleActionUpdate _$RuleActionUpdateFromJson(Map<String, dynamic> json) =>
    RuleActionUpdate(
      type: ruleActionKeywordNullableFromJson(json['type']),
      $value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      stopProcessing: json['stop_processing'] as bool?,
    );

Map<String, dynamic> _$RuleActionUpdateToJson(RuleActionUpdate instance) =>
    <String, dynamic>{
      if (ruleActionKeywordNullableToJson(instance.type) case final value?)
        'type': value,
      if (instance.$value case final value?) 'value': value,
      if (instance.order case final value?) 'order': value,
      if (instance.active case final value?) 'active': value,
      if (instance.stopProcessing case final value?) 'stop_processing': value,
    };

RuleGroup _$RuleGroupFromJson(Map<String, dynamic> json) => RuleGroup(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  description: json['description'] as String?,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool?,
);

Map<String, dynamic> _$RuleGroupToJson(RuleGroup instance) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'title': instance.title,
  if (instance.description case final value?) 'description': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
};

RuleGroupStore _$RuleGroupStoreFromJson(Map<String, dynamic> json) =>
    RuleGroupStore(
      title: json['title'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$RuleGroupStoreToJson(RuleGroupStore instance) =>
    <String, dynamic>{
      'title': instance.title,
      if (instance.description case final value?) 'description': value,
      if (instance.order case final value?) 'order': value,
      if (instance.active case final value?) 'active': value,
    };

RuleGroupUpdate _$RuleGroupUpdateFromJson(Map<String, dynamic> json) =>
    RuleGroupUpdate(
      title: json['title'] as String?,
      description: json['description'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$RuleGroupUpdateToJson(RuleGroupUpdate instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.description case final value?) 'description': value,
      if (instance.order case final value?) 'order': value,
      if (instance.active case final value?) 'active': value,
    };

RuleTrigger _$RuleTriggerFromJson(Map<String, dynamic> json) => RuleTrigger(
  id: json['id'] as String?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  type: ruleTriggerKeywordFromJson(json['type']),
  $value: json['value'] as String,
  prohibited: json['prohibited'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  stopProcessing: json['stop_processing'] as bool? ?? false,
);

Map<String, dynamic> _$RuleTriggerToJson(
  RuleTrigger instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (ruleTriggerKeywordToJson(instance.type) case final value?) 'type': value,
  'value': instance.$value,
  if (instance.prohibited case final value?) 'prohibited': value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
};

RuleTriggerStore _$RuleTriggerStoreFromJson(Map<String, dynamic> json) =>
    RuleTriggerStore(
      type: ruleTriggerKeywordFromJson(json['type']),
      $value: json['value'] as String,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      prohibited: json['prohibited'] as bool? ?? false,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleTriggerStoreToJson(
  RuleTriggerStore instance,
) => <String, dynamic>{
  if (ruleTriggerKeywordToJson(instance.type) case final value?) 'type': value,
  'value': instance.$value,
  if (instance.order case final value?) 'order': value,
  if (instance.active case final value?) 'active': value,
  if (instance.prohibited case final value?) 'prohibited': value,
  if (instance.stopProcessing case final value?) 'stop_processing': value,
};

RuleTriggerUpdate _$RuleTriggerUpdateFromJson(Map<String, dynamic> json) =>
    RuleTriggerUpdate(
      type: ruleTriggerKeywordNullableFromJson(json['type']),
      $value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      stopProcessing: json['stop_processing'] as bool?,
    );

Map<String, dynamic> _$RuleTriggerUpdateToJson(RuleTriggerUpdate instance) =>
    <String, dynamic>{
      if (ruleTriggerKeywordNullableToJson(instance.type) case final value?)
        'type': value,
      if (instance.$value case final value?) 'value': value,
      if (instance.order case final value?) 'order': value,
      if (instance.active case final value?) 'active': value,
      if (instance.stopProcessing case final value?) 'stop_processing': value,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  tag: json['tag'] as String,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  zoomLevel: (json['zoom_level'] as num?)?.toInt(),
);

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'tag': instance.tag,
  if (_dateToJson(instance.date) case final value?) 'date': value,
  if (instance.description case final value?) 'description': value,
  if (instance.latitude case final value?) 'latitude': value,
  if (instance.longitude case final value?) 'longitude': value,
  if (instance.zoomLevel case final value?) 'zoom_level': value,
};

TagModelStore _$TagModelStoreFromJson(Map<String, dynamic> json) =>
    TagModelStore(
      tag: json['tag'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelStoreToJson(TagModelStore instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      if (_dateToJson(instance.date) case final value?) 'date': value,
      if (instance.description case final value?) 'description': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.zoomLevel case final value?) 'zoom_level': value,
    };

TagModelUpdate _$TagModelUpdateFromJson(Map<String, dynamic> json) =>
    TagModelUpdate(
      tag: json['tag'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelUpdateToJson(TagModelUpdate instance) =>
    <String, dynamic>{
      if (instance.tag case final value?) 'tag': value,
      if (_dateToJson(instance.date) case final value?) 'date': value,
      if (instance.description case final value?) 'description': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.zoomLevel case final value?) 'zoom_level': value,
    };

CurrencyProperties _$CurrencyPropertiesFromJson(Map<String, dynamic> json) =>
    CurrencyProperties(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      enabled: json['enabled'] as bool? ?? true,
      primary: json['primary'] as bool?,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyPropertiesToJson(CurrencyProperties instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.primary case final value?) 'primary': value,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      if (instance.decimalPlaces case final value?) 'decimal_places': value,
    };

CurrencyStore _$CurrencyStoreFromJson(Map<String, dynamic> json) =>
    CurrencyStore(
      enabled: json['enabled'] as bool? ?? true,
      primary: json['primary'] as bool?,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyStoreToJson(CurrencyStore instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.primary case final value?) 'primary': value,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      if (instance.decimalPlaces case final value?) 'decimal_places': value,
    };

CurrencyUpdate _$CurrencyUpdateFromJson(Map<String, dynamic> json) =>
    CurrencyUpdate(
      enabled: json['enabled'] as bool?,
      primary: json['primary'] as bool?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyUpdateToJson(CurrencyUpdate instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.primary case final value?) 'primary': value,
      if (instance.code case final value?) 'code': value,
      if (instance.name case final value?) 'name': value,
      if (instance.symbol case final value?) 'symbol': value,
      if (instance.decimalPlaces case final value?) 'decimal_places': value,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  user: json['user'] as String?,
  groupTitle: json['group_title'] as String?,
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionSplit.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.user case final value?) 'user': value,
      if (instance.groupTitle case final value?) 'group_title': value,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

TransactionStore _$TransactionStoreFromJson(Map<String, dynamic> json) =>
    TransactionStore(
      errorIfDuplicateHash: json['error_if_duplicate_hash'] as bool?,
      applyRules: json['apply_rules'] as bool?,
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      groupTitle: json['group_title'] as String?,
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TransactionSplitStore.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionStoreToJson(TransactionStore instance) =>
    <String, dynamic>{
      if (instance.errorIfDuplicateHash case final value?)
        'error_if_duplicate_hash': value,
      if (instance.applyRules case final value?) 'apply_rules': value,
      if (instance.fireWebhooks case final value?) 'fire_webhooks': value,
      if (instance.groupTitle case final value?) 'group_title': value,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

TransactionUpdate _$TransactionUpdateFromJson(Map<String, dynamic> json) =>
    TransactionUpdate(
      applyRules: json['apply_rules'] as bool?,
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      groupTitle: json['group_title'] as String?,
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TransactionSplitUpdate.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionUpdateToJson(
  TransactionUpdate instance,
) => <String, dynamic>{
  if (instance.applyRules case final value?) 'apply_rules': value,
  if (instance.fireWebhooks case final value?) 'fire_webhooks': value,
  if (instance.groupTitle case final value?) 'group_title': value,
  if (instance.transactions?.map((e) => e.toJson()).toList() case final value?)
    'transactions': value,
};

TransactionLink _$TransactionLinkFromJson(Map<String, dynamic> json) =>
    TransactionLink(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      linkTypeId: json['link_type_id'] as String?,
      linkTypeName: json['link_type_name'] as String?,
      inwardId: json['inward_id'] as String,
      outwardId: json['outward_id'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransactionLinkToJson(TransactionLink instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.linkTypeId case final value?) 'link_type_id': value,
      if (instance.linkTypeName case final value?) 'link_type_name': value,
      'inward_id': instance.inwardId,
      'outward_id': instance.outwardId,
      if (instance.notes case final value?) 'notes': value,
    };

TransactionLinkStore _$TransactionLinkStoreFromJson(
  Map<String, dynamic> json,
) => TransactionLinkStore(
  linkTypeId: json['link_type_id'] as String?,
  linkTypeName: json['link_type_name'] as String?,
  inwardId: json['inward_id'] as String,
  outwardId: json['outward_id'] as String,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$TransactionLinkStoreToJson(
  TransactionLinkStore instance,
) => <String, dynamic>{
  if (instance.linkTypeId case final value?) 'link_type_id': value,
  if (instance.linkTypeName case final value?) 'link_type_name': value,
  'inward_id': instance.inwardId,
  'outward_id': instance.outwardId,
  if (instance.notes case final value?) 'notes': value,
};

TransactionLinkUpdate _$TransactionLinkUpdateFromJson(
  Map<String, dynamic> json,
) => TransactionLinkUpdate(
  linkTypeId: json['link_type_id'] as String?,
  linkTypeName: json['link_type_name'] as String?,
  inwardId: json['inward_id'] as String?,
  outwardId: json['outward_id'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$TransactionLinkUpdateToJson(
  TransactionLinkUpdate instance,
) => <String, dynamic>{
  if (instance.linkTypeId case final value?) 'link_type_id': value,
  if (instance.linkTypeName case final value?) 'link_type_name': value,
  if (instance.inwardId case final value?) 'inward_id': value,
  if (instance.outwardId case final value?) 'outward_id': value,
  if (instance.notes case final value?) 'notes': value,
};

LinkType _$LinkTypeFromJson(Map<String, dynamic> json) => LinkType(
  name: json['name'] as String,
  inward: json['inward'] as String,
  outward: json['outward'] as String,
  editable: json['editable'] as bool?,
);

Map<String, dynamic> _$LinkTypeToJson(LinkType instance) => <String, dynamic>{
  'name': instance.name,
  'inward': instance.inward,
  'outward': instance.outward,
  if (instance.editable case final value?) 'editable': value,
};

LinkTypeUpdate _$LinkTypeUpdateFromJson(Map<String, dynamic> json) =>
    LinkTypeUpdate(
      name: json['name'] as String?,
      inward: json['inward'] as String?,
      outward: json['outward'] as String?,
    );

Map<String, dynamic> _$LinkTypeUpdateToJson(LinkTypeUpdate instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.inward case final value?) 'inward': value,
      if (instance.outward case final value?) 'outward': value,
    };

TransactionSplit _$TransactionSplitFromJson(
  Map<String, dynamic> json,
) => TransactionSplit(
  user: json['user'] as String?,
  transactionJournalId: json['transaction_journal_id'] as String?,
  type: transactionTypePropertyFromJson(json['type']),
  date: DateTime.parse(json['date'] as String),
  order: (json['order'] as num?)?.toInt(),
  objectHasCurrencySetting: json['object_has_currency_setting'] as bool?,
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  foreignCurrencyId: json['foreign_currency_id'] as String?,
  foreignCurrencyCode: json['foreign_currency_code'] as String?,
  foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
  foreignCurrencyDecimalPlaces:
      (json['foreign_currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  amount: json['amount'] as String,
  pcAmount: json['pc_amount'] as String?,
  foreignAmount: json['foreign_amount'] as String?,
  pcForeignAmount: json['pc_foreign_amount'] as String?,
  sourceBalanceAfter: json['source_balance_after'] as String?,
  pcSourceBalanceAfter: json['pc_source_balance_after'] as String?,
  destinationBalanceAfter: json['destination_balance_after'] as String?,
  pcDestinationBalanceAfter: json['pc_destination_balance_after'] as String?,
  description: json['description'] as String,
  sourceId: json['source_id'] as String?,
  sourceName: json['source_name'] as String?,
  sourceIban: json['source_iban'] as String?,
  sourceType: accountTypePropertyNullableFromJson(json['source_type']),
  destinationId: json['destination_id'] as String?,
  destinationName: json['destination_name'] as String?,
  destinationIban: json['destination_iban'] as String?,
  destinationType: accountTypePropertyNullableFromJson(
    json['destination_type'],
  ),
  budgetId: json['budget_id'] as String?,
  budgetName: json['budget_name'] as String?,
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
  billId: json['bill_id'] as String?,
  billName: json['bill_name'] as String?,
  subscriptionId: json['subscription_id'] as String?,
  subscriptionName: json['subscription_name'] as String?,
  reconciled: json['reconciled'] as bool?,
  notes: json['notes'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  internalReference: json['internal_reference'] as String?,
  externalId: json['external_id'] as String?,
  externalUrl: json['external_url'] as String?,
  originalSource: json['original_source'] as String?,
  recurrenceId: json['recurrence_id'] as String?,
  recurrenceTotal: (json['recurrence_total'] as num?)?.toInt(),
  recurrenceCount: (json['recurrence_count'] as num?)?.toInt(),
  importHashV2: json['import_hash_v2'] as String?,
  sepaCc: json['sepa_cc'] as String?,
  sepaCtOp: json['sepa_ct_op'] as String?,
  sepaCtId: json['sepa_ct_id'] as String?,
  sepaDb: json['sepa_db'] as String?,
  sepaCountry: json['sepa_country'] as String?,
  sepaEp: json['sepa_ep'] as String?,
  sepaCi: json['sepa_ci'] as String?,
  sepaBatchId: json['sepa_batch_id'] as String?,
  interestDate:
      json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
  bookDate:
      json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
  processDate:
      json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
  dueDate:
      json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
  paymentDate:
      json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
  invoiceDate:
      json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  zoomLevel: (json['zoom_level'] as num?)?.toInt(),
  hasAttachments: json['has_attachments'] as bool?,
);

Map<String, dynamic> _$TransactionSplitToJson(
  TransactionSplit instance,
) => <String, dynamic>{
  if (instance.user case final value?) 'user': value,
  if (instance.transactionJournalId case final value?)
    'transaction_journal_id': value,
  if (transactionTypePropertyToJson(instance.type) case final value?)
    'type': value,
  'date': instance.date.toIso8601String(),
  if (instance.order case final value?) 'order': value,
  if (instance.objectHasCurrencySetting case final value?)
    'object_has_currency_setting': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.foreignCurrencyCode case final value?)
    'foreign_currency_code': value,
  if (instance.foreignCurrencySymbol case final value?)
    'foreign_currency_symbol': value,
  if (instance.foreignCurrencyDecimalPlaces case final value?)
    'foreign_currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  'amount': instance.amount,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.pcForeignAmount case final value?) 'pc_foreign_amount': value,
  if (instance.sourceBalanceAfter case final value?)
    'source_balance_after': value,
  if (instance.pcSourceBalanceAfter case final value?)
    'pc_source_balance_after': value,
  if (instance.destinationBalanceAfter case final value?)
    'destination_balance_after': value,
  if (instance.pcDestinationBalanceAfter case final value?)
    'pc_destination_balance_after': value,
  'description': instance.description,
  if (instance.sourceId case final value?) 'source_id': value,
  if (instance.sourceName case final value?) 'source_name': value,
  if (instance.sourceIban case final value?) 'source_iban': value,
  if (accountTypePropertyNullableToJson(instance.sourceType) case final value?)
    'source_type': value,
  if (instance.destinationId case final value?) 'destination_id': value,
  if (instance.destinationName case final value?) 'destination_name': value,
  if (instance.destinationIban case final value?) 'destination_iban': value,
  if (accountTypePropertyNullableToJson(instance.destinationType)
      case final value?)
    'destination_type': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.budgetName case final value?) 'budget_name': value,
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.categoryName case final value?) 'category_name': value,
  if (instance.billId case final value?) 'bill_id': value,
  if (instance.billName case final value?) 'bill_name': value,
  if (instance.subscriptionId case final value?) 'subscription_id': value,
  if (instance.subscriptionName case final value?) 'subscription_name': value,
  if (instance.reconciled case final value?) 'reconciled': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.tags case final value?) 'tags': value,
  if (instance.internalReference case final value?) 'internal_reference': value,
  if (instance.externalId case final value?) 'external_id': value,
  if (instance.externalUrl case final value?) 'external_url': value,
  if (instance.originalSource case final value?) 'original_source': value,
  if (instance.recurrenceId case final value?) 'recurrence_id': value,
  if (instance.recurrenceTotal case final value?) 'recurrence_total': value,
  if (instance.recurrenceCount case final value?) 'recurrence_count': value,
  if (instance.importHashV2 case final value?) 'import_hash_v2': value,
  if (instance.sepaCc case final value?) 'sepa_cc': value,
  if (instance.sepaCtOp case final value?) 'sepa_ct_op': value,
  if (instance.sepaCtId case final value?) 'sepa_ct_id': value,
  if (instance.sepaDb case final value?) 'sepa_db': value,
  if (instance.sepaCountry case final value?) 'sepa_country': value,
  if (instance.sepaEp case final value?) 'sepa_ep': value,
  if (instance.sepaCi case final value?) 'sepa_ci': value,
  if (instance.sepaBatchId case final value?) 'sepa_batch_id': value,
  if (instance.interestDate?.toIso8601String() case final value?)
    'interest_date': value,
  if (instance.bookDate?.toIso8601String() case final value?)
    'book_date': value,
  if (instance.processDate?.toIso8601String() case final value?)
    'process_date': value,
  if (instance.dueDate?.toIso8601String() case final value?) 'due_date': value,
  if (instance.paymentDate?.toIso8601String() case final value?)
    'payment_date': value,
  if (instance.invoiceDate?.toIso8601String() case final value?)
    'invoice_date': value,
  if (instance.latitude case final value?) 'latitude': value,
  if (instance.longitude case final value?) 'longitude': value,
  if (instance.zoomLevel case final value?) 'zoom_level': value,
  if (instance.hasAttachments case final value?) 'has_attachments': value,
};

TransactionSplitStore _$TransactionSplitStoreFromJson(
  Map<String, dynamic> json,
) => TransactionSplitStore(
  type: transactionTypePropertyFromJson(json['type']),
  date: DateTime.parse(json['date'] as String),
  amount: json['amount'] as String,
  description: json['description'] as String,
  order: (json['order'] as num?)?.toInt(),
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
  reconciled: json['reconciled'] as bool?,
  piggyBankId: (json['piggy_bank_id'] as num?)?.toInt(),
  piggyBankName: json['piggy_bank_name'] as String?,
  billId: json['bill_id'] as String?,
  billName: json['bill_name'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  notes: json['notes'] as String?,
  internalReference: json['internal_reference'] as String?,
  externalId: json['external_id'] as String?,
  externalUrl: json['external_url'] as String?,
  sepaCc: json['sepa_cc'] as String?,
  sepaCtOp: json['sepa_ct_op'] as String?,
  sepaCtId: json['sepa_ct_id'] as String?,
  sepaDb: json['sepa_db'] as String?,
  sepaCountry: json['sepa_country'] as String?,
  sepaEp: json['sepa_ep'] as String?,
  sepaCi: json['sepa_ci'] as String?,
  sepaBatchId: json['sepa_batch_id'] as String?,
  interestDate:
      json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
  bookDate:
      json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
  processDate:
      json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
  dueDate:
      json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
  paymentDate:
      json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
  invoiceDate:
      json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
);

Map<String, dynamic> _$TransactionSplitStoreToJson(
  TransactionSplitStore instance,
) => <String, dynamic>{
  if (transactionTypePropertyToJson(instance.type) case final value?)
    'type': value,
  'date': instance.date.toIso8601String(),
  'amount': instance.amount,
  'description': instance.description,
  if (instance.order case final value?) 'order': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.foreignCurrencyCode case final value?)
    'foreign_currency_code': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.budgetName case final value?) 'budget_name': value,
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.categoryName case final value?) 'category_name': value,
  if (instance.sourceId case final value?) 'source_id': value,
  if (instance.sourceName case final value?) 'source_name': value,
  if (instance.destinationId case final value?) 'destination_id': value,
  if (instance.destinationName case final value?) 'destination_name': value,
  if (instance.reconciled case final value?) 'reconciled': value,
  if (instance.piggyBankId case final value?) 'piggy_bank_id': value,
  if (instance.piggyBankName case final value?) 'piggy_bank_name': value,
  if (instance.billId case final value?) 'bill_id': value,
  if (instance.billName case final value?) 'bill_name': value,
  if (instance.tags case final value?) 'tags': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.internalReference case final value?) 'internal_reference': value,
  if (instance.externalId case final value?) 'external_id': value,
  if (instance.externalUrl case final value?) 'external_url': value,
  if (instance.sepaCc case final value?) 'sepa_cc': value,
  if (instance.sepaCtOp case final value?) 'sepa_ct_op': value,
  if (instance.sepaCtId case final value?) 'sepa_ct_id': value,
  if (instance.sepaDb case final value?) 'sepa_db': value,
  if (instance.sepaCountry case final value?) 'sepa_country': value,
  if (instance.sepaEp case final value?) 'sepa_ep': value,
  if (instance.sepaCi case final value?) 'sepa_ci': value,
  if (instance.sepaBatchId case final value?) 'sepa_batch_id': value,
  if (instance.interestDate?.toIso8601String() case final value?)
    'interest_date': value,
  if (instance.bookDate?.toIso8601String() case final value?)
    'book_date': value,
  if (instance.processDate?.toIso8601String() case final value?)
    'process_date': value,
  if (instance.dueDate?.toIso8601String() case final value?) 'due_date': value,
  if (instance.paymentDate?.toIso8601String() case final value?)
    'payment_date': value,
  if (instance.invoiceDate?.toIso8601String() case final value?)
    'invoice_date': value,
};

TransactionSplitUpdate _$TransactionSplitUpdateFromJson(
  Map<String, dynamic> json,
) => TransactionSplitUpdate(
  transactionJournalId: json['transaction_journal_id'] as String?,
  type: transactionTypePropertyNullableFromJson(json['type']),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  amount: json['amount'] as String?,
  description: json['description'] as String?,
  order: (json['order'] as num?)?.toInt(),
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  foreignAmount: json['foreign_amount'] as String?,
  foreignCurrencyId: json['foreign_currency_id'] as String?,
  foreignCurrencyCode: json['foreign_currency_code'] as String?,
  foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
  foreignCurrencyDecimalPlaces:
      (json['foreign_currency_decimal_places'] as num?)?.toInt(),
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
  reconciled: json['reconciled'] as bool?,
  billId: json['bill_id'] as String?,
  billName: json['bill_name'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  notes: json['notes'] as String?,
  internalReference: json['internal_reference'] as String?,
  externalId: json['external_id'] as String?,
  externalUrl: json['external_url'] as String?,
  sepaCc: json['sepa_cc'] as String?,
  sepaCtOp: json['sepa_ct_op'] as String?,
  sepaCtId: json['sepa_ct_id'] as String?,
  sepaDb: json['sepa_db'] as String?,
  sepaCountry: json['sepa_country'] as String?,
  sepaEp: json['sepa_ep'] as String?,
  sepaCi: json['sepa_ci'] as String?,
  sepaBatchId: json['sepa_batch_id'] as String?,
  interestDate:
      json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
  bookDate:
      json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
  processDate:
      json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
  dueDate:
      json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
  paymentDate:
      json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
  invoiceDate:
      json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
);

Map<String, dynamic> _$TransactionSplitUpdateToJson(
  TransactionSplitUpdate instance,
) => <String, dynamic>{
  if (instance.transactionJournalId case final value?)
    'transaction_journal_id': value,
  if (transactionTypePropertyNullableToJson(instance.type) case final value?)
    'type': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.description case final value?) 'description': value,
  if (instance.order case final value?) 'order': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.foreignCurrencyId case final value?)
    'foreign_currency_id': value,
  if (instance.foreignCurrencyCode case final value?)
    'foreign_currency_code': value,
  if (instance.foreignCurrencySymbol case final value?)
    'foreign_currency_symbol': value,
  if (instance.foreignCurrencyDecimalPlaces case final value?)
    'foreign_currency_decimal_places': value,
  if (instance.budgetId case final value?) 'budget_id': value,
  if (instance.budgetName case final value?) 'budget_name': value,
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.categoryName case final value?) 'category_name': value,
  if (instance.sourceId case final value?) 'source_id': value,
  if (instance.sourceName case final value?) 'source_name': value,
  if (instance.sourceIban case final value?) 'source_iban': value,
  if (instance.destinationId case final value?) 'destination_id': value,
  if (instance.destinationName case final value?) 'destination_name': value,
  if (instance.destinationIban case final value?) 'destination_iban': value,
  if (instance.reconciled case final value?) 'reconciled': value,
  if (instance.billId case final value?) 'bill_id': value,
  if (instance.billName case final value?) 'bill_name': value,
  if (instance.tags case final value?) 'tags': value,
  if (instance.notes case final value?) 'notes': value,
  if (instance.internalReference case final value?) 'internal_reference': value,
  if (instance.externalId case final value?) 'external_id': value,
  if (instance.externalUrl case final value?) 'external_url': value,
  if (instance.sepaCc case final value?) 'sepa_cc': value,
  if (instance.sepaCtOp case final value?) 'sepa_ct_op': value,
  if (instance.sepaCtId case final value?) 'sepa_ct_id': value,
  if (instance.sepaDb case final value?) 'sepa_db': value,
  if (instance.sepaCountry case final value?) 'sepa_country': value,
  if (instance.sepaEp case final value?) 'sepa_ep': value,
  if (instance.sepaCi case final value?) 'sepa_ci': value,
  if (instance.sepaBatchId case final value?) 'sepa_batch_id': value,
  if (instance.interestDate?.toIso8601String() case final value?)
    'interest_date': value,
  if (instance.bookDate?.toIso8601String() case final value?)
    'book_date': value,
  if (instance.processDate?.toIso8601String() case final value?)
    'process_date': value,
  if (instance.dueDate?.toIso8601String() case final value?) 'due_date': value,
  if (instance.paymentDate?.toIso8601String() case final value?)
    'payment_date': value,
  if (instance.invoiceDate?.toIso8601String() case final value?)
    'invoice_date': value,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  email: json['email'] as String,
  blocked: json['blocked'] as bool?,
  blockedCode: userBlockedCodePropertyNullableFromJson(json['blocked_code']),
  role: userRolePropertyNullableFromJson(json['role']),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  'email': instance.email,
  if (instance.blocked case final value?) 'blocked': value,
  if (userBlockedCodePropertyNullableToJson(instance.blockedCode)
      case final value?)
    'blocked_code': value,
  if (userRolePropertyNullableToJson(instance.role) case final value?)
    'role': value,
};

UserGroupRead _$UserGroupReadFromJson(Map<String, dynamic> json) =>
    UserGroupRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: UserGroupReadAttributes.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupReadToJson(UserGroupRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

UserGroupReadAttributes _$UserGroupReadAttributesFromJson(
  Map<String, dynamic> json,
) => UserGroupReadAttributes(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  inUse: json['in_use'] as bool?,
  canSeeMembers: json['can_see_members'] as bool?,
  title: json['title'] as String?,
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => UserGroupReadMembers.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$UserGroupReadAttributesToJson(
  UserGroupReadAttributes instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.inUse case final value?) 'in_use': value,
  if (instance.canSeeMembers case final value?) 'can_see_members': value,
  if (instance.title case final value?) 'title': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.members?.map((e) => e.toJson()).toList() case final value?)
    'members': value,
};

UserGroupReadMembers _$UserGroupReadMembersFromJson(
  Map<String, dynamic> json,
) => UserGroupReadMembers(
  userId: json['user_id'] as String?,
  userEmail: json['user_email'] as String?,
  you: json['you'] as bool?,
  roles: userGroupReadRoleListFromJson(json['roles'] as List?),
);

Map<String, dynamic> _$UserGroupReadMembersToJson(
  UserGroupReadMembers instance,
) => <String, dynamic>{
  if (instance.userId case final value?) 'user_id': value,
  if (instance.userEmail case final value?) 'user_email': value,
  if (instance.you case final value?) 'you': value,
  'roles': userGroupReadRoleListToJson(instance.roles),
};

UserGroupSingle _$UserGroupSingleFromJson(Map<String, dynamic> json) =>
    UserGroupSingle(
      data: UserGroupRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupSingleToJson(UserGroupSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

UserGroupUpdate _$UserGroupUpdateFromJson(Map<String, dynamic> json) =>
    UserGroupUpdate(
      title: json['title'] as String,
      primaryCurrencyId: json['primary_currency_id'] as String?,
      primaryCurrencyCode: json['primary_currency_code'] as String?,
    );

Map<String, dynamic> _$UserGroupUpdateToJson(UserGroupUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      if (instance.primaryCurrencyId case final value?)
        'primary_currency_id': value,
      if (instance.primaryCurrencyCode case final value?)
        'primary_currency_code': value,
    };

Webhook _$WebhookFromJson(Map<String, dynamic> json) => Webhook(
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  active: json['active'] as bool?,
  title: json['title'] as String,
  secret: json['secret'] as String?,
  trigger: webhookTriggerFromJson(json['trigger']),
  response: webhookResponseFromJson(json['response']),
  delivery: webhookDeliveryFromJson(json['delivery']),
  url: json['url'] as String,
);

Map<String, dynamic> _$WebhookToJson(Webhook instance) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.active case final value?) 'active': value,
  'title': instance.title,
  if (instance.secret case final value?) 'secret': value,
  if (webhookTriggerToJson(instance.trigger) case final value?)
    'trigger': value,
  if (webhookResponseToJson(instance.response) case final value?)
    'response': value,
  if (webhookDeliveryToJson(instance.delivery) case final value?)
    'delivery': value,
  'url': instance.url,
};

WebhookStore _$WebhookStoreFromJson(Map<String, dynamic> json) => WebhookStore(
  active: json['active'] as bool?,
  title: json['title'] as String,
  trigger: webhookTriggerFromJson(json['trigger']),
  response: webhookResponseFromJson(json['response']),
  delivery: webhookDeliveryFromJson(json['delivery']),
  url: json['url'] as String,
);

Map<String, dynamic> _$WebhookStoreToJson(WebhookStore instance) =>
    <String, dynamic>{
      if (instance.active case final value?) 'active': value,
      'title': instance.title,
      if (webhookTriggerToJson(instance.trigger) case final value?)
        'trigger': value,
      if (webhookResponseToJson(instance.response) case final value?)
        'response': value,
      if (webhookDeliveryToJson(instance.delivery) case final value?)
        'delivery': value,
      'url': instance.url,
    };

WebhookUpdate _$WebhookUpdateFromJson(Map<String, dynamic> json) =>
    WebhookUpdate(
      active: json['active'] as bool?,
      title: json['title'] as String?,
      secret: json['secret'] as String?,
      trigger: webhookTriggerNullableFromJson(json['trigger']),
      response: webhookResponseNullableFromJson(json['response']),
      delivery: webhookDeliveryNullableFromJson(json['delivery']),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$WebhookUpdateToJson(WebhookUpdate instance) =>
    <String, dynamic>{
      if (instance.active case final value?) 'active': value,
      if (instance.title case final value?) 'title': value,
      if (instance.secret case final value?) 'secret': value,
      if (webhookTriggerNullableToJson(instance.trigger) case final value?)
        'trigger': value,
      if (webhookResponseNullableToJson(instance.response) case final value?)
        'response': value,
      if (webhookDeliveryNullableToJson(instance.delivery) case final value?)
        'delivery': value,
      if (instance.url case final value?) 'url': value,
    };

WebhookAttempt _$WebhookAttemptFromJson(Map<String, dynamic> json) =>
    WebhookAttempt(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      webhookMessageId: json['webhook_message_id'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      logs: json['logs'] as String?,
      response: json['response'] as String?,
    );

Map<String, dynamic> _$WebhookAttemptToJson(
  WebhookAttempt instance,
) => <String, dynamic>{
  if (instance.createdAt?.toIso8601String() case final value?)
    'created_at': value,
  if (instance.updatedAt?.toIso8601String() case final value?)
    'updated_at': value,
  if (instance.webhookMessageId case final value?) 'webhook_message_id': value,
  if (instance.statusCode case final value?) 'status_code': value,
  if (instance.logs case final value?) 'logs': value,
  if (instance.response case final value?) 'response': value,
};

WebhookMessage _$WebhookMessageFromJson(Map<String, dynamic> json) =>
    WebhookMessage(
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      sent: json['sent'] as bool?,
      errored: json['errored'] as bool?,
      webhookId: json['webhook_id'] as String?,
      uuid: json['uuid'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$WebhookMessageToJson(WebhookMessage instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.sent case final value?) 'sent': value,
      if (instance.errored case final value?) 'errored': value,
      if (instance.webhookId case final value?) 'webhook_id': value,
      if (instance.uuid case final value?) 'uuid': value,
      if (instance.message case final value?) 'message': value,
    };

PolymorphicProperty _$PolymorphicPropertyFromJson(Map<String, dynamic> json) =>
    PolymorphicProperty();

Map<String, dynamic> _$PolymorphicPropertyToJson(
  PolymorphicProperty instance,
) => <String, dynamic>{};

BasicSummary _$BasicSummaryFromJson(Map<String, dynamic> json) =>
    BasicSummary();

Map<String, dynamic> _$BasicSummaryToJson(BasicSummary instance) =>
    <String, dynamic>{};

BasicSummaryEntry _$BasicSummaryEntryFromJson(Map<String, dynamic> json) =>
    BasicSummaryEntry(
      key: json['key'] as String?,
      title: json['title'] as String?,
      monetaryValue: (json['monetary_value'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      noAvailableBudgets: json['no_available_budgets'] as bool?,
      valueParsed: json['value_parsed'] as String?,
      localIcon: json['local_icon'] as String?,
      subTitle: json['sub_title'] as String?,
    );

Map<String, dynamic> _$BasicSummaryEntryToJson(BasicSummaryEntry instance) =>
    <String, dynamic>{
      if (instance.key case final value?) 'key': value,
      if (instance.title case final value?) 'title': value,
      if (instance.monetaryValue case final value?) 'monetary_value': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.noAvailableBudgets case final value?)
        'no_available_budgets': value,
      if (instance.valueParsed case final value?) 'value_parsed': value,
      if (instance.localIcon case final value?) 'local_icon': value,
      if (instance.subTitle case final value?) 'sub_title': value,
    };

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      title: configValueFilterFromJson(json['title']),
      $value: PolymorphicProperty.fromJson(
        json['value'] as Map<String, dynamic>,
      ),
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$ConfigurationToJson(
  Configuration instance,
) => <String, dynamic>{
  if (configValueFilterToJson(instance.title) case final value?) 'title': value,
  'value': instance.$value.toJson(),
  'editable': instance.editable,
};

ConfigurationUpdate _$ConfigurationUpdateFromJson(Map<String, dynamic> json) =>
    ConfigurationUpdate(
      $value: PolymorphicProperty.fromJson(
        json['value'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConfigurationUpdateToJson(
  ConfigurationUpdate instance,
) => <String, dynamic>{'value': instance.$value.toJson()};

CronResult _$CronResultFromJson(Map<String, dynamic> json) => CronResult(
  recurringTransactions:
      json['recurring_transactions'] == null
          ? null
          : CronResultRow.fromJson(
            json['recurring_transactions'] as Map<String, dynamic>,
          ),
  autoBudgets:
      json['auto_budgets'] == null
          ? null
          : CronResultRow.fromJson(
            json['auto_budgets'] as Map<String, dynamic>,
          ),
  telemetry:
      json['telemetry'] == null
          ? null
          : CronResultRow.fromJson(json['telemetry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CronResultToJson(
  CronResult instance,
) => <String, dynamic>{
  if (instance.recurringTransactions?.toJson() case final value?)
    'recurring_transactions': value,
  if (instance.autoBudgets?.toJson() case final value?) 'auto_budgets': value,
  if (instance.telemetry?.toJson() case final value?) 'telemetry': value,
};

CronResultRow _$CronResultRowFromJson(Map<String, dynamic> json) =>
    CronResultRow(
      jobFired: json['job_fired'] as bool?,
      jobSucceeded: json['job_succeeded'] as bool?,
      jobErrored: json['job_errored'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CronResultRowToJson(CronResultRow instance) =>
    <String, dynamic>{
      if (instance.jobFired case final value?) 'job_fired': value,
      if (instance.jobSucceeded case final value?) 'job_succeeded': value,
      if (instance.jobErrored case final value?) 'job_errored': value,
      if (instance.message case final value?) 'message': value,
    };

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
  data:
      json['data'] == null
          ? null
          : SystemInfo$Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'data': value,
    };

UserSingle _$UserSingleFromJson(Map<String, dynamic> json) =>
    UserSingle(data: UserRead.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$UserSingleToJson(UserSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  pagination:
      json['pagination'] == null
          ? null
          : Meta$Pagination.fromJson(
            json['pagination'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  if (instance.pagination?.toJson() case final value?) 'pagination': value,
};

BadRequestResponse _$BadRequestResponseFromJson(Map<String, dynamic> json) =>
    BadRequestResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$BadRequestResponseToJson(BadRequestResponse instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.exception case final value?) 'exception': value,
    };

InternalExceptionResponse _$InternalExceptionResponseFromJson(
  Map<String, dynamic> json,
) => InternalExceptionResponse(
  message: json['message'] as String?,
  exception: json['exception'] as String?,
);

Map<String, dynamic> _$InternalExceptionResponseToJson(
  InternalExceptionResponse instance,
) => <String, dynamic>{
  if (instance.message case final value?) 'message': value,
  if (instance.exception case final value?) 'exception': value,
};

NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    NotFoundResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$NotFoundResponseToJson(NotFoundResponse instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.exception case final value?) 'exception': value,
    };

UnauthenticatedResponse _$UnauthenticatedResponseFromJson(
  Map<String, dynamic> json,
) => UnauthenticatedResponse(
  message: json['message'] as String?,
  exception: json['exception'] as String?,
);

Map<String, dynamic> _$UnauthenticatedResponseToJson(
  UnauthenticatedResponse instance,
) => <String, dynamic>{
  if (instance.message case final value?) 'message': value,
  if (instance.exception case final value?) 'exception': value,
};

ValidationErrorResponse _$ValidationErrorResponseFromJson(
  Map<String, dynamic> json,
) => ValidationErrorResponse(
  message: json['message'] as String?,
  errors:
      json['errors'] == null
          ? null
          : ValidationErrorResponse$Errors.fromJson(
            json['errors'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$ValidationErrorResponseToJson(
  ValidationErrorResponse instance,
) => <String, dynamic>{
  if (instance.message case final value?) 'message': value,
  if (instance.errors?.toJson() case final value?) 'errors': value,
};

BillProperties$PaidDates$Item _$BillProperties$PaidDates$ItemFromJson(
  Map<String, dynamic> json,
) => BillProperties$PaidDates$Item(
  transactionGroupId: json['transaction_group_id'] as String?,
  transactionJournalId: json['transaction_journal_id'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  subscriptionId: json['subscription_id'] as String?,
  currencyId: json['currency_id'] as String?,
  currencyName: json['currency_name'] as String?,
  currencyCode: json['currency_code'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
  currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
  primaryCurrencyId: json['primary_currency_id'] as String?,
  primaryCurrencyName: json['primary_currency_name'] as String?,
  primaryCurrencyCode: json['primary_currency_code'] as String?,
  primaryCurrencySymbol: json['primary_currency_symbol'] as String?,
  primaryCurrencyDecimalPlaces:
      (json['primary_currency_decimal_places'] as num?)?.toInt(),
  amount: json['amount'] as String?,
  pcAmount: json['pc_amount'] as String?,
  foreignAmount: json['foreign_amount'] as String?,
  pcForeignAmount: json['pc_foreign_amount'] as String?,
);

Map<String, dynamic> _$BillProperties$PaidDates$ItemToJson(
  BillProperties$PaidDates$Item instance,
) => <String, dynamic>{
  if (instance.transactionGroupId case final value?)
    'transaction_group_id': value,
  if (instance.transactionJournalId case final value?)
    'transaction_journal_id': value,
  if (instance.date?.toIso8601String() case final value?) 'date': value,
  if (instance.subscriptionId case final value?) 'subscription_id': value,
  if (instance.currencyId case final value?) 'currency_id': value,
  if (instance.currencyName case final value?) 'currency_name': value,
  if (instance.currencyCode case final value?) 'currency_code': value,
  if (instance.currencySymbol case final value?) 'currency_symbol': value,
  if (instance.currencyDecimalPlaces case final value?)
    'currency_decimal_places': value,
  if (instance.primaryCurrencyId case final value?)
    'primary_currency_id': value,
  if (instance.primaryCurrencyName case final value?)
    'primary_currency_name': value,
  if (instance.primaryCurrencyCode case final value?)
    'primary_currency_code': value,
  if (instance.primaryCurrencySymbol case final value?)
    'primary_currency_symbol': value,
  if (instance.primaryCurrencyDecimalPlaces case final value?)
    'primary_currency_decimal_places': value,
  if (instance.amount case final value?) 'amount': value,
  if (instance.pcAmount case final value?) 'pc_amount': value,
  if (instance.foreignAmount case final value?) 'foreign_amount': value,
  if (instance.pcForeignAmount case final value?) 'pc_foreign_amount': value,
};

SystemInfo$Data _$SystemInfo$DataFromJson(Map<String, dynamic> json) =>
    SystemInfo$Data(
      version: json['version'] as String?,
      apiVersion: json['api_version'] as String?,
      phpVersion: json['php_version'] as String?,
      os: json['os'] as String?,
      driver: json['driver'] as String?,
    );

Map<String, dynamic> _$SystemInfo$DataToJson(SystemInfo$Data instance) =>
    <String, dynamic>{
      if (instance.version case final value?) 'version': value,
      if (instance.apiVersion case final value?) 'api_version': value,
      if (instance.phpVersion case final value?) 'php_version': value,
      if (instance.os case final value?) 'os': value,
      if (instance.driver case final value?) 'driver': value,
    };

Meta$Pagination _$Meta$PaginationFromJson(Map<String, dynamic> json) =>
    Meta$Pagination(
      total: (json['total'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Meta$PaginationToJson(Meta$Pagination instance) =>
    <String, dynamic>{
      if (instance.total case final value?) 'total': value,
      if (instance.count case final value?) 'count': value,
      if (instance.perPage case final value?) 'per_page': value,
      if (instance.currentPage case final value?) 'current_page': value,
      if (instance.totalPages case final value?) 'total_pages': value,
    };

ValidationErrorResponse$Errors _$ValidationErrorResponse$ErrorsFromJson(
  Map<String, dynamic> json,
) => ValidationErrorResponse$Errors(
  email:
      (json['email'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  force:
      (json['force'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  blocked:
      (json['blocked'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  field:
      (json['field'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  role:
      (json['role'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  blockedCode:
      (json['blocked_code'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  name:
      (json['name'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  type:
      (json['type'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  iban:
      (json['iban'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  start:
      (json['start'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  end: (json['end'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  date:
      (json['date'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
);

Map<String, dynamic> _$ValidationErrorResponse$ErrorsToJson(
  ValidationErrorResponse$Errors instance,
) => <String, dynamic>{
  if (instance.email case final value?) 'email': value,
  if (instance.force case final value?) 'force': value,
  if (instance.blocked case final value?) 'blocked': value,
  if (instance.field case final value?) 'field': value,
  if (instance.role case final value?) 'role': value,
  if (instance.blockedCode case final value?) 'blocked_code': value,
  if (instance.name case final value?) 'name': value,
  if (instance.type case final value?) 'type': value,
  if (instance.iban case final value?) 'iban': value,
  if (instance.start case final value?) 'start': value,
  if (instance.end case final value?) 'end': value,
  if (instance.date case final value?) 'date': value,
};
