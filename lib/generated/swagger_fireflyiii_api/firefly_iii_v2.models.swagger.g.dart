// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii_v2.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSum _$TransactionSumFromJson(Map<String, dynamic> json) =>
    TransactionSum(
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyName: json['native_currency_name'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      sum: json['sum'] as String?,
      nativeSum: json['native_sum'] as String?,
    );

Map<String, dynamic> _$TransactionSumToJson(TransactionSum instance) =>
    <String, dynamic>{
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyName case final value?) 'currency_name': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyName case final value?)
        'native_currency_name': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      if (instance.sum case final value?) 'sum': value,
      if (instance.nativeSum case final value?) 'native_sum': value,
    };

AutocompleteAccountV2 _$AutocompleteAccountV2FromJson(
        Map<String, dynamic> json) =>
    AutocompleteAccountV2(
      id: json['id'] as String,
      name: json['name'] as String,
      nameWithBalance: json['name_with_balance'] as String,
      type: json['type'] as String,
      currencyId: json['currency_id'] as String,
      currencyName: json['currency_name'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num).toInt(),
    );

Map<String, dynamic> _$AutocompleteAccountV2ToJson(
        AutocompleteAccountV2 instance) =>
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

AutocompleteTD _$AutocompleteTDFromJson(Map<String, dynamic> json) =>
    AutocompleteTD(
      id: json['id'] as String,
      transactionJournalId: json['transaction_journal_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AutocompleteTDToJson(AutocompleteTD instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.transactionJournalId case final value?)
        'transaction_journal_id': value,
      'name': instance.name,
      'description': instance.description,
    };

ObjectLinkV2 _$ObjectLinkV2FromJson(Map<String, dynamic> json) =>
    ObjectLinkV2();

Map<String, dynamic> _$ObjectLinkV2ToJson(ObjectLinkV2 instance) =>
    <String, dynamic>{};

PageLinkV2 _$PageLinkV2FromJson(Map<String, dynamic> json) => PageLinkV2(
      self: json['self'] as String?,
      first: json['first'] as String?,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$PageLinkV2ToJson(PageLinkV2 instance) =>
    <String, dynamic>{
      if (instance.self case final value?) 'self': value,
      if (instance.first case final value?) 'first': value,
      if (instance.next case final value?) 'next': value,
      if (instance.prev case final value?) 'prev': value,
      if (instance.last case final value?) 'last': value,
    };

AccountV2 _$AccountV2FromJson(Map<String, dynamic> json) => AccountV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      active: json['active'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt(),
      name: json['name'] as String,
      iban: json['iban'] as String?,
      type: shortAccountTypePropertyFromJson(json['type']),
      accountRole: accountRolePropertyNullableFromJson(json['account_role']),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      currentBalance: json['current_balance'] as String?,
      nativeCurrentBalance: json['native_current_balance'] as String?,
      currentBalanceDate: json['current_balance_date'] == null
          ? null
          : DateTime.parse(json['current_balance_date'] as String),
    );

Map<String, dynamic> _$AccountV2ToJson(AccountV2 instance) => <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.active case final value?) 'active': value,
      if (instance.order case final value?) 'order': value,
      'name': instance.name,
      if (instance.iban case final value?) 'iban': value,
      if (shortAccountTypePropertyToJson(instance.type) case final value?)
        'type': value,
      if (accountRolePropertyNullableToJson(instance.accountRole)
          case final value?)
        'account_role': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      if (instance.currentBalance case final value?) 'current_balance': value,
      if (instance.nativeCurrentBalance case final value?)
        'native_current_balance': value,
      if (instance.currentBalanceDate?.toIso8601String() case final value?)
        'current_balance_date': value,
    };

AccountV2Read _$AccountV2ReadFromJson(Map<String, dynamic> json) =>
    AccountV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          AccountV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountV2ReadToJson(AccountV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

AccountV2Single _$AccountV2SingleFromJson(Map<String, dynamic> json) =>
    AccountV2Single(
      data: AccountV2Read.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountV2SingleToJson(AccountV2Single instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

BudgetLimitV2 _$BudgetLimitV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyName: json['currency_name'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      budgetId: json['budget_id'] as String?,
      period: json['period'] as String?,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$BudgetLimitV2ToJson(BudgetLimitV2 instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencyName case final value?) 'currency_name': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.budgetId case final value?) 'budget_id': value,
      if (instance.period case final value?) 'period': value,
      'amount': instance.amount,
    };

BudgetLimitV2Array _$BudgetLimitV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetLimitV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => BudgetLimitReadV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitV2ArrayToJson(BudgetLimitV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetLimitReadV2 _$BudgetLimitReadV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitReadV2(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          BudgetLimitV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitReadV2ToJson(BudgetLimitReadV2 instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

BudgetV2 _$BudgetV2FromJson(Map<String, dynamic> json) => BudgetV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      active: json['active'] as bool?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BudgetV2ToJson(BudgetV2 instance) => <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'name': instance.name,
      if (instance.active case final value?) 'active': value,
      if (instance.order case final value?) 'order': value,
    };

BudgetV2Array _$BudgetV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BudgetV2Read.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ArrayToJson(BudgetV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetV2Read _$BudgetV2ReadFromJson(Map<String, dynamic> json) => BudgetV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: BudgetV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ReadToJson(BudgetV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ChartDataPointV2 _$ChartDataPointV2FromJson(Map<String, dynamic> json) =>
    ChartDataPointV2(
      key: json['key'] as String?,
    );

Map<String, dynamic> _$ChartDataPointV2ToJson(ChartDataPointV2 instance) =>
    <String, dynamic>{
      if (instance.key case final value?) 'key': value,
    };

ChartDataSetV2 _$ChartDataSetV2FromJson(Map<String, dynamic> json) =>
    ChartDataSetV2(
      label: json['label'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      period: chartV2PeriodPropertyNullableFromJson(json['period']),
      entries: json['entries'],
      nativeEntries: json['native_entries'],
    );

Map<String, dynamic> _$ChartDataSetV2ToJson(ChartDataSetV2 instance) =>
    <String, dynamic>{
      if (instance.label case final value?) 'label': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      if (instance.start?.toIso8601String() case final value?) 'start': value,
      if (instance.end?.toIso8601String() case final value?) 'end': value,
      if (chartV2PeriodPropertyNullableToJson(instance.period)
          case final value?)
        'period': value,
      if (instance.entries case final value?) 'entries': value,
      if (instance.nativeEntries case final value?) 'native_entries': value,
    };

CurrencyV2 _$CurrencyV2FromJson(Map<String, dynamic> json) => CurrencyV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      enabled: json['enabled'] as bool? ?? true,
      $default: json['default'] as bool?,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyV2ToJson(CurrencyV2 instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.$default case final value?) 'default': value,
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      if (instance.decimalPlaces case final value?) 'decimal_places': value,
    };

CurrencyV2Array _$CurrencyV2ArrayFromJson(Map<String, dynamic> json) =>
    CurrencyV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CurrencyV2Read.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyV2ArrayToJson(CurrencyV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

CurrencyV2Read _$CurrencyV2ReadFromJson(Map<String, dynamic> json) =>
    CurrencyV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          CurrencyV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyV2ReadToJson(CurrencyV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

PiggyBankV2 _$PiggyBankV2FromJson(Map<String, dynamic> json) => PiggyBankV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      accountId: json['account_id'] as String,
      accountName: json['account_name'] as String?,
      name: json['name'] as String,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      currentAmount: json['current_amount'] as String?,
      nativeCurrentAmount: json['native_current_amount'] as String?,
      targetAmount: json['target_amount'] as String?,
      nativeTargetAmount: json['native_target_amount'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      leftToSave: json['left_to_save'] as String?,
      nativeLeftToSave: json['native_left_to_save'] as String?,
      savePerMonth: json['save_per_month'] as String?,
      nativeSavePerMonth: json['native_save_per_month'] as String?,
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
    );

Map<String, dynamic> _$PiggyBankV2ToJson(PiggyBankV2 instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'account_id': instance.accountId,
      if (instance.accountName case final value?) 'account_name': value,
      'name': instance.name,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      if (instance.currentAmount case final value?) 'current_amount': value,
      if (instance.nativeCurrentAmount case final value?)
        'native_current_amount': value,
      if (instance.targetAmount case final value?) 'target_amount': value,
      if (instance.nativeTargetAmount case final value?)
        'native_target_amount': value,
      if (instance.percentage case final value?) 'percentage': value,
      if (instance.leftToSave case final value?) 'left_to_save': value,
      if (instance.nativeLeftToSave case final value?)
        'native_left_to_save': value,
      if (instance.savePerMonth case final value?) 'save_per_month': value,
      if (instance.nativeSavePerMonth case final value?)
        'native_save_per_month': value,
      if (_dateToJson(instance.startDate) case final value?)
        'start_date': value,
      if (_dateToJson(instance.targetDate) case final value?)
        'target_date': value,
      if (instance.order case final value?) 'order': value,
      if (instance.active case final value?) 'active': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.objectGroupId case final value?) 'object_group_id': value,
      if (instance.objectGroupOrder case final value?)
        'object_group_order': value,
      if (instance.objectGroupTitle case final value?)
        'object_group_title': value,
    };

PiggyBankV2Array _$PiggyBankV2ArrayFromJson(Map<String, dynamic> json) =>
    PiggyBankV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PiggyBankV2Read.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankV2ArrayToJson(PiggyBankV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

PiggyBankV2Read _$PiggyBankV2ReadFromJson(Map<String, dynamic> json) =>
    PiggyBankV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          PiggyBankV2.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PiggyBankV2ReadToJson(PiggyBankV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
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
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'name': instance.name,
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

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      amountMin: json['amount_min'] as String,
      amountMax: json['amount_max'] as String,
      nativeAmountMin: json['native_amount_min'] as String?,
      nativeAmountMax: json['native_amount_max'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      extensionDate: json['extension_date'] == null
          ? null
          : DateTime.parse(json['extension_date'] as String),
      repeatFreq: subscriptionRepeatPropertyFromJson(json['repeat_freq']),
      skip: (json['skip'] as num?)?.toInt(),
      active: json['active'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      objectGroupId: json['object_group_id'] as String?,
      objectGroupOrder: (json['object_group_order'] as num?)?.toInt(),
      objectGroupTitle: json['object_group_title'] as String?,
      nextExpectedMatch: json['next_expected_match'] == null
          ? null
          : DateTime.parse(json['next_expected_match'] as String),
      nextExpectedMatchDiff: json['next_expected_match_diff'] as String?,
      payDates: (json['pay_dates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          [],
      paidDates: (json['paid_dates'] as List<dynamic>?)
          ?.map((e) =>
              Subscription$PaidDates$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      'name': instance.name,
      'amount_min': instance.amountMin,
      'amount_max': instance.amountMax,
      if (instance.nativeAmountMin case final value?)
        'native_amount_min': value,
      if (instance.nativeAmountMax case final value?)
        'native_amount_max': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      'date': instance.date.toIso8601String(),
      if (instance.endDate?.toIso8601String() case final value?)
        'end_date': value,
      if (instance.extensionDate?.toIso8601String() case final value?)
        'extension_date': value,
      if (subscriptionRepeatPropertyToJson(instance.repeatFreq)
          case final value?)
        'repeat_freq': value,
      if (instance.skip case final value?) 'skip': value,
      if (instance.active case final value?) 'active': value,
      if (instance.order case final value?) 'order': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.objectGroupId case final value?) 'object_group_id': value,
      if (instance.objectGroupOrder case final value?)
        'object_group_order': value,
      if (instance.objectGroupTitle case final value?)
        'object_group_title': value,
      if (instance.nextExpectedMatch?.toIso8601String() case final value?)
        'next_expected_match': value,
      if (instance.nextExpectedMatchDiff case final value?)
        'next_expected_match_diff': value,
      if (instance.payDates?.map((e) => e.toIso8601String()).toList()
          case final value?)
        'pay_dates': value,
      if (instance.paidDates?.map((e) => e.toJson()).toList() case final value?)
        'paid_dates': value,
    };

SubscriptionArray _$SubscriptionArrayFromJson(Map<String, dynamic> json) =>
    SubscriptionArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SubscriptionRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionArrayToJson(SubscriptionArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

SubscriptionRead _$SubscriptionReadFromJson(Map<String, dynamic> json) =>
    SubscriptionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Subscription.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionReadToJson(SubscriptionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

SubscriptionSingle _$SubscriptionSingleFromJson(Map<String, dynamic> json) =>
    SubscriptionSingle(
      data: SubscriptionRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionSingleToJson(SubscriptionSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

TransactionV2 _$TransactionV2FromJson(Map<String, dynamic> json) =>
    TransactionV2(
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: json['user'] as String?,
      userGroup: json['user_group'] as String?,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map(
                  (e) => TransactionV2Split.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionV2ToJson(TransactionV2 instance) =>
    <String, dynamic>{
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.user case final value?) 'user': value,
      if (instance.userGroup case final value?) 'user_group': value,
      if (instance.groupTitle case final value?) 'group_title': value,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

TransactionV2Array _$TransactionV2ArrayFromJson(Map<String, dynamic> json) =>
    TransactionV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => TransactionV2Read.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionV2ArrayToJson(TransactionV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

TransactionV2Read _$TransactionV2ReadFromJson(Map<String, dynamic> json) =>
    TransactionV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          TransactionV2.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLinkV2.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionV2ReadToJson(TransactionV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

TransactionV2Single _$TransactionV2SingleFromJson(Map<String, dynamic> json) =>
    TransactionV2Single(
      data: TransactionV2Read.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionV2SingleToJson(
        TransactionV2Single instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

TransactionV2Split _$TransactionV2SplitFromJson(Map<String, dynamic> json) =>
    TransactionV2Split(
      user: json['user'] as String?,
      userGroup: json['user_group'] as String?,
      transactionJournalId: json['transaction_journal_id'] as String?,
      type: transactionTypePropertyFromJson(json['type']),
      date: DateTime.parse(json['date'] as String),
      order: (json['order'] as num?)?.toInt(),
      amount: json['amount'] as String,
      nativeAmount: json['native_amount'] as String?,
      foreignAmount: json['foreign_amount'] as String?,
      nativeForeignAmount: json['native_foreign_amount'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyName: json['currency_name'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyName: json['native_currency_name'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          (json['foreign_currency_decimal_places'] as num?)?.toInt(),
      description: json['description'] as String,
      sourceId: json['source_id'] as String?,
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      sourceType: accountTypePropertyNullableFromJson(json['source_type']),
      destinationId: json['destination_id'] as String?,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      destinationType:
          accountTypePropertyNullableFromJson(json['destination_type']),
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      reconciled: json['reconciled'] as bool?,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
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
    );

Map<String, dynamic> _$TransactionV2SplitToJson(TransactionV2Split instance) =>
    <String, dynamic>{
      if (instance.user case final value?) 'user': value,
      if (instance.userGroup case final value?) 'user_group': value,
      if (instance.transactionJournalId case final value?)
        'transaction_journal_id': value,
      if (transactionTypePropertyToJson(instance.type) case final value?)
        'type': value,
      'date': instance.date.toIso8601String(),
      if (instance.order case final value?) 'order': value,
      'amount': instance.amount,
      if (instance.nativeAmount case final value?) 'native_amount': value,
      if (instance.foreignAmount case final value?) 'foreign_amount': value,
      if (instance.nativeForeignAmount case final value?)
        'native_foreign_amount': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyName case final value?) 'currency_name': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyName case final value?)
        'native_currency_name': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
      if (instance.foreignCurrencyId case final value?)
        'foreign_currency_id': value,
      if (instance.foreignCurrencyCode case final value?)
        'foreign_currency_code': value,
      if (instance.foreignCurrencySymbol case final value?)
        'foreign_currency_symbol': value,
      if (instance.foreignCurrencyDecimalPlaces case final value?)
        'foreign_currency_decimal_places': value,
      'description': instance.description,
      if (instance.sourceId case final value?) 'source_id': value,
      if (instance.sourceName case final value?) 'source_name': value,
      if (instance.sourceIban case final value?) 'source_iban': value,
      if (accountTypePropertyNullableToJson(instance.sourceType)
          case final value?)
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
      if (instance.reconciled case final value?) 'reconciled': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.tags case final value?) 'tags': value,
      if (instance.internalReference case final value?)
        'internal_reference': value,
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
      if (instance.dueDate?.toIso8601String() case final value?)
        'due_date': value,
      if (instance.paymentDate?.toIso8601String() case final value?)
        'payment_date': value,
      if (instance.invoiceDate?.toIso8601String() case final value?)
        'invoice_date': value,
    };

TransactionV2SplitStore _$TransactionV2SplitStoreFromJson(
        Map<String, dynamic> json) =>
    TransactionV2SplitStore(
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

Map<String, dynamic> _$TransactionV2SplitStoreToJson(
        TransactionV2SplitStore instance) =>
    <String, dynamic>{
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
      if (instance.internalReference case final value?)
        'internal_reference': value,
      if (instance.externalId case final value?) 'external_id': value,
      if (instance.externalUrl case final value?) 'external_url': value,
      if (instance.bunqPaymentId case final value?) 'bunq_payment_id': value,
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
      if (instance.dueDate?.toIso8601String() case final value?)
        'due_date': value,
      if (instance.paymentDate?.toIso8601String() case final value?)
        'payment_date': value,
      if (instance.invoiceDate?.toIso8601String() case final value?)
        'invoice_date': value,
    };

TransactionV2Store _$TransactionV2StoreFromJson(Map<String, dynamic> json) =>
    TransactionV2Store(
      errorIfDuplicateHash: json['error_if_duplicate_hash'] as bool?,
      applyRules: json['apply_rules'] as bool?,
      fireWebhooks: json['fire_webhooks'] as bool? ?? true,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) =>
                  TransactionV2SplitStore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionV2StoreToJson(TransactionV2Store instance) =>
    <String, dynamic>{
      if (instance.errorIfDuplicateHash case final value?)
        'error_if_duplicate_hash': value,
      if (instance.applyRules case final value?) 'apply_rules': value,
      if (instance.fireWebhooks case final value?) 'fire_webhooks': value,
      if (instance.groupTitle case final value?) 'group_title': value,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };

NetWorthArray _$NetWorthArrayFromJson(Map<String, dynamic> json) =>
    NetWorthArray(
      currencyCode: json['currency_code'] == null
          ? null
          : NetWorthItem.fromJson(
              json['currency_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetWorthArrayToJson(NetWorthArray instance) =>
    <String, dynamic>{
      if (instance.currencyCode?.toJson() case final value?)
        'currency_code': value,
    };

NetWorthItem _$NetWorthItemFromJson(Map<String, dynamic> json) => NetWorthItem(
      balance: json['balance'] as String?,
      nativeBalance: json['native_balance'] as String?,
      currencyId: json['currency_id'] as String?,
      currencyName: json['currency_name'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
      nativeCurrencyId: json['native_currency_id'] as String?,
      nativeCurrencyName: json['native_currency_name'] as String?,
      nativeCurrencySymbol: json['native_currency_symbol'] as String?,
      nativeCurrencyCode: json['native_currency_code'] as String?,
      nativeCurrencyDecimalPlaces:
          (json['native_currency_decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NetWorthItemToJson(NetWorthItem instance) =>
    <String, dynamic>{
      if (instance.balance case final value?) 'balance': value,
      if (instance.nativeBalance case final value?) 'native_balance': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyName case final value?) 'currency_name': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
      if (instance.nativeCurrencyId case final value?)
        'native_currency_id': value,
      if (instance.nativeCurrencyName case final value?)
        'native_currency_name': value,
      if (instance.nativeCurrencySymbol case final value?)
        'native_currency_symbol': value,
      if (instance.nativeCurrencyCode case final value?)
        'native_currency_code': value,
      if (instance.nativeCurrencyDecimalPlaces case final value?)
        'native_currency_decimal_places': value,
    };

PolymorphicProperty _$PolymorphicPropertyFromJson(Map<String, dynamic> json) =>
    PolymorphicProperty();

Map<String, dynamic> _$PolymorphicPropertyToJson(
        PolymorphicProperty instance) =>
    <String, dynamic>{};

BasicSummaryV2 _$BasicSummaryV2FromJson(Map<String, dynamic> json) =>
    BasicSummaryV2();

Map<String, dynamic> _$BasicSummaryV2ToJson(BasicSummaryV2 instance) =>
    <String, dynamic>{};

BasicSummaryV2Entry _$BasicSummaryV2EntryFromJson(Map<String, dynamic> json) =>
    BasicSummaryV2Entry(
      key: json['key'] as String?,
      $value: (json['value'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      currencyDecimalPlaces: (json['currency_decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BasicSummaryV2EntryToJson(
        BasicSummaryV2Entry instance) =>
    <String, dynamic>{
      if (instance.key case final value?) 'key': value,
      if (instance.$value case final value?) 'value': value,
      if (instance.currencyId case final value?) 'currency_id': value,
      if (instance.currencyCode case final value?) 'currency_code': value,
      if (instance.currencySymbol case final value?) 'currency_symbol': value,
      if (instance.currencyDecimalPlaces case final value?)
        'currency_decimal_places': value,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination: json['pagination'] == null
          ? null
          : Meta$Pagination.fromJson(
              json['pagination'] as Map<String, dynamic>),
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
        Map<String, dynamic> json) =>
    InternalExceptionResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$InternalExceptionResponseToJson(
        InternalExceptionResponse instance) =>
    <String, dynamic>{
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
        Map<String, dynamic> json) =>
    UnauthenticatedResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$UnauthenticatedResponseToJson(
        UnauthenticatedResponse instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.exception case final value?) 'exception': value,
    };

ValidationErrorResponse _$ValidationErrorResponseFromJson(
        Map<String, dynamic> json) =>
    ValidationErrorResponse(
      message: json['message'] as String?,
      errors: json['errors'] == null
          ? null
          : ValidationErrorResponse$Errors.fromJson(
              json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidationErrorResponseToJson(
        ValidationErrorResponse instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.errors?.toJson() case final value?) 'errors': value,
    };

Subscription$PaidDates$Item _$Subscription$PaidDates$ItemFromJson(
        Map<String, dynamic> json) =>
    Subscription$PaidDates$Item(
      transactionGroupId: json['transaction_group_id'] as String?,
      transactionJournalId: json['transaction_journal_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$Subscription$PaidDates$ItemToJson(
        Subscription$PaidDates$Item instance) =>
    <String, dynamic>{
      if (instance.transactionGroupId case final value?)
        'transaction_group_id': value,
      if (instance.transactionJournalId case final value?)
        'transaction_journal_id': value,
      if (instance.date?.toIso8601String() case final value?) 'date': value,
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
        Map<String, dynamic> json) =>
    ValidationErrorResponse$Errors(
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

Map<String, dynamic> _$ValidationErrorResponse$ErrorsToJson(
        ValidationErrorResponse$Errors instance) =>
    <String, dynamic>{
      if (instance.email case final value?) 'email': value,
      if (instance.blocked case final value?) 'blocked': value,
      if (instance.role case final value?) 'role': value,
      if (instance.blockedCode case final value?) 'blocked_code': value,
      if (instance.name case final value?) 'name': value,
      if (instance.type case final value?) 'type': value,
      if (instance.iban case final value?) 'iban': value,
      if (instance.start case final value?) 'start': value,
      if (instance.end case final value?) 'end': value,
      if (instance.date case final value?) 'date': value,
    };
