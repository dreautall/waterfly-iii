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
      active: json['active'] as bool?,
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
  'active': ?instance.active,
  'type': instance.type,
  'currency_id': instance.currencyId,
  'currency_name': instance.currencyName,
  'currency_code': instance.currencyCode,
  'currency_symbol': instance.currencySymbol,
  'currency_decimal_places': instance.currencyDecimalPlaces,
  'account_currency_id': ?instance.accountCurrencyId,
  'account_currency_name': ?instance.accountCurrencyName,
  'account_currency_code': ?instance.accountCurrencyCode,
  'account_currency_symbol': ?instance.accountCurrencySymbol,
  'account_currency_decimal_places': ?instance.accountCurrencyDecimalPlaces,
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
      'active': ?instance.active,
    };

AutocompleteBudget _$AutocompleteBudgetFromJson(Map<String, dynamic> json) =>
    AutocompleteBudget(
      id: json['id'] as String,
      name: json['name'] as String,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$AutocompleteBudgetToJson(AutocompleteBudget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': ?instance.active,
    };

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

Map<String, dynamic> _$AutocompletePiggyToJson(AutocompletePiggy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_name': ?instance.currencyName,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'object_group_id': ?instance.objectGroupId,
      'object_group_title': ?instance.objectGroupTitle,
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
  'name_with_balance': ?instance.nameWithBalance,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'object_group_id': ?instance.objectGroupId,
  'object_group_title': ?instance.objectGroupTitle,
};

AutocompleteRecurrence _$AutocompleteRecurrenceFromJson(
  Map<String, dynamic> json,
) => AutocompleteRecurrence(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  active: json['active'] as bool?,
);

Map<String, dynamic> _$AutocompleteRecurrenceToJson(
  AutocompleteRecurrence instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'active': ?instance.active,
};

AutocompleteRule _$AutocompleteRuleFromJson(Map<String, dynamic> json) =>
    AutocompleteRule(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$AutocompleteRuleToJson(AutocompleteRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': ?instance.description,
      'active': ?instance.active,
    };

AutocompleteRuleGroup _$AutocompleteRuleGroupFromJson(
  Map<String, dynamic> json,
) => AutocompleteRuleGroup(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  active: json['active'] as bool?,
);

Map<String, dynamic> _$AutocompleteRuleGroupToJson(
  AutocompleteRuleGroup instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'active': ?instance.active,
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
  'transaction_group_id': ?instance.transactionGroupId,
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
  'transaction_group_id': ?instance.transactionGroupId,
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
    <String, dynamic>{'key': ?instance.key};

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
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  type: json['type'] as String?,
  period: chartDatasetPeriodPropertyNullableFromJson(json['period']),
  yAxisID: (json['yAxisID'] as num?)?.toInt(),
  entries: json['entries'],
  pcEntries: json['pc_entries'],
);

Map<String, dynamic> _$ChartDataSetToJson(ChartDataSet instance) =>
    <String, dynamic>{
      'label': ?instance.label,
      'currency_id': ?instance.currencyId,
      'currency_name': ?instance.currencyName,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_name': ?instance.primaryCurrencyName,
      'primary_currency_code': ?instance.primaryCurrencyCode,
      'primary_currency_symbol': ?instance.primaryCurrencySymbol,
      'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
      'date': ?instance.date?.toIso8601String(),
      'start_date': ?instance.startDate?.toIso8601String(),
      'end_date': ?instance.endDate?.toIso8601String(),
      'type': ?instance.type,
      'period': ?chartDatasetPeriodPropertyNullableToJson(instance.period),
      'yAxisID': ?instance.yAxisID,
      'entries': ?instance.entries,
      'pc_entries': ?instance.pcEntries,
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
      'id': ?instance.id,
      'name': ?instance.name,
      'difference': ?instance.difference,
      'difference_float': ?instance.differenceFloat,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
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
      'difference': ?instance.difference,
      'difference_float': ?instance.differenceFloat,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
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
  'id': ?instance.id,
  'name': ?instance.name,
  'difference': ?instance.difference,
  'difference_float': ?instance.differenceFloat,
  'in': ?instance.$in,
  'in_float': ?instance.inFloat,
  'out': ?instance.out,
  'out_float': ?instance.outFloat,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
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
  attributes: WebhookProperties.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
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
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
      balanceDifference: json['balance_difference'] as String?,
      pcBalanceDifference: json['pc_balance_difference'] as String?,
      openingBalance: json['opening_balance'] as String?,
      pcOpeningBalance: json['pc_opening_balance'] as String?,
      virtualBalance: json['virtual_balance'] as String?,
      pcVirtualBalance: json['pc_virtual_balance'] as String?,
      debtAmount: json['debt_amount'] as String?,
      pcDebtAmount: json['pc_debt_amount'] as String?,
      currentBalanceDate: json['current_balance_date'] == null
          ? null
          : DateTime.parse(json['current_balance_date'] as String),
      notes: json['notes'] as String?,
      monthlyPaymentDate: json['monthly_payment_date'] == null
          ? null
          : DateTime.parse(json['monthly_payment_date'] as String),
      creditCardType: creditCardTypePropertyNullableFromJson(
        json['credit_card_type'],
      ),
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      openingBalanceDate: json['opening_balance_date'] == null
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
      lastActivity: json['last_activity'] == null
          ? null
          : DateTime.parse(json['last_activity'] as String),
    );

Map<String, dynamic> _$AccountPropertiesToJson(AccountProperties instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'active': ?instance.active,
      'order': ?instance.order,
      'name': instance.name,
      'type': ?shortAccountTypePropertyToJson(instance.type),
      'account_role': ?accountRolePropertyNullableToJson(instance.accountRole),
      'object_group_id': ?instance.objectGroupId,
      'object_group_order': ?instance.objectGroupOrder,
      'object_group_title': ?instance.objectGroupTitle,
      'object_has_currency_setting': ?instance.objectHasCurrencySetting,
      'currency_id': ?instance.currencyId,
      'currency_name': ?instance.currencyName,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_name': ?instance.primaryCurrencyName,
      'primary_currency_code': ?instance.primaryCurrencyCode,
      'primary_currency_symbol': ?instance.primaryCurrencySymbol,
      'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
      'current_balance': ?instance.currentBalance,
      'pc_current_balance': ?instance.pcCurrentBalance,
      'balance_difference': ?instance.balanceDifference,
      'pc_balance_difference': ?instance.pcBalanceDifference,
      'opening_balance': ?instance.openingBalance,
      'pc_opening_balance': ?instance.pcOpeningBalance,
      'virtual_balance': ?instance.virtualBalance,
      'pc_virtual_balance': ?instance.pcVirtualBalance,
      'debt_amount': ?instance.debtAmount,
      'pc_debt_amount': ?instance.pcDebtAmount,
      'current_balance_date': ?instance.currentBalanceDate?.toIso8601String(),
      'notes': ?instance.notes,
      'monthly_payment_date': ?instance.monthlyPaymentDate?.toIso8601String(),
      'credit_card_type': ?creditCardTypePropertyNullableToJson(
        instance.creditCardType,
      ),
      'account_number': ?instance.accountNumber,
      'iban': ?instance.iban,
      'bic': ?instance.bic,
      'opening_balance_date': ?instance.openingBalanceDate?.toIso8601String(),
      'liability_type': ?liabilityTypePropertyNullableToJson(
        instance.liabilityType,
      ),
      'liability_direction': ?liabilityDirectionPropertyNullableToJson(
        instance.liabilityDirection,
      ),
      'interest': ?instance.interest,
      'interest_period': ?interestPeriodPropertyNullableToJson(
        instance.interestPeriod,
      ),
      'include_net_worth': ?instance.includeNetWorth,
      'longitude': ?instance.longitude,
      'latitude': ?instance.latitude,
      'zoom_level': ?instance.zoomLevel,
      'last_activity': ?instance.lastActivity?.toIso8601String(),
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
  openingBalanceDate: json['opening_balance_date'] == null
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
  monthlyPaymentDate: json['monthly_payment_date'] == null
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

Map<String, dynamic> _$AccountStoreToJson(AccountStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': ?shortAccountTypePropertyToJson(instance.type),
      'iban': ?instance.iban,
      'bic': ?instance.bic,
      'account_number': ?instance.accountNumber,
      'opening_balance': ?instance.openingBalance,
      'opening_balance_date': ?instance.openingBalanceDate?.toIso8601String(),
      'virtual_balance': ?instance.virtualBalance,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'active': ?instance.active,
      'order': ?instance.order,
      'include_net_worth': ?instance.includeNetWorth,
      'account_role': ?accountRolePropertyNullableToJson(instance.accountRole),
      'credit_card_type': ?creditCardTypePropertyNullableToJson(
        instance.creditCardType,
      ),
      'monthly_payment_date': ?instance.monthlyPaymentDate?.toIso8601String(),
      'liability_type': ?liabilityTypePropertyNullableToJson(
        instance.liabilityType,
      ),
      'liability_direction': ?liabilityDirectionPropertyNullableToJson(
        instance.liabilityDirection,
      ),
      'interest': ?instance.interest,
      'interest_period': ?interestPeriodPropertyNullableToJson(
        instance.interestPeriod,
      ),
      'notes': ?instance.notes,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'zoom_level': ?instance.zoomLevel,
    };

AccountUpdate _$AccountUpdateFromJson(Map<String, dynamic> json) =>
    AccountUpdate(
      name: json['name'] as String,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      accountNumber: json['account_number'] as String?,
      openingBalance: json['opening_balance'] as String?,
      openingBalanceDate: json['opening_balance_date'] == null
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
      monthlyPaymentDate: json['monthly_payment_date'] == null
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

Map<String, dynamic> _$AccountUpdateToJson(AccountUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iban': ?instance.iban,
      'bic': ?instance.bic,
      'account_number': ?instance.accountNumber,
      'opening_balance': ?instance.openingBalance,
      'opening_balance_date': ?instance.openingBalanceDate?.toIso8601String(),
      'virtual_balance': ?instance.virtualBalance,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'active': ?instance.active,
      'order': ?instance.order,
      'include_net_worth': ?instance.includeNetWorth,
      'account_role': ?accountRolePropertyNullableToJson(instance.accountRole),
      'credit_card_type': ?creditCardTypePropertyNullableToJson(
        instance.creditCardType,
      ),
      'monthly_payment_date': ?instance.monthlyPaymentDate?.toIso8601String(),
      'liability_type': ?liabilityTypePropertyNullableToJson(
        instance.liabilityType,
      ),
      'interest': ?instance.interest,
      'interest_period': ?interestPeriodPropertyNullableToJson(
        instance.interestPeriod,
      ),
      'notes': ?instance.notes,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'zoom_level': ?instance.zoomLevel,
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
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'sum': ?instance.sum,
};

AttachmentProperties _$AttachmentPropertiesFromJson(
  Map<String, dynamic> json,
) => AttachmentProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'attachable_type': ?attachableTypeNullableToJson(instance.attachableType),
  'attachable_id': ?instance.attachableId,
  'hash': ?instance.hash,
  'filename': ?instance.filename,
  'download_url': ?instance.downloadUrl,
  'upload_url': ?instance.uploadUrl,
  'title': ?instance.title,
  'notes': ?instance.notes,
  'mime': ?instance.mime,
  'size': ?instance.size,
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
      'attachable_type': ?attachableTypeToJson(instance.attachableType),
      'attachable_id': instance.attachableId,
      'title': ?instance.title,
      'notes': ?instance.notes,
    };

AttachmentUpdate _$AttachmentUpdateFromJson(Map<String, dynamic> json) =>
    AttachmentUpdate(
      filename: json['filename'] as String?,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttachmentUpdateToJson(AttachmentUpdate instance) =>
    <String, dynamic>{
      'filename': ?instance.filename,
      'title': ?instance.title,
      'notes': ?instance.notes,
    };

AvailableBudgetProperties _$AvailableBudgetPropertiesFromJson(
  Map<String, dynamic> json,
) => AvailableBudgetProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'amount': ?instance.amount,
  'pc_amount': ?instance.pcAmount,
  'start': ?instance.start?.toIso8601String(),
  'end': ?instance.end?.toIso8601String(),
  'spent_in_budgets': ?instance.spentInBudgets?.map((e) => e.toJson()).toList(),
  'pc_spent_in_budgets': ?instance.pcSpentInBudgets
      ?.map((e) => e.toJson())
      .toList(),
  'spent_outside_budgets': ?instance.spentOutsideBudgets
      ?.map((e) => e.toJson())
      .toList(),
  'pc_spent_outside_budgets': ?instance.pcSpentOutsideBudgets
      ?.map((e) => e.toJson())
      .toList(),
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

BillProperties _$BillPropertiesFromJson(
  Map<String, dynamic> json,
) => BillProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  extensionDate: json['extension_date'] == null
      ? null
      : DateTime.parse(json['extension_date'] as String),
  repeatFreq: billRepeatFrequencyNullableFromJson(json['repeat_freq']),
  skip: (json['skip'] as num?)?.toInt(),
  active: json['active'] as bool?,
  order: (json['order'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  objectGroupId: json['object_group_id'] as String?,
  objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
  objectGroupTitle: json['object_group_title'] as String?,
  paidDates: (json['paid_dates'] as List<dynamic>?)
      ?.map(
        (e) =>
            BillProperties$PaidDates$Item.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  payDates:
      (json['pay_dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList() ??
      [],
  nextExpectedMatch: json['next_expected_match'] == null
      ? null
      : DateTime.parse(json['next_expected_match'] as String),
  nextExpectedMatchDiff: json['next_expected_match_diff'] as String?,
);

Map<String, dynamic> _$BillPropertiesToJson(BillProperties instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'name': ?instance.name,
      'object_has_currency_setting': ?instance.objectHasCurrencySetting,
      'currency_id': ?instance.currencyId,
      'currency_name': ?instance.currencyName,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_name': ?instance.primaryCurrencyName,
      'primary_currency_code': ?instance.primaryCurrencyCode,
      'primary_currency_symbol': ?instance.primaryCurrencySymbol,
      'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
      'amount_min': ?instance.amountMin,
      'pc_amount_min': ?instance.pcAmountMin,
      'amount_max': ?instance.amountMax,
      'pc_amount_max': ?instance.pcAmountMax,
      'amount_avg': ?instance.amountAvg,
      'pc_amount_avg': ?instance.pcAmountAvg,
      'date': ?instance.date?.toIso8601String(),
      'end_date': ?instance.endDate?.toIso8601String(),
      'extension_date': ?instance.extensionDate?.toIso8601String(),
      'repeat_freq': ?billRepeatFrequencyNullableToJson(instance.repeatFreq),
      'skip': ?instance.skip,
      'active': ?instance.active,
      'order': ?instance.order,
      'notes': ?instance.notes,
      'object_group_id': ?instance.objectGroupId,
      'object_group_order': ?instance.objectGroupOrder,
      'object_group_title': ?instance.objectGroupTitle,
      'paid_dates': ?instance.paidDates?.map((e) => e.toJson()).toList(),
      'pay_dates': ?instance.payDates?.map((e) => e.toIso8601String()).toList(),
      'next_expected_match': ?instance.nextExpectedMatch?.toIso8601String(),
      'next_expected_match_diff': ?instance.nextExpectedMatchDiff,
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
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  extensionDate: json['extension_date'] == null
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
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'name': instance.name,
  'amount_min': instance.amountMin,
  'amount_max': instance.amountMax,
  'date': instance.date.toIso8601String(),
  'end_date': ?instance.endDate?.toIso8601String(),
  'extension_date': ?instance.extensionDate?.toIso8601String(),
  'repeat_freq': ?billRepeatFrequencyToJson(instance.repeatFreq),
  'skip': ?instance.skip,
  'active': ?instance.active,
  'notes': ?instance.notes,
  'object_group_id': ?instance.objectGroupId,
  'object_group_title': ?instance.objectGroupTitle,
};

BillUpdate _$BillUpdateFromJson(Map<String, dynamic> json) => BillUpdate(
  currencyId: json['currency_id'] as String?,
  currencyCode: json['currency_code'] as String?,
  name: json['name'] as String,
  amountMin: json['amount_min'] as String?,
  amountMax: json['amount_max'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  extensionDate: json['extension_date'] == null
      ? null
      : DateTime.parse(json['extension_date'] as String),
  repeatFreq: billRepeatFrequencyNullableFromJson(json['repeat_freq']),
  skip: (json['skip'] as num?)?.toInt(),
  active: json['active'] as bool?,
  notes: json['notes'] as String?,
  objectGroupId: json['object_group_id'] as String?,
  objectGroupTitle: json['object_group_title'] as String?,
);

Map<String, dynamic> _$BillUpdateToJson(BillUpdate instance) =>
    <String, dynamic>{
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'name': instance.name,
      'amount_min': ?instance.amountMin,
      'amount_max': ?instance.amountMax,
      'date': ?instance.date?.toIso8601String(),
      'end_date': ?instance.endDate?.toIso8601String(),
      'extension_date': ?instance.extensionDate?.toIso8601String(),
      'repeat_freq': ?billRepeatFrequencyNullableToJson(instance.repeatFreq),
      'skip': ?instance.skip,
      'active': ?instance.active,
      'notes': ?instance.notes,
      'object_group_id': ?instance.objectGroupId,
      'object_group_title': ?instance.objectGroupTitle,
    };

BudgetProperties _$BudgetPropertiesFromJson(Map<String, dynamic> json) =>
    BudgetProperties(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'active': ?instance.active,
  'name': instance.name,
  'order': ?instance.order,
  'notes': ?instance.notes,
  'auto_budget_type': ?autoBudgetTypeNullableToJson(instance.autoBudgetType),
  'auto_budget_period': ?autoBudgetPeriodNullableToJson(
    instance.autoBudgetPeriod,
  ),
  'object_group_id': ?instance.objectGroupId,
  'object_group_order': ?instance.objectGroupOrder,
  'object_group_title': ?instance.objectGroupTitle,
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'auto_budget_amount': ?instance.autoBudgetAmount,
  'pc_auto_budget_amount': ?instance.pcAutoBudgetAmount,
  'spent': ?instance.spent?.map((e) => e.toJson()).toList(),
  'pc_spent': ?instance.pcSpent?.map((e) => e.toJson()).toList(),
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
  fireWebhooks: json['fire_webhooks'] as bool? ?? true,
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
  'active': ?instance.active,
  'order': ?instance.order,
  'notes': ?instance.notes,
  'fire_webhooks': ?instance.fireWebhooks,
  'auto_budget_type': ?autoBudgetTypeNullableToJson(instance.autoBudgetType),
  'auto_budget_currency_id': ?instance.autoBudgetCurrencyId,
  'auto_budget_currency_code': ?instance.autoBudgetCurrencyCode,
  'auto_budget_amount': ?instance.autoBudgetAmount,
  'auto_budget_period': ?autoBudgetPeriodNullableToJson(
    instance.autoBudgetPeriod,
  ),
};

BudgetUpdate _$BudgetUpdateFromJson(Map<String, dynamic> json) => BudgetUpdate(
  name: json['name'] as String,
  active: json['active'] as bool?,
  order: (json['order'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  fireWebhooks: json['fire_webhooks'] as bool? ?? true,
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
  'active': ?instance.active,
  'order': ?instance.order,
  'notes': ?instance.notes,
  'fire_webhooks': ?instance.fireWebhooks,
  'auto_budget_type': ?autoBudgetTypeNullableToJson(instance.autoBudgetType),
  'auto_budget_currency_id': ?instance.autoBudgetCurrencyId,
  'auto_budget_currency_code': ?instance.autoBudgetCurrencyCode,
  'auto_budget_amount': ?instance.autoBudgetAmount,
  'auto_budget_period': ?autoBudgetPeriodNullableToJson(
    instance.autoBudgetPeriod,
  ),
};

BudgetLimitProperties _$BudgetLimitPropertiesFromJson(
  Map<String, dynamic> json,
) => BudgetLimitProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'start': ?instance.start?.toIso8601String(),
  'end': ?instance.end?.toIso8601String(),
  'budget_id': ?instance.budgetId,
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'amount': ?instance.amount,
  'pc_amount': ?instance.pcAmount,
  'period': ?instance.period,
  'spent': ?instance.spent?.map((e) => e.toJson()).toList(),
  'pc_spent': ?instance.pcSpent?.map((e) => e.toJson()).toList(),
  'notes': ?instance.notes,
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
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
    );

Map<String, dynamic> _$BudgetLimitStoreToJson(BudgetLimitStore instance) =>
    <String, dynamic>{
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'budget_id': ?instance.budgetId,
      'start': ?_dateToJson(instance.start),
      'period': ?instance.period,
      'end': ?_dateToJson(instance.end),
      'amount': instance.amount,
      'notes': ?instance.notes,
      'fire_webhooks': ?instance.fireWebhooks,
    };

BudgetLimitUpdate _$BudgetLimitUpdateFromJson(Map<String, dynamic> json) =>
    BudgetLimitUpdate(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
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
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
    );

Map<String, dynamic> _$BudgetLimitUpdateToJson(BudgetLimitUpdate instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'start': ?instance.start?.toIso8601String(),
      'end': ?instance.end?.toIso8601String(),
      'budget_id': ?instance.budgetId,
      'object_has_currency_setting': ?instance.objectHasCurrencySetting,
      'currency_id': ?instance.currencyId,
      'currency_name': ?instance.currencyName,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_name': ?instance.primaryCurrencyName,
      'primary_currency_code': ?instance.primaryCurrencyCode,
      'primary_currency_symbol': ?instance.primaryCurrencySymbol,
      'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
      'period': ?instance.period,
      'amount': ?instance.amount,
      'pc_amount': ?instance.pcAmount,
      'spent': ?instance.spent,
      'notes': ?instance.notes,
      'fire_webhooks': ?instance.fireWebhooks,
    };

CategoryProperties _$CategoryPropertiesFromJson(Map<String, dynamic> json) =>
    CategoryProperties(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'name': instance.name,
  'notes': ?instance.notes,
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'spent': ?instance.spent?.map((e) => e.toJson()).toList(),
  'pc_spent': ?instance.pcSpent?.map((e) => e.toJson()).toList(),
  'earned': ?instance.earned?.map((e) => e.toJson()).toList(),
  'pc_earned': ?instance.pcEarned?.map((e) => e.toJson()).toList(),
  'transferred': ?instance.transferred?.map((e) => e.toJson()).toList(),
  'pc_transferred': ?instance.pcTransferred?.map((e) => e.toJson()).toList(),
};

CategoryStore _$CategoryStoreFromJson(Map<String, dynamic> json) =>
    CategoryStore(
      name: json['name'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CategoryStoreToJson(CategoryStore instance) =>
    <String, dynamic>{'name': instance.name, 'notes': ?instance.notes};

CategoryUpdate _$CategoryUpdateFromJson(Map<String, dynamic> json) =>
    CategoryUpdate(
      name: json['name'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CategoryUpdateToJson(CategoryUpdate instance) =>
    <String, dynamic>{'name': instance.name, 'notes': ?instance.notes};

CurrencyExchangeProperties _$CurrencyExchangePropertiesFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  fromCurrencyId: json['from_currency_id'] as String?,
  fromCurrencyName: json['from_currency_name'] as String?,
  fromCurrencyCode: json['from_currency_code'] as String?,
  fromCurrencySymbol: json['from_currency_symbol'] as String?,
  fromCurrencyDecimalPlaces: (json['from_currency_decimal_places'] as num?)
      ?.toInt(),
  toCurrencyId: json['to_currency_id'] as String?,
  toCurrencyName: json['to_currency_name'] as String?,
  toCurrencyCode: json['to_currency_code'] as String?,
  toCurrencySymbol: json['to_currency_symbol'] as String?,
  toCurrencyDecimalPlaces: (json['to_currency_decimal_places'] as num?)
      ?.toInt(),
  rate: json['rate'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$CurrencyExchangePropertiesToJson(
  CurrencyExchangeProperties instance,
) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'from_currency_id': ?instance.fromCurrencyId,
  'from_currency_name': ?instance.fromCurrencyName,
  'from_currency_code': ?instance.fromCurrencyCode,
  'from_currency_symbol': ?instance.fromCurrencySymbol,
  'from_currency_decimal_places': ?instance.fromCurrencyDecimalPlaces,
  'to_currency_id': ?instance.toCurrencyId,
  'to_currency_name': ?instance.toCurrencyName,
  'to_currency_code': ?instance.toCurrencyCode,
  'to_currency_symbol': ?instance.toCurrencySymbol,
  'to_currency_decimal_places': ?instance.toCurrencyDecimalPlaces,
  'rate': ?instance.rate,
  'date': ?instance.date?.toIso8601String(),
};

CurrencyExchangeRateRead _$CurrencyExchangeRateReadFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateRead(
  type: json['type'] as String?,
  id: json['id'] as String?,
  attributes: json['attributes'] == null
      ? null
      : CurrencyExchangeProperties.fromJson(
          json['attributes'] as Map<String, dynamic>,
        ),
  links: json['links'] == null
      ? null
      : ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrencyExchangeRateReadToJson(
  CurrencyExchangeRateRead instance,
) => <String, dynamic>{
  'type': ?instance.type,
  'id': ?instance.id,
  'attributes': ?instance.attributes?.toJson(),
  'links': ?instance.links?.toJson(),
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
  date: DateTime.parse(json['date'] as String),
  from: json['from'] as String,
  to: json['to'] as String,
  rate: json['rate'] as String?,
);

Map<String, dynamic> _$CurrencyExchangeRateStoreToJson(
  CurrencyExchangeRateStore instance,
) => <String, dynamic>{
  'date': ?_dateToJson(instance.date),
  'from': instance.from,
  'to': instance.to,
  'rate': ?instance.rate,
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
  'date': ?_dateToJson(instance.date),
  'rate': instance.rate,
  'from': ?instance.from,
  'to': ?instance.to,
};

CurrencyExchangeRateUpdateNoDate _$CurrencyExchangeRateUpdateNoDateFromJson(
  Map<String, dynamic> json,
) => CurrencyExchangeRateUpdateNoDate(rate: json['rate'] as String);

Map<String, dynamic> _$CurrencyExchangeRateUpdateNoDateToJson(
  CurrencyExchangeRateUpdateNoDate instance,
) => <String, dynamic>{'rate': instance.rate};

ObjectGroup _$ObjectGroupFromJson(Map<String, dynamic> json) => ObjectGroup(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$ObjectGroupToJson(ObjectGroup instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'title': instance.title,
      'order': instance.order,
    };

ObjectGroupUpdate _$ObjectGroupUpdateFromJson(Map<String, dynamic> json) =>
    ObjectGroupUpdate(
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ObjectGroupUpdateToJson(ObjectGroupUpdate instance) =>
    <String, dynamic>{'title': instance.title, 'order': ?instance.order};

ObjectLink _$ObjectLinkFromJson(Map<String, dynamic> json) =>
    ObjectLink(self: json['self'] as String?);

Map<String, dynamic> _$ObjectLinkToJson(ObjectLink instance) =>
    <String, dynamic>{'self': ?instance.self};

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
  self: json['self'] as String?,
  first: json['first'] as String?,
  next: json['next'] as String?,
  prev: json['prev'] as String?,
  last: json['last'] as String?,
);

Map<String, dynamic> _$PageLinkToJson(PageLink instance) => <String, dynamic>{
  'self': ?instance.self,
  'first': ?instance.first,
  'next': ?instance.next,
  'prev': ?instance.prev,
  'last': ?instance.last,
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
  'account_id': ?instance.accountId,
  'name': ?instance.name,
  'current_amount': ?instance.currentAmount,
  'pc_current_amount': ?instance.pcCurrentAmount,
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
  'id': ?instance.id,
  'name': ?instance.name,
  'current_amount': ?instance.currentAmount,
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
  'account_id': ?instance.accountId,
  'name': ?instance.name,
  'current_amount': ?instance.currentAmount,
};

PiggyBankProperties _$PiggyBankPropertiesFromJson(Map<String, dynamic> json) =>
    PiggyBankProperties(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      percentage: (json['percentage'] as num?)?.toInt(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'name': instance.name,
  'percentage': ?instance.percentage,
  'start_date': ?instance.startDate?.toIso8601String(),
  'target_date': ?instance.targetDate?.toIso8601String(),
  'order': ?instance.order,
  'active': ?instance.active,
  'notes': ?instance.notes,
  'object_group_id': ?instance.objectGroupId,
  'object_group_order': ?instance.objectGroupOrder,
  'object_group_title': ?instance.objectGroupTitle,
  'accounts': ?instance.accounts?.map((e) => e.toJson()).toList(),
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'target_amount': ?instance.targetAmount,
  'pc_target_amount': ?instance.pcTargetAmount,
  'current_amount': ?instance.currentAmount,
  'pc_current_amount': ?instance.pcCurrentAmount,
  'left_to_save': ?instance.leftToSave,
  'pc_left_to_save': ?instance.pcLeftToSave,
  'save_per_month': ?instance.savePerMonth,
  'pc_save_per_month': ?instance.pcSavePerMonth,
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
      startDate: DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankStoreToJson(PiggyBankStore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'accounts': ?instance.accounts?.map((e) => e.toJson()).toList(),
      'target_amount': ?instance.targetAmount,
      'current_amount': ?instance.currentAmount,
      'start_date': ?_dateToJson(instance.startDate),
      'target_date': ?_dateToJson(instance.targetDate),
      'order': ?instance.order,
      'active': ?instance.active,
      'notes': ?instance.notes,
      'object_group_id': ?instance.objectGroupId,
      'object_group_title': ?instance.objectGroupTitle,
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
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      targetDate: json['target_date'] == null
          ? null
          : DateTime.parse(json['target_date'] as String),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupTitle: json['object_group_title'] as String?,
    );

Map<String, dynamic> _$PiggyBankUpdateToJson(PiggyBankUpdate instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'accounts': ?instance.accounts?.map((e) => e.toJson()).toList(),
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'target_amount': ?instance.targetAmount,
      'start_date': ?_dateToJson(instance.startDate),
      'target_date': ?_dateToJson(instance.targetDate),
      'order': ?instance.order,
      'active': ?instance.active,
      'notes': ?instance.notes,
      'object_group_id': ?instance.objectGroupId,
      'object_group_title': ?instance.objectGroupTitle,
    };

PiggyBankEventProperties _$PiggyBankEventPropertiesFromJson(
  Map<String, dynamic> json,
) => PiggyBankEventProperties(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'amount': ?instance.amount,
  'pc_amount': ?instance.pcAmount,
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'transaction_journal_id': ?instance.transactionJournalId,
  'transaction_group_id': ?instance.transactionGroupId,
};

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  name: json['name'] as String,
  data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
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
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  type: recurrenceTransactionTypeNullableFromJson(json['type']),
  title: json['title'] as String?,
  description: json['description'] as String?,
  firstDate: json['first_date'] == null
      ? null
      : DateTime.parse(json['first_date'] as String),
  latestDate: json['latest_date'] == null
      ? null
      : DateTime.parse(json['latest_date'] as String),
  repeatUntil: json['repeat_until'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'type': ?recurrenceTransactionTypeNullableToJson(instance.type),
  'title': ?instance.title,
  'description': ?instance.description,
  'first_date': ?_dateToJson(instance.firstDate),
  'latest_date': ?_dateToJson(instance.latestDate),
  'repeat_until': ?_dateToJson(instance.repeatUntil),
  'apply_rules': ?instance.applyRules,
  'active': ?instance.active,
  'nr_of_repetitions': ?instance.nrOfRepetitions,
  'notes': ?instance.notes,
  'repetitions': ?instance.repetitions?.map((e) => e.toJson()).toList(),
  'transactions': ?instance.transactions?.map((e) => e.toJson()).toList(),
};

RecurrenceStore _$RecurrenceStoreFromJson(
  Map<String, dynamic> json,
) => RecurrenceStore(
  type: recurrenceTransactionTypeFromJson(json['type']),
  title: json['title'] as String,
  description: json['description'] as String?,
  firstDate: DateTime.parse(json['first_date'] as String),
  repeatUntil: json['repeat_until'] == null
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

Map<String, dynamic> _$RecurrenceStoreToJson(RecurrenceStore instance) =>
    <String, dynamic>{
      'type': ?recurrenceTransactionTypeToJson(instance.type),
      'title': instance.title,
      'description': ?instance.description,
      'first_date': ?_dateToJson(instance.firstDate),
      'repeat_until': ?_dateToJson(instance.repeatUntil),
      'nr_of_repetitions': ?instance.nrOfRepetitions,
      'apply_rules': ?instance.applyRules,
      'active': ?instance.active,
      'notes': ?instance.notes,
      'repetitions': instance.repetitions.map((e) => e.toJson()).toList(),
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

RecurrenceUpdate _$RecurrenceUpdateFromJson(
  Map<String, dynamic> json,
) => RecurrenceUpdate(
  title: json['title'] as String?,
  description: json['description'] as String?,
  firstDate: json['first_date'] == null
      ? null
      : DateTime.parse(json['first_date'] as String),
  repeatUntil: json['repeat_until'] == null
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

Map<String, dynamic> _$RecurrenceUpdateToJson(RecurrenceUpdate instance) =>
    <String, dynamic>{
      'title': ?instance.title,
      'description': ?instance.description,
      'first_date': ?_dateToJson(instance.firstDate),
      'repeat_until': ?_dateToJson(instance.repeatUntil),
      'nr_of_repetitions': ?instance.nrOfRepetitions,
      'apply_rules': ?instance.applyRules,
      'active': ?instance.active,
      'notes': ?instance.notes,
      'repetitions': ?instance.repetitions?.map((e) => e.toJson()).toList(),
      'transactions': ?instance.transactions?.map((e) => e.toJson()).toList(),
    };

RecurrenceRepetition _$RecurrenceRepetitionFromJson(
  Map<String, dynamic> json,
) => RecurrenceRepetition(
  id: json['id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'id': ?instance.id,
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'type': ?recurrenceRepetitionTypeToJson(instance.type),
  'moment': instance.moment,
  'skip': ?instance.skip,
  'weekend': ?instance.weekend,
  'description': ?instance.description,
  'occurrences': ?instance.occurrences
      ?.map((e) => e.toIso8601String())
      .toList(),
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
  'type': ?recurrenceRepetitionTypeToJson(instance.type),
  'moment': instance.moment,
  'skip': ?instance.skip,
  'weekend': ?instance.weekend,
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
  'type': ?recurrenceRepetitionTypeNullableToJson(instance.type),
  'moment': ?instance.moment,
  'skip': ?instance.skip,
  'weekend': ?instance.weekend,
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
  'id': ?instance.id,
  'description': instance.description,
  'object_has_currency_setting': ?instance.objectHasCurrencySetting,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'amount': instance.amount,
  'pc_amount': ?instance.pcAmount,
  'foreign_amount': ?instance.foreignAmount,
  'pc_foreign_amount': ?instance.pcForeignAmount,
  'foreign_currency_id': ?instance.foreignCurrencyId,
  'foreign_currency_name': ?instance.foreignCurrencyName,
  'foreign_currency_code': ?instance.foreignCurrencyCode,
  'foreign_currency_symbol': ?instance.foreignCurrencySymbol,
  'foreign_currency_decimal_places': ?instance.foreignCurrencyDecimalPlaces,
  'budget_id': ?instance.budgetId,
  'budget_name': ?instance.budgetName,
  'category_id': ?instance.categoryId,
  'category_name': ?instance.categoryName,
  'source_id': ?instance.sourceId,
  'source_name': ?instance.sourceName,
  'source_iban': ?instance.sourceIban,
  'source_type': ?accountTypePropertyNullableToJson(instance.sourceType),
  'destination_id': ?instance.destinationId,
  'destination_name': ?instance.destinationName,
  'destination_iban': ?instance.destinationIban,
  'destination_type': ?accountTypePropertyNullableToJson(
    instance.destinationType,
  ),
  'tags': ?instance.tags,
  'piggy_bank_id': ?instance.piggyBankId,
  'piggy_bank_name': ?instance.piggyBankName,
  'subscription_id': ?instance.subscriptionId,
  'subscription_name': ?instance.subscriptionName,
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
  'foreign_amount': ?instance.foreignAmount,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'foreign_currency_id': ?instance.foreignCurrencyId,
  'foreign_currency_code': ?instance.foreignCurrencyCode,
  'budget_id': ?instance.budgetId,
  'category_id': ?instance.categoryId,
  'source_id': instance.sourceId,
  'destination_id': instance.destinationId,
  'tags': ?instance.tags,
  'piggy_bank_id': ?instance.piggyBankId,
  'bill_id': ?instance.billId,
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
  'description': ?instance.description,
  'amount': ?instance.amount,
  'foreign_amount': ?instance.foreignAmount,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'foreign_currency_id': ?instance.foreignCurrencyId,
  'budget_id': ?instance.budgetId,
  'category_id': ?instance.categoryId,
  'source_id': ?instance.sourceId,
  'destination_id': ?instance.destinationId,
  'tags': ?instance.tags,
  'piggy_bank_id': ?instance.piggyBankId,
  'bill_id': ?instance.billId,
};

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'title': instance.title,
  'description': ?instance.description,
  'rule_group_id': instance.ruleGroupId,
  'rule_group_title': ?instance.ruleGroupTitle,
  'order': ?instance.order,
  'trigger': ?ruleTriggerTypeToJson(instance.trigger),
  'active': ?instance.active,
  'strict': ?instance.strict,
  'stop_processing': ?instance.stopProcessing,
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
  'description': ?instance.description,
  'rule_group_id': instance.ruleGroupId,
  'rule_group_title': ?instance.ruleGroupTitle,
  'order': ?instance.order,
  'trigger': ?ruleTriggerTypeToJson(instance.trigger),
  'active': ?instance.active,
  'strict': ?instance.strict,
  'stop_processing': ?instance.stopProcessing,
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
      'title': ?instance.title,
      'description': ?instance.description,
      'rule_group_id': ?instance.ruleGroupId,
      'order': ?instance.order,
      'trigger': ?ruleTriggerTypeNullableToJson(instance.trigger),
      'active': ?instance.active,
      'strict': ?instance.strict,
      'stop_processing': ?instance.stopProcessing,
      'triggers': ?instance.triggers?.map((e) => e.toJson()).toList(),
      'actions': ?instance.actions?.map((e) => e.toJson()).toList(),
    };

RuleAction _$RuleActionFromJson(Map<String, dynamic> json) => RuleAction(
  id: json['id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  type: ruleActionKeywordFromJson(json['type']),
  value: json['value'] as String?,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  stopProcessing: json['stop_processing'] as bool? ?? false,
);

Map<String, dynamic> _$RuleActionToJson(RuleAction instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'type': ?ruleActionKeywordToJson(instance.type),
      'value': ?instance.value,
      'order': ?instance.order,
      'active': ?instance.active,
      'stop_processing': ?instance.stopProcessing,
    };

RuleActionStore _$RuleActionStoreFromJson(Map<String, dynamic> json) =>
    RuleActionStore(
      type: ruleActionKeywordFromJson(json['type']),
      value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleActionStoreToJson(RuleActionStore instance) =>
    <String, dynamic>{
      'type': ?ruleActionKeywordToJson(instance.type),
      'value': ?instance.value,
      'order': ?instance.order,
      'active': ?instance.active,
      'stop_processing': ?instance.stopProcessing,
    };

RuleActionUpdate _$RuleActionUpdateFromJson(Map<String, dynamic> json) =>
    RuleActionUpdate(
      type: ruleActionKeywordNullableFromJson(json['type']),
      value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      stopProcessing: json['stop_processing'] as bool?,
    );

Map<String, dynamic> _$RuleActionUpdateToJson(RuleActionUpdate instance) =>
    <String, dynamic>{
      'type': ?ruleActionKeywordNullableToJson(instance.type),
      'value': ?instance.value,
      'order': ?instance.order,
      'active': ?instance.active,
      'stop_processing': ?instance.stopProcessing,
    };

RuleGroup _$RuleGroupFromJson(Map<String, dynamic> json) => RuleGroup(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  description: json['description'] as String?,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool?,
);

Map<String, dynamic> _$RuleGroupToJson(RuleGroup instance) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'title': instance.title,
  'description': ?instance.description,
  'order': ?instance.order,
  'active': ?instance.active,
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
      'description': ?instance.description,
      'order': ?instance.order,
      'active': ?instance.active,
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
      'title': ?instance.title,
      'description': ?instance.description,
      'order': ?instance.order,
      'active': ?instance.active,
    };

RuleTrigger _$RuleTriggerFromJson(Map<String, dynamic> json) => RuleTrigger(
  id: json['id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  type: ruleTriggerKeywordFromJson(json['type']),
  value: json['value'] as String,
  prohibited: json['prohibited'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt(),
  active: json['active'] as bool? ?? true,
  stopProcessing: json['stop_processing'] as bool? ?? false,
);

Map<String, dynamic> _$RuleTriggerToJson(RuleTrigger instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'type': ?ruleTriggerKeywordToJson(instance.type),
      'value': instance.value,
      'prohibited': ?instance.prohibited,
      'order': ?instance.order,
      'active': ?instance.active,
      'stop_processing': ?instance.stopProcessing,
    };

RuleTriggerStore _$RuleTriggerStoreFromJson(Map<String, dynamic> json) =>
    RuleTriggerStore(
      type: ruleTriggerKeywordFromJson(json['type']),
      value: json['value'] as String,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      prohibited: json['prohibited'] as bool? ?? false,
      stopProcessing: json['stop_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleTriggerStoreToJson(RuleTriggerStore instance) =>
    <String, dynamic>{
      'type': ?ruleTriggerKeywordToJson(instance.type),
      'value': instance.value,
      'order': ?instance.order,
      'active': ?instance.active,
      'prohibited': ?instance.prohibited,
      'stop_processing': ?instance.stopProcessing,
    };

RuleTriggerUpdate _$RuleTriggerUpdateFromJson(Map<String, dynamic> json) =>
    RuleTriggerUpdate(
      type: ruleTriggerKeywordNullableFromJson(json['type']),
      value: json['value'] as String?,
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      stopProcessing: json['stop_processing'] as bool?,
    );

Map<String, dynamic> _$RuleTriggerUpdateToJson(RuleTriggerUpdate instance) =>
    <String, dynamic>{
      'type': ?ruleTriggerKeywordNullableToJson(instance.type),
      'value': ?instance.value,
      'order': ?instance.order,
      'active': ?instance.active,
      'stop_processing': ?instance.stopProcessing,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'tag': instance.tag,
  'date': ?_dateToJson(instance.date),
  'description': ?instance.description,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'zoom_level': ?instance.zoomLevel,
};

TagModelStore _$TagModelStoreFromJson(Map<String, dynamic> json) =>
    TagModelStore(
      tag: json['tag'] as String,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelStoreToJson(TagModelStore instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'date': ?_dateToJson(instance.date),
      'description': ?instance.description,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'zoom_level': ?instance.zoomLevel,
    };

TagModelUpdate _$TagModelUpdateFromJson(Map<String, dynamic> json) =>
    TagModelUpdate(
      tag: json['tag'] as String?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelUpdateToJson(TagModelUpdate instance) =>
    <String, dynamic>{
      'tag': ?instance.tag,
      'date': ?_dateToJson(instance.date),
      'description': ?instance.description,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'zoom_level': ?instance.zoomLevel,
    };

CurrencyProperties _$CurrencyPropertiesFromJson(Map<String, dynamic> json) =>
    CurrencyProperties(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'enabled': ?instance.enabled,
      'primary': ?instance.primary,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': ?instance.decimalPlaces,
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
      'enabled': ?instance.enabled,
      'primary': ?instance.primary,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimal_places': ?instance.decimalPlaces,
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
      'enabled': ?instance.enabled,
      'primary': ?instance.primary,
      'code': ?instance.code,
      'name': ?instance.name,
      'symbol': ?instance.symbol,
      'decimal_places': ?instance.decimalPlaces,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'user': ?instance.user,
      'group_title': ?instance.groupTitle,
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
      'error_if_duplicate_hash': ?instance.errorIfDuplicateHash,
      'apply_rules': ?instance.applyRules,
      'fire_webhooks': ?instance.fireWebhooks,
      'group_title': ?instance.groupTitle,
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

Map<String, dynamic> _$TransactionUpdateToJson(TransactionUpdate instance) =>
    <String, dynamic>{
      'apply_rules': ?instance.applyRules,
      'fire_webhooks': ?instance.fireWebhooks,
      'group_title': ?instance.groupTitle,
      'transactions': ?instance.transactions?.map((e) => e.toJson()).toList(),
    };

TransactionLink _$TransactionLinkFromJson(Map<String, dynamic> json) =>
    TransactionLink(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'link_type_id': ?instance.linkTypeId,
      'link_type_name': ?instance.linkTypeName,
      'inward_id': instance.inwardId,
      'outward_id': instance.outwardId,
      'notes': ?instance.notes,
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
  'link_type_id': ?instance.linkTypeId,
  'link_type_name': ?instance.linkTypeName,
  'inward_id': instance.inwardId,
  'outward_id': instance.outwardId,
  'notes': ?instance.notes,
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
  'link_type_id': ?instance.linkTypeId,
  'link_type_name': ?instance.linkTypeName,
  'inward_id': ?instance.inwardId,
  'outward_id': ?instance.outwardId,
  'notes': ?instance.notes,
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
  'editable': ?instance.editable,
};

LinkTypeUpdate _$LinkTypeUpdateFromJson(Map<String, dynamic> json) =>
    LinkTypeUpdate(
      name: json['name'] as String?,
      inward: json['inward'] as String?,
      outward: json['outward'] as String?,
    );

Map<String, dynamic> _$LinkTypeUpdateToJson(LinkTypeUpdate instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'inward': ?instance.inward,
      'outward': ?instance.outward,
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
  zoomLevel: (json['zoom_level'] as num?)?.toInt(),
  hasAttachments: json['has_attachments'] as bool?,
);

Map<String, dynamic> _$TransactionSplitToJson(TransactionSplit instance) =>
    <String, dynamic>{
      'user': ?instance.user,
      'transaction_journal_id': ?instance.transactionJournalId,
      'type': ?transactionTypePropertyToJson(instance.type),
      'date': instance.date.toIso8601String(),
      'order': ?instance.order,
      'object_has_currency_setting': ?instance.objectHasCurrencySetting,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_name': ?instance.currencyName,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'foreign_currency_id': ?instance.foreignCurrencyId,
      'foreign_currency_code': ?instance.foreignCurrencyCode,
      'foreign_currency_symbol': ?instance.foreignCurrencySymbol,
      'foreign_currency_decimal_places': ?instance.foreignCurrencyDecimalPlaces,
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_code': ?instance.primaryCurrencyCode,
      'primary_currency_symbol': ?instance.primaryCurrencySymbol,
      'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
      'amount': instance.amount,
      'pc_amount': ?instance.pcAmount,
      'foreign_amount': ?instance.foreignAmount,
      'pc_foreign_amount': ?instance.pcForeignAmount,
      'source_balance_after': ?instance.sourceBalanceAfter,
      'pc_source_balance_after': ?instance.pcSourceBalanceAfter,
      'destination_balance_after': ?instance.destinationBalanceAfter,
      'pc_destination_balance_after': ?instance.pcDestinationBalanceAfter,
      'description': instance.description,
      'source_id': ?instance.sourceId,
      'source_name': ?instance.sourceName,
      'source_iban': ?instance.sourceIban,
      'source_type': ?accountTypePropertyNullableToJson(instance.sourceType),
      'destination_id': ?instance.destinationId,
      'destination_name': ?instance.destinationName,
      'destination_iban': ?instance.destinationIban,
      'destination_type': ?accountTypePropertyNullableToJson(
        instance.destinationType,
      ),
      'budget_id': ?instance.budgetId,
      'budget_name': ?instance.budgetName,
      'category_id': ?instance.categoryId,
      'category_name': ?instance.categoryName,
      'bill_id': ?instance.billId,
      'bill_name': ?instance.billName,
      'subscription_id': ?instance.subscriptionId,
      'subscription_name': ?instance.subscriptionName,
      'reconciled': ?instance.reconciled,
      'notes': ?instance.notes,
      'tags': ?instance.tags,
      'internal_reference': ?instance.internalReference,
      'external_id': ?instance.externalId,
      'external_url': ?instance.externalUrl,
      'original_source': ?instance.originalSource,
      'recurrence_id': ?instance.recurrenceId,
      'recurrence_total': ?instance.recurrenceTotal,
      'recurrence_count': ?instance.recurrenceCount,
      'import_hash_v2': ?instance.importHashV2,
      'sepa_cc': ?instance.sepaCc,
      'sepa_ct_op': ?instance.sepaCtOp,
      'sepa_ct_id': ?instance.sepaCtId,
      'sepa_db': ?instance.sepaDb,
      'sepa_country': ?instance.sepaCountry,
      'sepa_ep': ?instance.sepaEp,
      'sepa_ci': ?instance.sepaCi,
      'sepa_batch_id': ?instance.sepaBatchId,
      'interest_date': ?instance.interestDate?.toIso8601String(),
      'book_date': ?instance.bookDate?.toIso8601String(),
      'process_date': ?instance.processDate?.toIso8601String(),
      'due_date': ?instance.dueDate?.toIso8601String(),
      'payment_date': ?instance.paymentDate?.toIso8601String(),
      'invoice_date': ?instance.invoiceDate?.toIso8601String(),
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'zoom_level': ?instance.zoomLevel,
      'has_attachments': ?instance.hasAttachments,
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
  TransactionSplitStore instance,
) => <String, dynamic>{
  'type': ?transactionTypePropertyToJson(instance.type),
  'date': instance.date.toIso8601String(),
  'amount': instance.amount,
  'description': instance.description,
  'order': ?instance.order,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'foreign_amount': ?instance.foreignAmount,
  'foreign_currency_id': ?instance.foreignCurrencyId,
  'foreign_currency_code': ?instance.foreignCurrencyCode,
  'budget_id': ?instance.budgetId,
  'budget_name': ?instance.budgetName,
  'category_id': ?instance.categoryId,
  'category_name': ?instance.categoryName,
  'source_id': ?instance.sourceId,
  'source_name': ?instance.sourceName,
  'destination_id': ?instance.destinationId,
  'destination_name': ?instance.destinationName,
  'reconciled': ?instance.reconciled,
  'piggy_bank_id': ?instance.piggyBankId,
  'piggy_bank_name': ?instance.piggyBankName,
  'bill_id': ?instance.billId,
  'bill_name': ?instance.billName,
  'tags': ?instance.tags,
  'notes': ?instance.notes,
  'internal_reference': ?instance.internalReference,
  'external_id': ?instance.externalId,
  'external_url': ?instance.externalUrl,
  'sepa_cc': ?instance.sepaCc,
  'sepa_ct_op': ?instance.sepaCtOp,
  'sepa_ct_id': ?instance.sepaCtId,
  'sepa_db': ?instance.sepaDb,
  'sepa_country': ?instance.sepaCountry,
  'sepa_ep': ?instance.sepaEp,
  'sepa_ci': ?instance.sepaCi,
  'sepa_batch_id': ?instance.sepaBatchId,
  'interest_date': ?instance.interestDate?.toIso8601String(),
  'book_date': ?instance.bookDate?.toIso8601String(),
  'process_date': ?instance.processDate?.toIso8601String(),
  'due_date': ?instance.dueDate?.toIso8601String(),
  'payment_date': ?instance.paymentDate?.toIso8601String(),
  'invoice_date': ?instance.invoiceDate?.toIso8601String(),
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
  TransactionSplitUpdate instance,
) => <String, dynamic>{
  'transaction_journal_id': ?instance.transactionJournalId,
  'type': ?transactionTypePropertyNullableToJson(instance.type),
  'date': ?instance.date?.toIso8601String(),
  'amount': ?instance.amount,
  'description': ?instance.description,
  'order': ?instance.order,
  'currency_id': ?instance.currencyId,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_name': ?instance.currencyName,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'foreign_amount': ?instance.foreignAmount,
  'foreign_currency_id': ?instance.foreignCurrencyId,
  'foreign_currency_code': ?instance.foreignCurrencyCode,
  'foreign_currency_symbol': ?instance.foreignCurrencySymbol,
  'foreign_currency_decimal_places': ?instance.foreignCurrencyDecimalPlaces,
  'budget_id': ?instance.budgetId,
  'budget_name': ?instance.budgetName,
  'category_id': ?instance.categoryId,
  'category_name': ?instance.categoryName,
  'source_id': ?instance.sourceId,
  'source_name': ?instance.sourceName,
  'source_iban': ?instance.sourceIban,
  'destination_id': ?instance.destinationId,
  'destination_name': ?instance.destinationName,
  'destination_iban': ?instance.destinationIban,
  'reconciled': ?instance.reconciled,
  'bill_id': ?instance.billId,
  'bill_name': ?instance.billName,
  'tags': ?instance.tags,
  'notes': ?instance.notes,
  'internal_reference': ?instance.internalReference,
  'external_id': ?instance.externalId,
  'external_url': ?instance.externalUrl,
  'sepa_cc': ?instance.sepaCc,
  'sepa_ct_op': ?instance.sepaCtOp,
  'sepa_ct_id': ?instance.sepaCtId,
  'sepa_db': ?instance.sepaDb,
  'sepa_country': ?instance.sepaCountry,
  'sepa_ep': ?instance.sepaEp,
  'sepa_ci': ?instance.sepaCi,
  'sepa_batch_id': ?instance.sepaBatchId,
  'interest_date': ?instance.interestDate?.toIso8601String(),
  'book_date': ?instance.bookDate?.toIso8601String(),
  'process_date': ?instance.processDate?.toIso8601String(),
  'due_date': ?instance.dueDate?.toIso8601String(),
  'payment_date': ?instance.paymentDate?.toIso8601String(),
  'invoice_date': ?instance.invoiceDate?.toIso8601String(),
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  email: json['email'] as String,
  blocked: json['blocked'] as bool?,
  blockedCode: userBlockedCodePropertyNullableFromJson(json['blocked_code']),
  role: userRolePropertyNullableFromJson(json['role']),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'email': instance.email,
  'blocked': ?instance.blocked,
  'blocked_code': ?userBlockedCodePropertyNullableToJson(instance.blockedCode),
  'role': ?userRolePropertyNullableToJson(instance.role),
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
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
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
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'in_use': ?instance.inUse,
  'can_see_members': ?instance.canSeeMembers,
  'title': ?instance.title,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'members': ?instance.members?.map((e) => e.toJson()).toList(),
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
  'user_id': ?instance.userId,
  'user_email': ?instance.userEmail,
  'you': ?instance.you,
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
      'primary_currency_id': ?instance.primaryCurrencyId,
      'primary_currency_code': ?instance.primaryCurrencyCode,
    };

WebhookProperties _$WebhookPropertiesFromJson(Map<String, dynamic> json) =>
    WebhookProperties(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool?,
      title: json['title'] as String,
      secret: json['secret'] as String?,
      triggers: (json['triggers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveries: (json['deliveries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$WebhookPropertiesToJson(WebhookProperties instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'active': ?instance.active,
      'title': instance.title,
      'secret': ?instance.secret,
      'triggers': ?instance.triggers,
      'responses': ?instance.responses,
      'deliveries': ?instance.deliveries,
      'url': instance.url,
    };

WebhookStore _$WebhookStoreFromJson(Map<String, dynamic> json) => WebhookStore(
  active: json['active'] as bool?,
  title: json['title'] as String,
  triggers: (json['triggers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  responses: (json['responses'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  deliveries: (json['deliveries'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  url: json['url'] as String,
);

Map<String, dynamic> _$WebhookStoreToJson(WebhookStore instance) =>
    <String, dynamic>{
      'active': ?instance.active,
      'title': instance.title,
      'triggers': ?instance.triggers,
      'responses': ?instance.responses,
      'deliveries': ?instance.deliveries,
      'url': instance.url,
    };

WebhookUpdate _$WebhookUpdateFromJson(Map<String, dynamic> json) =>
    WebhookUpdate(
      active: json['active'] as bool?,
      title: json['title'] as String?,
      secret: json['secret'] as String?,
      triggers: (json['triggers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveries: (json['deliveries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$WebhookUpdateToJson(WebhookUpdate instance) =>
    <String, dynamic>{
      'active': ?instance.active,
      'title': ?instance.title,
      'secret': ?instance.secret,
      'triggers': ?instance.triggers,
      'responses': ?instance.responses,
      'deliveries': ?instance.deliveries,
      'url': ?instance.url,
    };

WebhookAttempt _$WebhookAttemptFromJson(Map<String, dynamic> json) =>
    WebhookAttempt(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      webhookMessageId: json['webhook_message_id'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      logs: json['logs'] as String?,
      response: json['response'] as String?,
    );

Map<String, dynamic> _$WebhookAttemptToJson(WebhookAttempt instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'webhook_message_id': ?instance.webhookMessageId,
      'status_code': ?instance.statusCode,
      'logs': ?instance.logs,
      'response': ?instance.response,
    };

WebhookMessage _$WebhookMessageFromJson(Map<String, dynamic> json) =>
    WebhookMessage(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
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
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'sent': ?instance.sent,
      'errored': ?instance.errored,
      'webhook_id': ?instance.webhookId,
      'uuid': ?instance.uuid,
      'message': ?instance.message,
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
      'key': ?instance.key,
      'title': ?instance.title,
      'monetary_value': ?instance.monetaryValue,
      'currency_id': ?instance.currencyId,
      'currency_code': ?instance.currencyCode,
      'currency_symbol': ?instance.currencySymbol,
      'currency_decimal_places': ?instance.currencyDecimalPlaces,
      'no_available_budgets': ?instance.noAvailableBudgets,
      'value_parsed': ?instance.valueParsed,
      'local_icon': ?instance.localIcon,
      'sub_title': ?instance.subTitle,
    };

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      title: configValueFilterFromJson(json['title']),
      value: PolymorphicProperty.fromJson(
        json['value'] as Map<String, dynamic>,
      ),
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'title': ?configValueFilterToJson(instance.title),
      'value': instance.value.toJson(),
      'editable': instance.editable,
    };

ConfigurationUpdate _$ConfigurationUpdateFromJson(Map<String, dynamic> json) =>
    ConfigurationUpdate(
      value: PolymorphicProperty.fromJson(
        json['value'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConfigurationUpdateToJson(
  ConfigurationUpdate instance,
) => <String, dynamic>{'value': instance.value.toJson()};

CronResult _$CronResultFromJson(Map<String, dynamic> json) => CronResult(
  recurringTransactions: json['recurring_transactions'] == null
      ? null
      : CronResultRow.fromJson(
          json['recurring_transactions'] as Map<String, dynamic>,
        ),
  autoBudgets: json['auto_budgets'] == null
      ? null
      : CronResultRow.fromJson(json['auto_budgets'] as Map<String, dynamic>),
  telemetry: json['telemetry'] == null
      ? null
      : CronResultRow.fromJson(json['telemetry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CronResultToJson(CronResult instance) =>
    <String, dynamic>{
      'recurring_transactions': ?instance.recurringTransactions?.toJson(),
      'auto_budgets': ?instance.autoBudgets?.toJson(),
      'telemetry': ?instance.telemetry?.toJson(),
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
      'job_fired': ?instance.jobFired,
      'job_succeeded': ?instance.jobSucceeded,
      'job_errored': ?instance.jobErrored,
      'message': ?instance.message,
    };

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
  data: json['data'] == null
      ? null
      : SystemInfo$Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{'data': ?instance.data?.toJson()};

UserSingle _$UserSingleFromJson(Map<String, dynamic> json) =>
    UserSingle(data: UserRead.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$UserSingleToJson(UserSingle instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  pagination: json['pagination'] == null
      ? null
      : Meta$Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'pagination': ?instance.pagination?.toJson(),
};

BadRequestResponse _$BadRequestResponseFromJson(Map<String, dynamic> json) =>
    BadRequestResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$BadRequestResponseToJson(BadRequestResponse instance) =>
    <String, dynamic>{
      'message': ?instance.message,
      'exception': ?instance.exception,
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
  'message': ?instance.message,
  'exception': ?instance.exception,
};

NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    NotFoundResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$NotFoundResponseToJson(NotFoundResponse instance) =>
    <String, dynamic>{
      'message': ?instance.message,
      'exception': ?instance.exception,
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
  'message': ?instance.message,
  'exception': ?instance.exception,
};

ValidationErrorResponse _$ValidationErrorResponseFromJson(
  Map<String, dynamic> json,
) => ValidationErrorResponse(
  message: json['message'] as String?,
  errors: json['errors'] == null
      ? null
      : ValidationErrorResponse$Errors.fromJson(
          json['errors'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ValidationErrorResponseToJson(
  ValidationErrorResponse instance,
) => <String, dynamic>{
  'message': ?instance.message,
  'errors': ?instance.errors?.toJson(),
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
  'transaction_group_id': ?instance.transactionGroupId,
  'transaction_journal_id': ?instance.transactionJournalId,
  'date': ?instance.date?.toIso8601String(),
  'subscription_id': ?instance.subscriptionId,
  'currency_id': ?instance.currencyId,
  'currency_name': ?instance.currencyName,
  'currency_code': ?instance.currencyCode,
  'currency_symbol': ?instance.currencySymbol,
  'currency_decimal_places': ?instance.currencyDecimalPlaces,
  'primary_currency_id': ?instance.primaryCurrencyId,
  'primary_currency_name': ?instance.primaryCurrencyName,
  'primary_currency_code': ?instance.primaryCurrencyCode,
  'primary_currency_symbol': ?instance.primaryCurrencySymbol,
  'primary_currency_decimal_places': ?instance.primaryCurrencyDecimalPlaces,
  'amount': ?instance.amount,
  'pc_amount': ?instance.pcAmount,
  'foreign_amount': ?instance.foreignAmount,
  'pc_foreign_amount': ?instance.pcForeignAmount,
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
      'version': ?instance.version,
      'api_version': ?instance.apiVersion,
      'php_version': ?instance.phpVersion,
      'os': ?instance.os,
      'driver': ?instance.driver,
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
      'total': ?instance.total,
      'count': ?instance.count,
      'per_page': ?instance.perPage,
      'current_page': ?instance.currentPage,
      'total_pages': ?instance.totalPages,
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
  'email': ?instance.email,
  'force': ?instance.force,
  'blocked': ?instance.blocked,
  'field': ?instance.field,
  'role': ?instance.role,
  'blocked_code': ?instance.blockedCode,
  'name': ?instance.name,
  'type': ?instance.type,
  'iban': ?instance.iban,
  'start': ?instance.start,
  'end': ?instance.end,
  'date': ?instance.date,
};
