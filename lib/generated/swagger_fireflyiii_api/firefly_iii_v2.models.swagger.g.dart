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

Map<String, dynamic> _$TransactionSumToJson(TransactionSum instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_name', instance.currencyName);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_name', instance.nativeCurrencyName);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  writeNotNull('sum', instance.sum);
  writeNotNull('native_sum', instance.nativeSum);
  return val;
}

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

Map<String, dynamic> _$AutocompleteTDToJson(AutocompleteTD instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction_journal_id', instance.transactionJournalId);
  val['name'] = instance.name;
  val['description'] = instance.description;
  return val;
}

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

Map<String, dynamic> _$PageLinkV2ToJson(PageLinkV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('self', instance.self);
  writeNotNull('first', instance.first);
  writeNotNull('next', instance.next);
  writeNotNull('prev', instance.prev);
  writeNotNull('last', instance.last);
  return val;
}

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

Map<String, dynamic> _$AccountV2ToJson(AccountV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('active', instance.active);
  writeNotNull('order', instance.order);
  val['name'] = instance.name;
  writeNotNull('iban', instance.iban);
  writeNotNull('type', shortAccountTypePropertyToJson(instance.type));
  writeNotNull(
      'account_role', accountRolePropertyNullableToJson(instance.accountRole));
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  writeNotNull('current_balance', instance.currentBalance);
  writeNotNull('native_current_balance', instance.nativeCurrentBalance);
  writeNotNull(
      'current_balance_date', instance.currentBalanceDate?.toIso8601String());
  return val;
}

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

Map<String, dynamic> _$BudgetLimitV2ToJson(BudgetLimitV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['start'] = instance.start.toIso8601String();
  val['end'] = instance.end.toIso8601String();
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_name', instance.currencyName);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('period', instance.period);
  val['amount'] = instance.amount;
  return val;
}

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

Map<String, dynamic> _$BudgetV2ToJson(BudgetV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['name'] = instance.name;
  writeNotNull('active', instance.active);
  writeNotNull('order', instance.order);
  return val;
}

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

Map<String, dynamic> _$ChartDataPointV2ToJson(ChartDataPointV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  return val;
}

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

Map<String, dynamic> _$ChartDataSetV2ToJson(ChartDataSetV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('label', instance.label);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  writeNotNull('start', instance.start?.toIso8601String());
  writeNotNull('end', instance.end?.toIso8601String());
  writeNotNull('period', chartV2PeriodPropertyNullableToJson(instance.period));
  writeNotNull('entries', instance.entries);
  writeNotNull('native_entries', instance.nativeEntries);
  return val;
}

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

Map<String, dynamic> _$CurrencyV2ToJson(CurrencyV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('enabled', instance.enabled);
  writeNotNull('default', instance.$default);
  val['code'] = instance.code;
  val['name'] = instance.name;
  val['symbol'] = instance.symbol;
  writeNotNull('decimal_places', instance.decimalPlaces);
  return val;
}

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

Map<String, dynamic> _$PiggyBankV2ToJson(PiggyBankV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['account_id'] = instance.accountId;
  writeNotNull('account_name', instance.accountName);
  val['name'] = instance.name;
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  writeNotNull('current_amount', instance.currentAmount);
  writeNotNull('native_current_amount', instance.nativeCurrentAmount);
  writeNotNull('target_amount', instance.targetAmount);
  writeNotNull('native_target_amount', instance.nativeTargetAmount);
  writeNotNull('percentage', instance.percentage);
  writeNotNull('left_to_save', instance.leftToSave);
  writeNotNull('native_left_to_save', instance.nativeLeftToSave);
  writeNotNull('save_per_month', instance.savePerMonth);
  writeNotNull('native_save_per_month', instance.nativeSavePerMonth);
  writeNotNull('start_date', _dateToJson(instance.startDate));
  writeNotNull('target_date', _dateToJson(instance.targetDate));
  writeNotNull('order', instance.order);
  writeNotNull('active', instance.active);
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_order', instance.objectGroupOrder);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  return val;
}

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

Map<String, dynamic> _$PreferenceToJson(Preference instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['name'] = instance.name;
  val['data'] = instance.data.toJson();
  return val;
}

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

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['name'] = instance.name;
  val['amount_min'] = instance.amountMin;
  val['amount_max'] = instance.amountMax;
  writeNotNull('native_amount_min', instance.nativeAmountMin);
  writeNotNull('native_amount_max', instance.nativeAmountMax);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  val['date'] = instance.date.toIso8601String();
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('extension_date', instance.extensionDate?.toIso8601String());
  writeNotNull(
      'repeat_freq', subscriptionRepeatPropertyToJson(instance.repeatFreq));
  writeNotNull('skip', instance.skip);
  writeNotNull('active', instance.active);
  writeNotNull('order', instance.order);
  writeNotNull('notes', instance.notes);
  writeNotNull('object_group_id', instance.objectGroupId);
  writeNotNull('object_group_order', instance.objectGroupOrder);
  writeNotNull('object_group_title', instance.objectGroupTitle);
  writeNotNull(
      'next_expected_match', instance.nextExpectedMatch?.toIso8601String());
  writeNotNull('next_expected_match_diff', instance.nextExpectedMatchDiff);
  writeNotNull(
      'pay_dates', instance.payDates?.map((e) => e.toIso8601String()).toList());
  writeNotNull(
      'paid_dates', instance.paidDates?.map((e) => e.toJson()).toList());
  return val;
}

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

Map<String, dynamic> _$TransactionV2ToJson(TransactionV2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('user', instance.user);
  writeNotNull('user_group', instance.userGroup);
  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

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

Map<String, dynamic> _$TransactionV2SplitToJson(TransactionV2Split instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user', instance.user);
  writeNotNull('user_group', instance.userGroup);
  writeNotNull('transaction_journal_id', instance.transactionJournalId);
  writeNotNull('type', transactionTypePropertyToJson(instance.type));
  val['date'] = instance.date.toIso8601String();
  writeNotNull('order', instance.order);
  val['amount'] = instance.amount;
  writeNotNull('native_amount', instance.nativeAmount);
  writeNotNull('foreign_amount', instance.foreignAmount);
  writeNotNull('native_foreign_amount', instance.nativeForeignAmount);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_name', instance.currencyName);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull('native_currency_name', instance.nativeCurrencyName);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('foreign_currency_symbol', instance.foreignCurrencySymbol);
  writeNotNull(
      'foreign_currency_decimal_places', instance.foreignCurrencyDecimalPlaces);
  val['description'] = instance.description;
  writeNotNull('source_id', instance.sourceId);
  writeNotNull('source_name', instance.sourceName);
  writeNotNull('source_iban', instance.sourceIban);
  writeNotNull(
      'source_type', accountTypePropertyNullableToJson(instance.sourceType));
  writeNotNull('destination_id', instance.destinationId);
  writeNotNull('destination_name', instance.destinationName);
  writeNotNull('destination_iban', instance.destinationIban);
  writeNotNull('destination_type',
      accountTypePropertyNullableToJson(instance.destinationType));
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('budget_name', instance.budgetName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  writeNotNull('reconciled', instance.reconciled);
  writeNotNull('notes', instance.notes);
  writeNotNull('tags', instance.tags);
  writeNotNull('internal_reference', instance.internalReference);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_url', instance.externalUrl);
  writeNotNull('original_source', instance.originalSource);
  writeNotNull('recurrence_id', instance.recurrenceId);
  writeNotNull('recurrence_total', instance.recurrenceTotal);
  writeNotNull('recurrence_count', instance.recurrenceCount);
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
  return val;
}

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
    TransactionV2SplitStore instance) {
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
  writeNotNull('reconciled', instance.reconciled);
  writeNotNull('piggy_bank_id', instance.piggyBankId);
  writeNotNull('piggy_bank_name', instance.piggyBankName);
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

Map<String, dynamic> _$TransactionV2StoreToJson(TransactionV2Store instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('error_if_duplicate_hash', instance.errorIfDuplicateHash);
  writeNotNull('apply_rules', instance.applyRules);
  writeNotNull('fire_webhooks', instance.fireWebhooks);
  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

NetWorthArray _$NetWorthArrayFromJson(Map<String, dynamic> json) =>
    NetWorthArray(
      currencyCode: json['currency_code'] == null
          ? null
          : NetWorthItem.fromJson(
              json['currency_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetWorthArrayToJson(NetWorthArray instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currency_code', instance.currencyCode?.toJson());
  return val;
}

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

Map<String, dynamic> _$NetWorthItemToJson(NetWorthItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('balance', instance.balance);
  writeNotNull('native_balance', instance.nativeBalance);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_name', instance.currencyName);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  writeNotNull('native_currency_id', instance.nativeCurrencyId);
  writeNotNull('native_currency_name', instance.nativeCurrencyName);
  writeNotNull('native_currency_symbol', instance.nativeCurrencySymbol);
  writeNotNull('native_currency_code', instance.nativeCurrencyCode);
  writeNotNull(
      'native_currency_decimal_places', instance.nativeCurrencyDecimalPlaces);
  return val;
}

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

Map<String, dynamic> _$BasicSummaryV2EntryToJson(BasicSummaryV2Entry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('value', instance.$value);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('currency_symbol', instance.currencySymbol);
  writeNotNull('currency_decimal_places', instance.currencyDecimalPlaces);
  return val;
}

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination: json['pagination'] == null
          ? null
          : Meta$Pagination.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}

BadRequestResponse _$BadRequestResponseFromJson(Map<String, dynamic> json) =>
    BadRequestResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$BadRequestResponseToJson(BadRequestResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('exception', instance.exception);
  return val;
}

InternalExceptionResponse _$InternalExceptionResponseFromJson(
        Map<String, dynamic> json) =>
    InternalExceptionResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$InternalExceptionResponseToJson(
    InternalExceptionResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('exception', instance.exception);
  return val;
}

NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    NotFoundResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$NotFoundResponseToJson(NotFoundResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('exception', instance.exception);
  return val;
}

UnauthenticatedResponse _$UnauthenticatedResponseFromJson(
        Map<String, dynamic> json) =>
    UnauthenticatedResponse(
      message: json['message'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$UnauthenticatedResponseToJson(
    UnauthenticatedResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('exception', instance.exception);
  return val;
}

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
    ValidationErrorResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('errors', instance.errors?.toJson());
  return val;
}

Subscription$PaidDates$Item _$Subscription$PaidDates$ItemFromJson(
        Map<String, dynamic> json) =>
    Subscription$PaidDates$Item(
      transactionGroupId: json['transaction_group_id'] as String?,
      transactionJournalId: json['transaction_journal_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$Subscription$PaidDates$ItemToJson(
    Subscription$PaidDates$Item instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction_group_id', instance.transactionGroupId);
  writeNotNull('transaction_journal_id', instance.transactionJournalId);
  writeNotNull('date', instance.date?.toIso8601String());
  return val;
}

Meta$Pagination _$Meta$PaginationFromJson(Map<String, dynamic> json) =>
    Meta$Pagination(
      total: (json['total'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Meta$PaginationToJson(Meta$Pagination instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total', instance.total);
  writeNotNull('count', instance.count);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('total_pages', instance.totalPages);
  return val;
}

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
    ValidationErrorResponse$Errors instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('blocked', instance.blocked);
  writeNotNull('role', instance.role);
  writeNotNull('blocked_code', instance.blockedCode);
  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  writeNotNull('iban', instance.iban);
  writeNotNull('start', instance.start);
  writeNotNull('end', instance.end);
  writeNotNull('date', instance.date);
  return val;
}
