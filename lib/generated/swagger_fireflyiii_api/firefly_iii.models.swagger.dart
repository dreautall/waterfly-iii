// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'firefly_iii.enums.swagger.dart' as enums;

part 'firefly_iii.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountArray {
  const AccountArray({required this.data, required this.meta});

  factory AccountArray.fromJson(Map<String, dynamic> json) =>
      _$AccountArrayFromJson(json);

  static const toJsonFactory = _$AccountArrayToJson;
  Map<String, dynamic> toJson() => _$AccountArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <AccountRead>[])
  final List<AccountRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$AccountArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountArrayExtension on AccountArray {
  AccountArray copyWith({List<AccountRead>? data, Meta? meta}) {
    return AccountArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  AccountArray copyWithWrapped({
    Wrapped<List<AccountRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return AccountArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentArray {
  const AttachmentArray({required this.data, required this.meta});

  factory AttachmentArray.fromJson(Map<String, dynamic> json) =>
      _$AttachmentArrayFromJson(json);

  static const toJsonFactory = _$AttachmentArrayToJson;
  Map<String, dynamic> toJson() => _$AttachmentArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <AttachmentRead>[])
  final List<AttachmentRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$AttachmentArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentArrayExtension on AttachmentArray {
  AttachmentArray copyWith({List<AttachmentRead>? data, Meta? meta}) {
    return AttachmentArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  AttachmentArray copyWithWrapped({
    Wrapped<List<AttachmentRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return AttachmentArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

typedef AutocompleteAccountArray = List<AutocompleteAccount>;
typedef AutocompleteBillArray = List<AutocompleteBill>;
typedef AutocompleteBudgetArray = List<AutocompleteBudget>;
typedef AutocompleteCategoryArray = List<AutocompleteCategory>;
typedef AutocompleteCurrencyArray = List<AutocompleteCurrency>;
typedef AutocompleteCurrencyCodeArray = List<AutocompleteCurrencyCode>;
typedef AutocompleteObjectGroupArray = List<AutocompleteObjectGroup>;
typedef AutocompletePiggyArray = List<AutocompletePiggy>;
typedef AutocompletePiggyBalanceArray = List<AutocompletePiggyBalance>;
typedef AutocompleteRecurrenceArray = List<AutocompleteRecurrence>;
typedef AutocompleteRuleArray = List<AutocompleteRule>;
typedef AutocompleteRuleGroupArray = List<AutocompleteRuleGroup>;
typedef AutocompleteTagArray = List<AutocompleteTag>;
typedef AutocompleteTransactionArray = List<AutocompleteTransaction>;
typedef AutocompleteTransactionIDArray = List<AutocompleteTransactionID>;
typedef AutocompleteTransactionTypeArray = List<AutocompleteTransactionType>;

@JsonSerializable(explicitToJson: true)
class AvailableBudgetArray {
  const AvailableBudgetArray({required this.data, required this.meta});

  factory AvailableBudgetArray.fromJson(Map<String, dynamic> json) =>
      _$AvailableBudgetArrayFromJson(json);

  static const toJsonFactory = _$AvailableBudgetArrayToJson;
  Map<String, dynamic> toJson() => _$AvailableBudgetArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <AvailableBudgetRead>[],
  )
  final List<AvailableBudgetRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$AvailableBudgetArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AvailableBudgetArrayExtension on AvailableBudgetArray {
  AvailableBudgetArray copyWith({List<AvailableBudgetRead>? data, Meta? meta}) {
    return AvailableBudgetArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  AvailableBudgetArray copyWithWrapped({
    Wrapped<List<AvailableBudgetRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return AvailableBudgetArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BillArray {
  const BillArray({required this.data, required this.meta});

  factory BillArray.fromJson(Map<String, dynamic> json) =>
      _$BillArrayFromJson(json);

  static const toJsonFactory = _$BillArrayToJson;
  Map<String, dynamic> toJson() => _$BillArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <BillRead>[])
  final List<BillRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$BillArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillArrayExtension on BillArray {
  BillArray copyWith({List<BillRead>? data, Meta? meta}) {
    return BillArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  BillArray copyWithWrapped({
    Wrapped<List<BillRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return BillArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetArray {
  const BudgetArray({required this.data, required this.meta});

  factory BudgetArray.fromJson(Map<String, dynamic> json) =>
      _$BudgetArrayFromJson(json);

  static const toJsonFactory = _$BudgetArrayToJson;
  Map<String, dynamic> toJson() => _$BudgetArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <BudgetRead>[])
  final List<BudgetRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$BudgetArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetArrayExtension on BudgetArray {
  BudgetArray copyWith({List<BudgetRead>? data, Meta? meta}) {
    return BudgetArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  BudgetArray copyWithWrapped({
    Wrapped<List<BudgetRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return BudgetArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitArray {
  const BudgetLimitArray({required this.data, required this.meta});

  factory BudgetLimitArray.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitArrayFromJson(json);

  static const toJsonFactory = _$BudgetLimitArrayToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <BudgetLimitRead>[],
  )
  final List<BudgetLimitRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$BudgetLimitArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitArrayExtension on BudgetLimitArray {
  BudgetLimitArray copyWith({List<BudgetLimitRead>? data, Meta? meta}) {
    return BudgetLimitArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  BudgetLimitArray copyWithWrapped({
    Wrapped<List<BudgetLimitRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return BudgetLimitArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryArray {
  const CategoryArray({required this.data, required this.meta});

  factory CategoryArray.fromJson(Map<String, dynamic> json) =>
      _$CategoryArrayFromJson(json);

  static const toJsonFactory = _$CategoryArrayToJson;
  Map<String, dynamic> toJson() => _$CategoryArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <CategoryRead>[])
  final List<CategoryRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$CategoryArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategoryArrayExtension on CategoryArray {
  CategoryArray copyWith({List<CategoryRead>? data, Meta? meta}) {
    return CategoryArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  CategoryArray copyWithWrapped({
    Wrapped<List<CategoryRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return CategoryArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

typedef ConfigurationArray = List<Configuration>;

@JsonSerializable(explicitToJson: true)
class CurrencyArray {
  const CurrencyArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory CurrencyArray.fromJson(Map<String, dynamic> json) =>
      _$CurrencyArrayFromJson(json);

  static const toJsonFactory = _$CurrencyArrayToJson;
  Map<String, dynamic> toJson() => _$CurrencyArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <CurrencyRead>[])
  final List<CurrencyRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$CurrencyArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyArrayExtension on CurrencyArray {
  CurrencyArray copyWith({
    List<CurrencyRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return CurrencyArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  CurrencyArray copyWithWrapped({
    Wrapped<List<CurrencyRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return CurrencyArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateArray {
  const CurrencyExchangeRateArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory CurrencyExchangeRateArray.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateArrayFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateArrayToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangeRateArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <CurrencyExchangeRateRead>[],
  )
  final List<CurrencyExchangeRateRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$CurrencyExchangeRateArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateArrayExtension on CurrencyExchangeRateArray {
  CurrencyExchangeRateArray copyWith({
    List<CurrencyExchangeRateRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return CurrencyExchangeRateArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  CurrencyExchangeRateArray copyWithWrapped({
    Wrapped<List<CurrencyExchangeRateRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return CurrencyExchangeRateArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LinkTypeArray {
  const LinkTypeArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory LinkTypeArray.fromJson(Map<String, dynamic> json) =>
      _$LinkTypeArrayFromJson(json);

  static const toJsonFactory = _$LinkTypeArrayToJson;
  Map<String, dynamic> toJson() => _$LinkTypeArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <LinkTypeRead>[])
  final List<LinkTypeRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$LinkTypeArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $LinkTypeArrayExtension on LinkTypeArray {
  LinkTypeArray copyWith({
    List<LinkTypeRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return LinkTypeArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  LinkTypeArray copyWithWrapped({
    Wrapped<List<LinkTypeRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return LinkTypeArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectGroupArray {
  const ObjectGroupArray({required this.data, required this.meta});

  factory ObjectGroupArray.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupArrayFromJson(json);

  static const toJsonFactory = _$ObjectGroupArrayToJson;
  Map<String, dynamic> toJson() => _$ObjectGroupArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <ObjectGroupRead>[],
  )
  final List<ObjectGroupRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$ObjectGroupArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectGroupArrayExtension on ObjectGroupArray {
  ObjectGroupArray copyWith({List<ObjectGroupRead>? data, Meta? meta}) {
    return ObjectGroupArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  ObjectGroupArray copyWithWrapped({
    Wrapped<List<ObjectGroupRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return ObjectGroupArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankArray {
  const PiggyBankArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PiggyBankArray.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankArrayFromJson(json);

  static const toJsonFactory = _$PiggyBankArrayToJson;
  Map<String, dynamic> toJson() => _$PiggyBankArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <PiggyBankRead>[])
  final List<PiggyBankRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$PiggyBankArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankArrayExtension on PiggyBankArray {
  PiggyBankArray copyWith({
    List<PiggyBankRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return PiggyBankArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  PiggyBankArray copyWithWrapped({
    Wrapped<List<PiggyBankRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return PiggyBankArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankEventArray {
  const PiggyBankEventArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PiggyBankEventArray.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankEventArrayFromJson(json);

  static const toJsonFactory = _$PiggyBankEventArrayToJson;
  Map<String, dynamic> toJson() => _$PiggyBankEventArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <PiggyBankEventRead>[],
  )
  final List<PiggyBankEventRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$PiggyBankEventArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankEventArrayExtension on PiggyBankEventArray {
  PiggyBankEventArray copyWith({
    List<PiggyBankEventRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return PiggyBankEventArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  PiggyBankEventArray copyWithWrapped({
    Wrapped<List<PiggyBankEventRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return PiggyBankEventArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PreferenceArray {
  const PreferenceArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PreferenceArray.fromJson(Map<String, dynamic> json) =>
      _$PreferenceArrayFromJson(json);

  static const toJsonFactory = _$PreferenceArrayToJson;
  Map<String, dynamic> toJson() => _$PreferenceArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <PreferenceRead>[])
  final List<PreferenceRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$PreferenceArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PreferenceArrayExtension on PreferenceArray {
  PreferenceArray copyWith({
    List<PreferenceRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return PreferenceArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  PreferenceArray copyWithWrapped({
    Wrapped<List<PreferenceRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return PreferenceArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceArray {
  const RecurrenceArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory RecurrenceArray.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceArrayFromJson(json);

  static const toJsonFactory = _$RecurrenceArrayToJson;
  Map<String, dynamic> toJson() => _$RecurrenceArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <RecurrenceRead>[])
  final List<RecurrenceRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$RecurrenceArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceArrayExtension on RecurrenceArray {
  RecurrenceArray copyWith({
    List<RecurrenceRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return RecurrenceArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  RecurrenceArray copyWithWrapped({
    Wrapped<List<RecurrenceRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return RecurrenceArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleArray {
  const RuleArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory RuleArray.fromJson(Map<String, dynamic> json) =>
      _$RuleArrayFromJson(json);

  static const toJsonFactory = _$RuleArrayToJson;
  Map<String, dynamic> toJson() => _$RuleArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <RuleRead>[])
  final List<RuleRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$RuleArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleArrayExtension on RuleArray {
  RuleArray copyWith({List<RuleRead>? data, Meta? meta, PageLink? links}) {
    return RuleArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  RuleArray copyWithWrapped({
    Wrapped<List<RuleRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return RuleArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroupArray {
  const RuleGroupArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory RuleGroupArray.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupArrayFromJson(json);

  static const toJsonFactory = _$RuleGroupArrayToJson;
  Map<String, dynamic> toJson() => _$RuleGroupArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <RuleGroupRead>[])
  final List<RuleGroupRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$RuleGroupArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupArrayExtension on RuleGroupArray {
  RuleGroupArray copyWith({
    List<RuleGroupRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return RuleGroupArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  RuleGroupArray copyWithWrapped({
    Wrapped<List<RuleGroupRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return RuleGroupArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TagArray {
  const TagArray({required this.data, required this.meta, required this.links});

  factory TagArray.fromJson(Map<String, dynamic> json) =>
      _$TagArrayFromJson(json);

  static const toJsonFactory = _$TagArrayToJson;
  Map<String, dynamic> toJson() => _$TagArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <TagRead>[])
  final List<TagRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$TagArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagArrayExtension on TagArray {
  TagArray copyWith({List<TagRead>? data, Meta? meta, PageLink? links}) {
    return TagArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  TagArray copyWithWrapped({
    Wrapped<List<TagRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return TagArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionArray {
  const TransactionArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory TransactionArray.fromJson(Map<String, dynamic> json) =>
      _$TransactionArrayFromJson(json);

  static const toJsonFactory = _$TransactionArrayToJson;
  Map<String, dynamic> toJson() => _$TransactionArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <TransactionRead>[],
  )
  final List<TransactionRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$TransactionArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionArrayExtension on TransactionArray {
  TransactionArray copyWith({
    List<TransactionRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return TransactionArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  TransactionArray copyWithWrapped({
    Wrapped<List<TransactionRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return TransactionArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLinkArray {
  const TransactionLinkArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory TransactionLinkArray.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkArrayFromJson(json);

  static const toJsonFactory = _$TransactionLinkArrayToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <TransactionLinkRead>[],
  )
  final List<TransactionLinkRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$TransactionLinkArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkArrayExtension on TransactionLinkArray {
  TransactionLinkArray copyWith({
    List<TransactionLinkRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return TransactionLinkArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  TransactionLinkArray copyWithWrapped({
    Wrapped<List<TransactionLinkRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return TransactionLinkArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserArray {
  const UserArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory UserArray.fromJson(Map<String, dynamic> json) =>
      _$UserArrayFromJson(json);

  static const toJsonFactory = _$UserArrayToJson;
  Map<String, dynamic> toJson() => _$UserArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <UserRead>[])
  final List<UserRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$UserArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserArrayExtension on UserArray {
  UserArray copyWith({List<UserRead>? data, Meta? meta, PageLink? links}) {
    return UserArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  UserArray copyWithWrapped({
    Wrapped<List<UserRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return UserArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupArray {
  const UserGroupArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory UserGroupArray.fromJson(Map<String, dynamic> json) =>
      _$UserGroupArrayFromJson(json);

  static const toJsonFactory = _$UserGroupArrayToJson;
  Map<String, dynamic> toJson() => _$UserGroupArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <UserGroupRead>[])
  final List<UserGroupRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$UserGroupArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupArrayExtension on UserGroupArray {
  UserGroupArray copyWith({
    List<UserGroupRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return UserGroupArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  UserGroupArray copyWithWrapped({
    Wrapped<List<UserGroupRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return UserGroupArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookArray {
  const WebhookArray({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory WebhookArray.fromJson(Map<String, dynamic> json) =>
      _$WebhookArrayFromJson(json);

  static const toJsonFactory = _$WebhookArrayToJson;
  Map<String, dynamic> toJson() => _$WebhookArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <WebhookRead>[])
  final List<WebhookRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLink links;
  static const fromJsonFactory = _$WebhookArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookArrayExtension on WebhookArray {
  WebhookArray copyWith({
    List<WebhookRead>? data,
    Meta? meta,
    PageLink? links,
  }) {
    return WebhookArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  WebhookArray copyWithWrapped({
    Wrapped<List<WebhookRead>>? data,
    Wrapped<Meta>? meta,
    Wrapped<PageLink>? links,
  }) {
    return WebhookArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookAttemptArray {
  const WebhookAttemptArray({required this.data, required this.meta});

  factory WebhookAttemptArray.fromJson(Map<String, dynamic> json) =>
      _$WebhookAttemptArrayFromJson(json);

  static const toJsonFactory = _$WebhookAttemptArrayToJson;
  Map<String, dynamic> toJson() => _$WebhookAttemptArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <WebhookAttemptRead>[],
  )
  final List<WebhookAttemptRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$WebhookAttemptArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookAttemptArrayExtension on WebhookAttemptArray {
  WebhookAttemptArray copyWith({List<WebhookAttemptRead>? data, Meta? meta}) {
    return WebhookAttemptArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  WebhookAttemptArray copyWithWrapped({
    Wrapped<List<WebhookAttemptRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return WebhookAttemptArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookMessageArray {
  const WebhookMessageArray({required this.data, required this.meta});

  factory WebhookMessageArray.fromJson(Map<String, dynamic> json) =>
      _$WebhookMessageArrayFromJson(json);

  static const toJsonFactory = _$WebhookMessageArrayToJson;
  Map<String, dynamic> toJson() => _$WebhookMessageArrayToJson(this);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
    defaultValue: <WebhookMessageRead>[],
  )
  final List<WebhookMessageRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$WebhookMessageArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookMessageArrayExtension on WebhookMessageArray {
  WebhookMessageArray copyWith({List<WebhookMessageRead>? data, Meta? meta}) {
    return WebhookMessageArray(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  WebhookMessageArray copyWithWrapped({
    Wrapped<List<WebhookMessageRead>>? data,
    Wrapped<Meta>? meta,
  }) {
    return WebhookMessageArray(
      data: (data != null ? data.value : this.data),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteAccount {
  const AutocompleteAccount({
    required this.id,
    required this.name,
    required this.nameWithBalance,
    this.active,
    required this.type,
    required this.currencyId,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    this.accountCurrencyId,
    this.accountCurrencyName,
    this.accountCurrencyCode,
    this.accountCurrencySymbol,
    this.accountCurrencyDecimalPlaces,
  });

  factory AutocompleteAccount.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteAccountFromJson(json);

  static const toJsonFactory = _$AutocompleteAccountToJson;
  Map<String, dynamic> toJson() => _$AutocompleteAccountToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'name_with_balance', includeIfNull: false)
  final String nameWithBalance;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int currencyDecimalPlaces;
  @JsonKey(name: 'account_currency_id', includeIfNull: false)
  final String? accountCurrencyId;
  @JsonKey(name: 'account_currency_name', includeIfNull: false)
  final String? accountCurrencyName;
  @JsonKey(name: 'account_currency_code', includeIfNull: false)
  final String? accountCurrencyCode;
  @JsonKey(name: 'account_currency_symbol', includeIfNull: false)
  final String? accountCurrencySymbol;
  @JsonKey(name: 'account_currency_decimal_places', includeIfNull: false)
  final int? accountCurrencyDecimalPlaces;
  static const fromJsonFactory = _$AutocompleteAccountFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteAccountExtension on AutocompleteAccount {
  AutocompleteAccount copyWith({
    String? id,
    String? name,
    String? nameWithBalance,
    bool? active,
    String? type,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? accountCurrencyId,
    String? accountCurrencyName,
    String? accountCurrencyCode,
    String? accountCurrencySymbol,
    int? accountCurrencyDecimalPlaces,
  }) {
    return AutocompleteAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      nameWithBalance: nameWithBalance ?? this.nameWithBalance,
      active: active ?? this.active,
      type: type ?? this.type,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      accountCurrencyId: accountCurrencyId ?? this.accountCurrencyId,
      accountCurrencyName: accountCurrencyName ?? this.accountCurrencyName,
      accountCurrencyCode: accountCurrencyCode ?? this.accountCurrencyCode,
      accountCurrencySymbol:
          accountCurrencySymbol ?? this.accountCurrencySymbol,
      accountCurrencyDecimalPlaces:
          accountCurrencyDecimalPlaces ?? this.accountCurrencyDecimalPlaces,
    );
  }

  AutocompleteAccount copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? nameWithBalance,
    Wrapped<bool?>? active,
    Wrapped<String>? type,
    Wrapped<String>? currencyId,
    Wrapped<String>? currencyName,
    Wrapped<String>? currencyCode,
    Wrapped<String>? currencySymbol,
    Wrapped<int>? currencyDecimalPlaces,
    Wrapped<String?>? accountCurrencyId,
    Wrapped<String?>? accountCurrencyName,
    Wrapped<String?>? accountCurrencyCode,
    Wrapped<String?>? accountCurrencySymbol,
    Wrapped<int?>? accountCurrencyDecimalPlaces,
  }) {
    return AutocompleteAccount(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      nameWithBalance:
          (nameWithBalance != null
              ? nameWithBalance.value
              : this.nameWithBalance),
      active: (active != null ? active.value : this.active),
      type: (type != null ? type.value : this.type),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      accountCurrencyId:
          (accountCurrencyId != null
              ? accountCurrencyId.value
              : this.accountCurrencyId),
      accountCurrencyName:
          (accountCurrencyName != null
              ? accountCurrencyName.value
              : this.accountCurrencyName),
      accountCurrencyCode:
          (accountCurrencyCode != null
              ? accountCurrencyCode.value
              : this.accountCurrencyCode),
      accountCurrencySymbol:
          (accountCurrencySymbol != null
              ? accountCurrencySymbol.value
              : this.accountCurrencySymbol),
      accountCurrencyDecimalPlaces:
          (accountCurrencyDecimalPlaces != null
              ? accountCurrencyDecimalPlaces.value
              : this.accountCurrencyDecimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteBill {
  const AutocompleteBill({required this.id, required this.name, this.active});

  factory AutocompleteBill.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteBillFromJson(json);

  static const toJsonFactory = _$AutocompleteBillToJson;
  Map<String, dynamic> toJson() => _$AutocompleteBillToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$AutocompleteBillFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteBillExtension on AutocompleteBill {
  AutocompleteBill copyWith({String? id, String? name, bool? active}) {
    return AutocompleteBill(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  AutocompleteBill copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<bool?>? active,
  }) {
    return AutocompleteBill(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteBudget {
  const AutocompleteBudget({required this.id, required this.name, this.active});

  factory AutocompleteBudget.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteBudgetFromJson(json);

  static const toJsonFactory = _$AutocompleteBudgetToJson;
  Map<String, dynamic> toJson() => _$AutocompleteBudgetToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$AutocompleteBudgetFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteBudgetExtension on AutocompleteBudget {
  AutocompleteBudget copyWith({String? id, String? name, bool? active}) {
    return AutocompleteBudget(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  AutocompleteBudget copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<bool?>? active,
  }) {
    return AutocompleteBudget(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteCategory {
  const AutocompleteCategory({required this.id, required this.name});

  factory AutocompleteCategory.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteCategoryFromJson(json);

  static const toJsonFactory = _$AutocompleteCategoryToJson;
  Map<String, dynamic> toJson() => _$AutocompleteCategoryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$AutocompleteCategoryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteCategoryExtension on AutocompleteCategory {
  AutocompleteCategory copyWith({String? id, String? name}) {
    return AutocompleteCategory(id: id ?? this.id, name: name ?? this.name);
  }

  AutocompleteCategory copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
  }) {
    return AutocompleteCategory(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteCurrency {
  const AutocompleteCurrency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });

  factory AutocompleteCurrency.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteCurrencyFromJson(json);

  static const toJsonFactory = _$AutocompleteCurrencyToJson;
  Map<String, dynamic> toJson() => _$AutocompleteCurrencyToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int decimalPlaces;
  static const fromJsonFactory = _$AutocompleteCurrencyFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteCurrencyExtension on AutocompleteCurrency {
  AutocompleteCurrency copyWith({
    String? id,
    String? name,
    String? code,
    String? symbol,
    int? decimalPlaces,
  }) {
    return AutocompleteCurrency(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    );
  }

  AutocompleteCurrency copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? code,
    Wrapped<String>? symbol,
    Wrapped<int>? decimalPlaces,
  }) {
    return AutocompleteCurrency(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      code: (code != null ? code.value : this.code),
      symbol: (symbol != null ? symbol.value : this.symbol),
      decimalPlaces:
          (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteCurrencyCode {
  const AutocompleteCurrencyCode({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });

  factory AutocompleteCurrencyCode.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteCurrencyCodeFromJson(json);

  static const toJsonFactory = _$AutocompleteCurrencyCodeToJson;
  Map<String, dynamic> toJson() => _$AutocompleteCurrencyCodeToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int decimalPlaces;
  static const fromJsonFactory = _$AutocompleteCurrencyCodeFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteCurrencyCodeExtension on AutocompleteCurrencyCode {
  AutocompleteCurrencyCode copyWith({
    String? id,
    String? name,
    String? code,
    String? symbol,
    int? decimalPlaces,
  }) {
    return AutocompleteCurrencyCode(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    );
  }

  AutocompleteCurrencyCode copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? code,
    Wrapped<String>? symbol,
    Wrapped<int>? decimalPlaces,
  }) {
    return AutocompleteCurrencyCode(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      code: (code != null ? code.value : this.code),
      symbol: (symbol != null ? symbol.value : this.symbol),
      decimalPlaces:
          (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteObjectGroup {
  const AutocompleteObjectGroup({
    required this.id,
    required this.title,
    required this.name,
  });

  factory AutocompleteObjectGroup.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteObjectGroupFromJson(json);

  static const toJsonFactory = _$AutocompleteObjectGroupToJson;
  Map<String, dynamic> toJson() => _$AutocompleteObjectGroupToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$AutocompleteObjectGroupFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteObjectGroupExtension on AutocompleteObjectGroup {
  AutocompleteObjectGroup copyWith({String? id, String? title, String? name}) {
    return AutocompleteObjectGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
    );
  }

  AutocompleteObjectGroup copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? title,
    Wrapped<String>? name,
  }) {
    return AutocompleteObjectGroup(
      id: (id != null ? id.value : this.id),
      title: (title != null ? title.value : this.title),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompletePiggy {
  const AutocompletePiggy({
    required this.id,
    required this.name,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.currencyDecimalPlaces,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory AutocompletePiggy.fromJson(Map<String, dynamic> json) =>
      _$AutocompletePiggyFromJson(json);

  static const toJsonFactory = _$AutocompletePiggyToJson;
  Map<String, dynamic> toJson() => _$AutocompletePiggyToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$AutocompletePiggyFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompletePiggyExtension on AutocompletePiggy {
  AutocompletePiggy copyWith({
    String? id,
    String? name,
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    int? currencyDecimalPlaces,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return AutocompletePiggy(
      id: id ?? this.id,
      name: name ?? this.name,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  AutocompletePiggy copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<String?>? currencyName,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return AutocompletePiggy(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompletePiggyBalance {
  const AutocompletePiggyBalance({
    required this.id,
    required this.name,
    this.nameWithBalance,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory AutocompletePiggyBalance.fromJson(Map<String, dynamic> json) =>
      _$AutocompletePiggyBalanceFromJson(json);

  static const toJsonFactory = _$AutocompletePiggyBalanceToJson;
  Map<String, dynamic> toJson() => _$AutocompletePiggyBalanceToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'name_with_balance', includeIfNull: false)
  final String? nameWithBalance;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$AutocompletePiggyBalanceFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompletePiggyBalanceExtension on AutocompletePiggyBalance {
  AutocompletePiggyBalance copyWith({
    String? id,
    String? name,
    String? nameWithBalance,
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return AutocompletePiggyBalance(
      id: id ?? this.id,
      name: name ?? this.name,
      nameWithBalance: nameWithBalance ?? this.nameWithBalance,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  AutocompletePiggyBalance copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? nameWithBalance,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return AutocompletePiggyBalance(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      nameWithBalance:
          (nameWithBalance != null
              ? nameWithBalance.value
              : this.nameWithBalance),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteRecurrence {
  const AutocompleteRecurrence({
    required this.id,
    required this.name,
    this.description,
    this.active,
  });

  factory AutocompleteRecurrence.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteRecurrenceFromJson(json);

  static const toJsonFactory = _$AutocompleteRecurrenceToJson;
  Map<String, dynamic> toJson() => _$AutocompleteRecurrenceToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$AutocompleteRecurrenceFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteRecurrenceExtension on AutocompleteRecurrence {
  AutocompleteRecurrence copyWith({
    String? id,
    String? name,
    String? description,
    bool? active,
  }) {
    return AutocompleteRecurrence(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
    );
  }

  AutocompleteRecurrence copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? active,
  }) {
    return AutocompleteRecurrence(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteRule {
  const AutocompleteRule({
    required this.id,
    required this.name,
    this.description,
    this.active,
  });

  factory AutocompleteRule.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteRuleFromJson(json);

  static const toJsonFactory = _$AutocompleteRuleToJson;
  Map<String, dynamic> toJson() => _$AutocompleteRuleToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$AutocompleteRuleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteRuleExtension on AutocompleteRule {
  AutocompleteRule copyWith({
    String? id,
    String? name,
    String? description,
    bool? active,
  }) {
    return AutocompleteRule(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
    );
  }

  AutocompleteRule copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? active,
  }) {
    return AutocompleteRule(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteRuleGroup {
  const AutocompleteRuleGroup({
    required this.id,
    required this.name,
    this.description,
    this.active,
  });

  factory AutocompleteRuleGroup.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteRuleGroupFromJson(json);

  static const toJsonFactory = _$AutocompleteRuleGroupToJson;
  Map<String, dynamic> toJson() => _$AutocompleteRuleGroupToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$AutocompleteRuleGroupFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteRuleGroupExtension on AutocompleteRuleGroup {
  AutocompleteRuleGroup copyWith({
    String? id,
    String? name,
    String? description,
    bool? active,
  }) {
    return AutocompleteRuleGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
    );
  }

  AutocompleteRuleGroup copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? active,
  }) {
    return AutocompleteRuleGroup(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteTag {
  const AutocompleteTag({
    required this.id,
    required this.name,
    required this.tag,
  });

  factory AutocompleteTag.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteTagFromJson(json);

  static const toJsonFactory = _$AutocompleteTagToJson;
  Map<String, dynamic> toJson() => _$AutocompleteTagToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'tag', includeIfNull: false)
  final String tag;
  static const fromJsonFactory = _$AutocompleteTagFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteTagExtension on AutocompleteTag {
  AutocompleteTag copyWith({String? id, String? name, String? tag}) {
    return AutocompleteTag(
      id: id ?? this.id,
      name: name ?? this.name,
      tag: tag ?? this.tag,
    );
  }

  AutocompleteTag copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? tag,
  }) {
    return AutocompleteTag(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      tag: (tag != null ? tag.value : this.tag),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteTransaction {
  const AutocompleteTransaction({
    required this.id,
    this.transactionGroupId,
    required this.name,
    required this.description,
  });

  factory AutocompleteTransaction.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteTransactionFromJson(json);

  static const toJsonFactory = _$AutocompleteTransactionToJson;
  Map<String, dynamic> toJson() => _$AutocompleteTransactionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'transaction_group_id', includeIfNull: false)
  final String? transactionGroupId;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  static const fromJsonFactory = _$AutocompleteTransactionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteTransactionExtension on AutocompleteTransaction {
  AutocompleteTransaction copyWith({
    String? id,
    String? transactionGroupId,
    String? name,
    String? description,
  }) {
    return AutocompleteTransaction(
      id: id ?? this.id,
      transactionGroupId: transactionGroupId ?? this.transactionGroupId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  AutocompleteTransaction copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String?>? transactionGroupId,
    Wrapped<String>? name,
    Wrapped<String>? description,
  }) {
    return AutocompleteTransaction(
      id: (id != null ? id.value : this.id),
      transactionGroupId:
          (transactionGroupId != null
              ? transactionGroupId.value
              : this.transactionGroupId),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteTransactionID {
  const AutocompleteTransactionID({
    required this.id,
    this.transactionGroupId,
    required this.name,
    required this.description,
  });

  factory AutocompleteTransactionID.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteTransactionIDFromJson(json);

  static const toJsonFactory = _$AutocompleteTransactionIDToJson;
  Map<String, dynamic> toJson() => _$AutocompleteTransactionIDToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'transaction_group_id', includeIfNull: false)
  final String? transactionGroupId;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  static const fromJsonFactory = _$AutocompleteTransactionIDFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteTransactionIDExtension on AutocompleteTransactionID {
  AutocompleteTransactionID copyWith({
    String? id,
    String? transactionGroupId,
    String? name,
    String? description,
  }) {
    return AutocompleteTransactionID(
      id: id ?? this.id,
      transactionGroupId: transactionGroupId ?? this.transactionGroupId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  AutocompleteTransactionID copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String?>? transactionGroupId,
    Wrapped<String>? name,
    Wrapped<String>? description,
  }) {
    return AutocompleteTransactionID(
      id: (id != null ? id.value : this.id),
      transactionGroupId:
          (transactionGroupId != null
              ? transactionGroupId.value
              : this.transactionGroupId),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteTransactionType {
  const AutocompleteTransactionType({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AutocompleteTransactionType.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteTransactionTypeFromJson(json);

  static const toJsonFactory = _$AutocompleteTransactionTypeToJson;
  Map<String, dynamic> toJson() => _$AutocompleteTransactionTypeToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  static const fromJsonFactory = _$AutocompleteTransactionTypeFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteTransactionTypeExtension on AutocompleteTransactionType {
  AutocompleteTransactionType copyWith({
    String? id,
    String? name,
    String? type,
  }) {
    return AutocompleteTransactionType(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  AutocompleteTransactionType copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? type,
  }) {
    return AutocompleteTransactionType(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      type: (type != null ? type.value : this.type),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ChartDataPoint {
  const ChartDataPoint({this.key});

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointFromJson(json);

  static const toJsonFactory = _$ChartDataPointToJson;
  Map<String, dynamic> toJson() => _$ChartDataPointToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String? key;
  static const fromJsonFactory = _$ChartDataPointFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ChartDataPointExtension on ChartDataPoint {
  ChartDataPoint copyWith({String? key}) {
    return ChartDataPoint(key: key ?? this.key);
  }

  ChartDataPoint copyWithWrapped({Wrapped<String?>? key}) {
    return ChartDataPoint(key: (key != null ? key.value : this.key));
  }
}

@JsonSerializable(explicitToJson: true)
class ChartDataSet {
  const ChartDataSet({
    this.label,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.date,
    this.startDate,
    this.endDate,
    this.type,
    this.period,
    this.yAxisID,
    this.entries,
    this.pcEntries,
  });

  factory ChartDataSet.fromJson(Map<String, dynamic> json) =>
      _$ChartDataSetFromJson(json);

  static const toJsonFactory = _$ChartDataSetToJson;
  Map<String, dynamic> toJson() => _$ChartDataSetToJson(this);

  @JsonKey(name: 'label', includeIfNull: false)
  final String? label;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(name: 'start_date', includeIfNull: false)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(
    name: 'period',
    includeIfNull: false,
    toJson: chartDatasetPeriodPropertyNullableToJson,
    fromJson: chartDatasetPeriodPropertyNullableFromJson,
  )
  final enums.ChartDatasetPeriodProperty? period;
  @JsonKey(name: 'yAxisID', includeIfNull: false)
  final int? yAxisID;
  @JsonKey(name: 'entries', includeIfNull: false)
  final Object? entries;
  @JsonKey(name: 'pc_entries', includeIfNull: false)
  final Object? pcEntries;
  static const fromJsonFactory = _$ChartDataSetFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ChartDataSetExtension on ChartDataSet {
  ChartDataSet copyWith({
    String? label,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    enums.ChartDatasetPeriodProperty? period,
    int? yAxisID,
    Object? entries,
    Object? pcEntries,
  }) {
    return ChartDataSet(
      label: label ?? this.label,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      period: period ?? this.period,
      yAxisID: yAxisID ?? this.yAxisID,
      entries: entries ?? this.entries,
      pcEntries: pcEntries ?? this.pcEntries,
    );
  }

  ChartDataSet copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<DateTime?>? date,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<String?>? type,
    Wrapped<enums.ChartDatasetPeriodProperty?>? period,
    Wrapped<int?>? yAxisID,
    Wrapped<Object?>? entries,
    Wrapped<Object?>? pcEntries,
  }) {
    return ChartDataSet(
      label: (label != null ? label.value : this.label),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      date: (date != null ? date.value : this.date),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      type: (type != null ? type.value : this.type),
      period: (period != null ? period.value : this.period),
      yAxisID: (yAxisID != null ? yAxisID.value : this.yAxisID),
      entries: (entries != null ? entries.value : this.entries),
      pcEntries: (pcEntries != null ? pcEntries.value : this.pcEntries),
    );
  }
}

typedef ChartLine = List<ChartDataSet>;

typedef InsightGroup = List<InsightGroupEntry>;

@JsonSerializable(explicitToJson: true)
class InsightGroupEntry {
  const InsightGroupEntry({
    this.id,
    this.name,
    this.difference,
    this.differenceFloat,
    this.currencyId,
    this.currencyCode,
  });

  factory InsightGroupEntry.fromJson(Map<String, dynamic> json) =>
      _$InsightGroupEntryFromJson(json);

  static const toJsonFactory = _$InsightGroupEntryToJson;
  Map<String, dynamic> toJson() => _$InsightGroupEntryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'difference', includeIfNull: false)
  final String? difference;
  @JsonKey(name: 'difference_float', includeIfNull: false)
  final double? differenceFloat;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  static const fromJsonFactory = _$InsightGroupEntryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $InsightGroupEntryExtension on InsightGroupEntry {
  InsightGroupEntry copyWith({
    String? id,
    String? name,
    String? difference,
    double? differenceFloat,
    String? currencyId,
    String? currencyCode,
  }) {
    return InsightGroupEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      difference: difference ?? this.difference,
      differenceFloat: differenceFloat ?? this.differenceFloat,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  InsightGroupEntry copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? difference,
    Wrapped<double?>? differenceFloat,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
  }) {
    return InsightGroupEntry(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      difference: (difference != null ? difference.value : this.difference),
      differenceFloat:
          (differenceFloat != null
              ? differenceFloat.value
              : this.differenceFloat),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
    );
  }
}

typedef InsightTotal = List<InsightTotalEntry>;

@JsonSerializable(explicitToJson: true)
class InsightTotalEntry {
  const InsightTotalEntry({
    this.difference,
    this.differenceFloat,
    this.currencyId,
    this.currencyCode,
  });

  factory InsightTotalEntry.fromJson(Map<String, dynamic> json) =>
      _$InsightTotalEntryFromJson(json);

  static const toJsonFactory = _$InsightTotalEntryToJson;
  Map<String, dynamic> toJson() => _$InsightTotalEntryToJson(this);

  @JsonKey(name: 'difference', includeIfNull: false)
  final String? difference;
  @JsonKey(name: 'difference_float', includeIfNull: false)
  final double? differenceFloat;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  static const fromJsonFactory = _$InsightTotalEntryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $InsightTotalEntryExtension on InsightTotalEntry {
  InsightTotalEntry copyWith({
    String? difference,
    double? differenceFloat,
    String? currencyId,
    String? currencyCode,
  }) {
    return InsightTotalEntry(
      difference: difference ?? this.difference,
      differenceFloat: differenceFloat ?? this.differenceFloat,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  InsightTotalEntry copyWithWrapped({
    Wrapped<String?>? difference,
    Wrapped<double?>? differenceFloat,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
  }) {
    return InsightTotalEntry(
      difference: (difference != null ? difference.value : this.difference),
      differenceFloat:
          (differenceFloat != null
              ? differenceFloat.value
              : this.differenceFloat),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
    );
  }
}

typedef InsightTransfer = List<InsightTransferEntry>;

@JsonSerializable(explicitToJson: true)
class InsightTransferEntry {
  const InsightTransferEntry({
    this.id,
    this.name,
    this.difference,
    this.differenceFloat,
    this.$in,
    this.inFloat,
    this.out,
    this.outFloat,
    this.currencyId,
    this.currencyCode,
  });

  factory InsightTransferEntry.fromJson(Map<String, dynamic> json) =>
      _$InsightTransferEntryFromJson(json);

  static const toJsonFactory = _$InsightTransferEntryToJson;
  Map<String, dynamic> toJson() => _$InsightTransferEntryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'difference', includeIfNull: false)
  final String? difference;
  @JsonKey(name: 'difference_float', includeIfNull: false)
  final double? differenceFloat;
  @JsonKey(name: 'in', includeIfNull: false)
  final String? $in;
  @JsonKey(name: 'in_float', includeIfNull: false)
  final double? inFloat;
  @JsonKey(name: 'out', includeIfNull: false)
  final String? out;
  @JsonKey(name: 'out_float', includeIfNull: false)
  final double? outFloat;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  static const fromJsonFactory = _$InsightTransferEntryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $InsightTransferEntryExtension on InsightTransferEntry {
  InsightTransferEntry copyWith({
    String? id,
    String? name,
    String? difference,
    double? differenceFloat,
    String? $in,
    double? inFloat,
    String? out,
    double? outFloat,
    String? currencyId,
    String? currencyCode,
  }) {
    return InsightTransferEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      difference: difference ?? this.difference,
      differenceFloat: differenceFloat ?? this.differenceFloat,
      $in: $in ?? this.$in,
      inFloat: inFloat ?? this.inFloat,
      out: out ?? this.out,
      outFloat: outFloat ?? this.outFloat,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  InsightTransferEntry copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? difference,
    Wrapped<double?>? differenceFloat,
    Wrapped<String?>? $in,
    Wrapped<double?>? inFloat,
    Wrapped<String?>? out,
    Wrapped<double?>? outFloat,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
  }) {
    return InsightTransferEntry(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      difference: (difference != null ? difference.value : this.difference),
      differenceFloat:
          (differenceFloat != null
              ? differenceFloat.value
              : this.differenceFloat),
      $in: ($in != null ? $in.value : this.$in),
      inFloat: (inFloat != null ? inFloat.value : this.inFloat),
      out: (out != null ? out.value : this.out),
      outFloat: (outFloat != null ? outFloat.value : this.outFloat),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryRead {
  const CategoryRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory CategoryRead.fromJson(Map<String, dynamic> json) =>
      _$CategoryReadFromJson(json);

  static const toJsonFactory = _$CategoryReadToJson;
  Map<String, dynamic> toJson() => _$CategoryReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final CategoryProperties attributes;
  static const fromJsonFactory = _$CategoryReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategoryReadExtension on CategoryRead {
  CategoryRead copyWith({
    String? type,
    String? id,
    CategoryProperties? attributes,
  }) {
    return CategoryRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  CategoryRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<CategoryProperties>? attributes,
  }) {
    return CategoryRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategorySingle {
  const CategorySingle({required this.data});

  factory CategorySingle.fromJson(Map<String, dynamic> json) =>
      _$CategorySingleFromJson(json);

  static const toJsonFactory = _$CategorySingleToJson;
  Map<String, dynamic> toJson() => _$CategorySingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final CategoryRead data;
  static const fromJsonFactory = _$CategorySingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategorySingleExtension on CategorySingle {
  CategorySingle copyWith({CategoryRead? data}) {
    return CategorySingle(data: data ?? this.data);
  }

  CategorySingle copyWithWrapped({Wrapped<CategoryRead>? data}) {
    return CategorySingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigurationSingle {
  const ConfigurationSingle({required this.data});

  factory ConfigurationSingle.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationSingleFromJson(json);

  static const toJsonFactory = _$ConfigurationSingleToJson;
  Map<String, dynamic> toJson() => _$ConfigurationSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final Configuration data;
  static const fromJsonFactory = _$ConfigurationSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ConfigurationSingleExtension on ConfigurationSingle {
  ConfigurationSingle copyWith({Configuration? data}) {
    return ConfigurationSingle(data: data ?? this.data);
  }

  ConfigurationSingle copyWithWrapped({Wrapped<Configuration>? data}) {
    return ConfigurationSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyRead {
  const CurrencyRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory CurrencyRead.fromJson(Map<String, dynamic> json) =>
      _$CurrencyReadFromJson(json);

  static const toJsonFactory = _$CurrencyReadToJson;
  Map<String, dynamic> toJson() => _$CurrencyReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final CurrencyProperties attributes;
  static const fromJsonFactory = _$CurrencyReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyReadExtension on CurrencyRead {
  CurrencyRead copyWith({
    String? type,
    String? id,
    CurrencyProperties? attributes,
  }) {
    return CurrencyRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  CurrencyRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<CurrencyProperties>? attributes,
  }) {
    return CurrencyRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencySingle {
  const CurrencySingle({required this.data});

  factory CurrencySingle.fromJson(Map<String, dynamic> json) =>
      _$CurrencySingleFromJson(json);

  static const toJsonFactory = _$CurrencySingleToJson;
  Map<String, dynamic> toJson() => _$CurrencySingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final CurrencyRead data;
  static const fromJsonFactory = _$CurrencySingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencySingleExtension on CurrencySingle {
  CurrencySingle copyWith({CurrencyRead? data}) {
    return CurrencySingle(data: data ?? this.data);
  }

  CurrencySingle copyWithWrapped({Wrapped<CurrencyRead>? data}) {
    return CurrencySingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class LinkTypeRead {
  const LinkTypeRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory LinkTypeRead.fromJson(Map<String, dynamic> json) =>
      _$LinkTypeReadFromJson(json);

  static const toJsonFactory = _$LinkTypeReadToJson;
  Map<String, dynamic> toJson() => _$LinkTypeReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final LinkType attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$LinkTypeReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $LinkTypeReadExtension on LinkTypeRead {
  LinkTypeRead copyWith({
    String? type,
    String? id,
    LinkType? attributes,
    ObjectLink? links,
  }) {
    return LinkTypeRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  LinkTypeRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<LinkType>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return LinkTypeRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LinkTypeSingle {
  const LinkTypeSingle({required this.data});

  factory LinkTypeSingle.fromJson(Map<String, dynamic> json) =>
      _$LinkTypeSingleFromJson(json);

  static const toJsonFactory = _$LinkTypeSingleToJson;
  Map<String, dynamic> toJson() => _$LinkTypeSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final LinkTypeRead data;
  static const fromJsonFactory = _$LinkTypeSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $LinkTypeSingleExtension on LinkTypeSingle {
  LinkTypeSingle copyWith({LinkTypeRead? data}) {
    return LinkTypeSingle(data: data ?? this.data);
  }

  LinkTypeSingle copyWithWrapped({Wrapped<LinkTypeRead>? data}) {
    return LinkTypeSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectGroupRead {
  const ObjectGroupRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory ObjectGroupRead.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupReadFromJson(json);

  static const toJsonFactory = _$ObjectGroupReadToJson;
  Map<String, dynamic> toJson() => _$ObjectGroupReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final ObjectGroup attributes;
  static const fromJsonFactory = _$ObjectGroupReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectGroupReadExtension on ObjectGroupRead {
  ObjectGroupRead copyWith({
    String? type,
    String? id,
    ObjectGroup? attributes,
  }) {
    return ObjectGroupRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  ObjectGroupRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<ObjectGroup>? attributes,
  }) {
    return ObjectGroupRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectGroupSingle {
  const ObjectGroupSingle({required this.data});

  factory ObjectGroupSingle.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupSingleFromJson(json);

  static const toJsonFactory = _$ObjectGroupSingleToJson;
  Map<String, dynamic> toJson() => _$ObjectGroupSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final ObjectGroupRead data;
  static const fromJsonFactory = _$ObjectGroupSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectGroupSingleExtension on ObjectGroupSingle {
  ObjectGroupSingle copyWith({ObjectGroupRead? data}) {
    return ObjectGroupSingle(data: data ?? this.data);
  }

  ObjectGroupSingle copyWithWrapped({Wrapped<ObjectGroupRead>? data}) {
    return ObjectGroupSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankEventRead {
  const PiggyBankEventRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankEventRead.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankEventReadFromJson(json);

  static const toJsonFactory = _$PiggyBankEventReadToJson;
  Map<String, dynamic> toJson() => _$PiggyBankEventReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final PiggyBankEventProperties attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$PiggyBankEventReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankEventReadExtension on PiggyBankEventRead {
  PiggyBankEventRead copyWith({
    String? type,
    String? id,
    PiggyBankEventProperties? attributes,
    ObjectLink? links,
  }) {
    return PiggyBankEventRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  PiggyBankEventRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<PiggyBankEventProperties>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return PiggyBankEventRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankRead {
  const PiggyBankRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankRead.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankReadFromJson(json);

  static const toJsonFactory = _$PiggyBankReadToJson;
  Map<String, dynamic> toJson() => _$PiggyBankReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final PiggyBankProperties attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$PiggyBankReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankReadExtension on PiggyBankRead {
  PiggyBankRead copyWith({
    String? type,
    String? id,
    PiggyBankProperties? attributes,
    ObjectLink? links,
  }) {
    return PiggyBankRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  PiggyBankRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<PiggyBankProperties>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return PiggyBankRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankSingle {
  const PiggyBankSingle({required this.data});

  factory PiggyBankSingle.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankSingleFromJson(json);

  static const toJsonFactory = _$PiggyBankSingleToJson;
  Map<String, dynamic> toJson() => _$PiggyBankSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final PiggyBankRead data;
  static const fromJsonFactory = _$PiggyBankSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankSingleExtension on PiggyBankSingle {
  PiggyBankSingle copyWith({PiggyBankRead? data}) {
    return PiggyBankSingle(data: data ?? this.data);
  }

  PiggyBankSingle copyWithWrapped({Wrapped<PiggyBankRead>? data}) {
    return PiggyBankSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class PreferenceRead {
  const PreferenceRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory PreferenceRead.fromJson(Map<String, dynamic> json) =>
      _$PreferenceReadFromJson(json);

  static const toJsonFactory = _$PreferenceReadToJson;
  Map<String, dynamic> toJson() => _$PreferenceReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final Preference attributes;
  static const fromJsonFactory = _$PreferenceReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PreferenceReadExtension on PreferenceRead {
  PreferenceRead copyWith({String? type, String? id, Preference? attributes}) {
    return PreferenceRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  PreferenceRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<Preference>? attributes,
  }) {
    return PreferenceRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PreferenceSingle {
  const PreferenceSingle({required this.data});

  factory PreferenceSingle.fromJson(Map<String, dynamic> json) =>
      _$PreferenceSingleFromJson(json);

  static const toJsonFactory = _$PreferenceSingleToJson;
  Map<String, dynamic> toJson() => _$PreferenceSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final PreferenceRead data;
  static const fromJsonFactory = _$PreferenceSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PreferenceSingleExtension on PreferenceSingle {
  PreferenceSingle copyWith({PreferenceRead? data}) {
    return PreferenceSingle(data: data ?? this.data);
  }

  PreferenceSingle copyWithWrapped({Wrapped<PreferenceRead>? data}) {
    return PreferenceSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceRead {
  const RecurrenceRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RecurrenceRead.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceReadFromJson(json);

  static const toJsonFactory = _$RecurrenceReadToJson;
  Map<String, dynamic> toJson() => _$RecurrenceReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final RecurrenceProperties attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$RecurrenceReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceReadExtension on RecurrenceRead {
  RecurrenceRead copyWith({
    String? type,
    String? id,
    RecurrenceProperties? attributes,
    ObjectLink? links,
  }) {
    return RecurrenceRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  RecurrenceRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<RecurrenceProperties>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return RecurrenceRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceSingle {
  const RecurrenceSingle({required this.data});

  factory RecurrenceSingle.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceSingleFromJson(json);

  static const toJsonFactory = _$RecurrenceSingleToJson;
  Map<String, dynamic> toJson() => _$RecurrenceSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final RecurrenceRead data;
  static const fromJsonFactory = _$RecurrenceSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceSingleExtension on RecurrenceSingle {
  RecurrenceSingle copyWith({RecurrenceRead? data}) {
    return RecurrenceSingle(data: data ?? this.data);
  }

  RecurrenceSingle copyWithWrapped({Wrapped<RecurrenceRead>? data}) {
    return RecurrenceSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroupRead {
  const RuleGroupRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RuleGroupRead.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupReadFromJson(json);

  static const toJsonFactory = _$RuleGroupReadToJson;
  Map<String, dynamic> toJson() => _$RuleGroupReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final RuleGroup attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$RuleGroupReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupReadExtension on RuleGroupRead {
  RuleGroupRead copyWith({
    String? type,
    String? id,
    RuleGroup? attributes,
    ObjectLink? links,
  }) {
    return RuleGroupRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  RuleGroupRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<RuleGroup>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return RuleGroupRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroupSingle {
  const RuleGroupSingle({required this.data});

  factory RuleGroupSingle.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupSingleFromJson(json);

  static const toJsonFactory = _$RuleGroupSingleToJson;
  Map<String, dynamic> toJson() => _$RuleGroupSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final RuleGroupRead data;
  static const fromJsonFactory = _$RuleGroupSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupSingleExtension on RuleGroupSingle {
  RuleGroupSingle copyWith({RuleGroupRead? data}) {
    return RuleGroupSingle(data: data ?? this.data);
  }

  RuleGroupSingle copyWithWrapped({Wrapped<RuleGroupRead>? data}) {
    return RuleGroupSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class RuleRead {
  const RuleRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory RuleRead.fromJson(Map<String, dynamic> json) =>
      _$RuleReadFromJson(json);

  static const toJsonFactory = _$RuleReadToJson;
  Map<String, dynamic> toJson() => _$RuleReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final Rule attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$RuleReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleReadExtension on RuleRead {
  RuleRead copyWith({
    String? type,
    String? id,
    Rule? attributes,
    ObjectLink? links,
  }) {
    return RuleRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  RuleRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<Rule>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return RuleRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleSingle {
  const RuleSingle({required this.data});

  factory RuleSingle.fromJson(Map<String, dynamic> json) =>
      _$RuleSingleFromJson(json);

  static const toJsonFactory = _$RuleSingleToJson;
  Map<String, dynamic> toJson() => _$RuleSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final RuleRead data;
  static const fromJsonFactory = _$RuleSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleSingleExtension on RuleSingle {
  RuleSingle copyWith({RuleRead? data}) {
    return RuleSingle(data: data ?? this.data);
  }

  RuleSingle copyWithWrapped({Wrapped<RuleRead>? data}) {
    return RuleSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class TagRead {
  const TagRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory TagRead.fromJson(Map<String, dynamic> json) =>
      _$TagReadFromJson(json);

  static const toJsonFactory = _$TagReadToJson;
  Map<String, dynamic> toJson() => _$TagReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final TagModel attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$TagReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagReadExtension on TagRead {
  TagRead copyWith({
    String? type,
    String? id,
    TagModel? attributes,
    ObjectLink? links,
  }) {
    return TagRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  TagRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<TagModel>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return TagRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TagSingle {
  const TagSingle({required this.data});

  factory TagSingle.fromJson(Map<String, dynamic> json) =>
      _$TagSingleFromJson(json);

  static const toJsonFactory = _$TagSingleToJson;
  Map<String, dynamic> toJson() => _$TagSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final TagRead data;
  static const fromJsonFactory = _$TagSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagSingleExtension on TagSingle {
  TagSingle copyWith({TagRead? data}) {
    return TagSingle(data: data ?? this.data);
  }

  TagSingle copyWithWrapped({Wrapped<TagRead>? data}) {
    return TagSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLinkRead {
  const TransactionLinkRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory TransactionLinkRead.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkReadFromJson(json);

  static const toJsonFactory = _$TransactionLinkReadToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final TransactionLink attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$TransactionLinkReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkReadExtension on TransactionLinkRead {
  TransactionLinkRead copyWith({
    String? type,
    String? id,
    TransactionLink? attributes,
    ObjectLink? links,
  }) {
    return TransactionLinkRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  TransactionLinkRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<TransactionLink>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return TransactionLinkRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLinkSingle {
  const TransactionLinkSingle({required this.data});

  factory TransactionLinkSingle.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkSingleFromJson(json);

  static const toJsonFactory = _$TransactionLinkSingleToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final TransactionLinkRead data;
  static const fromJsonFactory = _$TransactionLinkSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkSingleExtension on TransactionLinkSingle {
  TransactionLinkSingle copyWith({TransactionLinkRead? data}) {
    return TransactionLinkSingle(data: data ?? this.data);
  }

  TransactionLinkSingle copyWithWrapped({Wrapped<TransactionLinkRead>? data}) {
    return TransactionLinkSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionRead {
  const TransactionRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory TransactionRead.fromJson(Map<String, dynamic> json) =>
      _$TransactionReadFromJson(json);

  static const toJsonFactory = _$TransactionReadToJson;
  Map<String, dynamic> toJson() => _$TransactionReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final Transaction attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$TransactionReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionReadExtension on TransactionRead {
  TransactionRead copyWith({
    String? type,
    String? id,
    Transaction? attributes,
    ObjectLink? links,
  }) {
    return TransactionRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  TransactionRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<Transaction>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return TransactionRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionSingle {
  const TransactionSingle({required this.data});

  factory TransactionSingle.fromJson(Map<String, dynamic> json) =>
      _$TransactionSingleFromJson(json);

  static const toJsonFactory = _$TransactionSingleToJson;
  Map<String, dynamic> toJson() => _$TransactionSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final TransactionRead data;
  static const fromJsonFactory = _$TransactionSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSingleExtension on TransactionSingle {
  TransactionSingle copyWith({TransactionRead? data}) {
    return TransactionSingle(data: data ?? this.data);
  }

  TransactionSingle copyWithWrapped({Wrapped<TransactionRead>? data}) {
    return TransactionSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class UserRead {
  const UserRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory UserRead.fromJson(Map<String, dynamic> json) =>
      _$UserReadFromJson(json);

  static const toJsonFactory = _$UserReadToJson;
  Map<String, dynamic> toJson() => _$UserReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final User attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$UserReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserReadExtension on UserRead {
  UserRead copyWith({
    String? type,
    String? id,
    User? attributes,
    ObjectLink? links,
  }) {
    return UserRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  UserRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<User>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return UserRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookAttemptRead {
  const WebhookAttemptRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory WebhookAttemptRead.fromJson(Map<String, dynamic> json) =>
      _$WebhookAttemptReadFromJson(json);

  static const toJsonFactory = _$WebhookAttemptReadToJson;
  Map<String, dynamic> toJson() => _$WebhookAttemptReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final WebhookAttempt attributes;
  static const fromJsonFactory = _$WebhookAttemptReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookAttemptReadExtension on WebhookAttemptRead {
  WebhookAttemptRead copyWith({
    String? type,
    String? id,
    WebhookAttempt? attributes,
  }) {
    return WebhookAttemptRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  WebhookAttemptRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<WebhookAttempt>? attributes,
  }) {
    return WebhookAttemptRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookAttemptSingle {
  const WebhookAttemptSingle({required this.data});

  factory WebhookAttemptSingle.fromJson(Map<String, dynamic> json) =>
      _$WebhookAttemptSingleFromJson(json);

  static const toJsonFactory = _$WebhookAttemptSingleToJson;
  Map<String, dynamic> toJson() => _$WebhookAttemptSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final WebhookAttemptRead data;
  static const fromJsonFactory = _$WebhookAttemptSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookAttemptSingleExtension on WebhookAttemptSingle {
  WebhookAttemptSingle copyWith({WebhookAttemptRead? data}) {
    return WebhookAttemptSingle(data: data ?? this.data);
  }

  WebhookAttemptSingle copyWithWrapped({Wrapped<WebhookAttemptRead>? data}) {
    return WebhookAttemptSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookMessageRead {
  const WebhookMessageRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory WebhookMessageRead.fromJson(Map<String, dynamic> json) =>
      _$WebhookMessageReadFromJson(json);

  static const toJsonFactory = _$WebhookMessageReadToJson;
  Map<String, dynamic> toJson() => _$WebhookMessageReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final WebhookMessage attributes;
  static const fromJsonFactory = _$WebhookMessageReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookMessageReadExtension on WebhookMessageRead {
  WebhookMessageRead copyWith({
    String? type,
    String? id,
    WebhookMessage? attributes,
  }) {
    return WebhookMessageRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  WebhookMessageRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<WebhookMessage>? attributes,
  }) {
    return WebhookMessageRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookMessageSingle {
  const WebhookMessageSingle({required this.data});

  factory WebhookMessageSingle.fromJson(Map<String, dynamic> json) =>
      _$WebhookMessageSingleFromJson(json);

  static const toJsonFactory = _$WebhookMessageSingleToJson;
  Map<String, dynamic> toJson() => _$WebhookMessageSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final WebhookMessageRead data;
  static const fromJsonFactory = _$WebhookMessageSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookMessageSingleExtension on WebhookMessageSingle {
  WebhookMessageSingle copyWith({WebhookMessageRead? data}) {
    return WebhookMessageSingle(data: data ?? this.data);
  }

  WebhookMessageSingle copyWithWrapped({Wrapped<WebhookMessageRead>? data}) {
    return WebhookMessageSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookRead {
  const WebhookRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory WebhookRead.fromJson(Map<String, dynamic> json) =>
      _$WebhookReadFromJson(json);

  static const toJsonFactory = _$WebhookReadToJson;
  Map<String, dynamic> toJson() => _$WebhookReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final WebhookProperties attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$WebhookReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookReadExtension on WebhookRead {
  WebhookRead copyWith({
    String? type,
    String? id,
    WebhookProperties? attributes,
    ObjectLink? links,
  }) {
    return WebhookRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  WebhookRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<WebhookProperties>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return WebhookRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookSingle {
  const WebhookSingle({required this.data});

  factory WebhookSingle.fromJson(Map<String, dynamic> json) =>
      _$WebhookSingleFromJson(json);

  static const toJsonFactory = _$WebhookSingleToJson;
  Map<String, dynamic> toJson() => _$WebhookSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final WebhookRead data;
  static const fromJsonFactory = _$WebhookSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookSingleExtension on WebhookSingle {
  WebhookSingle copyWith({WebhookRead? data}) {
    return WebhookSingle(data: data ?? this.data);
  }

  WebhookSingle copyWithWrapped({Wrapped<WebhookRead>? data}) {
    return WebhookSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class AccountProperties {
  const AccountProperties({
    this.createdAt,
    this.updatedAt,
    this.active,
    this.order,
    required this.name,
    required this.type,
    this.accountRole,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.currentBalance,
    this.pcCurrentBalance,
    this.balanceDifference,
    this.pcBalanceDifference,
    this.openingBalance,
    this.pcOpeningBalance,
    this.virtualBalance,
    this.pcVirtualBalance,
    this.debtAmount,
    this.pcDebtAmount,
    this.currentBalanceDate,
    this.notes,
    this.monthlyPaymentDate,
    this.creditCardType,
    this.accountNumber,
    this.iban,
    this.bic,
    this.openingBalanceDate,
    this.liabilityType,
    this.liabilityDirection,
    this.interest,
    this.interestPeriod,
    this.includeNetWorth,
    this.longitude,
    this.latitude,
    this.zoomLevel,
    this.lastActivity,
  });

  factory AccountProperties.fromJson(Map<String, dynamic> json) =>
      _$AccountPropertiesFromJson(json);

  static const toJsonFactory = _$AccountPropertiesToJson;
  Map<String, dynamic> toJson() => _$AccountPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: shortAccountTypePropertyToJson,
    fromJson: shortAccountTypePropertyFromJson,
  )
  final enums.ShortAccountTypeProperty type;
  @JsonKey(
    name: 'account_role',
    includeIfNull: false,
    toJson: accountRolePropertyNullableToJson,
    fromJson: accountRolePropertyNullableFromJson,
  )
  final enums.AccountRoleProperty? accountRole;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_order', includeIfNull: false)
  final int? objectGroupOrder;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'current_balance', includeIfNull: false)
  final String? currentBalance;
  @JsonKey(name: 'pc_current_balance', includeIfNull: false)
  final String? pcCurrentBalance;
  @JsonKey(name: 'balance_difference', includeIfNull: false)
  final String? balanceDifference;
  @JsonKey(name: 'pc_balance_difference', includeIfNull: false)
  final String? pcBalanceDifference;
  @JsonKey(name: 'opening_balance', includeIfNull: false)
  final String? openingBalance;
  @JsonKey(name: 'pc_opening_balance', includeIfNull: false)
  final String? pcOpeningBalance;
  @JsonKey(name: 'virtual_balance', includeIfNull: false)
  final String? virtualBalance;
  @JsonKey(name: 'pc_virtual_balance', includeIfNull: false)
  final String? pcVirtualBalance;
  @JsonKey(name: 'debt_amount', includeIfNull: false)
  final String? debtAmount;
  @JsonKey(name: 'pc_debt_amount', includeIfNull: false)
  final String? pcDebtAmount;
  @JsonKey(name: 'current_balance_date', includeIfNull: false)
  final DateTime? currentBalanceDate;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'monthly_payment_date', includeIfNull: false)
  final DateTime? monthlyPaymentDate;
  @JsonKey(
    name: 'credit_card_type',
    includeIfNull: false,
    toJson: creditCardTypePropertyNullableToJson,
    fromJson: creditCardTypePropertyNullableFromJson,
  )
  final enums.CreditCardTypeProperty? creditCardType;
  @JsonKey(name: 'account_number', includeIfNull: false)
  final String? accountNumber;
  @JsonKey(name: 'iban', includeIfNull: false)
  final String? iban;
  @JsonKey(name: 'bic', includeIfNull: false)
  final String? bic;
  @JsonKey(name: 'opening_balance_date', includeIfNull: false)
  final DateTime? openingBalanceDate;
  @JsonKey(
    name: 'liability_type',
    includeIfNull: false,
    toJson: liabilityTypePropertyNullableToJson,
    fromJson: liabilityTypePropertyNullableFromJson,
  )
  final enums.LiabilityTypeProperty? liabilityType;
  @JsonKey(
    name: 'liability_direction',
    includeIfNull: false,
    toJson: liabilityDirectionPropertyNullableToJson,
    fromJson: liabilityDirectionPropertyNullableFromJson,
  )
  final enums.LiabilityDirectionProperty? liabilityDirection;
  @JsonKey(name: 'interest', includeIfNull: false)
  final String? interest;
  @JsonKey(
    name: 'interest_period',
    includeIfNull: false,
    toJson: interestPeriodPropertyNullableToJson,
    fromJson: interestPeriodPropertyNullableFromJson,
  )
  final enums.InterestPeriodProperty? interestPeriod;
  @JsonKey(name: 'include_net_worth', includeIfNull: false, defaultValue: true)
  final bool? includeNetWorth;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  @JsonKey(name: 'last_activity', includeIfNull: false)
  final DateTime? lastActivity;
  static const fromJsonFactory = _$AccountPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountPropertiesExtension on AccountProperties {
  AccountProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? active,
    int? order,
    String? name,
    enums.ShortAccountTypeProperty? type,
    enums.AccountRoleProperty? accountRole,
    String? objectGroupId,
    int? objectGroupOrder,
    String? objectGroupTitle,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? currentBalance,
    String? pcCurrentBalance,
    String? balanceDifference,
    String? pcBalanceDifference,
    String? openingBalance,
    String? pcOpeningBalance,
    String? virtualBalance,
    String? pcVirtualBalance,
    String? debtAmount,
    String? pcDebtAmount,
    DateTime? currentBalanceDate,
    String? notes,
    DateTime? monthlyPaymentDate,
    enums.CreditCardTypeProperty? creditCardType,
    String? accountNumber,
    String? iban,
    String? bic,
    DateTime? openingBalanceDate,
    enums.LiabilityTypeProperty? liabilityType,
    enums.LiabilityDirectionProperty? liabilityDirection,
    String? interest,
    enums.InterestPeriodProperty? interestPeriod,
    bool? includeNetWorth,
    double? longitude,
    double? latitude,
    int? zoomLevel,
    DateTime? lastActivity,
  }) {
    return AccountProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      active: active ?? this.active,
      order: order ?? this.order,
      name: name ?? this.name,
      type: type ?? this.type,
      accountRole: accountRole ?? this.accountRole,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupOrder: objectGroupOrder ?? this.objectGroupOrder,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      currentBalance: currentBalance ?? this.currentBalance,
      pcCurrentBalance: pcCurrentBalance ?? this.pcCurrentBalance,
      balanceDifference: balanceDifference ?? this.balanceDifference,
      pcBalanceDifference: pcBalanceDifference ?? this.pcBalanceDifference,
      openingBalance: openingBalance ?? this.openingBalance,
      pcOpeningBalance: pcOpeningBalance ?? this.pcOpeningBalance,
      virtualBalance: virtualBalance ?? this.virtualBalance,
      pcVirtualBalance: pcVirtualBalance ?? this.pcVirtualBalance,
      debtAmount: debtAmount ?? this.debtAmount,
      pcDebtAmount: pcDebtAmount ?? this.pcDebtAmount,
      currentBalanceDate: currentBalanceDate ?? this.currentBalanceDate,
      notes: notes ?? this.notes,
      monthlyPaymentDate: monthlyPaymentDate ?? this.monthlyPaymentDate,
      creditCardType: creditCardType ?? this.creditCardType,
      accountNumber: accountNumber ?? this.accountNumber,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
      openingBalanceDate: openingBalanceDate ?? this.openingBalanceDate,
      liabilityType: liabilityType ?? this.liabilityType,
      liabilityDirection: liabilityDirection ?? this.liabilityDirection,
      interest: interest ?? this.interest,
      interestPeriod: interestPeriod ?? this.interestPeriod,
      includeNetWorth: includeNetWorth ?? this.includeNetWorth,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  AccountProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<String>? name,
    Wrapped<enums.ShortAccountTypeProperty>? type,
    Wrapped<enums.AccountRoleProperty?>? accountRole,
    Wrapped<String?>? objectGroupId,
    Wrapped<int?>? objectGroupOrder,
    Wrapped<String?>? objectGroupTitle,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? currentBalance,
    Wrapped<String?>? pcCurrentBalance,
    Wrapped<String?>? balanceDifference,
    Wrapped<String?>? pcBalanceDifference,
    Wrapped<String?>? openingBalance,
    Wrapped<String?>? pcOpeningBalance,
    Wrapped<String?>? virtualBalance,
    Wrapped<String?>? pcVirtualBalance,
    Wrapped<String?>? debtAmount,
    Wrapped<String?>? pcDebtAmount,
    Wrapped<DateTime?>? currentBalanceDate,
    Wrapped<String?>? notes,
    Wrapped<DateTime?>? monthlyPaymentDate,
    Wrapped<enums.CreditCardTypeProperty?>? creditCardType,
    Wrapped<String?>? accountNumber,
    Wrapped<String?>? iban,
    Wrapped<String?>? bic,
    Wrapped<DateTime?>? openingBalanceDate,
    Wrapped<enums.LiabilityTypeProperty?>? liabilityType,
    Wrapped<enums.LiabilityDirectionProperty?>? liabilityDirection,
    Wrapped<String?>? interest,
    Wrapped<enums.InterestPeriodProperty?>? interestPeriod,
    Wrapped<bool?>? includeNetWorth,
    Wrapped<double?>? longitude,
    Wrapped<double?>? latitude,
    Wrapped<int?>? zoomLevel,
    Wrapped<DateTime?>? lastActivity,
  }) {
    return AccountProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      name: (name != null ? name.value : this.name),
      type: (type != null ? type.value : this.type),
      accountRole: (accountRole != null ? accountRole.value : this.accountRole),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupOrder:
          (objectGroupOrder != null
              ? objectGroupOrder.value
              : this.objectGroupOrder),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      currentBalance:
          (currentBalance != null ? currentBalance.value : this.currentBalance),
      pcCurrentBalance:
          (pcCurrentBalance != null
              ? pcCurrentBalance.value
              : this.pcCurrentBalance),
      balanceDifference:
          (balanceDifference != null
              ? balanceDifference.value
              : this.balanceDifference),
      pcBalanceDifference:
          (pcBalanceDifference != null
              ? pcBalanceDifference.value
              : this.pcBalanceDifference),
      openingBalance:
          (openingBalance != null ? openingBalance.value : this.openingBalance),
      pcOpeningBalance:
          (pcOpeningBalance != null
              ? pcOpeningBalance.value
              : this.pcOpeningBalance),
      virtualBalance:
          (virtualBalance != null ? virtualBalance.value : this.virtualBalance),
      pcVirtualBalance:
          (pcVirtualBalance != null
              ? pcVirtualBalance.value
              : this.pcVirtualBalance),
      debtAmount: (debtAmount != null ? debtAmount.value : this.debtAmount),
      pcDebtAmount:
          (pcDebtAmount != null ? pcDebtAmount.value : this.pcDebtAmount),
      currentBalanceDate:
          (currentBalanceDate != null
              ? currentBalanceDate.value
              : this.currentBalanceDate),
      notes: (notes != null ? notes.value : this.notes),
      monthlyPaymentDate:
          (monthlyPaymentDate != null
              ? monthlyPaymentDate.value
              : this.monthlyPaymentDate),
      creditCardType:
          (creditCardType != null ? creditCardType.value : this.creditCardType),
      accountNumber:
          (accountNumber != null ? accountNumber.value : this.accountNumber),
      iban: (iban != null ? iban.value : this.iban),
      bic: (bic != null ? bic.value : this.bic),
      openingBalanceDate:
          (openingBalanceDate != null
              ? openingBalanceDate.value
              : this.openingBalanceDate),
      liabilityType:
          (liabilityType != null ? liabilityType.value : this.liabilityType),
      liabilityDirection:
          (liabilityDirection != null
              ? liabilityDirection.value
              : this.liabilityDirection),
      interest: (interest != null ? interest.value : this.interest),
      interestPeriod:
          (interestPeriod != null ? interestPeriod.value : this.interestPeriod),
      includeNetWorth:
          (includeNetWorth != null
              ? includeNetWorth.value
              : this.includeNetWorth),
      longitude: (longitude != null ? longitude.value : this.longitude),
      latitude: (latitude != null ? latitude.value : this.latitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
      lastActivity:
          (lastActivity != null ? lastActivity.value : this.lastActivity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountRead {
  const AccountRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory AccountRead.fromJson(Map<String, dynamic> json) =>
      _$AccountReadFromJson(json);

  static const toJsonFactory = _$AccountReadToJson;
  Map<String, dynamic> toJson() => _$AccountReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final AccountProperties attributes;
  static const fromJsonFactory = _$AccountReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountReadExtension on AccountRead {
  AccountRead copyWith({
    String? type,
    String? id,
    AccountProperties? attributes,
  }) {
    return AccountRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  AccountRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<AccountProperties>? attributes,
  }) {
    return AccountRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountSingle {
  const AccountSingle({required this.data});

  factory AccountSingle.fromJson(Map<String, dynamic> json) =>
      _$AccountSingleFromJson(json);

  static const toJsonFactory = _$AccountSingleToJson;
  Map<String, dynamic> toJson() => _$AccountSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final AccountRead data;
  static const fromJsonFactory = _$AccountSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountSingleExtension on AccountSingle {
  AccountSingle copyWith({AccountRead? data}) {
    return AccountSingle(data: data ?? this.data);
  }

  AccountSingle copyWithWrapped({Wrapped<AccountRead>? data}) {
    return AccountSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class AccountStore {
  const AccountStore({
    required this.name,
    required this.type,
    this.iban,
    this.bic,
    this.accountNumber,
    this.openingBalance,
    this.openingBalanceDate,
    this.virtualBalance,
    this.currencyId,
    this.currencyCode,
    this.active,
    this.order,
    this.includeNetWorth,
    this.accountRole,
    this.creditCardType,
    this.monthlyPaymentDate,
    this.liabilityType,
    this.liabilityDirection,
    this.interest,
    this.interestPeriod,
    this.notes,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory AccountStore.fromJson(Map<String, dynamic> json) =>
      _$AccountStoreFromJson(json);

  static const toJsonFactory = _$AccountStoreToJson;
  Map<String, dynamic> toJson() => _$AccountStoreToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: shortAccountTypePropertyToJson,
    fromJson: shortAccountTypePropertyFromJson,
  )
  final enums.ShortAccountTypeProperty type;
  @JsonKey(name: 'iban', includeIfNull: false)
  final String? iban;
  @JsonKey(name: 'bic', includeIfNull: false)
  final String? bic;
  @JsonKey(name: 'account_number', includeIfNull: false)
  final String? accountNumber;
  @JsonKey(name: 'opening_balance', includeIfNull: false)
  final String? openingBalance;
  @JsonKey(name: 'opening_balance_date', includeIfNull: false)
  final DateTime? openingBalanceDate;
  @JsonKey(name: 'virtual_balance', includeIfNull: false)
  final String? virtualBalance;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'include_net_worth', includeIfNull: false, defaultValue: true)
  final bool? includeNetWorth;
  @JsonKey(
    name: 'account_role',
    includeIfNull: false,
    toJson: accountRolePropertyNullableToJson,
    fromJson: accountRolePropertyNullableFromJson,
  )
  final enums.AccountRoleProperty? accountRole;
  @JsonKey(
    name: 'credit_card_type',
    includeIfNull: false,
    toJson: creditCardTypePropertyNullableToJson,
    fromJson: creditCardTypePropertyNullableFromJson,
  )
  final enums.CreditCardTypeProperty? creditCardType;
  @JsonKey(name: 'monthly_payment_date', includeIfNull: false)
  final DateTime? monthlyPaymentDate;
  @JsonKey(
    name: 'liability_type',
    includeIfNull: false,
    toJson: liabilityTypePropertyNullableToJson,
    fromJson: liabilityTypePropertyNullableFromJson,
  )
  final enums.LiabilityTypeProperty? liabilityType;
  @JsonKey(
    name: 'liability_direction',
    includeIfNull: false,
    toJson: liabilityDirectionPropertyNullableToJson,
    fromJson: liabilityDirectionPropertyNullableFromJson,
  )
  final enums.LiabilityDirectionProperty? liabilityDirection;
  @JsonKey(name: 'interest', includeIfNull: false)
  final String? interest;
  @JsonKey(
    name: 'interest_period',
    includeIfNull: false,
    toJson: interestPeriodPropertyNullableToJson,
    fromJson: interestPeriodPropertyNullableFromJson,
  )
  final enums.InterestPeriodProperty? interestPeriod;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  static const fromJsonFactory = _$AccountStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountStoreExtension on AccountStore {
  AccountStore copyWith({
    String? name,
    enums.ShortAccountTypeProperty? type,
    String? iban,
    String? bic,
    String? accountNumber,
    String? openingBalance,
    DateTime? openingBalanceDate,
    String? virtualBalance,
    String? currencyId,
    String? currencyCode,
    bool? active,
    int? order,
    bool? includeNetWorth,
    enums.AccountRoleProperty? accountRole,
    enums.CreditCardTypeProperty? creditCardType,
    DateTime? monthlyPaymentDate,
    enums.LiabilityTypeProperty? liabilityType,
    enums.LiabilityDirectionProperty? liabilityDirection,
    String? interest,
    enums.InterestPeriodProperty? interestPeriod,
    String? notes,
    double? latitude,
    double? longitude,
    int? zoomLevel,
  }) {
    return AccountStore(
      name: name ?? this.name,
      type: type ?? this.type,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
      accountNumber: accountNumber ?? this.accountNumber,
      openingBalance: openingBalance ?? this.openingBalance,
      openingBalanceDate: openingBalanceDate ?? this.openingBalanceDate,
      virtualBalance: virtualBalance ?? this.virtualBalance,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      active: active ?? this.active,
      order: order ?? this.order,
      includeNetWorth: includeNetWorth ?? this.includeNetWorth,
      accountRole: accountRole ?? this.accountRole,
      creditCardType: creditCardType ?? this.creditCardType,
      monthlyPaymentDate: monthlyPaymentDate ?? this.monthlyPaymentDate,
      liabilityType: liabilityType ?? this.liabilityType,
      liabilityDirection: liabilityDirection ?? this.liabilityDirection,
      interest: interest ?? this.interest,
      interestPeriod: interestPeriod ?? this.interestPeriod,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  AccountStore copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.ShortAccountTypeProperty>? type,
    Wrapped<String?>? iban,
    Wrapped<String?>? bic,
    Wrapped<String?>? accountNumber,
    Wrapped<String?>? openingBalance,
    Wrapped<DateTime?>? openingBalanceDate,
    Wrapped<String?>? virtualBalance,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<bool?>? includeNetWorth,
    Wrapped<enums.AccountRoleProperty?>? accountRole,
    Wrapped<enums.CreditCardTypeProperty?>? creditCardType,
    Wrapped<DateTime?>? monthlyPaymentDate,
    Wrapped<enums.LiabilityTypeProperty?>? liabilityType,
    Wrapped<enums.LiabilityDirectionProperty?>? liabilityDirection,
    Wrapped<String?>? interest,
    Wrapped<enums.InterestPeriodProperty?>? interestPeriod,
    Wrapped<String?>? notes,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
  }) {
    return AccountStore(
      name: (name != null ? name.value : this.name),
      type: (type != null ? type.value : this.type),
      iban: (iban != null ? iban.value : this.iban),
      bic: (bic != null ? bic.value : this.bic),
      accountNumber:
          (accountNumber != null ? accountNumber.value : this.accountNumber),
      openingBalance:
          (openingBalance != null ? openingBalance.value : this.openingBalance),
      openingBalanceDate:
          (openingBalanceDate != null
              ? openingBalanceDate.value
              : this.openingBalanceDate),
      virtualBalance:
          (virtualBalance != null ? virtualBalance.value : this.virtualBalance),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      includeNetWorth:
          (includeNetWorth != null
              ? includeNetWorth.value
              : this.includeNetWorth),
      accountRole: (accountRole != null ? accountRole.value : this.accountRole),
      creditCardType:
          (creditCardType != null ? creditCardType.value : this.creditCardType),
      monthlyPaymentDate:
          (monthlyPaymentDate != null
              ? monthlyPaymentDate.value
              : this.monthlyPaymentDate),
      liabilityType:
          (liabilityType != null ? liabilityType.value : this.liabilityType),
      liabilityDirection:
          (liabilityDirection != null
              ? liabilityDirection.value
              : this.liabilityDirection),
      interest: (interest != null ? interest.value : this.interest),
      interestPeriod:
          (interestPeriod != null ? interestPeriod.value : this.interestPeriod),
      notes: (notes != null ? notes.value : this.notes),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountUpdate {
  const AccountUpdate({
    required this.name,
    this.iban,
    this.bic,
    this.accountNumber,
    this.openingBalance,
    this.openingBalanceDate,
    this.virtualBalance,
    this.currencyId,
    this.currencyCode,
    this.active,
    this.order,
    this.includeNetWorth,
    this.accountRole,
    this.creditCardType,
    this.monthlyPaymentDate,
    this.liabilityType,
    this.interest,
    this.interestPeriod,
    this.notes,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory AccountUpdate.fromJson(Map<String, dynamic> json) =>
      _$AccountUpdateFromJson(json);

  static const toJsonFactory = _$AccountUpdateToJson;
  Map<String, dynamic> toJson() => _$AccountUpdateToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'iban', includeIfNull: false)
  final String? iban;
  @JsonKey(name: 'bic', includeIfNull: false)
  final String? bic;
  @JsonKey(name: 'account_number', includeIfNull: false)
  final String? accountNumber;
  @JsonKey(name: 'opening_balance', includeIfNull: false)
  final String? openingBalance;
  @JsonKey(name: 'opening_balance_date', includeIfNull: false)
  final DateTime? openingBalanceDate;
  @JsonKey(name: 'virtual_balance', includeIfNull: false)
  final String? virtualBalance;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'include_net_worth', includeIfNull: false, defaultValue: true)
  final bool? includeNetWorth;
  @JsonKey(
    name: 'account_role',
    includeIfNull: false,
    toJson: accountRolePropertyNullableToJson,
    fromJson: accountRolePropertyNullableFromJson,
  )
  final enums.AccountRoleProperty? accountRole;
  @JsonKey(
    name: 'credit_card_type',
    includeIfNull: false,
    toJson: creditCardTypePropertyNullableToJson,
    fromJson: creditCardTypePropertyNullableFromJson,
  )
  final enums.CreditCardTypeProperty? creditCardType;
  @JsonKey(name: 'monthly_payment_date', includeIfNull: false)
  final DateTime? monthlyPaymentDate;
  @JsonKey(
    name: 'liability_type',
    includeIfNull: false,
    toJson: liabilityTypePropertyNullableToJson,
    fromJson: liabilityTypePropertyNullableFromJson,
  )
  final enums.LiabilityTypeProperty? liabilityType;
  @JsonKey(name: 'interest', includeIfNull: false)
  final String? interest;
  @JsonKey(
    name: 'interest_period',
    includeIfNull: false,
    toJson: interestPeriodPropertyNullableToJson,
    fromJson: interestPeriodPropertyNullableFromJson,
  )
  final enums.InterestPeriodProperty? interestPeriod;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  static const fromJsonFactory = _$AccountUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountUpdateExtension on AccountUpdate {
  AccountUpdate copyWith({
    String? name,
    String? iban,
    String? bic,
    String? accountNumber,
    String? openingBalance,
    DateTime? openingBalanceDate,
    String? virtualBalance,
    String? currencyId,
    String? currencyCode,
    bool? active,
    int? order,
    bool? includeNetWorth,
    enums.AccountRoleProperty? accountRole,
    enums.CreditCardTypeProperty? creditCardType,
    DateTime? monthlyPaymentDate,
    enums.LiabilityTypeProperty? liabilityType,
    String? interest,
    enums.InterestPeriodProperty? interestPeriod,
    String? notes,
    double? latitude,
    double? longitude,
    int? zoomLevel,
  }) {
    return AccountUpdate(
      name: name ?? this.name,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
      accountNumber: accountNumber ?? this.accountNumber,
      openingBalance: openingBalance ?? this.openingBalance,
      openingBalanceDate: openingBalanceDate ?? this.openingBalanceDate,
      virtualBalance: virtualBalance ?? this.virtualBalance,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      active: active ?? this.active,
      order: order ?? this.order,
      includeNetWorth: includeNetWorth ?? this.includeNetWorth,
      accountRole: accountRole ?? this.accountRole,
      creditCardType: creditCardType ?? this.creditCardType,
      monthlyPaymentDate: monthlyPaymentDate ?? this.monthlyPaymentDate,
      liabilityType: liabilityType ?? this.liabilityType,
      interest: interest ?? this.interest,
      interestPeriod: interestPeriod ?? this.interestPeriod,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  AccountUpdate copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? iban,
    Wrapped<String?>? bic,
    Wrapped<String?>? accountNumber,
    Wrapped<String?>? openingBalance,
    Wrapped<DateTime?>? openingBalanceDate,
    Wrapped<String?>? virtualBalance,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<bool?>? includeNetWorth,
    Wrapped<enums.AccountRoleProperty?>? accountRole,
    Wrapped<enums.CreditCardTypeProperty?>? creditCardType,
    Wrapped<DateTime?>? monthlyPaymentDate,
    Wrapped<enums.LiabilityTypeProperty?>? liabilityType,
    Wrapped<String?>? interest,
    Wrapped<enums.InterestPeriodProperty?>? interestPeriod,
    Wrapped<String?>? notes,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
  }) {
    return AccountUpdate(
      name: (name != null ? name.value : this.name),
      iban: (iban != null ? iban.value : this.iban),
      bic: (bic != null ? bic.value : this.bic),
      accountNumber:
          (accountNumber != null ? accountNumber.value : this.accountNumber),
      openingBalance:
          (openingBalance != null ? openingBalance.value : this.openingBalance),
      openingBalanceDate:
          (openingBalanceDate != null
              ? openingBalanceDate.value
              : this.openingBalanceDate),
      virtualBalance:
          (virtualBalance != null ? virtualBalance.value : this.virtualBalance),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      includeNetWorth:
          (includeNetWorth != null
              ? includeNetWorth.value
              : this.includeNetWorth),
      accountRole: (accountRole != null ? accountRole.value : this.accountRole),
      creditCardType:
          (creditCardType != null ? creditCardType.value : this.creditCardType),
      monthlyPaymentDate:
          (monthlyPaymentDate != null
              ? monthlyPaymentDate.value
              : this.monthlyPaymentDate),
      liabilityType:
          (liabilityType != null ? liabilityType.value : this.liabilityType),
      interest: (interest != null ? interest.value : this.interest),
      interestPeriod:
          (interestPeriod != null ? interestPeriod.value : this.interestPeriod),
      notes: (notes != null ? notes.value : this.notes),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ArrayEntryWithCurrencyAndSum {
  const ArrayEntryWithCurrencyAndSum({
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.sum,
  });

  factory ArrayEntryWithCurrencyAndSum.fromJson(Map<String, dynamic> json) =>
      _$ArrayEntryWithCurrencyAndSumFromJson(json);

  static const toJsonFactory = _$ArrayEntryWithCurrencyAndSumToJson;
  Map<String, dynamic> toJson() => _$ArrayEntryWithCurrencyAndSumToJson(this);

  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'sum', includeIfNull: false)
  final String? sum;
  static const fromJsonFactory = _$ArrayEntryWithCurrencyAndSumFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ArrayEntryWithCurrencyAndSumExtension
    on ArrayEntryWithCurrencyAndSum {
  ArrayEntryWithCurrencyAndSum copyWith({
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? sum,
  }) {
    return ArrayEntryWithCurrencyAndSum(
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      sum: sum ?? this.sum,
    );
  }

  ArrayEntryWithCurrencyAndSum copyWithWrapped({
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? sum,
  }) {
    return ArrayEntryWithCurrencyAndSum(
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      sum: (sum != null ? sum.value : this.sum),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentProperties {
  const AttachmentProperties({
    this.createdAt,
    this.updatedAt,
    this.attachableType,
    this.attachableId,
    this.hash,
    this.filename,
    this.downloadUrl,
    this.uploadUrl,
    this.title,
    this.notes,
    this.mime,
    this.size,
  });

  factory AttachmentProperties.fromJson(Map<String, dynamic> json) =>
      _$AttachmentPropertiesFromJson(json);

  static const toJsonFactory = _$AttachmentPropertiesToJson;
  Map<String, dynamic> toJson() => _$AttachmentPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
    name: 'attachable_type',
    includeIfNull: false,
    toJson: attachableTypeNullableToJson,
    fromJson: attachableTypeNullableFromJson,
  )
  final enums.AttachableType? attachableType;
  @JsonKey(name: 'attachable_id', includeIfNull: false)
  final String? attachableId;
  @JsonKey(name: 'hash', includeIfNull: false)
  final String? hash;
  @JsonKey(name: 'filename', includeIfNull: false)
  final String? filename;
  @JsonKey(name: 'download_url', includeIfNull: false)
  final String? downloadUrl;
  @JsonKey(name: 'upload_url', includeIfNull: false)
  final String? uploadUrl;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'mime', includeIfNull: false)
  final String? mime;
  @JsonKey(name: 'size', includeIfNull: false)
  final int? size;
  static const fromJsonFactory = _$AttachmentPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentPropertiesExtension on AttachmentProperties {
  AttachmentProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    enums.AttachableType? attachableType,
    String? attachableId,
    String? hash,
    String? filename,
    String? downloadUrl,
    String? uploadUrl,
    String? title,
    String? notes,
    String? mime,
    int? size,
  }) {
    return AttachmentProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attachableType: attachableType ?? this.attachableType,
      attachableId: attachableId ?? this.attachableId,
      hash: hash ?? this.hash,
      filename: filename ?? this.filename,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      uploadUrl: uploadUrl ?? this.uploadUrl,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      mime: mime ?? this.mime,
      size: size ?? this.size,
    );
  }

  AttachmentProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<enums.AttachableType?>? attachableType,
    Wrapped<String?>? attachableId,
    Wrapped<String?>? hash,
    Wrapped<String?>? filename,
    Wrapped<String?>? downloadUrl,
    Wrapped<String?>? uploadUrl,
    Wrapped<String?>? title,
    Wrapped<String?>? notes,
    Wrapped<String?>? mime,
    Wrapped<int?>? size,
  }) {
    return AttachmentProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      attachableType:
          (attachableType != null ? attachableType.value : this.attachableType),
      attachableId:
          (attachableId != null ? attachableId.value : this.attachableId),
      hash: (hash != null ? hash.value : this.hash),
      filename: (filename != null ? filename.value : this.filename),
      downloadUrl: (downloadUrl != null ? downloadUrl.value : this.downloadUrl),
      uploadUrl: (uploadUrl != null ? uploadUrl.value : this.uploadUrl),
      title: (title != null ? title.value : this.title),
      notes: (notes != null ? notes.value : this.notes),
      mime: (mime != null ? mime.value : this.mime),
      size: (size != null ? size.value : this.size),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentRead {
  const AttachmentRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory AttachmentRead.fromJson(Map<String, dynamic> json) =>
      _$AttachmentReadFromJson(json);

  static const toJsonFactory = _$AttachmentReadToJson;
  Map<String, dynamic> toJson() => _$AttachmentReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final AttachmentProperties attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$AttachmentReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentReadExtension on AttachmentRead {
  AttachmentRead copyWith({
    String? type,
    String? id,
    AttachmentProperties? attributes,
    ObjectLink? links,
  }) {
    return AttachmentRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  AttachmentRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<AttachmentProperties>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return AttachmentRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentSingle {
  const AttachmentSingle({required this.data});

  factory AttachmentSingle.fromJson(Map<String, dynamic> json) =>
      _$AttachmentSingleFromJson(json);

  static const toJsonFactory = _$AttachmentSingleToJson;
  Map<String, dynamic> toJson() => _$AttachmentSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final AttachmentRead data;
  static const fromJsonFactory = _$AttachmentSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentSingleExtension on AttachmentSingle {
  AttachmentSingle copyWith({AttachmentRead? data}) {
    return AttachmentSingle(data: data ?? this.data);
  }

  AttachmentSingle copyWithWrapped({Wrapped<AttachmentRead>? data}) {
    return AttachmentSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentStore {
  const AttachmentStore({
    required this.filename,
    required this.attachableType,
    required this.attachableId,
    this.title,
    this.notes,
  });

  factory AttachmentStore.fromJson(Map<String, dynamic> json) =>
      _$AttachmentStoreFromJson(json);

  static const toJsonFactory = _$AttachmentStoreToJson;
  Map<String, dynamic> toJson() => _$AttachmentStoreToJson(this);

  @JsonKey(name: 'filename', includeIfNull: false)
  final String filename;
  @JsonKey(
    name: 'attachable_type',
    includeIfNull: false,
    toJson: attachableTypeToJson,
    fromJson: attachableTypeFromJson,
  )
  final enums.AttachableType attachableType;
  @JsonKey(name: 'attachable_id', includeIfNull: false)
  final String attachableId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$AttachmentStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentStoreExtension on AttachmentStore {
  AttachmentStore copyWith({
    String? filename,
    enums.AttachableType? attachableType,
    String? attachableId,
    String? title,
    String? notes,
  }) {
    return AttachmentStore(
      filename: filename ?? this.filename,
      attachableType: attachableType ?? this.attachableType,
      attachableId: attachableId ?? this.attachableId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  AttachmentStore copyWithWrapped({
    Wrapped<String>? filename,
    Wrapped<enums.AttachableType>? attachableType,
    Wrapped<String>? attachableId,
    Wrapped<String?>? title,
    Wrapped<String?>? notes,
  }) {
    return AttachmentStore(
      filename: (filename != null ? filename.value : this.filename),
      attachableType:
          (attachableType != null ? attachableType.value : this.attachableType),
      attachableId:
          (attachableId != null ? attachableId.value : this.attachableId),
      title: (title != null ? title.value : this.title),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AttachmentUpdate {
  const AttachmentUpdate({this.filename, this.title, this.notes});

  factory AttachmentUpdate.fromJson(Map<String, dynamic> json) =>
      _$AttachmentUpdateFromJson(json);

  static const toJsonFactory = _$AttachmentUpdateToJson;
  Map<String, dynamic> toJson() => _$AttachmentUpdateToJson(this);

  @JsonKey(name: 'filename', includeIfNull: false)
  final String? filename;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$AttachmentUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AttachmentUpdateExtension on AttachmentUpdate {
  AttachmentUpdate copyWith({String? filename, String? title, String? notes}) {
    return AttachmentUpdate(
      filename: filename ?? this.filename,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  AttachmentUpdate copyWithWrapped({
    Wrapped<String?>? filename,
    Wrapped<String?>? title,
    Wrapped<String?>? notes,
  }) {
    return AttachmentUpdate(
      filename: (filename != null ? filename.value : this.filename),
      title: (title != null ? title.value : this.title),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AvailableBudgetProperties {
  const AvailableBudgetProperties({
    this.createdAt,
    this.updatedAt,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.amount,
    this.pcAmount,
    this.start,
    this.end,
    this.spentInBudgets,
    this.pcSpentInBudgets,
    this.spentOutsideBudgets,
    this.pcSpentOutsideBudgets,
  });

  factory AvailableBudgetProperties.fromJson(Map<String, dynamic> json) =>
      _$AvailableBudgetPropertiesFromJson(json);

  static const toJsonFactory = _$AvailableBudgetPropertiesToJson;
  Map<String, dynamic> toJson() => _$AvailableBudgetPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime? start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime? end;
  @JsonKey(
    name: 'spent_in_budgets',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? spentInBudgets;
  @JsonKey(
    name: 'pc_spent_in_budgets',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcSpentInBudgets;
  @JsonKey(
    name: 'spent_outside_budgets',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? spentOutsideBudgets;
  @JsonKey(
    name: 'pc_spent_outside_budgets',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcSpentOutsideBudgets;
  static const fromJsonFactory = _$AvailableBudgetPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AvailableBudgetPropertiesExtension on AvailableBudgetProperties {
  AvailableBudgetProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amount,
    String? pcAmount,
    DateTime? start,
    DateTime? end,
    List<ArrayEntryWithCurrencyAndSum>? spentInBudgets,
    List<ArrayEntryWithCurrencyAndSum>? pcSpentInBudgets,
    List<ArrayEntryWithCurrencyAndSum>? spentOutsideBudgets,
    List<ArrayEntryWithCurrencyAndSum>? pcSpentOutsideBudgets,
  }) {
    return AvailableBudgetProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      start: start ?? this.start,
      end: end ?? this.end,
      spentInBudgets: spentInBudgets ?? this.spentInBudgets,
      pcSpentInBudgets: pcSpentInBudgets ?? this.pcSpentInBudgets,
      spentOutsideBudgets: spentOutsideBudgets ?? this.spentOutsideBudgets,
      pcSpentOutsideBudgets:
          pcSpentOutsideBudgets ?? this.pcSpentOutsideBudgets,
    );
  }

  AvailableBudgetProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<DateTime?>? start,
    Wrapped<DateTime?>? end,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? spentInBudgets,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcSpentInBudgets,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? spentOutsideBudgets,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcSpentOutsideBudgets,
  }) {
    return AvailableBudgetProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      spentInBudgets:
          (spentInBudgets != null ? spentInBudgets.value : this.spentInBudgets),
      pcSpentInBudgets:
          (pcSpentInBudgets != null
              ? pcSpentInBudgets.value
              : this.pcSpentInBudgets),
      spentOutsideBudgets:
          (spentOutsideBudgets != null
              ? spentOutsideBudgets.value
              : this.spentOutsideBudgets),
      pcSpentOutsideBudgets:
          (pcSpentOutsideBudgets != null
              ? pcSpentOutsideBudgets.value
              : this.pcSpentOutsideBudgets),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AvailableBudgetRead {
  const AvailableBudgetRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory AvailableBudgetRead.fromJson(Map<String, dynamic> json) =>
      _$AvailableBudgetReadFromJson(json);

  static const toJsonFactory = _$AvailableBudgetReadToJson;
  Map<String, dynamic> toJson() => _$AvailableBudgetReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final AvailableBudgetProperties attributes;
  static const fromJsonFactory = _$AvailableBudgetReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AvailableBudgetReadExtension on AvailableBudgetRead {
  AvailableBudgetRead copyWith({
    String? type,
    String? id,
    AvailableBudgetProperties? attributes,
  }) {
    return AvailableBudgetRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  AvailableBudgetRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<AvailableBudgetProperties>? attributes,
  }) {
    return AvailableBudgetRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AvailableBudgetSingle {
  const AvailableBudgetSingle({required this.data});

  factory AvailableBudgetSingle.fromJson(Map<String, dynamic> json) =>
      _$AvailableBudgetSingleFromJson(json);

  static const toJsonFactory = _$AvailableBudgetSingleToJson;
  Map<String, dynamic> toJson() => _$AvailableBudgetSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final AvailableBudgetRead data;
  static const fromJsonFactory = _$AvailableBudgetSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AvailableBudgetSingleExtension on AvailableBudgetSingle {
  AvailableBudgetSingle copyWith({AvailableBudgetRead? data}) {
    return AvailableBudgetSingle(data: data ?? this.data);
  }

  AvailableBudgetSingle copyWithWrapped({Wrapped<AvailableBudgetRead>? data}) {
    return AvailableBudgetSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class BillProperties {
  const BillProperties({
    this.createdAt,
    this.updatedAt,
    this.name,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.amountMin,
    this.pcAmountMin,
    this.amountMax,
    this.pcAmountMax,
    this.amountAvg,
    this.pcAmountAvg,
    this.date,
    this.endDate,
    this.extensionDate,
    this.repeatFreq,
    this.skip,
    this.active,
    this.order,
    this.notes,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
    this.paidDates,
    this.payDates,
    this.nextExpectedMatch,
    this.nextExpectedMatchDiff,
  });

  factory BillProperties.fromJson(Map<String, dynamic> json) =>
      _$BillPropertiesFromJson(json);

  static const toJsonFactory = _$BillPropertiesToJson;
  Map<String, dynamic> toJson() => _$BillPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount_min', includeIfNull: false)
  final String? amountMin;
  @JsonKey(name: 'pc_amount_min', includeIfNull: false)
  final String? pcAmountMin;
  @JsonKey(name: 'amount_max', includeIfNull: false)
  final String? amountMax;
  @JsonKey(name: 'pc_amount_max', includeIfNull: false)
  final String? pcAmountMax;
  @JsonKey(name: 'amount_avg', includeIfNull: false)
  final String? amountAvg;
  @JsonKey(name: 'pc_amount_avg', includeIfNull: false)
  final String? pcAmountAvg;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'extension_date', includeIfNull: false)
  final DateTime? extensionDate;
  @JsonKey(
    name: 'repeat_freq',
    includeIfNull: false,
    toJson: billRepeatFrequencyNullableToJson,
    fromJson: billRepeatFrequencyNullableFromJson,
  )
  final enums.BillRepeatFrequency? repeatFreq;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_order', includeIfNull: false)
  final int? objectGroupOrder;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  @JsonKey(name: 'paid_dates', includeIfNull: false)
  final List<BillProperties$PaidDates$Item>? paidDates;
  @JsonKey(name: 'pay_dates', includeIfNull: false, defaultValue: <DateTime>[])
  final List<DateTime>? payDates;
  @JsonKey(name: 'next_expected_match', includeIfNull: false)
  final DateTime? nextExpectedMatch;
  @JsonKey(name: 'next_expected_match_diff', includeIfNull: false)
  final String? nextExpectedMatchDiff;
  static const fromJsonFactory = _$BillPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillPropertiesExtension on BillProperties {
  BillProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amountMin,
    String? pcAmountMin,
    String? amountMax,
    String? pcAmountMax,
    String? amountAvg,
    String? pcAmountAvg,
    DateTime? date,
    DateTime? endDate,
    DateTime? extensionDate,
    enums.BillRepeatFrequency? repeatFreq,
    int? skip,
    bool? active,
    int? order,
    String? notes,
    String? objectGroupId,
    int? objectGroupOrder,
    String? objectGroupTitle,
    List<BillProperties$PaidDates$Item>? paidDates,
    List<DateTime>? payDates,
    DateTime? nextExpectedMatch,
    String? nextExpectedMatchDiff,
  }) {
    return BillProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amountMin: amountMin ?? this.amountMin,
      pcAmountMin: pcAmountMin ?? this.pcAmountMin,
      amountMax: amountMax ?? this.amountMax,
      pcAmountMax: pcAmountMax ?? this.pcAmountMax,
      amountAvg: amountAvg ?? this.amountAvg,
      pcAmountAvg: pcAmountAvg ?? this.pcAmountAvg,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      extensionDate: extensionDate ?? this.extensionDate,
      repeatFreq: repeatFreq ?? this.repeatFreq,
      skip: skip ?? this.skip,
      active: active ?? this.active,
      order: order ?? this.order,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupOrder: objectGroupOrder ?? this.objectGroupOrder,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
      paidDates: paidDates ?? this.paidDates,
      payDates: payDates ?? this.payDates,
      nextExpectedMatch: nextExpectedMatch ?? this.nextExpectedMatch,
      nextExpectedMatchDiff:
          nextExpectedMatchDiff ?? this.nextExpectedMatchDiff,
    );
  }

  BillProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? name,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? amountMin,
    Wrapped<String?>? pcAmountMin,
    Wrapped<String?>? amountMax,
    Wrapped<String?>? pcAmountMax,
    Wrapped<String?>? amountAvg,
    Wrapped<String?>? pcAmountAvg,
    Wrapped<DateTime?>? date,
    Wrapped<DateTime?>? endDate,
    Wrapped<DateTime?>? extensionDate,
    Wrapped<enums.BillRepeatFrequency?>? repeatFreq,
    Wrapped<int?>? skip,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<int?>? objectGroupOrder,
    Wrapped<String?>? objectGroupTitle,
    Wrapped<List<BillProperties$PaidDates$Item>?>? paidDates,
    Wrapped<List<DateTime>?>? payDates,
    Wrapped<DateTime?>? nextExpectedMatch,
    Wrapped<String?>? nextExpectedMatchDiff,
  }) {
    return BillProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amountMin: (amountMin != null ? amountMin.value : this.amountMin),
      pcAmountMin: (pcAmountMin != null ? pcAmountMin.value : this.pcAmountMin),
      amountMax: (amountMax != null ? amountMax.value : this.amountMax),
      pcAmountMax: (pcAmountMax != null ? pcAmountMax.value : this.pcAmountMax),
      amountAvg: (amountAvg != null ? amountAvg.value : this.amountAvg),
      pcAmountAvg: (pcAmountAvg != null ? pcAmountAvg.value : this.pcAmountAvg),
      date: (date != null ? date.value : this.date),
      endDate: (endDate != null ? endDate.value : this.endDate),
      extensionDate:
          (extensionDate != null ? extensionDate.value : this.extensionDate),
      repeatFreq: (repeatFreq != null ? repeatFreq.value : this.repeatFreq),
      skip: (skip != null ? skip.value : this.skip),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupOrder:
          (objectGroupOrder != null
              ? objectGroupOrder.value
              : this.objectGroupOrder),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
      paidDates: (paidDates != null ? paidDates.value : this.paidDates),
      payDates: (payDates != null ? payDates.value : this.payDates),
      nextExpectedMatch:
          (nextExpectedMatch != null
              ? nextExpectedMatch.value
              : this.nextExpectedMatch),
      nextExpectedMatchDiff:
          (nextExpectedMatchDiff != null
              ? nextExpectedMatchDiff.value
              : this.nextExpectedMatchDiff),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BillRead {
  const BillRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BillRead.fromJson(Map<String, dynamic> json) =>
      _$BillReadFromJson(json);

  static const toJsonFactory = _$BillReadToJson;
  Map<String, dynamic> toJson() => _$BillReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final BillProperties attributes;
  static const fromJsonFactory = _$BillReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillReadExtension on BillRead {
  BillRead copyWith({String? type, String? id, BillProperties? attributes}) {
    return BillRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  BillRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<BillProperties>? attributes,
  }) {
    return BillRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BillSingle {
  const BillSingle({required this.data});

  factory BillSingle.fromJson(Map<String, dynamic> json) =>
      _$BillSingleFromJson(json);

  static const toJsonFactory = _$BillSingleToJson;
  Map<String, dynamic> toJson() => _$BillSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final BillRead data;
  static const fromJsonFactory = _$BillSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillSingleExtension on BillSingle {
  BillSingle copyWith({BillRead? data}) {
    return BillSingle(data: data ?? this.data);
  }

  BillSingle copyWithWrapped({Wrapped<BillRead>? data}) {
    return BillSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class BillStore {
  const BillStore({
    this.currencyId,
    this.currencyCode,
    required this.name,
    required this.amountMin,
    required this.amountMax,
    required this.date,
    this.endDate,
    this.extensionDate,
    required this.repeatFreq,
    this.skip,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory BillStore.fromJson(Map<String, dynamic> json) =>
      _$BillStoreFromJson(json);

  static const toJsonFactory = _$BillStoreToJson;
  Map<String, dynamic> toJson() => _$BillStoreToJson(this);

  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'amount_min', includeIfNull: false)
  final String amountMin;
  @JsonKey(name: 'amount_max', includeIfNull: false)
  final String amountMax;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime date;
  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'extension_date', includeIfNull: false)
  final DateTime? extensionDate;
  @JsonKey(
    name: 'repeat_freq',
    includeIfNull: false,
    toJson: billRepeatFrequencyToJson,
    fromJson: billRepeatFrequencyFromJson,
  )
  final enums.BillRepeatFrequency repeatFreq;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$BillStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillStoreExtension on BillStore {
  BillStore copyWith({
    String? currencyId,
    String? currencyCode,
    String? name,
    String? amountMin,
    String? amountMax,
    DateTime? date,
    DateTime? endDate,
    DateTime? extensionDate,
    enums.BillRepeatFrequency? repeatFreq,
    int? skip,
    bool? active,
    String? notes,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return BillStore(
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      name: name ?? this.name,
      amountMin: amountMin ?? this.amountMin,
      amountMax: amountMax ?? this.amountMax,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      extensionDate: extensionDate ?? this.extensionDate,
      repeatFreq: repeatFreq ?? this.repeatFreq,
      skip: skip ?? this.skip,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  BillStore copyWithWrapped({
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String>? name,
    Wrapped<String>? amountMin,
    Wrapped<String>? amountMax,
    Wrapped<DateTime>? date,
    Wrapped<DateTime?>? endDate,
    Wrapped<DateTime?>? extensionDate,
    Wrapped<enums.BillRepeatFrequency>? repeatFreq,
    Wrapped<int?>? skip,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return BillStore(
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      name: (name != null ? name.value : this.name),
      amountMin: (amountMin != null ? amountMin.value : this.amountMin),
      amountMax: (amountMax != null ? amountMax.value : this.amountMax),
      date: (date != null ? date.value : this.date),
      endDate: (endDate != null ? endDate.value : this.endDate),
      extensionDate:
          (extensionDate != null ? extensionDate.value : this.extensionDate),
      repeatFreq: (repeatFreq != null ? repeatFreq.value : this.repeatFreq),
      skip: (skip != null ? skip.value : this.skip),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BillUpdate {
  const BillUpdate({
    this.currencyId,
    this.currencyCode,
    required this.name,
    this.amountMin,
    this.amountMax,
    this.date,
    this.endDate,
    this.extensionDate,
    this.repeatFreq,
    this.skip,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory BillUpdate.fromJson(Map<String, dynamic> json) =>
      _$BillUpdateFromJson(json);

  static const toJsonFactory = _$BillUpdateToJson;
  Map<String, dynamic> toJson() => _$BillUpdateToJson(this);

  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'amount_min', includeIfNull: false)
  final String? amountMin;
  @JsonKey(name: 'amount_max', includeIfNull: false)
  final String? amountMax;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'extension_date', includeIfNull: false)
  final DateTime? extensionDate;
  @JsonKey(
    name: 'repeat_freq',
    includeIfNull: false,
    toJson: billRepeatFrequencyNullableToJson,
    fromJson: billRepeatFrequencyNullableFromJson,
  )
  final enums.BillRepeatFrequency? repeatFreq;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$BillUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillUpdateExtension on BillUpdate {
  BillUpdate copyWith({
    String? currencyId,
    String? currencyCode,
    String? name,
    String? amountMin,
    String? amountMax,
    DateTime? date,
    DateTime? endDate,
    DateTime? extensionDate,
    enums.BillRepeatFrequency? repeatFreq,
    int? skip,
    bool? active,
    String? notes,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return BillUpdate(
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      name: name ?? this.name,
      amountMin: amountMin ?? this.amountMin,
      amountMax: amountMax ?? this.amountMax,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      extensionDate: extensionDate ?? this.extensionDate,
      repeatFreq: repeatFreq ?? this.repeatFreq,
      skip: skip ?? this.skip,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  BillUpdate copyWithWrapped({
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String>? name,
    Wrapped<String?>? amountMin,
    Wrapped<String?>? amountMax,
    Wrapped<DateTime?>? date,
    Wrapped<DateTime?>? endDate,
    Wrapped<DateTime?>? extensionDate,
    Wrapped<enums.BillRepeatFrequency?>? repeatFreq,
    Wrapped<int?>? skip,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return BillUpdate(
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      name: (name != null ? name.value : this.name),
      amountMin: (amountMin != null ? amountMin.value : this.amountMin),
      amountMax: (amountMax != null ? amountMax.value : this.amountMax),
      date: (date != null ? date.value : this.date),
      endDate: (endDate != null ? endDate.value : this.endDate),
      extensionDate:
          (extensionDate != null ? extensionDate.value : this.extensionDate),
      repeatFreq: (repeatFreq != null ? repeatFreq.value : this.repeatFreq),
      skip: (skip != null ? skip.value : this.skip),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetProperties {
  const BudgetProperties({
    this.createdAt,
    this.updatedAt,
    this.active,
    required this.name,
    this.order,
    this.notes,
    this.autoBudgetType,
    this.autoBudgetPeriod,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.autoBudgetAmount,
    this.pcAutoBudgetAmount,
    this.spent,
    this.pcSpent,
  });

  factory BudgetProperties.fromJson(Map<String, dynamic> json) =>
      _$BudgetPropertiesFromJson(json);

  static const toJsonFactory = _$BudgetPropertiesToJson;
  Map<String, dynamic> toJson() => _$BudgetPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'auto_budget_type',
    includeIfNull: false,
    toJson: autoBudgetTypeNullableToJson,
    fromJson: autoBudgetTypeNullableFromJson,
  )
  final enums.AutoBudgetType? autoBudgetType;
  @JsonKey(
    name: 'auto_budget_period',
    includeIfNull: false,
    toJson: autoBudgetPeriodNullableToJson,
    fromJson: autoBudgetPeriodNullableFromJson,
  )
  final enums.AutoBudgetPeriod? autoBudgetPeriod;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_order', includeIfNull: false)
  final int? objectGroupOrder;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'auto_budget_amount', includeIfNull: false)
  final String? autoBudgetAmount;
  @JsonKey(name: 'pc_auto_budget_amount', includeIfNull: false)
  final String? pcAutoBudgetAmount;
  @JsonKey(
    name: 'spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? spent;
  @JsonKey(
    name: 'pc_spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcSpent;
  static const fromJsonFactory = _$BudgetPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetPropertiesExtension on BudgetProperties {
  BudgetProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? active,
    String? name,
    int? order,
    String? notes,
    enums.AutoBudgetType? autoBudgetType,
    enums.AutoBudgetPeriod? autoBudgetPeriod,
    String? objectGroupId,
    int? objectGroupOrder,
    String? objectGroupTitle,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? autoBudgetAmount,
    String? pcAutoBudgetAmount,
    List<ArrayEntryWithCurrencyAndSum>? spent,
    List<ArrayEntryWithCurrencyAndSum>? pcSpent,
  }) {
    return BudgetProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      active: active ?? this.active,
      name: name ?? this.name,
      order: order ?? this.order,
      notes: notes ?? this.notes,
      autoBudgetType: autoBudgetType ?? this.autoBudgetType,
      autoBudgetPeriod: autoBudgetPeriod ?? this.autoBudgetPeriod,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupOrder: objectGroupOrder ?? this.objectGroupOrder,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      autoBudgetAmount: autoBudgetAmount ?? this.autoBudgetAmount,
      pcAutoBudgetAmount: pcAutoBudgetAmount ?? this.pcAutoBudgetAmount,
      spent: spent ?? this.spent,
      pcSpent: pcSpent ?? this.pcSpent,
    );
  }

  BudgetProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? active,
    Wrapped<String>? name,
    Wrapped<int?>? order,
    Wrapped<String?>? notes,
    Wrapped<enums.AutoBudgetType?>? autoBudgetType,
    Wrapped<enums.AutoBudgetPeriod?>? autoBudgetPeriod,
    Wrapped<String?>? objectGroupId,
    Wrapped<int?>? objectGroupOrder,
    Wrapped<String?>? objectGroupTitle,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? autoBudgetAmount,
    Wrapped<String?>? pcAutoBudgetAmount,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? spent,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcSpent,
  }) {
    return BudgetProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      active: (active != null ? active.value : this.active),
      name: (name != null ? name.value : this.name),
      order: (order != null ? order.value : this.order),
      notes: (notes != null ? notes.value : this.notes),
      autoBudgetType:
          (autoBudgetType != null ? autoBudgetType.value : this.autoBudgetType),
      autoBudgetPeriod:
          (autoBudgetPeriod != null
              ? autoBudgetPeriod.value
              : this.autoBudgetPeriod),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupOrder:
          (objectGroupOrder != null
              ? objectGroupOrder.value
              : this.objectGroupOrder),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      autoBudgetAmount:
          (autoBudgetAmount != null
              ? autoBudgetAmount.value
              : this.autoBudgetAmount),
      pcAutoBudgetAmount:
          (pcAutoBudgetAmount != null
              ? pcAutoBudgetAmount.value
              : this.pcAutoBudgetAmount),
      spent: (spent != null ? spent.value : this.spent),
      pcSpent: (pcSpent != null ? pcSpent.value : this.pcSpent),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetRead {
  const BudgetRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BudgetRead.fromJson(Map<String, dynamic> json) =>
      _$BudgetReadFromJson(json);

  static const toJsonFactory = _$BudgetReadToJson;
  Map<String, dynamic> toJson() => _$BudgetReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final BudgetProperties attributes;
  static const fromJsonFactory = _$BudgetReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetReadExtension on BudgetRead {
  BudgetRead copyWith({
    String? type,
    String? id,
    BudgetProperties? attributes,
  }) {
    return BudgetRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  BudgetRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<BudgetProperties>? attributes,
  }) {
    return BudgetRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetSingle {
  const BudgetSingle({required this.data});

  factory BudgetSingle.fromJson(Map<String, dynamic> json) =>
      _$BudgetSingleFromJson(json);

  static const toJsonFactory = _$BudgetSingleToJson;
  Map<String, dynamic> toJson() => _$BudgetSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final BudgetRead data;
  static const fromJsonFactory = _$BudgetSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetSingleExtension on BudgetSingle {
  BudgetSingle copyWith({BudgetRead? data}) {
    return BudgetSingle(data: data ?? this.data);
  }

  BudgetSingle copyWithWrapped({Wrapped<BudgetRead>? data}) {
    return BudgetSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetStore {
  const BudgetStore({
    required this.name,
    this.active,
    this.order,
    this.notes,
    this.autoBudgetType,
    this.autoBudgetCurrencyId,
    this.autoBudgetCurrencyCode,
    this.autoBudgetAmount,
    this.autoBudgetPeriod,
  });

  factory BudgetStore.fromJson(Map<String, dynamic> json) =>
      _$BudgetStoreFromJson(json);

  static const toJsonFactory = _$BudgetStoreToJson;
  Map<String, dynamic> toJson() => _$BudgetStoreToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'auto_budget_type',
    includeIfNull: false,
    toJson: autoBudgetTypeNullableToJson,
    fromJson: autoBudgetTypeNullableFromJson,
  )
  final enums.AutoBudgetType? autoBudgetType;
  @JsonKey(name: 'auto_budget_currency_id', includeIfNull: false)
  final String? autoBudgetCurrencyId;
  @JsonKey(name: 'auto_budget_currency_code', includeIfNull: false)
  final String? autoBudgetCurrencyCode;
  @JsonKey(name: 'auto_budget_amount', includeIfNull: false)
  final String? autoBudgetAmount;
  @JsonKey(
    name: 'auto_budget_period',
    includeIfNull: false,
    toJson: autoBudgetPeriodNullableToJson,
    fromJson: autoBudgetPeriodNullableFromJson,
  )
  final enums.AutoBudgetPeriod? autoBudgetPeriod;
  static const fromJsonFactory = _$BudgetStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetStoreExtension on BudgetStore {
  BudgetStore copyWith({
    String? name,
    bool? active,
    int? order,
    String? notes,
    enums.AutoBudgetType? autoBudgetType,
    String? autoBudgetCurrencyId,
    String? autoBudgetCurrencyCode,
    String? autoBudgetAmount,
    enums.AutoBudgetPeriod? autoBudgetPeriod,
  }) {
    return BudgetStore(
      name: name ?? this.name,
      active: active ?? this.active,
      order: order ?? this.order,
      notes: notes ?? this.notes,
      autoBudgetType: autoBudgetType ?? this.autoBudgetType,
      autoBudgetCurrencyId: autoBudgetCurrencyId ?? this.autoBudgetCurrencyId,
      autoBudgetCurrencyCode:
          autoBudgetCurrencyCode ?? this.autoBudgetCurrencyCode,
      autoBudgetAmount: autoBudgetAmount ?? this.autoBudgetAmount,
      autoBudgetPeriod: autoBudgetPeriod ?? this.autoBudgetPeriod,
    );
  }

  BudgetStore copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<String?>? notes,
    Wrapped<enums.AutoBudgetType?>? autoBudgetType,
    Wrapped<String?>? autoBudgetCurrencyId,
    Wrapped<String?>? autoBudgetCurrencyCode,
    Wrapped<String?>? autoBudgetAmount,
    Wrapped<enums.AutoBudgetPeriod?>? autoBudgetPeriod,
  }) {
    return BudgetStore(
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      notes: (notes != null ? notes.value : this.notes),
      autoBudgetType:
          (autoBudgetType != null ? autoBudgetType.value : this.autoBudgetType),
      autoBudgetCurrencyId:
          (autoBudgetCurrencyId != null
              ? autoBudgetCurrencyId.value
              : this.autoBudgetCurrencyId),
      autoBudgetCurrencyCode:
          (autoBudgetCurrencyCode != null
              ? autoBudgetCurrencyCode.value
              : this.autoBudgetCurrencyCode),
      autoBudgetAmount:
          (autoBudgetAmount != null
              ? autoBudgetAmount.value
              : this.autoBudgetAmount),
      autoBudgetPeriod:
          (autoBudgetPeriod != null
              ? autoBudgetPeriod.value
              : this.autoBudgetPeriod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetUpdate {
  const BudgetUpdate({
    required this.name,
    this.active,
    this.order,
    this.notes,
    this.autoBudgetType,
    this.autoBudgetCurrencyId,
    this.autoBudgetCurrencyCode,
    this.autoBudgetAmount,
    this.autoBudgetPeriod,
  });

  factory BudgetUpdate.fromJson(Map<String, dynamic> json) =>
      _$BudgetUpdateFromJson(json);

  static const toJsonFactory = _$BudgetUpdateToJson;
  Map<String, dynamic> toJson() => _$BudgetUpdateToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'auto_budget_type',
    includeIfNull: false,
    toJson: autoBudgetTypeNullableToJson,
    fromJson: autoBudgetTypeNullableFromJson,
  )
  final enums.AutoBudgetType? autoBudgetType;
  @JsonKey(name: 'auto_budget_currency_id', includeIfNull: false)
  final String? autoBudgetCurrencyId;
  @JsonKey(name: 'auto_budget_currency_code', includeIfNull: false)
  final String? autoBudgetCurrencyCode;
  @JsonKey(name: 'auto_budget_amount', includeIfNull: false)
  final String? autoBudgetAmount;
  @JsonKey(
    name: 'auto_budget_period',
    includeIfNull: false,
    toJson: autoBudgetPeriodNullableToJson,
    fromJson: autoBudgetPeriodNullableFromJson,
  )
  final enums.AutoBudgetPeriod? autoBudgetPeriod;
  static const fromJsonFactory = _$BudgetUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetUpdateExtension on BudgetUpdate {
  BudgetUpdate copyWith({
    String? name,
    bool? active,
    int? order,
    String? notes,
    enums.AutoBudgetType? autoBudgetType,
    String? autoBudgetCurrencyId,
    String? autoBudgetCurrencyCode,
    String? autoBudgetAmount,
    enums.AutoBudgetPeriod? autoBudgetPeriod,
  }) {
    return BudgetUpdate(
      name: name ?? this.name,
      active: active ?? this.active,
      order: order ?? this.order,
      notes: notes ?? this.notes,
      autoBudgetType: autoBudgetType ?? this.autoBudgetType,
      autoBudgetCurrencyId: autoBudgetCurrencyId ?? this.autoBudgetCurrencyId,
      autoBudgetCurrencyCode:
          autoBudgetCurrencyCode ?? this.autoBudgetCurrencyCode,
      autoBudgetAmount: autoBudgetAmount ?? this.autoBudgetAmount,
      autoBudgetPeriod: autoBudgetPeriod ?? this.autoBudgetPeriod,
    );
  }

  BudgetUpdate copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<bool?>? active,
    Wrapped<int?>? order,
    Wrapped<String?>? notes,
    Wrapped<enums.AutoBudgetType?>? autoBudgetType,
    Wrapped<String?>? autoBudgetCurrencyId,
    Wrapped<String?>? autoBudgetCurrencyCode,
    Wrapped<String?>? autoBudgetAmount,
    Wrapped<enums.AutoBudgetPeriod?>? autoBudgetPeriod,
  }) {
    return BudgetUpdate(
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
      order: (order != null ? order.value : this.order),
      notes: (notes != null ? notes.value : this.notes),
      autoBudgetType:
          (autoBudgetType != null ? autoBudgetType.value : this.autoBudgetType),
      autoBudgetCurrencyId:
          (autoBudgetCurrencyId != null
              ? autoBudgetCurrencyId.value
              : this.autoBudgetCurrencyId),
      autoBudgetCurrencyCode:
          (autoBudgetCurrencyCode != null
              ? autoBudgetCurrencyCode.value
              : this.autoBudgetCurrencyCode),
      autoBudgetAmount:
          (autoBudgetAmount != null
              ? autoBudgetAmount.value
              : this.autoBudgetAmount),
      autoBudgetPeriod:
          (autoBudgetPeriod != null
              ? autoBudgetPeriod.value
              : this.autoBudgetPeriod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitProperties {
  const BudgetLimitProperties({
    this.createdAt,
    this.updatedAt,
    this.start,
    this.end,
    this.budgetId,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.amount,
    this.pcAmount,
    this.period,
    this.spent,
    this.pcSpent,
    this.notes,
  });

  factory BudgetLimitProperties.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitPropertiesFromJson(json);

  static const toJsonFactory = _$BudgetLimitPropertiesToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime? start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime? end;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'period', includeIfNull: false)
  final String? period;
  @JsonKey(
    name: 'spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? spent;
  @JsonKey(
    name: 'pc_spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcSpent;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$BudgetLimitPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitPropertiesExtension on BudgetLimitProperties {
  BudgetLimitProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? start,
    DateTime? end,
    String? budgetId,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amount,
    String? pcAmount,
    String? period,
    List<ArrayEntryWithCurrencyAndSum>? spent,
    List<ArrayEntryWithCurrencyAndSum>? pcSpent,
    String? notes,
  }) {
    return BudgetLimitProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      start: start ?? this.start,
      end: end ?? this.end,
      budgetId: budgetId ?? this.budgetId,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      period: period ?? this.period,
      spent: spent ?? this.spent,
      pcSpent: pcSpent ?? this.pcSpent,
      notes: notes ?? this.notes,
    );
  }

  BudgetLimitProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? start,
    Wrapped<DateTime?>? end,
    Wrapped<String?>? budgetId,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<String?>? period,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? spent,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcSpent,
    Wrapped<String?>? notes,
  }) {
    return BudgetLimitProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      period: (period != null ? period.value : this.period),
      spent: (spent != null ? spent.value : this.spent),
      pcSpent: (pcSpent != null ? pcSpent.value : this.pcSpent),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitRead {
  const BudgetLimitRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BudgetLimitRead.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitReadFromJson(json);

  static const toJsonFactory = _$BudgetLimitReadToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final BudgetLimitProperties attributes;
  static const fromJsonFactory = _$BudgetLimitReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitReadExtension on BudgetLimitRead {
  BudgetLimitRead copyWith({
    String? type,
    String? id,
    BudgetLimitProperties? attributes,
  }) {
    return BudgetLimitRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  BudgetLimitRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<BudgetLimitProperties>? attributes,
  }) {
    return BudgetLimitRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitSingle {
  const BudgetLimitSingle({required this.data});

  factory BudgetLimitSingle.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitSingleFromJson(json);

  static const toJsonFactory = _$BudgetLimitSingleToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final BudgetLimitRead data;
  static const fromJsonFactory = _$BudgetLimitSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitSingleExtension on BudgetLimitSingle {
  BudgetLimitSingle copyWith({BudgetLimitRead? data}) {
    return BudgetLimitSingle(data: data ?? this.data);
  }

  BudgetLimitSingle copyWithWrapped({Wrapped<BudgetLimitRead>? data}) {
    return BudgetLimitSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitStore {
  const BudgetLimitStore({
    this.currencyId,
    this.currencyCode,
    this.budgetId,
    required this.start,
    this.period,
    required this.end,
    required this.amount,
    this.notes,
  });

  factory BudgetLimitStore.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitStoreFromJson(json);

  static const toJsonFactory = _$BudgetLimitStoreToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitStoreToJson(this);

  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'start', includeIfNull: false, toJson: _dateToJson)
  final DateTime start;
  @JsonKey(name: 'period', includeIfNull: false)
  final String? period;
  @JsonKey(name: 'end', includeIfNull: false, toJson: _dateToJson)
  final DateTime end;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$BudgetLimitStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitStoreExtension on BudgetLimitStore {
  BudgetLimitStore copyWith({
    String? currencyId,
    String? currencyCode,
    String? budgetId,
    DateTime? start,
    String? period,
    DateTime? end,
    String? amount,
    String? notes,
  }) {
    return BudgetLimitStore(
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      budgetId: budgetId ?? this.budgetId,
      start: start ?? this.start,
      period: period ?? this.period,
      end: end ?? this.end,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
    );
  }

  BudgetLimitStore copyWithWrapped({
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? budgetId,
    Wrapped<DateTime>? start,
    Wrapped<String?>? period,
    Wrapped<DateTime>? end,
    Wrapped<String>? amount,
    Wrapped<String?>? notes,
  }) {
    return BudgetLimitStore(
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      start: (start != null ? start.value : this.start),
      period: (period != null ? period.value : this.period),
      end: (end != null ? end.value : this.end),
      amount: (amount != null ? amount.value : this.amount),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitUpdate {
  const BudgetLimitUpdate({
    this.createdAt,
    this.updatedAt,
    this.start,
    this.end,
    this.budgetId,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.period,
    this.amount,
    this.pcAmount,
    this.spent,
    this.notes,
  });

  factory BudgetLimitUpdate.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitUpdateFromJson(json);

  static const toJsonFactory = _$BudgetLimitUpdateToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitUpdateToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime? start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime? end;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'period', includeIfNull: false)
  final String? period;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'spent', includeIfNull: false)
  final String? spent;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$BudgetLimitUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitUpdateExtension on BudgetLimitUpdate {
  BudgetLimitUpdate copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? start,
    DateTime? end,
    String? budgetId,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? period,
    String? amount,
    String? pcAmount,
    String? spent,
    String? notes,
  }) {
    return BudgetLimitUpdate(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      start: start ?? this.start,
      end: end ?? this.end,
      budgetId: budgetId ?? this.budgetId,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      period: period ?? this.period,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      spent: spent ?? this.spent,
      notes: notes ?? this.notes,
    );
  }

  BudgetLimitUpdate copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? start,
    Wrapped<DateTime?>? end,
    Wrapped<String?>? budgetId,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? period,
    Wrapped<String?>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<String?>? spent,
    Wrapped<String?>? notes,
  }) {
    return BudgetLimitUpdate(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      period: (period != null ? period.value : this.period),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      spent: (spent != null ? spent.value : this.spent),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryProperties {
  const CategoryProperties({
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.notes,
    this.objectHasCurrencySetting,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.spent,
    this.pcSpent,
    this.earned,
    this.pcEarned,
    this.transferred,
    this.pcTransferred,
  });

  factory CategoryProperties.fromJson(Map<String, dynamic> json) =>
      _$CategoryPropertiesFromJson(json);

  static const toJsonFactory = _$CategoryPropertiesToJson;
  Map<String, dynamic> toJson() => _$CategoryPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(
    name: 'spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? spent;
  @JsonKey(
    name: 'pc_spent',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcSpent;
  @JsonKey(
    name: 'earned',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? earned;
  @JsonKey(
    name: 'pc_earned',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcEarned;
  @JsonKey(
    name: 'transferred',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? transferred;
  @JsonKey(
    name: 'pc_transferred',
    includeIfNull: false,
    defaultValue: <ArrayEntryWithCurrencyAndSum>[],
  )
  final List<ArrayEntryWithCurrencyAndSum>? pcTransferred;
  static const fromJsonFactory = _$CategoryPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategoryPropertiesExtension on CategoryProperties {
  CategoryProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? notes,
    bool? objectHasCurrencySetting,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    List<ArrayEntryWithCurrencyAndSum>? spent,
    List<ArrayEntryWithCurrencyAndSum>? pcSpent,
    List<ArrayEntryWithCurrencyAndSum>? earned,
    List<ArrayEntryWithCurrencyAndSum>? pcEarned,
    List<ArrayEntryWithCurrencyAndSum>? transferred,
    List<ArrayEntryWithCurrencyAndSum>? pcTransferred,
  }) {
    return CategoryProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      spent: spent ?? this.spent,
      pcSpent: pcSpent ?? this.pcSpent,
      earned: earned ?? this.earned,
      pcEarned: pcEarned ?? this.pcEarned,
      transferred: transferred ?? this.transferred,
      pcTransferred: pcTransferred ?? this.pcTransferred,
    );
  }

  CategoryProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? name,
    Wrapped<String?>? notes,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? spent,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcSpent,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? earned,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcEarned,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? transferred,
    Wrapped<List<ArrayEntryWithCurrencyAndSum>?>? pcTransferred,
  }) {
    return CategoryProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      notes: (notes != null ? notes.value : this.notes),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      spent: (spent != null ? spent.value : this.spent),
      pcSpent: (pcSpent != null ? pcSpent.value : this.pcSpent),
      earned: (earned != null ? earned.value : this.earned),
      pcEarned: (pcEarned != null ? pcEarned.value : this.pcEarned),
      transferred: (transferred != null ? transferred.value : this.transferred),
      pcTransferred:
          (pcTransferred != null ? pcTransferred.value : this.pcTransferred),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryStore {
  const CategoryStore({required this.name, this.notes});

  factory CategoryStore.fromJson(Map<String, dynamic> json) =>
      _$CategoryStoreFromJson(json);

  static const toJsonFactory = _$CategoryStoreToJson;
  Map<String, dynamic> toJson() => _$CategoryStoreToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$CategoryStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategoryStoreExtension on CategoryStore {
  CategoryStore copyWith({String? name, String? notes}) {
    return CategoryStore(name: name ?? this.name, notes: notes ?? this.notes);
  }

  CategoryStore copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? notes,
  }) {
    return CategoryStore(
      name: (name != null ? name.value : this.name),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryUpdate {
  const CategoryUpdate({required this.name, this.notes});

  factory CategoryUpdate.fromJson(Map<String, dynamic> json) =>
      _$CategoryUpdateFromJson(json);

  static const toJsonFactory = _$CategoryUpdateToJson;
  Map<String, dynamic> toJson() => _$CategoryUpdateToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$CategoryUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CategoryUpdateExtension on CategoryUpdate {
  CategoryUpdate copyWith({String? name, String? notes}) {
    return CategoryUpdate(name: name ?? this.name, notes: notes ?? this.notes);
  }

  CategoryUpdate copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? notes,
  }) {
    return CategoryUpdate(
      name: (name != null ? name.value : this.name),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeProperties {
  const CurrencyExchangeProperties({
    this.createdAt,
    this.updatedAt,
    this.fromCurrencyId,
    this.fromCurrencyName,
    this.fromCurrencyCode,
    this.fromCurrencySymbol,
    this.fromCurrencyDecimalPlaces,
    this.toCurrencyId,
    this.toCurrencyName,
    this.toCurrencyCode,
    this.toCurrencySymbol,
    this.toCurrencyDecimalPlaces,
    this.rate,
    this.date,
  });

  factory CurrencyExchangeProperties.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangePropertiesFromJson(json);

  static const toJsonFactory = _$CurrencyExchangePropertiesToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangePropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'from_currency_id', includeIfNull: false)
  final String? fromCurrencyId;
  @JsonKey(name: 'from_currency_name', includeIfNull: false)
  final String? fromCurrencyName;
  @JsonKey(name: 'from_currency_code', includeIfNull: false)
  final String? fromCurrencyCode;
  @JsonKey(name: 'from_currency_symbol', includeIfNull: false)
  final String? fromCurrencySymbol;
  @JsonKey(name: 'from_currency_decimal_places', includeIfNull: false)
  final int? fromCurrencyDecimalPlaces;
  @JsonKey(name: 'to_currency_id', includeIfNull: false)
  final String? toCurrencyId;
  @JsonKey(name: 'to_currency_name', includeIfNull: false)
  final String? toCurrencyName;
  @JsonKey(name: 'to_currency_code', includeIfNull: false)
  final String? toCurrencyCode;
  @JsonKey(name: 'to_currency_symbol', includeIfNull: false)
  final String? toCurrencySymbol;
  @JsonKey(name: 'to_currency_decimal_places', includeIfNull: false)
  final int? toCurrencyDecimalPlaces;
  @JsonKey(name: 'rate', includeIfNull: false)
  final String? rate;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  static const fromJsonFactory = _$CurrencyExchangePropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangePropertiesExtension on CurrencyExchangeProperties {
  CurrencyExchangeProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fromCurrencyId,
    String? fromCurrencyName,
    String? fromCurrencyCode,
    String? fromCurrencySymbol,
    int? fromCurrencyDecimalPlaces,
    String? toCurrencyId,
    String? toCurrencyName,
    String? toCurrencyCode,
    String? toCurrencySymbol,
    int? toCurrencyDecimalPlaces,
    String? rate,
    DateTime? date,
  }) {
    return CurrencyExchangeProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fromCurrencyId: fromCurrencyId ?? this.fromCurrencyId,
      fromCurrencyName: fromCurrencyName ?? this.fromCurrencyName,
      fromCurrencyCode: fromCurrencyCode ?? this.fromCurrencyCode,
      fromCurrencySymbol: fromCurrencySymbol ?? this.fromCurrencySymbol,
      fromCurrencyDecimalPlaces:
          fromCurrencyDecimalPlaces ?? this.fromCurrencyDecimalPlaces,
      toCurrencyId: toCurrencyId ?? this.toCurrencyId,
      toCurrencyName: toCurrencyName ?? this.toCurrencyName,
      toCurrencyCode: toCurrencyCode ?? this.toCurrencyCode,
      toCurrencySymbol: toCurrencySymbol ?? this.toCurrencySymbol,
      toCurrencyDecimalPlaces:
          toCurrencyDecimalPlaces ?? this.toCurrencyDecimalPlaces,
      rate: rate ?? this.rate,
      date: date ?? this.date,
    );
  }

  CurrencyExchangeProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? fromCurrencyId,
    Wrapped<String?>? fromCurrencyName,
    Wrapped<String?>? fromCurrencyCode,
    Wrapped<String?>? fromCurrencySymbol,
    Wrapped<int?>? fromCurrencyDecimalPlaces,
    Wrapped<String?>? toCurrencyId,
    Wrapped<String?>? toCurrencyName,
    Wrapped<String?>? toCurrencyCode,
    Wrapped<String?>? toCurrencySymbol,
    Wrapped<int?>? toCurrencyDecimalPlaces,
    Wrapped<String?>? rate,
    Wrapped<DateTime?>? date,
  }) {
    return CurrencyExchangeProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      fromCurrencyId:
          (fromCurrencyId != null ? fromCurrencyId.value : this.fromCurrencyId),
      fromCurrencyName:
          (fromCurrencyName != null
              ? fromCurrencyName.value
              : this.fromCurrencyName),
      fromCurrencyCode:
          (fromCurrencyCode != null
              ? fromCurrencyCode.value
              : this.fromCurrencyCode),
      fromCurrencySymbol:
          (fromCurrencySymbol != null
              ? fromCurrencySymbol.value
              : this.fromCurrencySymbol),
      fromCurrencyDecimalPlaces:
          (fromCurrencyDecimalPlaces != null
              ? fromCurrencyDecimalPlaces.value
              : this.fromCurrencyDecimalPlaces),
      toCurrencyId:
          (toCurrencyId != null ? toCurrencyId.value : this.toCurrencyId),
      toCurrencyName:
          (toCurrencyName != null ? toCurrencyName.value : this.toCurrencyName),
      toCurrencyCode:
          (toCurrencyCode != null ? toCurrencyCode.value : this.toCurrencyCode),
      toCurrencySymbol:
          (toCurrencySymbol != null
              ? toCurrencySymbol.value
              : this.toCurrencySymbol),
      toCurrencyDecimalPlaces:
          (toCurrencyDecimalPlaces != null
              ? toCurrencyDecimalPlaces.value
              : this.toCurrencyDecimalPlaces),
      rate: (rate != null ? rate.value : this.rate),
      date: (date != null ? date.value : this.date),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateRead {
  const CurrencyExchangeRateRead({
    this.type,
    this.id,
    this.attributes,
    this.links,
  });

  factory CurrencyExchangeRateRead.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateReadFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateReadToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangeRateReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final CurrencyExchangeProperties? attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink? links;
  static const fromJsonFactory = _$CurrencyExchangeRateReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateReadExtension on CurrencyExchangeRateRead {
  CurrencyExchangeRateRead copyWith({
    String? type,
    String? id,
    CurrencyExchangeProperties? attributes,
    ObjectLink? links,
  }) {
    return CurrencyExchangeRateRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  CurrencyExchangeRateRead copyWithWrapped({
    Wrapped<String?>? type,
    Wrapped<String?>? id,
    Wrapped<CurrencyExchangeProperties?>? attributes,
    Wrapped<ObjectLink?>? links,
  }) {
    return CurrencyExchangeRateRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateSingle {
  const CurrencyExchangeRateSingle({required this.data});

  factory CurrencyExchangeRateSingle.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateSingleFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateSingleToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangeRateSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final CurrencyExchangeRateRead data;
  static const fromJsonFactory = _$CurrencyExchangeRateSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateSingleExtension on CurrencyExchangeRateSingle {
  CurrencyExchangeRateSingle copyWith({CurrencyExchangeRateRead? data}) {
    return CurrencyExchangeRateSingle(data: data ?? this.data);
  }

  CurrencyExchangeRateSingle copyWithWrapped({
    Wrapped<CurrencyExchangeRateRead>? data,
  }) {
    return CurrencyExchangeRateSingle(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateStore {
  const CurrencyExchangeRateStore({
    required this.from,
    required this.to,
    this.rate,
  });

  factory CurrencyExchangeRateStore.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateStoreFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateStoreToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangeRateStoreToJson(this);

  @JsonKey(name: 'from', includeIfNull: false)
  final String from;
  @JsonKey(name: 'to', includeIfNull: false)
  final String to;
  @JsonKey(name: 'rate', includeIfNull: false)
  final String? rate;
  static const fromJsonFactory = _$CurrencyExchangeRateStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateStoreExtension on CurrencyExchangeRateStore {
  CurrencyExchangeRateStore copyWith({String? from, String? to, String? rate}) {
    return CurrencyExchangeRateStore(
      from: from ?? this.from,
      to: to ?? this.to,
      rate: rate ?? this.rate,
    );
  }

  CurrencyExchangeRateStore copyWithWrapped({
    Wrapped<String>? from,
    Wrapped<String>? to,
    Wrapped<String?>? rate,
  }) {
    return CurrencyExchangeRateStore(
      from: (from != null ? from.value : this.from),
      to: (to != null ? to.value : this.to),
      rate: (rate != null ? rate.value : this.rate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateStoreByDate {
  const CurrencyExchangeRateStoreByDate({
    required this.from,
    required this.rates,
  });

  factory CurrencyExchangeRateStoreByDate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateStoreByDateFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateStoreByDateToJson;
  Map<String, dynamic> toJson() =>
      _$CurrencyExchangeRateStoreByDateToJson(this);

  @JsonKey(name: 'from', includeIfNull: false)
  final String from;
  @JsonKey(name: 'rates', includeIfNull: false)
  final Map<String, dynamic> rates;
  static const fromJsonFactory = _$CurrencyExchangeRateStoreByDateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateStoreByDateExtension
    on CurrencyExchangeRateStoreByDate {
  CurrencyExchangeRateStoreByDate copyWith({
    String? from,
    Map<String, dynamic>? rates,
  }) {
    return CurrencyExchangeRateStoreByDate(
      from: from ?? this.from,
      rates: rates ?? this.rates,
    );
  }

  CurrencyExchangeRateStoreByDate copyWithWrapped({
    Wrapped<String>? from,
    Wrapped<Map<String, dynamic>>? rates,
  }) {
    return CurrencyExchangeRateStoreByDate(
      from: (from != null ? from.value : this.from),
      rates: (rates != null ? rates.value : this.rates),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateStoreByPair {
  const CurrencyExchangeRateStoreByPair();

  factory CurrencyExchangeRateStoreByPair.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateStoreByPairFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateStoreByPairToJson;
  Map<String, dynamic> toJson() =>
      _$CurrencyExchangeRateStoreByPairToJson(this);

  static const fromJsonFactory = _$CurrencyExchangeRateStoreByPairFromJson;

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateUpdate {
  const CurrencyExchangeRateUpdate({
    required this.date,
    required this.rate,
    this.from,
    this.to,
  });

  factory CurrencyExchangeRateUpdate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyExchangeRateUpdateFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateUpdateToJson;
  Map<String, dynamic> toJson() => _$CurrencyExchangeRateUpdateToJson(this);

  @JsonKey(name: 'date', includeIfNull: false, toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: 'rate', includeIfNull: false)
  final String rate;
  @JsonKey(name: 'from', includeIfNull: false)
  final String? from;
  @JsonKey(name: 'to', includeIfNull: false)
  final String? to;
  static const fromJsonFactory = _$CurrencyExchangeRateUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateUpdateExtension on CurrencyExchangeRateUpdate {
  CurrencyExchangeRateUpdate copyWith({
    DateTime? date,
    String? rate,
    String? from,
    String? to,
  }) {
    return CurrencyExchangeRateUpdate(
      date: date ?? this.date,
      rate: rate ?? this.rate,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  CurrencyExchangeRateUpdate copyWithWrapped({
    Wrapped<DateTime>? date,
    Wrapped<String>? rate,
    Wrapped<String?>? from,
    Wrapped<String?>? to,
  }) {
    return CurrencyExchangeRateUpdate(
      date: (date != null ? date.value : this.date),
      rate: (rate != null ? rate.value : this.rate),
      from: (from != null ? from.value : this.from),
      to: (to != null ? to.value : this.to),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyExchangeRateUpdateNoDate {
  const CurrencyExchangeRateUpdateNoDate({required this.rate});

  factory CurrencyExchangeRateUpdateNoDate.fromJson(
    Map<String, dynamic> json,
  ) => _$CurrencyExchangeRateUpdateNoDateFromJson(json);

  static const toJsonFactory = _$CurrencyExchangeRateUpdateNoDateToJson;
  Map<String, dynamic> toJson() =>
      _$CurrencyExchangeRateUpdateNoDateToJson(this);

  @JsonKey(name: 'rate', includeIfNull: false)
  final String rate;
  static const fromJsonFactory = _$CurrencyExchangeRateUpdateNoDateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyExchangeRateUpdateNoDateExtension
    on CurrencyExchangeRateUpdateNoDate {
  CurrencyExchangeRateUpdateNoDate copyWith({String? rate}) {
    return CurrencyExchangeRateUpdateNoDate(rate: rate ?? this.rate);
  }

  CurrencyExchangeRateUpdateNoDate copyWithWrapped({Wrapped<String>? rate}) {
    return CurrencyExchangeRateUpdateNoDate(
      rate: (rate != null ? rate.value : this.rate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectGroup {
  const ObjectGroup({
    this.createdAt,
    this.updatedAt,
    required this.title,
    required this.order,
  });

  factory ObjectGroup.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupFromJson(json);

  static const toJsonFactory = _$ObjectGroupToJson;
  Map<String, dynamic> toJson() => _$ObjectGroupToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'order', includeIfNull: false)
  final int order;
  static const fromJsonFactory = _$ObjectGroupFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectGroupExtension on ObjectGroup {
  ObjectGroup copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    int? order,
  }) {
    return ObjectGroup(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      order: order ?? this.order,
    );
  }

  ObjectGroup copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? title,
    Wrapped<int>? order,
  }) {
    return ObjectGroup(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      title: (title != null ? title.value : this.title),
      order: (order != null ? order.value : this.order),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectGroupUpdate {
  const ObjectGroupUpdate({required this.title, this.order});

  factory ObjectGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupUpdateFromJson(json);

  static const toJsonFactory = _$ObjectGroupUpdateToJson;
  Map<String, dynamic> toJson() => _$ObjectGroupUpdateToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  static const fromJsonFactory = _$ObjectGroupUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectGroupUpdateExtension on ObjectGroupUpdate {
  ObjectGroupUpdate copyWith({String? title, int? order}) {
    return ObjectGroupUpdate(
      title: title ?? this.title,
      order: order ?? this.order,
    );
  }

  ObjectGroupUpdate copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<int?>? order,
  }) {
    return ObjectGroupUpdate(
      title: (title != null ? title.value : this.title),
      order: (order != null ? order.value : this.order),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectLink {
  const ObjectLink({this.self});

  factory ObjectLink.fromJson(Map<String, dynamic> json) =>
      _$ObjectLinkFromJson(json);

  static const toJsonFactory = _$ObjectLinkToJson;
  Map<String, dynamic> toJson() => _$ObjectLinkToJson(this);

  @JsonKey(name: 'self', includeIfNull: false)
  final String? self;
  static const fromJsonFactory = _$ObjectLinkFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectLinkExtension on ObjectLink {
  ObjectLink copyWith({String? self}) {
    return ObjectLink(self: self ?? this.self);
  }

  ObjectLink copyWithWrapped({Wrapped<String?>? self}) {
    return ObjectLink(self: (self != null ? self.value : this.self));
  }
}

@JsonSerializable(explicitToJson: true)
class PageLink {
  const PageLink({this.self, this.first, this.next, this.prev, this.last});

  factory PageLink.fromJson(Map<String, dynamic> json) =>
      _$PageLinkFromJson(json);

  static const toJsonFactory = _$PageLinkToJson;
  Map<String, dynamic> toJson() => _$PageLinkToJson(this);

  @JsonKey(name: 'self', includeIfNull: false)
  final String? self;
  @JsonKey(name: 'first', includeIfNull: false)
  final String? first;
  @JsonKey(name: 'next', includeIfNull: false)
  final String? next;
  @JsonKey(name: 'prev', includeIfNull: false)
  final String? prev;
  @JsonKey(name: 'last', includeIfNull: false)
  final String? last;
  static const fromJsonFactory = _$PageLinkFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PageLinkExtension on PageLink {
  PageLink copyWith({
    String? self,
    String? first,
    String? next,
    String? prev,
    String? last,
  }) {
    return PageLink(
      self: self ?? this.self,
      first: first ?? this.first,
      next: next ?? this.next,
      prev: prev ?? this.prev,
      last: last ?? this.last,
    );
  }

  PageLink copyWithWrapped({
    Wrapped<String?>? self,
    Wrapped<String?>? first,
    Wrapped<String?>? next,
    Wrapped<String?>? prev,
    Wrapped<String?>? last,
  }) {
    return PageLink(
      self: (self != null ? self.value : this.self),
      first: (first != null ? first.value : this.first),
      next: (next != null ? next.value : this.next),
      prev: (prev != null ? prev.value : this.prev),
      last: (last != null ? last.value : this.last),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankAccountRead {
  const PiggyBankAccountRead({
    this.accountId,
    this.name,
    this.currentAmount,
    this.pcCurrentAmount,
  });

  factory PiggyBankAccountRead.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankAccountReadFromJson(json);

  static const toJsonFactory = _$PiggyBankAccountReadToJson;
  Map<String, dynamic> toJson() => _$PiggyBankAccountReadToJson(this);

  @JsonKey(name: 'account_id', includeIfNull: false)
  final String? accountId;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  @JsonKey(name: 'pc_current_amount', includeIfNull: false)
  final String? pcCurrentAmount;
  static const fromJsonFactory = _$PiggyBankAccountReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankAccountReadExtension on PiggyBankAccountRead {
  PiggyBankAccountRead copyWith({
    String? accountId,
    String? name,
    String? currentAmount,
    String? pcCurrentAmount,
  }) {
    return PiggyBankAccountRead(
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      currentAmount: currentAmount ?? this.currentAmount,
      pcCurrentAmount: pcCurrentAmount ?? this.pcCurrentAmount,
    );
  }

  PiggyBankAccountRead copyWithWrapped({
    Wrapped<String?>? accountId,
    Wrapped<String?>? name,
    Wrapped<String?>? currentAmount,
    Wrapped<String?>? pcCurrentAmount,
  }) {
    return PiggyBankAccountRead(
      accountId: (accountId != null ? accountId.value : this.accountId),
      name: (name != null ? name.value : this.name),
      currentAmount:
          (currentAmount != null ? currentAmount.value : this.currentAmount),
      pcCurrentAmount:
          (pcCurrentAmount != null
              ? pcCurrentAmount.value
              : this.pcCurrentAmount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankAccountStore {
  const PiggyBankAccountStore({this.id, this.name, this.currentAmount});

  factory PiggyBankAccountStore.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankAccountStoreFromJson(json);

  static const toJsonFactory = _$PiggyBankAccountStoreToJson;
  Map<String, dynamic> toJson() => _$PiggyBankAccountStoreToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  static const fromJsonFactory = _$PiggyBankAccountStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankAccountStoreExtension on PiggyBankAccountStore {
  PiggyBankAccountStore copyWith({
    String? id,
    String? name,
    String? currentAmount,
  }) {
    return PiggyBankAccountStore(
      id: id ?? this.id,
      name: name ?? this.name,
      currentAmount: currentAmount ?? this.currentAmount,
    );
  }

  PiggyBankAccountStore copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? currentAmount,
  }) {
    return PiggyBankAccountStore(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      currentAmount:
          (currentAmount != null ? currentAmount.value : this.currentAmount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankAccountUpdate {
  const PiggyBankAccountUpdate({this.accountId, this.name, this.currentAmount});

  factory PiggyBankAccountUpdate.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankAccountUpdateFromJson(json);

  static const toJsonFactory = _$PiggyBankAccountUpdateToJson;
  Map<String, dynamic> toJson() => _$PiggyBankAccountUpdateToJson(this);

  @JsonKey(name: 'account_id', includeIfNull: false)
  final String? accountId;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  static const fromJsonFactory = _$PiggyBankAccountUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankAccountUpdateExtension on PiggyBankAccountUpdate {
  PiggyBankAccountUpdate copyWith({
    String? accountId,
    String? name,
    String? currentAmount,
  }) {
    return PiggyBankAccountUpdate(
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      currentAmount: currentAmount ?? this.currentAmount,
    );
  }

  PiggyBankAccountUpdate copyWithWrapped({
    Wrapped<String?>? accountId,
    Wrapped<String?>? name,
    Wrapped<String?>? currentAmount,
  }) {
    return PiggyBankAccountUpdate(
      accountId: (accountId != null ? accountId.value : this.accountId),
      name: (name != null ? name.value : this.name),
      currentAmount:
          (currentAmount != null ? currentAmount.value : this.currentAmount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankProperties {
  const PiggyBankProperties({
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.percentage,
    this.startDate,
    this.targetDate,
    this.order,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
    this.accounts,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.targetAmount,
    this.pcTargetAmount,
    this.currentAmount,
    this.pcCurrentAmount,
    this.leftToSave,
    this.pcLeftToSave,
    this.savePerMonth,
    this.pcSavePerMonth,
  });

  factory PiggyBankProperties.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankPropertiesFromJson(json);

  static const toJsonFactory = _$PiggyBankPropertiesToJson;
  Map<String, dynamic> toJson() => _$PiggyBankPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'percentage', includeIfNull: false)
  final double? percentage;
  @JsonKey(name: 'start_date', includeIfNull: false)
  final DateTime? startDate;
  @JsonKey(name: 'target_date', includeIfNull: false)
  final DateTime? targetDate;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_order', includeIfNull: false)
  final int? objectGroupOrder;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  @JsonKey(
    name: 'accounts',
    includeIfNull: false,
    defaultValue: <PiggyBankAccountRead>[],
  )
  final List<PiggyBankAccountRead>? accounts;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'target_amount', includeIfNull: false)
  final String? targetAmount;
  @JsonKey(name: 'pc_target_amount', includeIfNull: false)
  final String? pcTargetAmount;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  @JsonKey(name: 'pc_current_amount', includeIfNull: false)
  final String? pcCurrentAmount;
  @JsonKey(name: 'left_to_save', includeIfNull: false)
  final String? leftToSave;
  @JsonKey(name: 'pc_left_to_save', includeIfNull: false)
  final String? pcLeftToSave;
  @JsonKey(name: 'save_per_month', includeIfNull: false)
  final String? savePerMonth;
  @JsonKey(name: 'pc_save_per_month', includeIfNull: false)
  final String? pcSavePerMonth;
  static const fromJsonFactory = _$PiggyBankPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankPropertiesExtension on PiggyBankProperties {
  PiggyBankProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    double? percentage,
    DateTime? startDate,
    DateTime? targetDate,
    int? order,
    bool? active,
    String? notes,
    String? objectGroupId,
    int? objectGroupOrder,
    String? objectGroupTitle,
    List<PiggyBankAccountRead>? accounts,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? targetAmount,
    String? pcTargetAmount,
    String? currentAmount,
    String? pcCurrentAmount,
    String? leftToSave,
    String? pcLeftToSave,
    String? savePerMonth,
    String? pcSavePerMonth,
  }) {
    return PiggyBankProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      order: order ?? this.order,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupOrder: objectGroupOrder ?? this.objectGroupOrder,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
      accounts: accounts ?? this.accounts,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      targetAmount: targetAmount ?? this.targetAmount,
      pcTargetAmount: pcTargetAmount ?? this.pcTargetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      pcCurrentAmount: pcCurrentAmount ?? this.pcCurrentAmount,
      leftToSave: leftToSave ?? this.leftToSave,
      pcLeftToSave: pcLeftToSave ?? this.pcLeftToSave,
      savePerMonth: savePerMonth ?? this.savePerMonth,
      pcSavePerMonth: pcSavePerMonth ?? this.pcSavePerMonth,
    );
  }

  PiggyBankProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? name,
    Wrapped<double?>? percentage,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? targetDate,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<int?>? objectGroupOrder,
    Wrapped<String?>? objectGroupTitle,
    Wrapped<List<PiggyBankAccountRead>?>? accounts,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? targetAmount,
    Wrapped<String?>? pcTargetAmount,
    Wrapped<String?>? currentAmount,
    Wrapped<String?>? pcCurrentAmount,
    Wrapped<String?>? leftToSave,
    Wrapped<String?>? pcLeftToSave,
    Wrapped<String?>? savePerMonth,
    Wrapped<String?>? pcSavePerMonth,
  }) {
    return PiggyBankProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      percentage: (percentage != null ? percentage.value : this.percentage),
      startDate: (startDate != null ? startDate.value : this.startDate),
      targetDate: (targetDate != null ? targetDate.value : this.targetDate),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupOrder:
          (objectGroupOrder != null
              ? objectGroupOrder.value
              : this.objectGroupOrder),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
      accounts: (accounts != null ? accounts.value : this.accounts),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      targetAmount:
          (targetAmount != null ? targetAmount.value : this.targetAmount),
      pcTargetAmount:
          (pcTargetAmount != null ? pcTargetAmount.value : this.pcTargetAmount),
      currentAmount:
          (currentAmount != null ? currentAmount.value : this.currentAmount),
      pcCurrentAmount:
          (pcCurrentAmount != null
              ? pcCurrentAmount.value
              : this.pcCurrentAmount),
      leftToSave: (leftToSave != null ? leftToSave.value : this.leftToSave),
      pcLeftToSave:
          (pcLeftToSave != null ? pcLeftToSave.value : this.pcLeftToSave),
      savePerMonth:
          (savePerMonth != null ? savePerMonth.value : this.savePerMonth),
      pcSavePerMonth:
          (pcSavePerMonth != null ? pcSavePerMonth.value : this.pcSavePerMonth),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankStore {
  const PiggyBankStore({
    required this.name,
    this.accounts,
    this.targetAmount,
    this.currentAmount,
    required this.startDate,
    this.targetDate,
    this.order,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory PiggyBankStore.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankStoreFromJson(json);

  static const toJsonFactory = _$PiggyBankStoreToJson;
  Map<String, dynamic> toJson() => _$PiggyBankStoreToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(
    name: 'accounts',
    includeIfNull: false,
    defaultValue: <PiggyBankAccountStore>[],
  )
  final List<PiggyBankAccountStore>? accounts;
  @JsonKey(name: 'target_amount', includeIfNull: false)
  final String? targetAmount;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  @JsonKey(name: 'start_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'target_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? targetDate;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$PiggyBankStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankStoreExtension on PiggyBankStore {
  PiggyBankStore copyWith({
    String? name,
    List<PiggyBankAccountStore>? accounts,
    String? targetAmount,
    String? currentAmount,
    DateTime? startDate,
    DateTime? targetDate,
    int? order,
    bool? active,
    String? notes,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return PiggyBankStore(
      name: name ?? this.name,
      accounts: accounts ?? this.accounts,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      order: order ?? this.order,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  PiggyBankStore copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<List<PiggyBankAccountStore>?>? accounts,
    Wrapped<String?>? targetAmount,
    Wrapped<String?>? currentAmount,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime?>? targetDate,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return PiggyBankStore(
      name: (name != null ? name.value : this.name),
      accounts: (accounts != null ? accounts.value : this.accounts),
      targetAmount:
          (targetAmount != null ? targetAmount.value : this.targetAmount),
      currentAmount:
          (currentAmount != null ? currentAmount.value : this.currentAmount),
      startDate: (startDate != null ? startDate.value : this.startDate),
      targetDate: (targetDate != null ? targetDate.value : this.targetDate),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankUpdate {
  const PiggyBankUpdate({
    this.name,
    this.accounts,
    this.currencyId,
    this.currencyCode,
    this.targetAmount,
    this.startDate,
    this.targetDate,
    this.order,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupTitle,
  });

  factory PiggyBankUpdate.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankUpdateFromJson(json);

  static const toJsonFactory = _$PiggyBankUpdateToJson;
  Map<String, dynamic> toJson() => _$PiggyBankUpdateToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(
    name: 'accounts',
    includeIfNull: false,
    defaultValue: <PiggyBankAccountUpdate>[],
  )
  final List<PiggyBankAccountUpdate>? accounts;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'target_amount', includeIfNull: false)
  final String? targetAmount;
  @JsonKey(name: 'start_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'target_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? targetDate;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'object_group_id', includeIfNull: false)
  final String? objectGroupId;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$PiggyBankUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankUpdateExtension on PiggyBankUpdate {
  PiggyBankUpdate copyWith({
    String? name,
    List<PiggyBankAccountUpdate>? accounts,
    String? currencyId,
    String? currencyCode,
    String? targetAmount,
    DateTime? startDate,
    DateTime? targetDate,
    int? order,
    bool? active,
    String? notes,
    String? objectGroupId,
    String? objectGroupTitle,
  }) {
    return PiggyBankUpdate(
      name: name ?? this.name,
      accounts: accounts ?? this.accounts,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      targetAmount: targetAmount ?? this.targetAmount,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      order: order ?? this.order,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      objectGroupId: objectGroupId ?? this.objectGroupId,
      objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle,
    );
  }

  PiggyBankUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<List<PiggyBankAccountUpdate>?>? accounts,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? targetAmount,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? targetDate,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<String?>? objectGroupId,
    Wrapped<String?>? objectGroupTitle,
  }) {
    return PiggyBankUpdate(
      name: (name != null ? name.value : this.name),
      accounts: (accounts != null ? accounts.value : this.accounts),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      targetAmount:
          (targetAmount != null ? targetAmount.value : this.targetAmount),
      startDate: (startDate != null ? startDate.value : this.startDate),
      targetDate: (targetDate != null ? targetDate.value : this.targetDate),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      objectGroupId:
          (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
      objectGroupTitle:
          (objectGroupTitle != null
              ? objectGroupTitle.value
              : this.objectGroupTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankEventProperties {
  const PiggyBankEventProperties({
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.pcAmount,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.transactionJournalId,
    this.transactionGroupId,
  });

  factory PiggyBankEventProperties.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankEventPropertiesFromJson(json);

  static const toJsonFactory = _$PiggyBankEventPropertiesToJson;
  Map<String, dynamic> toJson() => _$PiggyBankEventPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(name: 'transaction_group_id', includeIfNull: false)
  final String? transactionGroupId;
  static const fromJsonFactory = _$PiggyBankEventPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankEventPropertiesExtension on PiggyBankEventProperties {
  PiggyBankEventProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? amount,
    String? pcAmount,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? transactionJournalId,
    String? transactionGroupId,
  }) {
    return PiggyBankEventProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      transactionJournalId: transactionJournalId ?? this.transactionJournalId,
      transactionGroupId: transactionGroupId ?? this.transactionGroupId,
    );
  }

  PiggyBankEventProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? transactionJournalId,
    Wrapped<String?>? transactionGroupId,
  }) {
    return PiggyBankEventProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      transactionJournalId:
          (transactionJournalId != null
              ? transactionJournalId.value
              : this.transactionJournalId),
      transactionGroupId:
          (transactionGroupId != null
              ? transactionGroupId.value
              : this.transactionGroupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Preference {
  const Preference({
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.data,
  });

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  static const toJsonFactory = _$PreferenceToJson;
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'data', includeIfNull: false)
  final PolymorphicProperty data;
  static const fromJsonFactory = _$PreferenceFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PreferenceExtension on Preference {
  Preference copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    PolymorphicProperty? data,
  }) {
    return Preference(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  Preference copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? name,
    Wrapped<PolymorphicProperty>? data,
  }) {
    return Preference(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PreferenceUpdate {
  const PreferenceUpdate({required this.data});

  factory PreferenceUpdate.fromJson(Map<String, dynamic> json) =>
      _$PreferenceUpdateFromJson(json);

  static const toJsonFactory = _$PreferenceUpdateToJson;
  Map<String, dynamic> toJson() => _$PreferenceUpdateToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final PolymorphicProperty data;
  static const fromJsonFactory = _$PreferenceUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PreferenceUpdateExtension on PreferenceUpdate {
  PreferenceUpdate copyWith({PolymorphicProperty? data}) {
    return PreferenceUpdate(data: data ?? this.data);
  }

  PreferenceUpdate copyWithWrapped({Wrapped<PolymorphicProperty>? data}) {
    return PreferenceUpdate(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceProperties {
  const RecurrenceProperties({
    this.createdAt,
    this.updatedAt,
    this.type,
    this.title,
    this.description,
    this.firstDate,
    this.latestDate,
    this.repeatUntil,
    this.applyRules,
    this.active,
    this.nrOfRepetitions,
    this.notes,
    this.repetitions,
    this.transactions,
  });

  factory RecurrenceProperties.fromJson(Map<String, dynamic> json) =>
      _$RecurrencePropertiesFromJson(json);

  static const toJsonFactory = _$RecurrencePropertiesToJson;
  Map<String, dynamic> toJson() => _$RecurrencePropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: recurrenceTransactionTypeNullableToJson,
    fromJson: recurrenceTransactionTypeNullableFromJson,
  )
  final enums.RecurrenceTransactionType? type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'first_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? firstDate;
  @JsonKey(name: 'latest_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? latestDate;
  @JsonKey(name: 'repeat_until', includeIfNull: false, toJson: _dateToJson)
  final DateTime? repeatUntil;
  @JsonKey(name: 'apply_rules', includeIfNull: false)
  final bool? applyRules;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'nr_of_repetitions', includeIfNull: false)
  final int? nrOfRepetitions;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'repetitions',
    includeIfNull: false,
    defaultValue: <RecurrenceRepetition>[],
  )
  final List<RecurrenceRepetition>? repetitions;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <RecurrenceTransaction>[],
  )
  final List<RecurrenceTransaction>? transactions;
  static const fromJsonFactory = _$RecurrencePropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrencePropertiesExtension on RecurrenceProperties {
  RecurrenceProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    enums.RecurrenceTransactionType? type,
    String? title,
    String? description,
    DateTime? firstDate,
    DateTime? latestDate,
    DateTime? repeatUntil,
    bool? applyRules,
    bool? active,
    int? nrOfRepetitions,
    String? notes,
    List<RecurrenceRepetition>? repetitions,
    List<RecurrenceTransaction>? transactions,
  }) {
    return RecurrenceProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      firstDate: firstDate ?? this.firstDate,
      latestDate: latestDate ?? this.latestDate,
      repeatUntil: repeatUntil ?? this.repeatUntil,
      applyRules: applyRules ?? this.applyRules,
      active: active ?? this.active,
      nrOfRepetitions: nrOfRepetitions ?? this.nrOfRepetitions,
      notes: notes ?? this.notes,
      repetitions: repetitions ?? this.repetitions,
      transactions: transactions ?? this.transactions,
    );
  }

  RecurrenceProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<enums.RecurrenceTransactionType?>? type,
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<DateTime?>? firstDate,
    Wrapped<DateTime?>? latestDate,
    Wrapped<DateTime?>? repeatUntil,
    Wrapped<bool?>? applyRules,
    Wrapped<bool?>? active,
    Wrapped<int?>? nrOfRepetitions,
    Wrapped<String?>? notes,
    Wrapped<List<RecurrenceRepetition>?>? repetitions,
    Wrapped<List<RecurrenceTransaction>?>? transactions,
  }) {
    return RecurrenceProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      firstDate: (firstDate != null ? firstDate.value : this.firstDate),
      latestDate: (latestDate != null ? latestDate.value : this.latestDate),
      repeatUntil: (repeatUntil != null ? repeatUntil.value : this.repeatUntil),
      applyRules: (applyRules != null ? applyRules.value : this.applyRules),
      active: (active != null ? active.value : this.active),
      nrOfRepetitions:
          (nrOfRepetitions != null
              ? nrOfRepetitions.value
              : this.nrOfRepetitions),
      notes: (notes != null ? notes.value : this.notes),
      repetitions: (repetitions != null ? repetitions.value : this.repetitions),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceStore {
  const RecurrenceStore({
    required this.type,
    required this.title,
    this.description,
    required this.firstDate,
    this.repeatUntil,
    this.nrOfRepetitions,
    this.applyRules,
    this.active,
    this.notes,
    required this.repetitions,
    required this.transactions,
  });

  factory RecurrenceStore.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceStoreFromJson(json);

  static const toJsonFactory = _$RecurrenceStoreToJson;
  Map<String, dynamic> toJson() => _$RecurrenceStoreToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: recurrenceTransactionTypeToJson,
    fromJson: recurrenceTransactionTypeFromJson,
  )
  final enums.RecurrenceTransactionType type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'first_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime firstDate;
  @JsonKey(name: 'repeat_until', includeIfNull: false, toJson: _dateToJson)
  final DateTime? repeatUntil;
  @JsonKey(name: 'nr_of_repetitions', includeIfNull: false)
  final int? nrOfRepetitions;
  @JsonKey(name: 'apply_rules', includeIfNull: false)
  final bool? applyRules;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'repetitions',
    includeIfNull: false,
    defaultValue: <RecurrenceRepetitionStore>[],
  )
  final List<RecurrenceRepetitionStore> repetitions;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <RecurrenceTransactionStore>[],
  )
  final List<RecurrenceTransactionStore> transactions;
  static const fromJsonFactory = _$RecurrenceStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceStoreExtension on RecurrenceStore {
  RecurrenceStore copyWith({
    enums.RecurrenceTransactionType? type,
    String? title,
    String? description,
    DateTime? firstDate,
    DateTime? repeatUntil,
    int? nrOfRepetitions,
    bool? applyRules,
    bool? active,
    String? notes,
    List<RecurrenceRepetitionStore>? repetitions,
    List<RecurrenceTransactionStore>? transactions,
  }) {
    return RecurrenceStore(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      firstDate: firstDate ?? this.firstDate,
      repeatUntil: repeatUntil ?? this.repeatUntil,
      nrOfRepetitions: nrOfRepetitions ?? this.nrOfRepetitions,
      applyRules: applyRules ?? this.applyRules,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      repetitions: repetitions ?? this.repetitions,
      transactions: transactions ?? this.transactions,
    );
  }

  RecurrenceStore copyWithWrapped({
    Wrapped<enums.RecurrenceTransactionType>? type,
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<DateTime>? firstDate,
    Wrapped<DateTime?>? repeatUntil,
    Wrapped<int?>? nrOfRepetitions,
    Wrapped<bool?>? applyRules,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<List<RecurrenceRepetitionStore>>? repetitions,
    Wrapped<List<RecurrenceTransactionStore>>? transactions,
  }) {
    return RecurrenceStore(
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      firstDate: (firstDate != null ? firstDate.value : this.firstDate),
      repeatUntil: (repeatUntil != null ? repeatUntil.value : this.repeatUntil),
      nrOfRepetitions:
          (nrOfRepetitions != null
              ? nrOfRepetitions.value
              : this.nrOfRepetitions),
      applyRules: (applyRules != null ? applyRules.value : this.applyRules),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      repetitions: (repetitions != null ? repetitions.value : this.repetitions),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceUpdate {
  const RecurrenceUpdate({
    this.title,
    this.description,
    this.firstDate,
    this.repeatUntil,
    this.nrOfRepetitions,
    this.applyRules,
    this.active,
    this.notes,
    this.repetitions,
    this.transactions,
  });

  factory RecurrenceUpdate.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceUpdateFromJson(json);

  static const toJsonFactory = _$RecurrenceUpdateToJson;
  Map<String, dynamic> toJson() => _$RecurrenceUpdateToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'first_date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? firstDate;
  @JsonKey(name: 'repeat_until', includeIfNull: false, toJson: _dateToJson)
  final DateTime? repeatUntil;
  @JsonKey(name: 'nr_of_repetitions', includeIfNull: false)
  final int? nrOfRepetitions;
  @JsonKey(name: 'apply_rules', includeIfNull: false)
  final bool? applyRules;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(
    name: 'repetitions',
    includeIfNull: false,
    defaultValue: <RecurrenceRepetitionUpdate>[],
  )
  final List<RecurrenceRepetitionUpdate>? repetitions;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <RecurrenceTransactionUpdate>[],
  )
  final List<RecurrenceTransactionUpdate>? transactions;
  static const fromJsonFactory = _$RecurrenceUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceUpdateExtension on RecurrenceUpdate {
  RecurrenceUpdate copyWith({
    String? title,
    String? description,
    DateTime? firstDate,
    DateTime? repeatUntil,
    int? nrOfRepetitions,
    bool? applyRules,
    bool? active,
    String? notes,
    List<RecurrenceRepetitionUpdate>? repetitions,
    List<RecurrenceTransactionUpdate>? transactions,
  }) {
    return RecurrenceUpdate(
      title: title ?? this.title,
      description: description ?? this.description,
      firstDate: firstDate ?? this.firstDate,
      repeatUntil: repeatUntil ?? this.repeatUntil,
      nrOfRepetitions: nrOfRepetitions ?? this.nrOfRepetitions,
      applyRules: applyRules ?? this.applyRules,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      repetitions: repetitions ?? this.repetitions,
      transactions: transactions ?? this.transactions,
    );
  }

  RecurrenceUpdate copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<DateTime?>? firstDate,
    Wrapped<DateTime?>? repeatUntil,
    Wrapped<int?>? nrOfRepetitions,
    Wrapped<bool?>? applyRules,
    Wrapped<bool?>? active,
    Wrapped<String?>? notes,
    Wrapped<List<RecurrenceRepetitionUpdate>?>? repetitions,
    Wrapped<List<RecurrenceTransactionUpdate>?>? transactions,
  }) {
    return RecurrenceUpdate(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      firstDate: (firstDate != null ? firstDate.value : this.firstDate),
      repeatUntil: (repeatUntil != null ? repeatUntil.value : this.repeatUntil),
      nrOfRepetitions:
          (nrOfRepetitions != null
              ? nrOfRepetitions.value
              : this.nrOfRepetitions),
      applyRules: (applyRules != null ? applyRules.value : this.applyRules),
      active: (active != null ? active.value : this.active),
      notes: (notes != null ? notes.value : this.notes),
      repetitions: (repetitions != null ? repetitions.value : this.repetitions),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceRepetition {
  const RecurrenceRepetition({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.type,
    required this.moment,
    this.skip,
    this.weekend,
    this.description,
    this.occurrences,
  });

  factory RecurrenceRepetition.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRepetitionFromJson(json);

  static const toJsonFactory = _$RecurrenceRepetitionToJson;
  Map<String, dynamic> toJson() => _$RecurrenceRepetitionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: recurrenceRepetitionTypeToJson,
    fromJson: recurrenceRepetitionTypeFromJson,
  )
  final enums.RecurrenceRepetitionType type;
  @JsonKey(name: 'moment', includeIfNull: false)
  final String moment;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'weekend', includeIfNull: false)
  final int? weekend;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(
    name: 'occurrences',
    includeIfNull: false,
    defaultValue: <DateTime>[],
  )
  final List<DateTime>? occurrences;
  static const fromJsonFactory = _$RecurrenceRepetitionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceRepetitionExtension on RecurrenceRepetition {
  RecurrenceRepetition copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    enums.RecurrenceRepetitionType? type,
    String? moment,
    int? skip,
    int? weekend,
    String? description,
    List<DateTime>? occurrences,
  }) {
    return RecurrenceRepetition(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      moment: moment ?? this.moment,
      skip: skip ?? this.skip,
      weekend: weekend ?? this.weekend,
      description: description ?? this.description,
      occurrences: occurrences ?? this.occurrences,
    );
  }

  RecurrenceRepetition copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<enums.RecurrenceRepetitionType>? type,
    Wrapped<String>? moment,
    Wrapped<int?>? skip,
    Wrapped<int?>? weekend,
    Wrapped<String?>? description,
    Wrapped<List<DateTime>?>? occurrences,
  }) {
    return RecurrenceRepetition(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      type: (type != null ? type.value : this.type),
      moment: (moment != null ? moment.value : this.moment),
      skip: (skip != null ? skip.value : this.skip),
      weekend: (weekend != null ? weekend.value : this.weekend),
      description: (description != null ? description.value : this.description),
      occurrences: (occurrences != null ? occurrences.value : this.occurrences),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceRepetitionStore {
  const RecurrenceRepetitionStore({
    required this.type,
    required this.moment,
    this.skip,
    this.weekend,
  });

  factory RecurrenceRepetitionStore.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRepetitionStoreFromJson(json);

  static const toJsonFactory = _$RecurrenceRepetitionStoreToJson;
  Map<String, dynamic> toJson() => _$RecurrenceRepetitionStoreToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: recurrenceRepetitionTypeToJson,
    fromJson: recurrenceRepetitionTypeFromJson,
  )
  final enums.RecurrenceRepetitionType type;
  @JsonKey(name: 'moment', includeIfNull: false)
  final String moment;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'weekend', includeIfNull: false)
  final int? weekend;
  static const fromJsonFactory = _$RecurrenceRepetitionStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceRepetitionStoreExtension on RecurrenceRepetitionStore {
  RecurrenceRepetitionStore copyWith({
    enums.RecurrenceRepetitionType? type,
    String? moment,
    int? skip,
    int? weekend,
  }) {
    return RecurrenceRepetitionStore(
      type: type ?? this.type,
      moment: moment ?? this.moment,
      skip: skip ?? this.skip,
      weekend: weekend ?? this.weekend,
    );
  }

  RecurrenceRepetitionStore copyWithWrapped({
    Wrapped<enums.RecurrenceRepetitionType>? type,
    Wrapped<String>? moment,
    Wrapped<int?>? skip,
    Wrapped<int?>? weekend,
  }) {
    return RecurrenceRepetitionStore(
      type: (type != null ? type.value : this.type),
      moment: (moment != null ? moment.value : this.moment),
      skip: (skip != null ? skip.value : this.skip),
      weekend: (weekend != null ? weekend.value : this.weekend),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceRepetitionUpdate {
  const RecurrenceRepetitionUpdate({
    this.type,
    this.moment,
    this.skip,
    this.weekend,
  });

  factory RecurrenceRepetitionUpdate.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRepetitionUpdateFromJson(json);

  static const toJsonFactory = _$RecurrenceRepetitionUpdateToJson;
  Map<String, dynamic> toJson() => _$RecurrenceRepetitionUpdateToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: recurrenceRepetitionTypeNullableToJson,
    fromJson: recurrenceRepetitionTypeNullableFromJson,
  )
  final enums.RecurrenceRepetitionType? type;
  @JsonKey(name: 'moment', includeIfNull: false)
  final String? moment;
  @JsonKey(name: 'skip', includeIfNull: false)
  final int? skip;
  @JsonKey(name: 'weekend', includeIfNull: false)
  final int? weekend;
  static const fromJsonFactory = _$RecurrenceRepetitionUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceRepetitionUpdateExtension on RecurrenceRepetitionUpdate {
  RecurrenceRepetitionUpdate copyWith({
    enums.RecurrenceRepetitionType? type,
    String? moment,
    int? skip,
    int? weekend,
  }) {
    return RecurrenceRepetitionUpdate(
      type: type ?? this.type,
      moment: moment ?? this.moment,
      skip: skip ?? this.skip,
      weekend: weekend ?? this.weekend,
    );
  }

  RecurrenceRepetitionUpdate copyWithWrapped({
    Wrapped<enums.RecurrenceRepetitionType?>? type,
    Wrapped<String?>? moment,
    Wrapped<int?>? skip,
    Wrapped<int?>? weekend,
  }) {
    return RecurrenceRepetitionUpdate(
      type: (type != null ? type.value : this.type),
      moment: (moment != null ? moment.value : this.moment),
      skip: (skip != null ? skip.value : this.skip),
      weekend: (weekend != null ? weekend.value : this.weekend),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceTransaction {
  const RecurrenceTransaction({
    this.id,
    required this.description,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    required this.amount,
    this.pcAmount,
    this.foreignAmount,
    this.pcForeignAmount,
    this.foreignCurrencyId,
    this.foreignCurrencyName,
    this.foreignCurrencyCode,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.sourceId,
    this.sourceName,
    this.sourceIban,
    this.sourceType,
    this.destinationId,
    this.destinationName,
    this.destinationIban,
    this.destinationType,
    this.tags,
    this.piggyBankId,
    this.piggyBankName,
    this.subscriptionId,
    this.subscriptionName,
  });

  factory RecurrenceTransaction.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceTransactionFromJson(json);

  static const toJsonFactory = _$RecurrenceTransactionToJson;
  Map<String, dynamic> toJson() => _$RecurrenceTransactionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'pc_foreign_amount', includeIfNull: false)
  final String? pcForeignAmount;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_name', includeIfNull: false)
  final String? foreignCurrencyName;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol', includeIfNull: false)
  final String? foreignCurrencySymbol;
  @JsonKey(name: 'foreign_currency_decimal_places', includeIfNull: false)
  final int? foreignCurrencyDecimalPlaces;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'budget_name', includeIfNull: false)
  final String? budgetName;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'category_name', includeIfNull: false)
  final String? categoryName;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String? sourceId;
  @JsonKey(name: 'source_name', includeIfNull: false)
  final String? sourceName;
  @JsonKey(name: 'source_iban', includeIfNull: false)
  final String? sourceIban;
  @JsonKey(
    name: 'source_type',
    includeIfNull: false,
    toJson: accountTypePropertyNullableToJson,
    fromJson: accountTypePropertyNullableFromJson,
  )
  final enums.AccountTypeProperty? sourceType;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String? destinationId;
  @JsonKey(name: 'destination_name', includeIfNull: false)
  final String? destinationName;
  @JsonKey(name: 'destination_iban', includeIfNull: false)
  final String? destinationIban;
  @JsonKey(
    name: 'destination_type',
    includeIfNull: false,
    toJson: accountTypePropertyNullableToJson,
    fromJson: accountTypePropertyNullableFromJson,
  )
  final enums.AccountTypeProperty? destinationType;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'piggy_bank_id', includeIfNull: false)
  final String? piggyBankId;
  @JsonKey(name: 'piggy_bank_name', includeIfNull: false)
  final String? piggyBankName;
  @JsonKey(name: 'subscription_id', includeIfNull: false)
  final String? subscriptionId;
  @JsonKey(name: 'subscription_name', includeIfNull: false)
  final String? subscriptionName;
  static const fromJsonFactory = _$RecurrenceTransactionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceTransactionExtension on RecurrenceTransaction {
  RecurrenceTransaction copyWith({
    String? id,
    String? description,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amount,
    String? pcAmount,
    String? foreignAmount,
    String? pcForeignAmount,
    String? foreignCurrencyId,
    String? foreignCurrencyName,
    String? foreignCurrencyCode,
    String? foreignCurrencySymbol,
    int? foreignCurrencyDecimalPlaces,
    String? budgetId,
    String? budgetName,
    String? categoryId,
    String? categoryName,
    String? sourceId,
    String? sourceName,
    String? sourceIban,
    enums.AccountTypeProperty? sourceType,
    String? destinationId,
    String? destinationName,
    String? destinationIban,
    enums.AccountTypeProperty? destinationType,
    List<String>? tags,
    String? piggyBankId,
    String? piggyBankName,
    String? subscriptionId,
    String? subscriptionName,
  }) {
    return RecurrenceTransaction(
      id: id ?? this.id,
      description: description ?? this.description,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      pcForeignAmount: pcForeignAmount ?? this.pcForeignAmount,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      foreignCurrencyName: foreignCurrencyName ?? this.foreignCurrencyName,
      foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
      foreignCurrencySymbol:
          foreignCurrencySymbol ?? this.foreignCurrencySymbol,
      foreignCurrencyDecimalPlaces:
          foreignCurrencyDecimalPlaces ?? this.foreignCurrencyDecimalPlaces,
      budgetId: budgetId ?? this.budgetId,
      budgetName: budgetName ?? this.budgetName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      sourceIban: sourceIban ?? this.sourceIban,
      sourceType: sourceType ?? this.sourceType,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      destinationIban: destinationIban ?? this.destinationIban,
      destinationType: destinationType ?? this.destinationType,
      tags: tags ?? this.tags,
      piggyBankId: piggyBankId ?? this.piggyBankId,
      piggyBankName: piggyBankName ?? this.piggyBankName,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      subscriptionName: subscriptionName ?? this.subscriptionName,
    );
  }

  RecurrenceTransaction copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String>? description,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? pcForeignAmount,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? foreignCurrencyName,
    Wrapped<String?>? foreignCurrencyCode,
    Wrapped<String?>? foreignCurrencySymbol,
    Wrapped<int?>? foreignCurrencyDecimalPlaces,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? budgetName,
    Wrapped<String?>? categoryId,
    Wrapped<String?>? categoryName,
    Wrapped<String?>? sourceId,
    Wrapped<String?>? sourceName,
    Wrapped<String?>? sourceIban,
    Wrapped<enums.AccountTypeProperty?>? sourceType,
    Wrapped<String?>? destinationId,
    Wrapped<String?>? destinationName,
    Wrapped<String?>? destinationIban,
    Wrapped<enums.AccountTypeProperty?>? destinationType,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? piggyBankId,
    Wrapped<String?>? piggyBankName,
    Wrapped<String?>? subscriptionId,
    Wrapped<String?>? subscriptionName,
  }) {
    return RecurrenceTransaction(
      id: (id != null ? id.value : this.id),
      description: (description != null ? description.value : this.description),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      pcForeignAmount:
          (pcForeignAmount != null
              ? pcForeignAmount.value
              : this.pcForeignAmount),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      foreignCurrencyName:
          (foreignCurrencyName != null
              ? foreignCurrencyName.value
              : this.foreignCurrencyName),
      foreignCurrencyCode:
          (foreignCurrencyCode != null
              ? foreignCurrencyCode.value
              : this.foreignCurrencyCode),
      foreignCurrencySymbol:
          (foreignCurrencySymbol != null
              ? foreignCurrencySymbol.value
              : this.foreignCurrencySymbol),
      foreignCurrencyDecimalPlaces:
          (foreignCurrencyDecimalPlaces != null
              ? foreignCurrencyDecimalPlaces.value
              : this.foreignCurrencyDecimalPlaces),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      budgetName: (budgetName != null ? budgetName.value : this.budgetName),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      categoryName:
          (categoryName != null ? categoryName.value : this.categoryName),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      sourceName: (sourceName != null ? sourceName.value : this.sourceName),
      sourceIban: (sourceIban != null ? sourceIban.value : this.sourceIban),
      sourceType: (sourceType != null ? sourceType.value : this.sourceType),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      destinationName:
          (destinationName != null
              ? destinationName.value
              : this.destinationName),
      destinationIban:
          (destinationIban != null
              ? destinationIban.value
              : this.destinationIban),
      destinationType:
          (destinationType != null
              ? destinationType.value
              : this.destinationType),
      tags: (tags != null ? tags.value : this.tags),
      piggyBankId: (piggyBankId != null ? piggyBankId.value : this.piggyBankId),
      piggyBankName:
          (piggyBankName != null ? piggyBankName.value : this.piggyBankName),
      subscriptionId:
          (subscriptionId != null ? subscriptionId.value : this.subscriptionId),
      subscriptionName:
          (subscriptionName != null
              ? subscriptionName.value
              : this.subscriptionName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceTransactionStore {
  const RecurrenceTransactionStore({
    required this.description,
    required this.amount,
    this.foreignAmount,
    this.currencyId,
    this.currencyCode,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.budgetId,
    this.categoryId,
    required this.sourceId,
    required this.destinationId,
    this.tags,
    this.piggyBankId,
    this.billId,
  });

  factory RecurrenceTransactionStore.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceTransactionStoreFromJson(json);

  static const toJsonFactory = _$RecurrenceTransactionStoreToJson;
  Map<String, dynamic> toJson() => _$RecurrenceTransactionStoreToJson(this);

  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String sourceId;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String destinationId;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'piggy_bank_id', includeIfNull: false)
  final String? piggyBankId;
  @JsonKey(name: 'bill_id', includeIfNull: false)
  final String? billId;
  static const fromJsonFactory = _$RecurrenceTransactionStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceTransactionStoreExtension on RecurrenceTransactionStore {
  RecurrenceTransactionStore copyWith({
    String? description,
    String? amount,
    String? foreignAmount,
    String? currencyId,
    String? currencyCode,
    String? foreignCurrencyId,
    String? foreignCurrencyCode,
    String? budgetId,
    String? categoryId,
    String? sourceId,
    String? destinationId,
    List<String>? tags,
    String? piggyBankId,
    String? billId,
  }) {
    return RecurrenceTransactionStore(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
      budgetId: budgetId ?? this.budgetId,
      categoryId: categoryId ?? this.categoryId,
      sourceId: sourceId ?? this.sourceId,
      destinationId: destinationId ?? this.destinationId,
      tags: tags ?? this.tags,
      piggyBankId: piggyBankId ?? this.piggyBankId,
      billId: billId ?? this.billId,
    );
  }

  RecurrenceTransactionStore copyWithWrapped({
    Wrapped<String>? description,
    Wrapped<String>? amount,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? foreignCurrencyCode,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? categoryId,
    Wrapped<String>? sourceId,
    Wrapped<String>? destinationId,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? piggyBankId,
    Wrapped<String?>? billId,
  }) {
    return RecurrenceTransactionStore(
      description: (description != null ? description.value : this.description),
      amount: (amount != null ? amount.value : this.amount),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      foreignCurrencyCode:
          (foreignCurrencyCode != null
              ? foreignCurrencyCode.value
              : this.foreignCurrencyCode),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      tags: (tags != null ? tags.value : this.tags),
      piggyBankId: (piggyBankId != null ? piggyBankId.value : this.piggyBankId),
      billId: (billId != null ? billId.value : this.billId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecurrenceTransactionUpdate {
  const RecurrenceTransactionUpdate({
    required this.id,
    this.description,
    this.amount,
    this.foreignAmount,
    this.currencyId,
    this.currencyCode,
    this.foreignCurrencyId,
    this.budgetId,
    this.categoryId,
    this.sourceId,
    this.destinationId,
    this.tags,
    this.piggyBankId,
    this.billId,
  });

  factory RecurrenceTransactionUpdate.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceTransactionUpdateFromJson(json);

  static const toJsonFactory = _$RecurrenceTransactionUpdateToJson;
  Map<String, dynamic> toJson() => _$RecurrenceTransactionUpdateToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String? sourceId;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String? destinationId;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'piggy_bank_id', includeIfNull: false)
  final String? piggyBankId;
  @JsonKey(name: 'bill_id', includeIfNull: false)
  final String? billId;
  static const fromJsonFactory = _$RecurrenceTransactionUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RecurrenceTransactionUpdateExtension on RecurrenceTransactionUpdate {
  RecurrenceTransactionUpdate copyWith({
    String? id,
    String? description,
    String? amount,
    String? foreignAmount,
    String? currencyId,
    String? currencyCode,
    String? foreignCurrencyId,
    String? budgetId,
    String? categoryId,
    String? sourceId,
    String? destinationId,
    List<String>? tags,
    String? piggyBankId,
    String? billId,
  }) {
    return RecurrenceTransactionUpdate(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      budgetId: budgetId ?? this.budgetId,
      categoryId: categoryId ?? this.categoryId,
      sourceId: sourceId ?? this.sourceId,
      destinationId: destinationId ?? this.destinationId,
      tags: tags ?? this.tags,
      piggyBankId: piggyBankId ?? this.piggyBankId,
      billId: billId ?? this.billId,
    );
  }

  RecurrenceTransactionUpdate copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String?>? description,
    Wrapped<String?>? amount,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? categoryId,
    Wrapped<String?>? sourceId,
    Wrapped<String?>? destinationId,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? piggyBankId,
    Wrapped<String?>? billId,
  }) {
    return RecurrenceTransactionUpdate(
      id: (id != null ? id.value : this.id),
      description: (description != null ? description.value : this.description),
      amount: (amount != null ? amount.value : this.amount),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      tags: (tags != null ? tags.value : this.tags),
      piggyBankId: (piggyBankId != null ? piggyBankId.value : this.piggyBankId),
      billId: (billId != null ? billId.value : this.billId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Rule {
  const Rule({
    this.createdAt,
    this.updatedAt,
    required this.title,
    this.description,
    required this.ruleGroupId,
    this.ruleGroupTitle,
    this.order,
    required this.trigger,
    this.active,
    this.strict,
    this.stopProcessing,
    required this.triggers,
    required this.actions,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  static const toJsonFactory = _$RuleToJson;
  Map<String, dynamic> toJson() => _$RuleToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'rule_group_id', includeIfNull: false)
  final String ruleGroupId;
  @JsonKey(name: 'rule_group_title', includeIfNull: false)
  final String? ruleGroupTitle;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(
    name: 'trigger',
    includeIfNull: false,
    toJson: ruleTriggerTypeToJson,
    fromJson: ruleTriggerTypeFromJson,
  )
  final enums.RuleTriggerType trigger;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'strict', includeIfNull: false)
  final bool? strict;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  @JsonKey(
    name: 'triggers',
    includeIfNull: false,
    defaultValue: <RuleTrigger>[],
  )
  final List<RuleTrigger> triggers;
  @JsonKey(name: 'actions', includeIfNull: false, defaultValue: <RuleAction>[])
  final List<RuleAction> actions;
  static const fromJsonFactory = _$RuleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleExtension on Rule {
  Rule copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    String? ruleGroupId,
    String? ruleGroupTitle,
    int? order,
    enums.RuleTriggerType? trigger,
    bool? active,
    bool? strict,
    bool? stopProcessing,
    List<RuleTrigger>? triggers,
    List<RuleAction>? actions,
  }) {
    return Rule(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      ruleGroupId: ruleGroupId ?? this.ruleGroupId,
      ruleGroupTitle: ruleGroupTitle ?? this.ruleGroupTitle,
      order: order ?? this.order,
      trigger: trigger ?? this.trigger,
      active: active ?? this.active,
      strict: strict ?? this.strict,
      stopProcessing: stopProcessing ?? this.stopProcessing,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
    );
  }

  Rule copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<String>? ruleGroupId,
    Wrapped<String?>? ruleGroupTitle,
    Wrapped<int?>? order,
    Wrapped<enums.RuleTriggerType>? trigger,
    Wrapped<bool?>? active,
    Wrapped<bool?>? strict,
    Wrapped<bool?>? stopProcessing,
    Wrapped<List<RuleTrigger>>? triggers,
    Wrapped<List<RuleAction>>? actions,
  }) {
    return Rule(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      ruleGroupId: (ruleGroupId != null ? ruleGroupId.value : this.ruleGroupId),
      ruleGroupTitle:
          (ruleGroupTitle != null ? ruleGroupTitle.value : this.ruleGroupTitle),
      order: (order != null ? order.value : this.order),
      trigger: (trigger != null ? trigger.value : this.trigger),
      active: (active != null ? active.value : this.active),
      strict: (strict != null ? strict.value : this.strict),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
      triggers: (triggers != null ? triggers.value : this.triggers),
      actions: (actions != null ? actions.value : this.actions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleStore {
  const RuleStore({
    required this.title,
    this.description,
    required this.ruleGroupId,
    this.ruleGroupTitle,
    this.order,
    required this.trigger,
    this.active,
    this.strict,
    this.stopProcessing,
    required this.triggers,
    required this.actions,
  });

  factory RuleStore.fromJson(Map<String, dynamic> json) =>
      _$RuleStoreFromJson(json);

  static const toJsonFactory = _$RuleStoreToJson;
  Map<String, dynamic> toJson() => _$RuleStoreToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'rule_group_id', includeIfNull: false)
  final String ruleGroupId;
  @JsonKey(name: 'rule_group_title', includeIfNull: false)
  final String? ruleGroupTitle;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(
    name: 'trigger',
    includeIfNull: false,
    toJson: ruleTriggerTypeToJson,
    fromJson: ruleTriggerTypeFromJson,
  )
  final enums.RuleTriggerType trigger;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'strict', includeIfNull: false, defaultValue: true)
  final bool? strict;
  @JsonKey(name: 'stop_processing', includeIfNull: false)
  final bool? stopProcessing;
  @JsonKey(
    name: 'triggers',
    includeIfNull: false,
    defaultValue: <RuleTriggerStore>[],
  )
  final List<RuleTriggerStore> triggers;
  @JsonKey(
    name: 'actions',
    includeIfNull: false,
    defaultValue: <RuleActionStore>[],
  )
  final List<RuleActionStore> actions;
  static const fromJsonFactory = _$RuleStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleStoreExtension on RuleStore {
  RuleStore copyWith({
    String? title,
    String? description,
    String? ruleGroupId,
    String? ruleGroupTitle,
    int? order,
    enums.RuleTriggerType? trigger,
    bool? active,
    bool? strict,
    bool? stopProcessing,
    List<RuleTriggerStore>? triggers,
    List<RuleActionStore>? actions,
  }) {
    return RuleStore(
      title: title ?? this.title,
      description: description ?? this.description,
      ruleGroupId: ruleGroupId ?? this.ruleGroupId,
      ruleGroupTitle: ruleGroupTitle ?? this.ruleGroupTitle,
      order: order ?? this.order,
      trigger: trigger ?? this.trigger,
      active: active ?? this.active,
      strict: strict ?? this.strict,
      stopProcessing: stopProcessing ?? this.stopProcessing,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
    );
  }

  RuleStore copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<String>? ruleGroupId,
    Wrapped<String?>? ruleGroupTitle,
    Wrapped<int?>? order,
    Wrapped<enums.RuleTriggerType>? trigger,
    Wrapped<bool?>? active,
    Wrapped<bool?>? strict,
    Wrapped<bool?>? stopProcessing,
    Wrapped<List<RuleTriggerStore>>? triggers,
    Wrapped<List<RuleActionStore>>? actions,
  }) {
    return RuleStore(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      ruleGroupId: (ruleGroupId != null ? ruleGroupId.value : this.ruleGroupId),
      ruleGroupTitle:
          (ruleGroupTitle != null ? ruleGroupTitle.value : this.ruleGroupTitle),
      order: (order != null ? order.value : this.order),
      trigger: (trigger != null ? trigger.value : this.trigger),
      active: (active != null ? active.value : this.active),
      strict: (strict != null ? strict.value : this.strict),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
      triggers: (triggers != null ? triggers.value : this.triggers),
      actions: (actions != null ? actions.value : this.actions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleUpdate {
  const RuleUpdate({
    this.title,
    this.description,
    this.ruleGroupId,
    this.order,
    this.trigger,
    this.active,
    this.strict,
    this.stopProcessing,
    this.triggers,
    this.actions,
  });

  factory RuleUpdate.fromJson(Map<String, dynamic> json) =>
      _$RuleUpdateFromJson(json);

  static const toJsonFactory = _$RuleUpdateToJson;
  Map<String, dynamic> toJson() => _$RuleUpdateToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'rule_group_id', includeIfNull: false)
  final String? ruleGroupId;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(
    name: 'trigger',
    includeIfNull: false,
    toJson: ruleTriggerTypeNullableToJson,
    fromJson: ruleTriggerTypeNullableFromJson,
  )
  final enums.RuleTriggerType? trigger;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'strict', includeIfNull: false)
  final bool? strict;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  @JsonKey(
    name: 'triggers',
    includeIfNull: false,
    defaultValue: <RuleTriggerUpdate>[],
  )
  final List<RuleTriggerUpdate>? triggers;
  @JsonKey(
    name: 'actions',
    includeIfNull: false,
    defaultValue: <RuleActionUpdate>[],
  )
  final List<RuleActionUpdate>? actions;
  static const fromJsonFactory = _$RuleUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleUpdateExtension on RuleUpdate {
  RuleUpdate copyWith({
    String? title,
    String? description,
    String? ruleGroupId,
    int? order,
    enums.RuleTriggerType? trigger,
    bool? active,
    bool? strict,
    bool? stopProcessing,
    List<RuleTriggerUpdate>? triggers,
    List<RuleActionUpdate>? actions,
  }) {
    return RuleUpdate(
      title: title ?? this.title,
      description: description ?? this.description,
      ruleGroupId: ruleGroupId ?? this.ruleGroupId,
      order: order ?? this.order,
      trigger: trigger ?? this.trigger,
      active: active ?? this.active,
      strict: strict ?? this.strict,
      stopProcessing: stopProcessing ?? this.stopProcessing,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
    );
  }

  RuleUpdate copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<String?>? ruleGroupId,
    Wrapped<int?>? order,
    Wrapped<enums.RuleTriggerType?>? trigger,
    Wrapped<bool?>? active,
    Wrapped<bool?>? strict,
    Wrapped<bool?>? stopProcessing,
    Wrapped<List<RuleTriggerUpdate>?>? triggers,
    Wrapped<List<RuleActionUpdate>?>? actions,
  }) {
    return RuleUpdate(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      ruleGroupId: (ruleGroupId != null ? ruleGroupId.value : this.ruleGroupId),
      order: (order != null ? order.value : this.order),
      trigger: (trigger != null ? trigger.value : this.trigger),
      active: (active != null ? active.value : this.active),
      strict: (strict != null ? strict.value : this.strict),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
      triggers: (triggers != null ? triggers.value : this.triggers),
      actions: (actions != null ? actions.value : this.actions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleAction {
  const RuleAction({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.type,
    this.$value,
    this.order,
    this.active,
    this.stopProcessing,
  });

  factory RuleAction.fromJson(Map<String, dynamic> json) =>
      _$RuleActionFromJson(json);

  static const toJsonFactory = _$RuleActionToJson;
  Map<String, dynamic> toJson() => _$RuleActionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleActionKeywordToJson,
    fromJson: ruleActionKeywordFromJson,
  )
  final enums.RuleActionKeyword type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String? $value;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleActionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleActionExtension on RuleAction {
  RuleAction copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    enums.RuleActionKeyword? type,
    String? $value,
    int? order,
    bool? active,
    bool? stopProcessing,
  }) {
    return RuleAction(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      $value: $value ?? this.$value,
      order: order ?? this.order,
      active: active ?? this.active,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleAction copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<enums.RuleActionKeyword>? type,
    Wrapped<String?>? $value,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleAction(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleActionStore {
  const RuleActionStore({
    required this.type,
    this.$value,
    this.order,
    this.active,
    this.stopProcessing,
  });

  factory RuleActionStore.fromJson(Map<String, dynamic> json) =>
      _$RuleActionStoreFromJson(json);

  static const toJsonFactory = _$RuleActionStoreToJson;
  Map<String, dynamic> toJson() => _$RuleActionStoreToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleActionKeywordToJson,
    fromJson: ruleActionKeywordFromJson,
  )
  final enums.RuleActionKeyword type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String? $value;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleActionStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleActionStoreExtension on RuleActionStore {
  RuleActionStore copyWith({
    enums.RuleActionKeyword? type,
    String? $value,
    int? order,
    bool? active,
    bool? stopProcessing,
  }) {
    return RuleActionStore(
      type: type ?? this.type,
      $value: $value ?? this.$value,
      order: order ?? this.order,
      active: active ?? this.active,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleActionStore copyWithWrapped({
    Wrapped<enums.RuleActionKeyword>? type,
    Wrapped<String?>? $value,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleActionStore(
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleActionUpdate {
  const RuleActionUpdate({
    this.type,
    this.$value,
    this.order,
    this.active,
    this.stopProcessing,
  });

  factory RuleActionUpdate.fromJson(Map<String, dynamic> json) =>
      _$RuleActionUpdateFromJson(json);

  static const toJsonFactory = _$RuleActionUpdateToJson;
  Map<String, dynamic> toJson() => _$RuleActionUpdateToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleActionKeywordNullableToJson,
    fromJson: ruleActionKeywordNullableFromJson,
  )
  final enums.RuleActionKeyword? type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String? $value;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'stop_processing', includeIfNull: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleActionUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleActionUpdateExtension on RuleActionUpdate {
  RuleActionUpdate copyWith({
    enums.RuleActionKeyword? type,
    String? $value,
    int? order,
    bool? active,
    bool? stopProcessing,
  }) {
    return RuleActionUpdate(
      type: type ?? this.type,
      $value: $value ?? this.$value,
      order: order ?? this.order,
      active: active ?? this.active,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleActionUpdate copyWithWrapped({
    Wrapped<enums.RuleActionKeyword?>? type,
    Wrapped<String?>? $value,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleActionUpdate(
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroup {
  const RuleGroup({
    this.createdAt,
    this.updatedAt,
    required this.title,
    this.description,
    this.order,
    this.active,
  });

  factory RuleGroup.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupFromJson(json);

  static const toJsonFactory = _$RuleGroupToJson;
  Map<String, dynamic> toJson() => _$RuleGroupToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$RuleGroupFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupExtension on RuleGroup {
  RuleGroup copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    int? order,
    bool? active,
  }) {
    return RuleGroup(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      active: active ?? this.active,
    );
  }

  RuleGroup copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
  }) {
    return RuleGroup(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroupStore {
  const RuleGroupStore({
    required this.title,
    this.description,
    this.order,
    this.active,
  });

  factory RuleGroupStore.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupStoreFromJson(json);

  static const toJsonFactory = _$RuleGroupStoreToJson;
  Map<String, dynamic> toJson() => _$RuleGroupStoreToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$RuleGroupStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupStoreExtension on RuleGroupStore {
  RuleGroupStore copyWith({
    String? title,
    String? description,
    int? order,
    bool? active,
  }) {
    return RuleGroupStore(
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      active: active ?? this.active,
    );
  }

  RuleGroupStore copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
  }) {
    return RuleGroupStore(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleGroupUpdate {
  const RuleGroupUpdate({
    this.title,
    this.description,
    this.order,
    this.active,
  });

  factory RuleGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$RuleGroupUpdateFromJson(json);

  static const toJsonFactory = _$RuleGroupUpdateToJson;
  Map<String, dynamic> toJson() => _$RuleGroupUpdateToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  static const fromJsonFactory = _$RuleGroupUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleGroupUpdateExtension on RuleGroupUpdate {
  RuleGroupUpdate copyWith({
    String? title,
    String? description,
    int? order,
    bool? active,
  }) {
    return RuleGroupUpdate(
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      active: active ?? this.active,
    );
  }

  RuleGroupUpdate copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
  }) {
    return RuleGroupUpdate(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleTrigger {
  const RuleTrigger({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.type,
    required this.$value,
    this.prohibited,
    this.order,
    this.active,
    this.stopProcessing,
  });

  factory RuleTrigger.fromJson(Map<String, dynamic> json) =>
      _$RuleTriggerFromJson(json);

  static const toJsonFactory = _$RuleTriggerToJson;
  Map<String, dynamic> toJson() => _$RuleTriggerToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleTriggerKeywordToJson,
    fromJson: ruleTriggerKeywordFromJson,
  )
  final enums.RuleTriggerKeyword type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String $value;
  @JsonKey(name: 'prohibited', includeIfNull: false, defaultValue: false)
  final bool? prohibited;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleTriggerFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleTriggerExtension on RuleTrigger {
  RuleTrigger copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    enums.RuleTriggerKeyword? type,
    String? $value,
    bool? prohibited,
    int? order,
    bool? active,
    bool? stopProcessing,
  }) {
    return RuleTrigger(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      $value: $value ?? this.$value,
      prohibited: prohibited ?? this.prohibited,
      order: order ?? this.order,
      active: active ?? this.active,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleTrigger copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<enums.RuleTriggerKeyword>? type,
    Wrapped<String>? $value,
    Wrapped<bool?>? prohibited,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleTrigger(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      prohibited: (prohibited != null ? prohibited.value : this.prohibited),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleTriggerStore {
  const RuleTriggerStore({
    required this.type,
    required this.$value,
    this.order,
    this.active,
    this.prohibited,
    this.stopProcessing,
  });

  factory RuleTriggerStore.fromJson(Map<String, dynamic> json) =>
      _$RuleTriggerStoreFromJson(json);

  static const toJsonFactory = _$RuleTriggerStoreToJson;
  Map<String, dynamic> toJson() => _$RuleTriggerStoreToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleTriggerKeywordToJson,
    fromJson: ruleTriggerKeywordFromJson,
  )
  final enums.RuleTriggerKeyword type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String $value;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false, defaultValue: true)
  final bool? active;
  @JsonKey(name: 'prohibited', includeIfNull: false, defaultValue: false)
  final bool? prohibited;
  @JsonKey(name: 'stop_processing', includeIfNull: false, defaultValue: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleTriggerStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleTriggerStoreExtension on RuleTriggerStore {
  RuleTriggerStore copyWith({
    enums.RuleTriggerKeyword? type,
    String? $value,
    int? order,
    bool? active,
    bool? prohibited,
    bool? stopProcessing,
  }) {
    return RuleTriggerStore(
      type: type ?? this.type,
      $value: $value ?? this.$value,
      order: order ?? this.order,
      active: active ?? this.active,
      prohibited: prohibited ?? this.prohibited,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleTriggerStore copyWithWrapped({
    Wrapped<enums.RuleTriggerKeyword>? type,
    Wrapped<String>? $value,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? prohibited,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleTriggerStore(
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      prohibited: (prohibited != null ? prohibited.value : this.prohibited),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RuleTriggerUpdate {
  const RuleTriggerUpdate({
    this.type,
    this.$value,
    this.order,
    this.active,
    this.stopProcessing,
  });

  factory RuleTriggerUpdate.fromJson(Map<String, dynamic> json) =>
      _$RuleTriggerUpdateFromJson(json);

  static const toJsonFactory = _$RuleTriggerUpdateToJson;
  Map<String, dynamic> toJson() => _$RuleTriggerUpdateToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: ruleTriggerKeywordNullableToJson,
    fromJson: ruleTriggerKeywordNullableFromJson,
  )
  final enums.RuleTriggerKeyword? type;
  @JsonKey(name: 'value', includeIfNull: false)
  final String? $value;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'stop_processing', includeIfNull: false)
  final bool? stopProcessing;
  static const fromJsonFactory = _$RuleTriggerUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $RuleTriggerUpdateExtension on RuleTriggerUpdate {
  RuleTriggerUpdate copyWith({
    enums.RuleTriggerKeyword? type,
    String? $value,
    int? order,
    bool? active,
    bool? stopProcessing,
  }) {
    return RuleTriggerUpdate(
      type: type ?? this.type,
      $value: $value ?? this.$value,
      order: order ?? this.order,
      active: active ?? this.active,
      stopProcessing: stopProcessing ?? this.stopProcessing,
    );
  }

  RuleTriggerUpdate copyWithWrapped({
    Wrapped<enums.RuleTriggerKeyword?>? type,
    Wrapped<String?>? $value,
    Wrapped<int?>? order,
    Wrapped<bool?>? active,
    Wrapped<bool?>? stopProcessing,
  }) {
    return RuleTriggerUpdate(
      type: (type != null ? type.value : this.type),
      $value: ($value != null ? $value.value : this.$value),
      order: (order != null ? order.value : this.order),
      active: (active != null ? active.value : this.active),
      stopProcessing:
          (stopProcessing != null ? stopProcessing.value : this.stopProcessing),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TagModel {
  const TagModel({
    this.createdAt,
    this.updatedAt,
    required this.tag,
    this.date,
    this.description,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  static const toJsonFactory = _$TagModelToJson;
  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'tag', includeIfNull: false)
  final String tag;
  @JsonKey(name: 'date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  static const fromJsonFactory = _$TagModelFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagModelExtension on TagModel {
  TagModel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? tag,
    DateTime? date,
    String? description,
    double? latitude,
    double? longitude,
    int? zoomLevel,
  }) {
    return TagModel(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tag: tag ?? this.tag,
      date: date ?? this.date,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  TagModel copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? tag,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? description,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
  }) {
    return TagModel(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      tag: (tag != null ? tag.value : this.tag),
      date: (date != null ? date.value : this.date),
      description: (description != null ? description.value : this.description),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TagModelStore {
  const TagModelStore({
    required this.tag,
    this.date,
    this.description,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory TagModelStore.fromJson(Map<String, dynamic> json) =>
      _$TagModelStoreFromJson(json);

  static const toJsonFactory = _$TagModelStoreToJson;
  Map<String, dynamic> toJson() => _$TagModelStoreToJson(this);

  @JsonKey(name: 'tag', includeIfNull: false)
  final String tag;
  @JsonKey(name: 'date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  static const fromJsonFactory = _$TagModelStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagModelStoreExtension on TagModelStore {
  TagModelStore copyWith({
    String? tag,
    DateTime? date,
    String? description,
    double? latitude,
    double? longitude,
    int? zoomLevel,
  }) {
    return TagModelStore(
      tag: tag ?? this.tag,
      date: date ?? this.date,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  TagModelStore copyWithWrapped({
    Wrapped<String>? tag,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? description,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
  }) {
    return TagModelStore(
      tag: (tag != null ? tag.value : this.tag),
      date: (date != null ? date.value : this.date),
      description: (description != null ? description.value : this.description),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TagModelUpdate {
  const TagModelUpdate({
    this.tag,
    this.date,
    this.description,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory TagModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$TagModelUpdateFromJson(json);

  static const toJsonFactory = _$TagModelUpdateToJson;
  Map<String, dynamic> toJson() => _$TagModelUpdateToJson(this);

  @JsonKey(name: 'tag', includeIfNull: false)
  final String? tag;
  @JsonKey(name: 'date', includeIfNull: false, toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  static const fromJsonFactory = _$TagModelUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TagModelUpdateExtension on TagModelUpdate {
  TagModelUpdate copyWith({
    String? tag,
    DateTime? date,
    String? description,
    double? latitude,
    double? longitude,
    int? zoomLevel,
  }) {
    return TagModelUpdate(
      tag: tag ?? this.tag,
      date: date ?? this.date,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  TagModelUpdate copyWithWrapped({
    Wrapped<String?>? tag,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? description,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
  }) {
    return TagModelUpdate(
      tag: (tag != null ? tag.value : this.tag),
      date: (date != null ? date.value : this.date),
      description: (description != null ? description.value : this.description),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyProperties {
  const CurrencyProperties({
    this.createdAt,
    this.updatedAt,
    this.enabled,
    this.primary,
    required this.code,
    required this.name,
    required this.symbol,
    this.decimalPlaces,
  });

  factory CurrencyProperties.fromJson(Map<String, dynamic> json) =>
      _$CurrencyPropertiesFromJson(json);

  static const toJsonFactory = _$CurrencyPropertiesToJson;
  Map<String, dynamic> toJson() => _$CurrencyPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'enabled', includeIfNull: false, defaultValue: true)
  final bool? enabled;
  @JsonKey(name: 'primary', includeIfNull: false)
  final bool? primary;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int? decimalPlaces;
  static const fromJsonFactory = _$CurrencyPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyPropertiesExtension on CurrencyProperties {
  CurrencyProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? enabled,
    bool? primary,
    String? code,
    String? name,
    String? symbol,
    int? decimalPlaces,
  }) {
    return CurrencyProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      enabled: enabled ?? this.enabled,
      primary: primary ?? this.primary,
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    );
  }

  CurrencyProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? enabled,
    Wrapped<bool?>? primary,
    Wrapped<String>? code,
    Wrapped<String>? name,
    Wrapped<String>? symbol,
    Wrapped<int?>? decimalPlaces,
  }) {
    return CurrencyProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      enabled: (enabled != null ? enabled.value : this.enabled),
      primary: (primary != null ? primary.value : this.primary),
      code: (code != null ? code.value : this.code),
      name: (name != null ? name.value : this.name),
      symbol: (symbol != null ? symbol.value : this.symbol),
      decimalPlaces:
          (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyStore {
  const CurrencyStore({
    this.enabled,
    this.primary,
    required this.code,
    required this.name,
    required this.symbol,
    this.decimalPlaces,
  });

  factory CurrencyStore.fromJson(Map<String, dynamic> json) =>
      _$CurrencyStoreFromJson(json);

  static const toJsonFactory = _$CurrencyStoreToJson;
  Map<String, dynamic> toJson() => _$CurrencyStoreToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false, defaultValue: true)
  final bool? enabled;
  @JsonKey(name: 'primary', includeIfNull: false)
  final bool? primary;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int? decimalPlaces;
  static const fromJsonFactory = _$CurrencyStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyStoreExtension on CurrencyStore {
  CurrencyStore copyWith({
    bool? enabled,
    bool? primary,
    String? code,
    String? name,
    String? symbol,
    int? decimalPlaces,
  }) {
    return CurrencyStore(
      enabled: enabled ?? this.enabled,
      primary: primary ?? this.primary,
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    );
  }

  CurrencyStore copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<bool?>? primary,
    Wrapped<String>? code,
    Wrapped<String>? name,
    Wrapped<String>? symbol,
    Wrapped<int?>? decimalPlaces,
  }) {
    return CurrencyStore(
      enabled: (enabled != null ? enabled.value : this.enabled),
      primary: (primary != null ? primary.value : this.primary),
      code: (code != null ? code.value : this.code),
      name: (name != null ? name.value : this.name),
      symbol: (symbol != null ? symbol.value : this.symbol),
      decimalPlaces:
          (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyUpdate {
  const CurrencyUpdate({
    this.enabled,
    this.primary,
    this.code,
    this.name,
    this.symbol,
    this.decimalPlaces,
  });

  factory CurrencyUpdate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyUpdateFromJson(json);

  static const toJsonFactory = _$CurrencyUpdateToJson;
  Map<String, dynamic> toJson() => _$CurrencyUpdateToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'primary', includeIfNull: false)
  final bool? primary;
  @JsonKey(name: 'code', includeIfNull: false)
  final String? code;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String? symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int? decimalPlaces;
  static const fromJsonFactory = _$CurrencyUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyUpdateExtension on CurrencyUpdate {
  CurrencyUpdate copyWith({
    bool? enabled,
    bool? primary,
    String? code,
    String? name,
    String? symbol,
    int? decimalPlaces,
  }) {
    return CurrencyUpdate(
      enabled: enabled ?? this.enabled,
      primary: primary ?? this.primary,
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    );
  }

  CurrencyUpdate copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<bool?>? primary,
    Wrapped<String?>? code,
    Wrapped<String?>? name,
    Wrapped<String?>? symbol,
    Wrapped<int?>? decimalPlaces,
  }) {
    return CurrencyUpdate(
      enabled: (enabled != null ? enabled.value : this.enabled),
      primary: (primary != null ? primary.value : this.primary),
      code: (code != null ? code.value : this.code),
      name: (name != null ? name.value : this.name),
      symbol: (symbol != null ? symbol.value : this.symbol),
      decimalPlaces:
          (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction {
  const Transaction({
    this.createdAt,
    this.updatedAt,
    this.user,
    this.groupTitle,
    required this.transactions,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  static const toJsonFactory = _$TransactionToJson;
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'user', includeIfNull: false)
  final String? user;
  @JsonKey(name: 'group_title', includeIfNull: false)
  final String? groupTitle;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <TransactionSplit>[],
  )
  final List<TransactionSplit> transactions;
  static const fromJsonFactory = _$TransactionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionExtension on Transaction {
  Transaction copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? user,
    String? groupTitle,
    List<TransactionSplit>? transactions,
  }) {
    return Transaction(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      groupTitle: groupTitle ?? this.groupTitle,
      transactions: transactions ?? this.transactions,
    );
  }

  Transaction copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? user,
    Wrapped<String?>? groupTitle,
    Wrapped<List<TransactionSplit>>? transactions,
  }) {
    return Transaction(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      user: (user != null ? user.value : this.user),
      groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionStore {
  const TransactionStore({
    this.errorIfDuplicateHash,
    this.applyRules,
    this.fireWebhooks,
    this.groupTitle,
    required this.transactions,
  });

  factory TransactionStore.fromJson(Map<String, dynamic> json) =>
      _$TransactionStoreFromJson(json);

  static const toJsonFactory = _$TransactionStoreToJson;
  Map<String, dynamic> toJson() => _$TransactionStoreToJson(this);

  @JsonKey(name: 'error_if_duplicate_hash', includeIfNull: false)
  final bool? errorIfDuplicateHash;
  @JsonKey(name: 'apply_rules', includeIfNull: false)
  final bool? applyRules;
  @JsonKey(name: 'fire_webhooks', includeIfNull: false, defaultValue: true)
  final bool? fireWebhooks;
  @JsonKey(name: 'group_title', includeIfNull: false)
  final String? groupTitle;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <TransactionSplitStore>[],
  )
  final List<TransactionSplitStore> transactions;
  static const fromJsonFactory = _$TransactionStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionStoreExtension on TransactionStore {
  TransactionStore copyWith({
    bool? errorIfDuplicateHash,
    bool? applyRules,
    bool? fireWebhooks,
    String? groupTitle,
    List<TransactionSplitStore>? transactions,
  }) {
    return TransactionStore(
      errorIfDuplicateHash: errorIfDuplicateHash ?? this.errorIfDuplicateHash,
      applyRules: applyRules ?? this.applyRules,
      fireWebhooks: fireWebhooks ?? this.fireWebhooks,
      groupTitle: groupTitle ?? this.groupTitle,
      transactions: transactions ?? this.transactions,
    );
  }

  TransactionStore copyWithWrapped({
    Wrapped<bool?>? errorIfDuplicateHash,
    Wrapped<bool?>? applyRules,
    Wrapped<bool?>? fireWebhooks,
    Wrapped<String?>? groupTitle,
    Wrapped<List<TransactionSplitStore>>? transactions,
  }) {
    return TransactionStore(
      errorIfDuplicateHash:
          (errorIfDuplicateHash != null
              ? errorIfDuplicateHash.value
              : this.errorIfDuplicateHash),
      applyRules: (applyRules != null ? applyRules.value : this.applyRules),
      fireWebhooks:
          (fireWebhooks != null ? fireWebhooks.value : this.fireWebhooks),
      groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionUpdate {
  const TransactionUpdate({
    this.applyRules,
    this.fireWebhooks,
    this.groupTitle,
    this.transactions,
  });

  factory TransactionUpdate.fromJson(Map<String, dynamic> json) =>
      _$TransactionUpdateFromJson(json);

  static const toJsonFactory = _$TransactionUpdateToJson;
  Map<String, dynamic> toJson() => _$TransactionUpdateToJson(this);

  @JsonKey(name: 'apply_rules', includeIfNull: false)
  final bool? applyRules;
  @JsonKey(name: 'fire_webhooks', includeIfNull: false, defaultValue: true)
  final bool? fireWebhooks;
  @JsonKey(name: 'group_title', includeIfNull: false)
  final String? groupTitle;
  @JsonKey(
    name: 'transactions',
    includeIfNull: false,
    defaultValue: <TransactionSplitUpdate>[],
  )
  final List<TransactionSplitUpdate>? transactions;
  static const fromJsonFactory = _$TransactionUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionUpdateExtension on TransactionUpdate {
  TransactionUpdate copyWith({
    bool? applyRules,
    bool? fireWebhooks,
    String? groupTitle,
    List<TransactionSplitUpdate>? transactions,
  }) {
    return TransactionUpdate(
      applyRules: applyRules ?? this.applyRules,
      fireWebhooks: fireWebhooks ?? this.fireWebhooks,
      groupTitle: groupTitle ?? this.groupTitle,
      transactions: transactions ?? this.transactions,
    );
  }

  TransactionUpdate copyWithWrapped({
    Wrapped<bool?>? applyRules,
    Wrapped<bool?>? fireWebhooks,
    Wrapped<String?>? groupTitle,
    Wrapped<List<TransactionSplitUpdate>?>? transactions,
  }) {
    return TransactionUpdate(
      applyRules: (applyRules != null ? applyRules.value : this.applyRules),
      fireWebhooks:
          (fireWebhooks != null ? fireWebhooks.value : this.fireWebhooks),
      groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
      transactions:
          (transactions != null ? transactions.value : this.transactions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLink {
  const TransactionLink({
    this.createdAt,
    this.updatedAt,
    this.linkTypeId,
    this.linkTypeName,
    required this.inwardId,
    required this.outwardId,
    this.notes,
  });

  factory TransactionLink.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkFromJson(json);

  static const toJsonFactory = _$TransactionLinkToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'link_type_id', includeIfNull: false)
  final String? linkTypeId;
  @JsonKey(name: 'link_type_name', includeIfNull: false)
  final String? linkTypeName;
  @JsonKey(name: 'inward_id', includeIfNull: false)
  final String inwardId;
  @JsonKey(name: 'outward_id', includeIfNull: false)
  final String outwardId;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$TransactionLinkFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkExtension on TransactionLink {
  TransactionLink copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? linkTypeId,
    String? linkTypeName,
    String? inwardId,
    String? outwardId,
    String? notes,
  }) {
    return TransactionLink(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      linkTypeId: linkTypeId ?? this.linkTypeId,
      linkTypeName: linkTypeName ?? this.linkTypeName,
      inwardId: inwardId ?? this.inwardId,
      outwardId: outwardId ?? this.outwardId,
      notes: notes ?? this.notes,
    );
  }

  TransactionLink copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? linkTypeId,
    Wrapped<String?>? linkTypeName,
    Wrapped<String>? inwardId,
    Wrapped<String>? outwardId,
    Wrapped<String?>? notes,
  }) {
    return TransactionLink(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      linkTypeId: (linkTypeId != null ? linkTypeId.value : this.linkTypeId),
      linkTypeName:
          (linkTypeName != null ? linkTypeName.value : this.linkTypeName),
      inwardId: (inwardId != null ? inwardId.value : this.inwardId),
      outwardId: (outwardId != null ? outwardId.value : this.outwardId),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLinkStore {
  const TransactionLinkStore({
    this.linkTypeId,
    this.linkTypeName,
    required this.inwardId,
    required this.outwardId,
    this.notes,
  });

  factory TransactionLinkStore.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkStoreFromJson(json);

  static const toJsonFactory = _$TransactionLinkStoreToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkStoreToJson(this);

  @JsonKey(name: 'link_type_id', includeIfNull: false)
  final String? linkTypeId;
  @JsonKey(name: 'link_type_name', includeIfNull: false)
  final String? linkTypeName;
  @JsonKey(name: 'inward_id', includeIfNull: false)
  final String inwardId;
  @JsonKey(name: 'outward_id', includeIfNull: false)
  final String outwardId;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$TransactionLinkStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkStoreExtension on TransactionLinkStore {
  TransactionLinkStore copyWith({
    String? linkTypeId,
    String? linkTypeName,
    String? inwardId,
    String? outwardId,
    String? notes,
  }) {
    return TransactionLinkStore(
      linkTypeId: linkTypeId ?? this.linkTypeId,
      linkTypeName: linkTypeName ?? this.linkTypeName,
      inwardId: inwardId ?? this.inwardId,
      outwardId: outwardId ?? this.outwardId,
      notes: notes ?? this.notes,
    );
  }

  TransactionLinkStore copyWithWrapped({
    Wrapped<String?>? linkTypeId,
    Wrapped<String?>? linkTypeName,
    Wrapped<String>? inwardId,
    Wrapped<String>? outwardId,
    Wrapped<String?>? notes,
  }) {
    return TransactionLinkStore(
      linkTypeId: (linkTypeId != null ? linkTypeId.value : this.linkTypeId),
      linkTypeName:
          (linkTypeName != null ? linkTypeName.value : this.linkTypeName),
      inwardId: (inwardId != null ? inwardId.value : this.inwardId),
      outwardId: (outwardId != null ? outwardId.value : this.outwardId),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionLinkUpdate {
  const TransactionLinkUpdate({
    this.linkTypeId,
    this.linkTypeName,
    this.inwardId,
    this.outwardId,
    this.notes,
  });

  factory TransactionLinkUpdate.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinkUpdateFromJson(json);

  static const toJsonFactory = _$TransactionLinkUpdateToJson;
  Map<String, dynamic> toJson() => _$TransactionLinkUpdateToJson(this);

  @JsonKey(name: 'link_type_id', includeIfNull: false)
  final String? linkTypeId;
  @JsonKey(name: 'link_type_name', includeIfNull: false)
  final String? linkTypeName;
  @JsonKey(name: 'inward_id', includeIfNull: false)
  final String? inwardId;
  @JsonKey(name: 'outward_id', includeIfNull: false)
  final String? outwardId;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  static const fromJsonFactory = _$TransactionLinkUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionLinkUpdateExtension on TransactionLinkUpdate {
  TransactionLinkUpdate copyWith({
    String? linkTypeId,
    String? linkTypeName,
    String? inwardId,
    String? outwardId,
    String? notes,
  }) {
    return TransactionLinkUpdate(
      linkTypeId: linkTypeId ?? this.linkTypeId,
      linkTypeName: linkTypeName ?? this.linkTypeName,
      inwardId: inwardId ?? this.inwardId,
      outwardId: outwardId ?? this.outwardId,
      notes: notes ?? this.notes,
    );
  }

  TransactionLinkUpdate copyWithWrapped({
    Wrapped<String?>? linkTypeId,
    Wrapped<String?>? linkTypeName,
    Wrapped<String?>? inwardId,
    Wrapped<String?>? outwardId,
    Wrapped<String?>? notes,
  }) {
    return TransactionLinkUpdate(
      linkTypeId: (linkTypeId != null ? linkTypeId.value : this.linkTypeId),
      linkTypeName:
          (linkTypeName != null ? linkTypeName.value : this.linkTypeName),
      inwardId: (inwardId != null ? inwardId.value : this.inwardId),
      outwardId: (outwardId != null ? outwardId.value : this.outwardId),
      notes: (notes != null ? notes.value : this.notes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LinkType {
  const LinkType({
    required this.name,
    required this.inward,
    required this.outward,
    this.editable,
  });

  factory LinkType.fromJson(Map<String, dynamic> json) =>
      _$LinkTypeFromJson(json);

  static const toJsonFactory = _$LinkTypeToJson;
  Map<String, dynamic> toJson() => _$LinkTypeToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'inward', includeIfNull: false)
  final String inward;
  @JsonKey(name: 'outward', includeIfNull: false)
  final String outward;
  @JsonKey(name: 'editable', includeIfNull: false)
  final bool? editable;
  static const fromJsonFactory = _$LinkTypeFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $LinkTypeExtension on LinkType {
  LinkType copyWith({
    String? name,
    String? inward,
    String? outward,
    bool? editable,
  }) {
    return LinkType(
      name: name ?? this.name,
      inward: inward ?? this.inward,
      outward: outward ?? this.outward,
      editable: editable ?? this.editable,
    );
  }

  LinkType copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? inward,
    Wrapped<String>? outward,
    Wrapped<bool?>? editable,
  }) {
    return LinkType(
      name: (name != null ? name.value : this.name),
      inward: (inward != null ? inward.value : this.inward),
      outward: (outward != null ? outward.value : this.outward),
      editable: (editable != null ? editable.value : this.editable),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LinkTypeUpdate {
  const LinkTypeUpdate({this.name, this.inward, this.outward});

  factory LinkTypeUpdate.fromJson(Map<String, dynamic> json) =>
      _$LinkTypeUpdateFromJson(json);

  static const toJsonFactory = _$LinkTypeUpdateToJson;
  Map<String, dynamic> toJson() => _$LinkTypeUpdateToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'inward', includeIfNull: false)
  final String? inward;
  @JsonKey(name: 'outward', includeIfNull: false)
  final String? outward;
  static const fromJsonFactory = _$LinkTypeUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $LinkTypeUpdateExtension on LinkTypeUpdate {
  LinkTypeUpdate copyWith({String? name, String? inward, String? outward}) {
    return LinkTypeUpdate(
      name: name ?? this.name,
      inward: inward ?? this.inward,
      outward: outward ?? this.outward,
    );
  }

  LinkTypeUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? inward,
    Wrapped<String?>? outward,
  }) {
    return LinkTypeUpdate(
      name: (name != null ? name.value : this.name),
      inward: (inward != null ? inward.value : this.inward),
      outward: (outward != null ? outward.value : this.outward),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionSplit {
  const TransactionSplit({
    this.user,
    this.transactionJournalId,
    required this.type,
    required this.date,
    this.order,
    this.objectHasCurrencySetting,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.currencyDecimalPlaces,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    required this.amount,
    this.pcAmount,
    this.foreignAmount,
    this.pcForeignAmount,
    this.sourceBalanceAfter,
    this.pcSourceBalanceAfter,
    this.destinationBalanceAfter,
    this.pcDestinationBalanceAfter,
    required this.description,
    this.sourceId,
    this.sourceName,
    this.sourceIban,
    this.sourceType,
    this.destinationId,
    this.destinationName,
    this.destinationIban,
    this.destinationType,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.billId,
    this.billName,
    this.subscriptionId,
    this.subscriptionName,
    this.reconciled,
    this.notes,
    this.tags,
    this.internalReference,
    this.externalId,
    this.externalUrl,
    this.originalSource,
    this.recurrenceId,
    this.recurrenceTotal,
    this.recurrenceCount,
    this.importHashV2,
    this.sepaCc,
    this.sepaCtOp,
    this.sepaCtId,
    this.sepaDb,
    this.sepaCountry,
    this.sepaEp,
    this.sepaCi,
    this.sepaBatchId,
    this.interestDate,
    this.bookDate,
    this.processDate,
    this.dueDate,
    this.paymentDate,
    this.invoiceDate,
    this.latitude,
    this.longitude,
    this.zoomLevel,
    this.hasAttachments,
  });

  factory TransactionSplit.fromJson(Map<String, dynamic> json) =>
      _$TransactionSplitFromJson(json);

  static const toJsonFactory = _$TransactionSplitToJson;
  Map<String, dynamic> toJson() => _$TransactionSplitToJson(this);

  @JsonKey(name: 'user', includeIfNull: false)
  final String? user;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: transactionTypePropertyToJson,
    fromJson: transactionTypePropertyFromJson,
  )
  final enums.TransactionTypeProperty type;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime date;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'object_has_currency_setting', includeIfNull: false)
  final bool? objectHasCurrencySetting;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol', includeIfNull: false)
  final String? foreignCurrencySymbol;
  @JsonKey(name: 'foreign_currency_decimal_places', includeIfNull: false)
  final int? foreignCurrencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'pc_foreign_amount', includeIfNull: false)
  final String? pcForeignAmount;
  @JsonKey(name: 'source_balance_after', includeIfNull: false)
  final String? sourceBalanceAfter;
  @JsonKey(name: 'pc_source_balance_after', includeIfNull: false)
  final String? pcSourceBalanceAfter;
  @JsonKey(name: 'destination_balance_after', includeIfNull: false)
  final String? destinationBalanceAfter;
  @JsonKey(name: 'pc_destination_balance_after', includeIfNull: false)
  final String? pcDestinationBalanceAfter;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String? sourceId;
  @JsonKey(name: 'source_name', includeIfNull: false)
  final String? sourceName;
  @JsonKey(name: 'source_iban', includeIfNull: false)
  final String? sourceIban;
  @JsonKey(
    name: 'source_type',
    includeIfNull: false,
    toJson: accountTypePropertyNullableToJson,
    fromJson: accountTypePropertyNullableFromJson,
  )
  final enums.AccountTypeProperty? sourceType;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String? destinationId;
  @JsonKey(name: 'destination_name', includeIfNull: false)
  final String? destinationName;
  @JsonKey(name: 'destination_iban', includeIfNull: false)
  final String? destinationIban;
  @JsonKey(
    name: 'destination_type',
    includeIfNull: false,
    toJson: accountTypePropertyNullableToJson,
    fromJson: accountTypePropertyNullableFromJson,
  )
  final enums.AccountTypeProperty? destinationType;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'budget_name', includeIfNull: false)
  final String? budgetName;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'category_name', includeIfNull: false)
  final String? categoryName;
  @JsonKey(name: 'bill_id', includeIfNull: false)
  final String? billId;
  @JsonKey(name: 'bill_name', includeIfNull: false)
  final String? billName;
  @JsonKey(name: 'subscription_id', includeIfNull: false)
  final String? subscriptionId;
  @JsonKey(name: 'subscription_name', includeIfNull: false)
  final String? subscriptionName;
  @JsonKey(name: 'reconciled', includeIfNull: false)
  final bool? reconciled;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'internal_reference', includeIfNull: false)
  final String? internalReference;
  @JsonKey(name: 'external_id', includeIfNull: false)
  final String? externalId;
  @JsonKey(name: 'external_url', includeIfNull: false)
  final String? externalUrl;
  @JsonKey(name: 'original_source', includeIfNull: false)
  final String? originalSource;
  @JsonKey(name: 'recurrence_id', includeIfNull: false)
  final String? recurrenceId;
  @JsonKey(name: 'recurrence_total', includeIfNull: false)
  final int? recurrenceTotal;
  @JsonKey(name: 'recurrence_count', includeIfNull: false)
  final int? recurrenceCount;
  @JsonKey(name: 'import_hash_v2', includeIfNull: false)
  final String? importHashV2;
  @JsonKey(name: 'sepa_cc', includeIfNull: false)
  final String? sepaCc;
  @JsonKey(name: 'sepa_ct_op', includeIfNull: false)
  final String? sepaCtOp;
  @JsonKey(name: 'sepa_ct_id', includeIfNull: false)
  final String? sepaCtId;
  @JsonKey(name: 'sepa_db', includeIfNull: false)
  final String? sepaDb;
  @JsonKey(name: 'sepa_country', includeIfNull: false)
  final String? sepaCountry;
  @JsonKey(name: 'sepa_ep', includeIfNull: false)
  final String? sepaEp;
  @JsonKey(name: 'sepa_ci', includeIfNull: false)
  final String? sepaCi;
  @JsonKey(name: 'sepa_batch_id', includeIfNull: false)
  final String? sepaBatchId;
  @JsonKey(name: 'interest_date', includeIfNull: false)
  final DateTime? interestDate;
  @JsonKey(name: 'book_date', includeIfNull: false)
  final DateTime? bookDate;
  @JsonKey(name: 'process_date', includeIfNull: false)
  final DateTime? processDate;
  @JsonKey(name: 'due_date', includeIfNull: false)
  final DateTime? dueDate;
  @JsonKey(name: 'payment_date', includeIfNull: false)
  final DateTime? paymentDate;
  @JsonKey(name: 'invoice_date', includeIfNull: false)
  final DateTime? invoiceDate;
  @JsonKey(name: 'latitude', includeIfNull: false)
  final double? latitude;
  @JsonKey(name: 'longitude', includeIfNull: false)
  final double? longitude;
  @JsonKey(name: 'zoom_level', includeIfNull: false)
  final int? zoomLevel;
  @JsonKey(name: 'has_attachments', includeIfNull: false)
  final bool? hasAttachments;
  static const fromJsonFactory = _$TransactionSplitFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSplitExtension on TransactionSplit {
  TransactionSplit copyWith({
    String? user,
    String? transactionJournalId,
    enums.TransactionTypeProperty? type,
    DateTime? date,
    int? order,
    bool? objectHasCurrencySetting,
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    int? currencyDecimalPlaces,
    String? foreignCurrencyId,
    String? foreignCurrencyCode,
    String? foreignCurrencySymbol,
    int? foreignCurrencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amount,
    String? pcAmount,
    String? foreignAmount,
    String? pcForeignAmount,
    String? sourceBalanceAfter,
    String? pcSourceBalanceAfter,
    String? destinationBalanceAfter,
    String? pcDestinationBalanceAfter,
    String? description,
    String? sourceId,
    String? sourceName,
    String? sourceIban,
    enums.AccountTypeProperty? sourceType,
    String? destinationId,
    String? destinationName,
    String? destinationIban,
    enums.AccountTypeProperty? destinationType,
    String? budgetId,
    String? budgetName,
    String? categoryId,
    String? categoryName,
    String? billId,
    String? billName,
    String? subscriptionId,
    String? subscriptionName,
    bool? reconciled,
    String? notes,
    List<String>? tags,
    String? internalReference,
    String? externalId,
    String? externalUrl,
    String? originalSource,
    String? recurrenceId,
    int? recurrenceTotal,
    int? recurrenceCount,
    String? importHashV2,
    String? sepaCc,
    String? sepaCtOp,
    String? sepaCtId,
    String? sepaDb,
    String? sepaCountry,
    String? sepaEp,
    String? sepaCi,
    String? sepaBatchId,
    DateTime? interestDate,
    DateTime? bookDate,
    DateTime? processDate,
    DateTime? dueDate,
    DateTime? paymentDate,
    DateTime? invoiceDate,
    double? latitude,
    double? longitude,
    int? zoomLevel,
    bool? hasAttachments,
  }) {
    return TransactionSplit(
      user: user ?? this.user,
      transactionJournalId: transactionJournalId ?? this.transactionJournalId,
      type: type ?? this.type,
      date: date ?? this.date,
      order: order ?? this.order,
      objectHasCurrencySetting:
          objectHasCurrencySetting ?? this.objectHasCurrencySetting,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
      foreignCurrencySymbol:
          foreignCurrencySymbol ?? this.foreignCurrencySymbol,
      foreignCurrencyDecimalPlaces:
          foreignCurrencyDecimalPlaces ?? this.foreignCurrencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      pcForeignAmount: pcForeignAmount ?? this.pcForeignAmount,
      sourceBalanceAfter: sourceBalanceAfter ?? this.sourceBalanceAfter,
      pcSourceBalanceAfter: pcSourceBalanceAfter ?? this.pcSourceBalanceAfter,
      destinationBalanceAfter:
          destinationBalanceAfter ?? this.destinationBalanceAfter,
      pcDestinationBalanceAfter:
          pcDestinationBalanceAfter ?? this.pcDestinationBalanceAfter,
      description: description ?? this.description,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      sourceIban: sourceIban ?? this.sourceIban,
      sourceType: sourceType ?? this.sourceType,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      destinationIban: destinationIban ?? this.destinationIban,
      destinationType: destinationType ?? this.destinationType,
      budgetId: budgetId ?? this.budgetId,
      budgetName: budgetName ?? this.budgetName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      billId: billId ?? this.billId,
      billName: billName ?? this.billName,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      subscriptionName: subscriptionName ?? this.subscriptionName,
      reconciled: reconciled ?? this.reconciled,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      internalReference: internalReference ?? this.internalReference,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      originalSource: originalSource ?? this.originalSource,
      recurrenceId: recurrenceId ?? this.recurrenceId,
      recurrenceTotal: recurrenceTotal ?? this.recurrenceTotal,
      recurrenceCount: recurrenceCount ?? this.recurrenceCount,
      importHashV2: importHashV2 ?? this.importHashV2,
      sepaCc: sepaCc ?? this.sepaCc,
      sepaCtOp: sepaCtOp ?? this.sepaCtOp,
      sepaCtId: sepaCtId ?? this.sepaCtId,
      sepaDb: sepaDb ?? this.sepaDb,
      sepaCountry: sepaCountry ?? this.sepaCountry,
      sepaEp: sepaEp ?? this.sepaEp,
      sepaCi: sepaCi ?? this.sepaCi,
      sepaBatchId: sepaBatchId ?? this.sepaBatchId,
      interestDate: interestDate ?? this.interestDate,
      bookDate: bookDate ?? this.bookDate,
      processDate: processDate ?? this.processDate,
      dueDate: dueDate ?? this.dueDate,
      paymentDate: paymentDate ?? this.paymentDate,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasAttachments: hasAttachments ?? this.hasAttachments,
    );
  }

  TransactionSplit copyWithWrapped({
    Wrapped<String?>? user,
    Wrapped<String?>? transactionJournalId,
    Wrapped<enums.TransactionTypeProperty>? type,
    Wrapped<DateTime>? date,
    Wrapped<int?>? order,
    Wrapped<bool?>? objectHasCurrencySetting,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<String?>? currencyName,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? foreignCurrencyCode,
    Wrapped<String?>? foreignCurrencySymbol,
    Wrapped<int?>? foreignCurrencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? pcForeignAmount,
    Wrapped<String?>? sourceBalanceAfter,
    Wrapped<String?>? pcSourceBalanceAfter,
    Wrapped<String?>? destinationBalanceAfter,
    Wrapped<String?>? pcDestinationBalanceAfter,
    Wrapped<String>? description,
    Wrapped<String?>? sourceId,
    Wrapped<String?>? sourceName,
    Wrapped<String?>? sourceIban,
    Wrapped<enums.AccountTypeProperty?>? sourceType,
    Wrapped<String?>? destinationId,
    Wrapped<String?>? destinationName,
    Wrapped<String?>? destinationIban,
    Wrapped<enums.AccountTypeProperty?>? destinationType,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? budgetName,
    Wrapped<String?>? categoryId,
    Wrapped<String?>? categoryName,
    Wrapped<String?>? billId,
    Wrapped<String?>? billName,
    Wrapped<String?>? subscriptionId,
    Wrapped<String?>? subscriptionName,
    Wrapped<bool?>? reconciled,
    Wrapped<String?>? notes,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? internalReference,
    Wrapped<String?>? externalId,
    Wrapped<String?>? externalUrl,
    Wrapped<String?>? originalSource,
    Wrapped<String?>? recurrenceId,
    Wrapped<int?>? recurrenceTotal,
    Wrapped<int?>? recurrenceCount,
    Wrapped<String?>? importHashV2,
    Wrapped<String?>? sepaCc,
    Wrapped<String?>? sepaCtOp,
    Wrapped<String?>? sepaCtId,
    Wrapped<String?>? sepaDb,
    Wrapped<String?>? sepaCountry,
    Wrapped<String?>? sepaEp,
    Wrapped<String?>? sepaCi,
    Wrapped<String?>? sepaBatchId,
    Wrapped<DateTime?>? interestDate,
    Wrapped<DateTime?>? bookDate,
    Wrapped<DateTime?>? processDate,
    Wrapped<DateTime?>? dueDate,
    Wrapped<DateTime?>? paymentDate,
    Wrapped<DateTime?>? invoiceDate,
    Wrapped<double?>? latitude,
    Wrapped<double?>? longitude,
    Wrapped<int?>? zoomLevel,
    Wrapped<bool?>? hasAttachments,
  }) {
    return TransactionSplit(
      user: (user != null ? user.value : this.user),
      transactionJournalId:
          (transactionJournalId != null
              ? transactionJournalId.value
              : this.transactionJournalId),
      type: (type != null ? type.value : this.type),
      date: (date != null ? date.value : this.date),
      order: (order != null ? order.value : this.order),
      objectHasCurrencySetting:
          (objectHasCurrencySetting != null
              ? objectHasCurrencySetting.value
              : this.objectHasCurrencySetting),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      foreignCurrencyCode:
          (foreignCurrencyCode != null
              ? foreignCurrencyCode.value
              : this.foreignCurrencyCode),
      foreignCurrencySymbol:
          (foreignCurrencySymbol != null
              ? foreignCurrencySymbol.value
              : this.foreignCurrencySymbol),
      foreignCurrencyDecimalPlaces:
          (foreignCurrencyDecimalPlaces != null
              ? foreignCurrencyDecimalPlaces.value
              : this.foreignCurrencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      pcForeignAmount:
          (pcForeignAmount != null
              ? pcForeignAmount.value
              : this.pcForeignAmount),
      sourceBalanceAfter:
          (sourceBalanceAfter != null
              ? sourceBalanceAfter.value
              : this.sourceBalanceAfter),
      pcSourceBalanceAfter:
          (pcSourceBalanceAfter != null
              ? pcSourceBalanceAfter.value
              : this.pcSourceBalanceAfter),
      destinationBalanceAfter:
          (destinationBalanceAfter != null
              ? destinationBalanceAfter.value
              : this.destinationBalanceAfter),
      pcDestinationBalanceAfter:
          (pcDestinationBalanceAfter != null
              ? pcDestinationBalanceAfter.value
              : this.pcDestinationBalanceAfter),
      description: (description != null ? description.value : this.description),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      sourceName: (sourceName != null ? sourceName.value : this.sourceName),
      sourceIban: (sourceIban != null ? sourceIban.value : this.sourceIban),
      sourceType: (sourceType != null ? sourceType.value : this.sourceType),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      destinationName:
          (destinationName != null
              ? destinationName.value
              : this.destinationName),
      destinationIban:
          (destinationIban != null
              ? destinationIban.value
              : this.destinationIban),
      destinationType:
          (destinationType != null
              ? destinationType.value
              : this.destinationType),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      budgetName: (budgetName != null ? budgetName.value : this.budgetName),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      categoryName:
          (categoryName != null ? categoryName.value : this.categoryName),
      billId: (billId != null ? billId.value : this.billId),
      billName: (billName != null ? billName.value : this.billName),
      subscriptionId:
          (subscriptionId != null ? subscriptionId.value : this.subscriptionId),
      subscriptionName:
          (subscriptionName != null
              ? subscriptionName.value
              : this.subscriptionName),
      reconciled: (reconciled != null ? reconciled.value : this.reconciled),
      notes: (notes != null ? notes.value : this.notes),
      tags: (tags != null ? tags.value : this.tags),
      internalReference:
          (internalReference != null
              ? internalReference.value
              : this.internalReference),
      externalId: (externalId != null ? externalId.value : this.externalId),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
      originalSource:
          (originalSource != null ? originalSource.value : this.originalSource),
      recurrenceId:
          (recurrenceId != null ? recurrenceId.value : this.recurrenceId),
      recurrenceTotal:
          (recurrenceTotal != null
              ? recurrenceTotal.value
              : this.recurrenceTotal),
      recurrenceCount:
          (recurrenceCount != null
              ? recurrenceCount.value
              : this.recurrenceCount),
      importHashV2:
          (importHashV2 != null ? importHashV2.value : this.importHashV2),
      sepaCc: (sepaCc != null ? sepaCc.value : this.sepaCc),
      sepaCtOp: (sepaCtOp != null ? sepaCtOp.value : this.sepaCtOp),
      sepaCtId: (sepaCtId != null ? sepaCtId.value : this.sepaCtId),
      sepaDb: (sepaDb != null ? sepaDb.value : this.sepaDb),
      sepaCountry: (sepaCountry != null ? sepaCountry.value : this.sepaCountry),
      sepaEp: (sepaEp != null ? sepaEp.value : this.sepaEp),
      sepaCi: (sepaCi != null ? sepaCi.value : this.sepaCi),
      sepaBatchId: (sepaBatchId != null ? sepaBatchId.value : this.sepaBatchId),
      interestDate:
          (interestDate != null ? interestDate.value : this.interestDate),
      bookDate: (bookDate != null ? bookDate.value : this.bookDate),
      processDate: (processDate != null ? processDate.value : this.processDate),
      dueDate: (dueDate != null ? dueDate.value : this.dueDate),
      paymentDate: (paymentDate != null ? paymentDate.value : this.paymentDate),
      invoiceDate: (invoiceDate != null ? invoiceDate.value : this.invoiceDate),
      latitude: (latitude != null ? latitude.value : this.latitude),
      longitude: (longitude != null ? longitude.value : this.longitude),
      zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
      hasAttachments:
          (hasAttachments != null ? hasAttachments.value : this.hasAttachments),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionSplitStore {
  const TransactionSplitStore({
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    this.order,
    this.currencyId,
    this.currencyCode,
    this.foreignAmount,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.sourceId,
    this.sourceName,
    this.destinationId,
    this.destinationName,
    this.reconciled,
    this.piggyBankId,
    this.piggyBankName,
    this.billId,
    this.billName,
    this.tags,
    this.notes,
    this.internalReference,
    this.externalId,
    this.externalUrl,
    this.sepaCc,
    this.sepaCtOp,
    this.sepaCtId,
    this.sepaDb,
    this.sepaCountry,
    this.sepaEp,
    this.sepaCi,
    this.sepaBatchId,
    this.interestDate,
    this.bookDate,
    this.processDate,
    this.dueDate,
    this.paymentDate,
    this.invoiceDate,
  });

  factory TransactionSplitStore.fromJson(Map<String, dynamic> json) =>
      _$TransactionSplitStoreFromJson(json);

  static const toJsonFactory = _$TransactionSplitStoreToJson;
  Map<String, dynamic> toJson() => _$TransactionSplitStoreToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: transactionTypePropertyToJson,
    fromJson: transactionTypePropertyFromJson,
  )
  final enums.TransactionTypeProperty type;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime date;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'budget_name', includeIfNull: false)
  final String? budgetName;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'category_name', includeIfNull: false)
  final String? categoryName;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String? sourceId;
  @JsonKey(name: 'source_name', includeIfNull: false)
  final String? sourceName;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String? destinationId;
  @JsonKey(name: 'destination_name', includeIfNull: false)
  final String? destinationName;
  @JsonKey(name: 'reconciled', includeIfNull: false)
  final bool? reconciled;
  @JsonKey(name: 'piggy_bank_id', includeIfNull: false)
  final int? piggyBankId;
  @JsonKey(name: 'piggy_bank_name', includeIfNull: false)
  final String? piggyBankName;
  @JsonKey(name: 'bill_id', includeIfNull: false)
  final String? billId;
  @JsonKey(name: 'bill_name', includeIfNull: false)
  final String? billName;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'internal_reference', includeIfNull: false)
  final String? internalReference;
  @JsonKey(name: 'external_id', includeIfNull: false)
  final String? externalId;
  @JsonKey(name: 'external_url', includeIfNull: false)
  final String? externalUrl;
  @JsonKey(name: 'sepa_cc', includeIfNull: false)
  final String? sepaCc;
  @JsonKey(name: 'sepa_ct_op', includeIfNull: false)
  final String? sepaCtOp;
  @JsonKey(name: 'sepa_ct_id', includeIfNull: false)
  final String? sepaCtId;
  @JsonKey(name: 'sepa_db', includeIfNull: false)
  final String? sepaDb;
  @JsonKey(name: 'sepa_country', includeIfNull: false)
  final String? sepaCountry;
  @JsonKey(name: 'sepa_ep', includeIfNull: false)
  final String? sepaEp;
  @JsonKey(name: 'sepa_ci', includeIfNull: false)
  final String? sepaCi;
  @JsonKey(name: 'sepa_batch_id', includeIfNull: false)
  final String? sepaBatchId;
  @JsonKey(name: 'interest_date', includeIfNull: false)
  final DateTime? interestDate;
  @JsonKey(name: 'book_date', includeIfNull: false)
  final DateTime? bookDate;
  @JsonKey(name: 'process_date', includeIfNull: false)
  final DateTime? processDate;
  @JsonKey(name: 'due_date', includeIfNull: false)
  final DateTime? dueDate;
  @JsonKey(name: 'payment_date', includeIfNull: false)
  final DateTime? paymentDate;
  @JsonKey(name: 'invoice_date', includeIfNull: false)
  final DateTime? invoiceDate;
  static const fromJsonFactory = _$TransactionSplitStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSplitStoreExtension on TransactionSplitStore {
  TransactionSplitStore copyWith({
    enums.TransactionTypeProperty? type,
    DateTime? date,
    String? amount,
    String? description,
    int? order,
    String? currencyId,
    String? currencyCode,
    String? foreignAmount,
    String? foreignCurrencyId,
    String? foreignCurrencyCode,
    String? budgetId,
    String? budgetName,
    String? categoryId,
    String? categoryName,
    String? sourceId,
    String? sourceName,
    String? destinationId,
    String? destinationName,
    bool? reconciled,
    int? piggyBankId,
    String? piggyBankName,
    String? billId,
    String? billName,
    List<String>? tags,
    String? notes,
    String? internalReference,
    String? externalId,
    String? externalUrl,
    String? sepaCc,
    String? sepaCtOp,
    String? sepaCtId,
    String? sepaDb,
    String? sepaCountry,
    String? sepaEp,
    String? sepaCi,
    String? sepaBatchId,
    DateTime? interestDate,
    DateTime? bookDate,
    DateTime? processDate,
    DateTime? dueDate,
    DateTime? paymentDate,
    DateTime? invoiceDate,
  }) {
    return TransactionSplitStore(
      type: type ?? this.type,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      order: order ?? this.order,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
      budgetId: budgetId ?? this.budgetId,
      budgetName: budgetName ?? this.budgetName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      reconciled: reconciled ?? this.reconciled,
      piggyBankId: piggyBankId ?? this.piggyBankId,
      piggyBankName: piggyBankName ?? this.piggyBankName,
      billId: billId ?? this.billId,
      billName: billName ?? this.billName,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      internalReference: internalReference ?? this.internalReference,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      sepaCc: sepaCc ?? this.sepaCc,
      sepaCtOp: sepaCtOp ?? this.sepaCtOp,
      sepaCtId: sepaCtId ?? this.sepaCtId,
      sepaDb: sepaDb ?? this.sepaDb,
      sepaCountry: sepaCountry ?? this.sepaCountry,
      sepaEp: sepaEp ?? this.sepaEp,
      sepaCi: sepaCi ?? this.sepaCi,
      sepaBatchId: sepaBatchId ?? this.sepaBatchId,
      interestDate: interestDate ?? this.interestDate,
      bookDate: bookDate ?? this.bookDate,
      processDate: processDate ?? this.processDate,
      dueDate: dueDate ?? this.dueDate,
      paymentDate: paymentDate ?? this.paymentDate,
      invoiceDate: invoiceDate ?? this.invoiceDate,
    );
  }

  TransactionSplitStore copyWithWrapped({
    Wrapped<enums.TransactionTypeProperty>? type,
    Wrapped<DateTime>? date,
    Wrapped<String>? amount,
    Wrapped<String>? description,
    Wrapped<int?>? order,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? foreignCurrencyCode,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? budgetName,
    Wrapped<String?>? categoryId,
    Wrapped<String?>? categoryName,
    Wrapped<String?>? sourceId,
    Wrapped<String?>? sourceName,
    Wrapped<String?>? destinationId,
    Wrapped<String?>? destinationName,
    Wrapped<bool?>? reconciled,
    Wrapped<int?>? piggyBankId,
    Wrapped<String?>? piggyBankName,
    Wrapped<String?>? billId,
    Wrapped<String?>? billName,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? notes,
    Wrapped<String?>? internalReference,
    Wrapped<String?>? externalId,
    Wrapped<String?>? externalUrl,
    Wrapped<String?>? sepaCc,
    Wrapped<String?>? sepaCtOp,
    Wrapped<String?>? sepaCtId,
    Wrapped<String?>? sepaDb,
    Wrapped<String?>? sepaCountry,
    Wrapped<String?>? sepaEp,
    Wrapped<String?>? sepaCi,
    Wrapped<String?>? sepaBatchId,
    Wrapped<DateTime?>? interestDate,
    Wrapped<DateTime?>? bookDate,
    Wrapped<DateTime?>? processDate,
    Wrapped<DateTime?>? dueDate,
    Wrapped<DateTime?>? paymentDate,
    Wrapped<DateTime?>? invoiceDate,
  }) {
    return TransactionSplitStore(
      type: (type != null ? type.value : this.type),
      date: (date != null ? date.value : this.date),
      amount: (amount != null ? amount.value : this.amount),
      description: (description != null ? description.value : this.description),
      order: (order != null ? order.value : this.order),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      foreignCurrencyCode:
          (foreignCurrencyCode != null
              ? foreignCurrencyCode.value
              : this.foreignCurrencyCode),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      budgetName: (budgetName != null ? budgetName.value : this.budgetName),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      categoryName:
          (categoryName != null ? categoryName.value : this.categoryName),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      sourceName: (sourceName != null ? sourceName.value : this.sourceName),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      destinationName:
          (destinationName != null
              ? destinationName.value
              : this.destinationName),
      reconciled: (reconciled != null ? reconciled.value : this.reconciled),
      piggyBankId: (piggyBankId != null ? piggyBankId.value : this.piggyBankId),
      piggyBankName:
          (piggyBankName != null ? piggyBankName.value : this.piggyBankName),
      billId: (billId != null ? billId.value : this.billId),
      billName: (billName != null ? billName.value : this.billName),
      tags: (tags != null ? tags.value : this.tags),
      notes: (notes != null ? notes.value : this.notes),
      internalReference:
          (internalReference != null
              ? internalReference.value
              : this.internalReference),
      externalId: (externalId != null ? externalId.value : this.externalId),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
      sepaCc: (sepaCc != null ? sepaCc.value : this.sepaCc),
      sepaCtOp: (sepaCtOp != null ? sepaCtOp.value : this.sepaCtOp),
      sepaCtId: (sepaCtId != null ? sepaCtId.value : this.sepaCtId),
      sepaDb: (sepaDb != null ? sepaDb.value : this.sepaDb),
      sepaCountry: (sepaCountry != null ? sepaCountry.value : this.sepaCountry),
      sepaEp: (sepaEp != null ? sepaEp.value : this.sepaEp),
      sepaCi: (sepaCi != null ? sepaCi.value : this.sepaCi),
      sepaBatchId: (sepaBatchId != null ? sepaBatchId.value : this.sepaBatchId),
      interestDate:
          (interestDate != null ? interestDate.value : this.interestDate),
      bookDate: (bookDate != null ? bookDate.value : this.bookDate),
      processDate: (processDate != null ? processDate.value : this.processDate),
      dueDate: (dueDate != null ? dueDate.value : this.dueDate),
      paymentDate: (paymentDate != null ? paymentDate.value : this.paymentDate),
      invoiceDate: (invoiceDate != null ? invoiceDate.value : this.invoiceDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionSplitUpdate {
  const TransactionSplitUpdate({
    this.transactionJournalId,
    this.type,
    this.date,
    this.amount,
    this.description,
    this.order,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.currencyDecimalPlaces,
    this.foreignAmount,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.sourceId,
    this.sourceName,
    this.sourceIban,
    this.destinationId,
    this.destinationName,
    this.destinationIban,
    this.reconciled,
    this.billId,
    this.billName,
    this.tags,
    this.notes,
    this.internalReference,
    this.externalId,
    this.externalUrl,
    this.sepaCc,
    this.sepaCtOp,
    this.sepaCtId,
    this.sepaDb,
    this.sepaCountry,
    this.sepaEp,
    this.sepaCi,
    this.sepaBatchId,
    this.interestDate,
    this.bookDate,
    this.processDate,
    this.dueDate,
    this.paymentDate,
    this.invoiceDate,
  });

  factory TransactionSplitUpdate.fromJson(Map<String, dynamic> json) =>
      _$TransactionSplitUpdateFromJson(json);

  static const toJsonFactory = _$TransactionSplitUpdateToJson;
  Map<String, dynamic> toJson() => _$TransactionSplitUpdateToJson(this);

  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: transactionTypePropertyNullableToJson,
    fromJson: transactionTypePropertyNullableFromJson,
  )
  final enums.TransactionTypeProperty? type;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol', includeIfNull: false)
  final String? foreignCurrencySymbol;
  @JsonKey(name: 'foreign_currency_decimal_places', includeIfNull: false)
  final int? foreignCurrencyDecimalPlaces;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String? budgetId;
  @JsonKey(name: 'budget_name', includeIfNull: false)
  final String? budgetName;
  @JsonKey(name: 'category_id', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'category_name', includeIfNull: false)
  final String? categoryName;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String? sourceId;
  @JsonKey(name: 'source_name', includeIfNull: false)
  final String? sourceName;
  @JsonKey(name: 'source_iban', includeIfNull: false)
  final String? sourceIban;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String? destinationId;
  @JsonKey(name: 'destination_name', includeIfNull: false)
  final String? destinationName;
  @JsonKey(name: 'destination_iban', includeIfNull: false)
  final String? destinationIban;
  @JsonKey(name: 'reconciled', includeIfNull: false)
  final bool? reconciled;
  @JsonKey(name: 'bill_id', includeIfNull: false)
  final String? billId;
  @JsonKey(name: 'bill_name', includeIfNull: false)
  final String? billName;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'notes', includeIfNull: false)
  final String? notes;
  @JsonKey(name: 'internal_reference', includeIfNull: false)
  final String? internalReference;
  @JsonKey(name: 'external_id', includeIfNull: false)
  final String? externalId;
  @JsonKey(name: 'external_url', includeIfNull: false)
  final String? externalUrl;
  @JsonKey(name: 'sepa_cc', includeIfNull: false)
  final String? sepaCc;
  @JsonKey(name: 'sepa_ct_op', includeIfNull: false)
  final String? sepaCtOp;
  @JsonKey(name: 'sepa_ct_id', includeIfNull: false)
  final String? sepaCtId;
  @JsonKey(name: 'sepa_db', includeIfNull: false)
  final String? sepaDb;
  @JsonKey(name: 'sepa_country', includeIfNull: false)
  final String? sepaCountry;
  @JsonKey(name: 'sepa_ep', includeIfNull: false)
  final String? sepaEp;
  @JsonKey(name: 'sepa_ci', includeIfNull: false)
  final String? sepaCi;
  @JsonKey(name: 'sepa_batch_id', includeIfNull: false)
  final String? sepaBatchId;
  @JsonKey(name: 'interest_date', includeIfNull: false)
  final DateTime? interestDate;
  @JsonKey(name: 'book_date', includeIfNull: false)
  final DateTime? bookDate;
  @JsonKey(name: 'process_date', includeIfNull: false)
  final DateTime? processDate;
  @JsonKey(name: 'due_date', includeIfNull: false)
  final DateTime? dueDate;
  @JsonKey(name: 'payment_date', includeIfNull: false)
  final DateTime? paymentDate;
  @JsonKey(name: 'invoice_date', includeIfNull: false)
  final DateTime? invoiceDate;
  static const fromJsonFactory = _$TransactionSplitUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSplitUpdateExtension on TransactionSplitUpdate {
  TransactionSplitUpdate copyWith({
    String? transactionJournalId,
    enums.TransactionTypeProperty? type,
    DateTime? date,
    String? amount,
    String? description,
    int? order,
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    int? currencyDecimalPlaces,
    String? foreignAmount,
    String? foreignCurrencyId,
    String? foreignCurrencyCode,
    String? foreignCurrencySymbol,
    int? foreignCurrencyDecimalPlaces,
    String? budgetId,
    String? budgetName,
    String? categoryId,
    String? categoryName,
    String? sourceId,
    String? sourceName,
    String? sourceIban,
    String? destinationId,
    String? destinationName,
    String? destinationIban,
    bool? reconciled,
    String? billId,
    String? billName,
    List<String>? tags,
    String? notes,
    String? internalReference,
    String? externalId,
    String? externalUrl,
    String? sepaCc,
    String? sepaCtOp,
    String? sepaCtId,
    String? sepaDb,
    String? sepaCountry,
    String? sepaEp,
    String? sepaCi,
    String? sepaBatchId,
    DateTime? interestDate,
    DateTime? bookDate,
    DateTime? processDate,
    DateTime? dueDate,
    DateTime? paymentDate,
    DateTime? invoiceDate,
  }) {
    return TransactionSplitUpdate(
      transactionJournalId: transactionJournalId ?? this.transactionJournalId,
      type: type ?? this.type,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      order: order ?? this.order,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
      foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
      foreignCurrencySymbol:
          foreignCurrencySymbol ?? this.foreignCurrencySymbol,
      foreignCurrencyDecimalPlaces:
          foreignCurrencyDecimalPlaces ?? this.foreignCurrencyDecimalPlaces,
      budgetId: budgetId ?? this.budgetId,
      budgetName: budgetName ?? this.budgetName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      sourceIban: sourceIban ?? this.sourceIban,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      destinationIban: destinationIban ?? this.destinationIban,
      reconciled: reconciled ?? this.reconciled,
      billId: billId ?? this.billId,
      billName: billName ?? this.billName,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      internalReference: internalReference ?? this.internalReference,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      sepaCc: sepaCc ?? this.sepaCc,
      sepaCtOp: sepaCtOp ?? this.sepaCtOp,
      sepaCtId: sepaCtId ?? this.sepaCtId,
      sepaDb: sepaDb ?? this.sepaDb,
      sepaCountry: sepaCountry ?? this.sepaCountry,
      sepaEp: sepaEp ?? this.sepaEp,
      sepaCi: sepaCi ?? this.sepaCi,
      sepaBatchId: sepaBatchId ?? this.sepaBatchId,
      interestDate: interestDate ?? this.interestDate,
      bookDate: bookDate ?? this.bookDate,
      processDate: processDate ?? this.processDate,
      dueDate: dueDate ?? this.dueDate,
      paymentDate: paymentDate ?? this.paymentDate,
      invoiceDate: invoiceDate ?? this.invoiceDate,
    );
  }

  TransactionSplitUpdate copyWithWrapped({
    Wrapped<String?>? transactionJournalId,
    Wrapped<enums.TransactionTypeProperty?>? type,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? amount,
    Wrapped<String?>? description,
    Wrapped<int?>? order,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<String?>? currencyName,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? foreignCurrencyId,
    Wrapped<String?>? foreignCurrencyCode,
    Wrapped<String?>? foreignCurrencySymbol,
    Wrapped<int?>? foreignCurrencyDecimalPlaces,
    Wrapped<String?>? budgetId,
    Wrapped<String?>? budgetName,
    Wrapped<String?>? categoryId,
    Wrapped<String?>? categoryName,
    Wrapped<String?>? sourceId,
    Wrapped<String?>? sourceName,
    Wrapped<String?>? sourceIban,
    Wrapped<String?>? destinationId,
    Wrapped<String?>? destinationName,
    Wrapped<String?>? destinationIban,
    Wrapped<bool?>? reconciled,
    Wrapped<String?>? billId,
    Wrapped<String?>? billName,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? notes,
    Wrapped<String?>? internalReference,
    Wrapped<String?>? externalId,
    Wrapped<String?>? externalUrl,
    Wrapped<String?>? sepaCc,
    Wrapped<String?>? sepaCtOp,
    Wrapped<String?>? sepaCtId,
    Wrapped<String?>? sepaDb,
    Wrapped<String?>? sepaCountry,
    Wrapped<String?>? sepaEp,
    Wrapped<String?>? sepaCi,
    Wrapped<String?>? sepaBatchId,
    Wrapped<DateTime?>? interestDate,
    Wrapped<DateTime?>? bookDate,
    Wrapped<DateTime?>? processDate,
    Wrapped<DateTime?>? dueDate,
    Wrapped<DateTime?>? paymentDate,
    Wrapped<DateTime?>? invoiceDate,
  }) {
    return TransactionSplitUpdate(
      transactionJournalId:
          (transactionJournalId != null
              ? transactionJournalId.value
              : this.transactionJournalId),
      type: (type != null ? type.value : this.type),
      date: (date != null ? date.value : this.date),
      amount: (amount != null ? amount.value : this.amount),
      description: (description != null ? description.value : this.description),
      order: (order != null ? order.value : this.order),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      foreignCurrencyId:
          (foreignCurrencyId != null
              ? foreignCurrencyId.value
              : this.foreignCurrencyId),
      foreignCurrencyCode:
          (foreignCurrencyCode != null
              ? foreignCurrencyCode.value
              : this.foreignCurrencyCode),
      foreignCurrencySymbol:
          (foreignCurrencySymbol != null
              ? foreignCurrencySymbol.value
              : this.foreignCurrencySymbol),
      foreignCurrencyDecimalPlaces:
          (foreignCurrencyDecimalPlaces != null
              ? foreignCurrencyDecimalPlaces.value
              : this.foreignCurrencyDecimalPlaces),
      budgetId: (budgetId != null ? budgetId.value : this.budgetId),
      budgetName: (budgetName != null ? budgetName.value : this.budgetName),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      categoryName:
          (categoryName != null ? categoryName.value : this.categoryName),
      sourceId: (sourceId != null ? sourceId.value : this.sourceId),
      sourceName: (sourceName != null ? sourceName.value : this.sourceName),
      sourceIban: (sourceIban != null ? sourceIban.value : this.sourceIban),
      destinationId:
          (destinationId != null ? destinationId.value : this.destinationId),
      destinationName:
          (destinationName != null
              ? destinationName.value
              : this.destinationName),
      destinationIban:
          (destinationIban != null
              ? destinationIban.value
              : this.destinationIban),
      reconciled: (reconciled != null ? reconciled.value : this.reconciled),
      billId: (billId != null ? billId.value : this.billId),
      billName: (billName != null ? billName.value : this.billName),
      tags: (tags != null ? tags.value : this.tags),
      notes: (notes != null ? notes.value : this.notes),
      internalReference:
          (internalReference != null
              ? internalReference.value
              : this.internalReference),
      externalId: (externalId != null ? externalId.value : this.externalId),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
      sepaCc: (sepaCc != null ? sepaCc.value : this.sepaCc),
      sepaCtOp: (sepaCtOp != null ? sepaCtOp.value : this.sepaCtOp),
      sepaCtId: (sepaCtId != null ? sepaCtId.value : this.sepaCtId),
      sepaDb: (sepaDb != null ? sepaDb.value : this.sepaDb),
      sepaCountry: (sepaCountry != null ? sepaCountry.value : this.sepaCountry),
      sepaEp: (sepaEp != null ? sepaEp.value : this.sepaEp),
      sepaCi: (sepaCi != null ? sepaCi.value : this.sepaCi),
      sepaBatchId: (sepaBatchId != null ? sepaBatchId.value : this.sepaBatchId),
      interestDate:
          (interestDate != null ? interestDate.value : this.interestDate),
      bookDate: (bookDate != null ? bookDate.value : this.bookDate),
      processDate: (processDate != null ? processDate.value : this.processDate),
      dueDate: (dueDate != null ? dueDate.value : this.dueDate),
      paymentDate: (paymentDate != null ? paymentDate.value : this.paymentDate),
      invoiceDate: (invoiceDate != null ? invoiceDate.value : this.invoiceDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class User {
  const User({
    this.createdAt,
    this.updatedAt,
    required this.email,
    this.blocked,
    this.blockedCode,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static const toJsonFactory = _$UserToJson;
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'blocked', includeIfNull: false)
  final bool? blocked;
  @JsonKey(
    name: 'blocked_code',
    includeIfNull: false,
    toJson: userBlockedCodePropertyNullableToJson,
    fromJson: userBlockedCodePropertyNullableFromJson,
  )
  final enums.UserBlockedCodeProperty? blockedCode;
  @JsonKey(
    name: 'role',
    includeIfNull: false,
    toJson: userRolePropertyNullableToJson,
    fromJson: userRolePropertyNullableFromJson,
  )
  final enums.UserRoleProperty? role;
  static const fromJsonFactory = _$UserFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserExtension on User {
  User copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? email,
    bool? blocked,
    enums.UserBlockedCodeProperty? blockedCode,
    enums.UserRoleProperty? role,
  }) {
    return User(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      email: email ?? this.email,
      blocked: blocked ?? this.blocked,
      blockedCode: blockedCode ?? this.blockedCode,
      role: role ?? this.role,
    );
  }

  User copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? email,
    Wrapped<bool?>? blocked,
    Wrapped<enums.UserBlockedCodeProperty?>? blockedCode,
    Wrapped<enums.UserRoleProperty?>? role,
  }) {
    return User(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      email: (email != null ? email.value : this.email),
      blocked: (blocked != null ? blocked.value : this.blocked),
      blockedCode: (blockedCode != null ? blockedCode.value : this.blockedCode),
      role: (role != null ? role.value : this.role),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupRead {
  const UserGroupRead({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory UserGroupRead.fromJson(Map<String, dynamic> json) =>
      _$UserGroupReadFromJson(json);

  static const toJsonFactory = _$UserGroupReadToJson;
  Map<String, dynamic> toJson() => _$UserGroupReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final UserGroupReadAttributes attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLink links;
  static const fromJsonFactory = _$UserGroupReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupReadExtension on UserGroupRead {
  UserGroupRead copyWith({
    String? type,
    String? id,
    UserGroupReadAttributes? attributes,
    ObjectLink? links,
  }) {
    return UserGroupRead(
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      links: links ?? this.links,
    );
  }

  UserGroupRead copyWithWrapped({
    Wrapped<String>? type,
    Wrapped<String>? id,
    Wrapped<UserGroupReadAttributes>? attributes,
    Wrapped<ObjectLink>? links,
  }) {
    return UserGroupRead(
      type: (type != null ? type.value : this.type),
      id: (id != null ? id.value : this.id),
      attributes: (attributes != null ? attributes.value : this.attributes),
      links: (links != null ? links.value : this.links),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupReadAttributes {
  const UserGroupReadAttributes({
    this.createdAt,
    this.updatedAt,
    this.inUse,
    this.canSeeMembers,
    this.title,
    this.primaryCurrencyId,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.members,
  });

  factory UserGroupReadAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserGroupReadAttributesFromJson(json);

  static const toJsonFactory = _$UserGroupReadAttributesToJson;
  Map<String, dynamic> toJson() => _$UserGroupReadAttributesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'in_use', includeIfNull: false)
  final bool? inUse;
  @JsonKey(name: 'can_see_members', includeIfNull: false)
  final bool? canSeeMembers;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(
    name: 'members',
    includeIfNull: false,
    defaultValue: <UserGroupReadMembers>[],
  )
  final List<UserGroupReadMembers>? members;
  static const fromJsonFactory = _$UserGroupReadAttributesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupReadAttributesExtension on UserGroupReadAttributes {
  UserGroupReadAttributes copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? inUse,
    bool? canSeeMembers,
    String? title,
    String? primaryCurrencyId,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    List<UserGroupReadMembers>? members,
  }) {
    return UserGroupReadAttributes(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      inUse: inUse ?? this.inUse,
      canSeeMembers: canSeeMembers ?? this.canSeeMembers,
      title: title ?? this.title,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      members: members ?? this.members,
    );
  }

  UserGroupReadAttributes copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? inUse,
    Wrapped<bool?>? canSeeMembers,
    Wrapped<String?>? title,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<List<UserGroupReadMembers>?>? members,
  }) {
    return UserGroupReadAttributes(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      inUse: (inUse != null ? inUse.value : this.inUse),
      canSeeMembers:
          (canSeeMembers != null ? canSeeMembers.value : this.canSeeMembers),
      title: (title != null ? title.value : this.title),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      members: (members != null ? members.value : this.members),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupReadMembers {
  const UserGroupReadMembers({
    this.userId,
    this.userEmail,
    this.you,
    this.roles,
  });

  factory UserGroupReadMembers.fromJson(Map<String, dynamic> json) =>
      _$UserGroupReadMembersFromJson(json);

  static const toJsonFactory = _$UserGroupReadMembersToJson;
  Map<String, dynamic> toJson() => _$UserGroupReadMembersToJson(this);

  @JsonKey(name: 'user_id', includeIfNull: false)
  final String? userId;
  @JsonKey(name: 'user_email', includeIfNull: false)
  final String? userEmail;
  @JsonKey(name: 'you', includeIfNull: false)
  final bool? you;
  @JsonKey(
    name: 'roles',
    includeIfNull: false,
    toJson: userGroupReadRoleListToJson,
    fromJson: userGroupReadRoleListFromJson,
  )
  final List<enums.UserGroupReadRole>? roles;
  static const fromJsonFactory = _$UserGroupReadMembersFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupReadMembersExtension on UserGroupReadMembers {
  UserGroupReadMembers copyWith({
    String? userId,
    String? userEmail,
    bool? you,
    List<enums.UserGroupReadRole>? roles,
  }) {
    return UserGroupReadMembers(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      you: you ?? this.you,
      roles: roles ?? this.roles,
    );
  }

  UserGroupReadMembers copyWithWrapped({
    Wrapped<String?>? userId,
    Wrapped<String?>? userEmail,
    Wrapped<bool?>? you,
    Wrapped<List<enums.UserGroupReadRole>?>? roles,
  }) {
    return UserGroupReadMembers(
      userId: (userId != null ? userId.value : this.userId),
      userEmail: (userEmail != null ? userEmail.value : this.userEmail),
      you: (you != null ? you.value : this.you),
      roles: (roles != null ? roles.value : this.roles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupSingle {
  const UserGroupSingle({required this.data});

  factory UserGroupSingle.fromJson(Map<String, dynamic> json) =>
      _$UserGroupSingleFromJson(json);

  static const toJsonFactory = _$UserGroupSingleToJson;
  Map<String, dynamic> toJson() => _$UserGroupSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final UserGroupRead data;
  static const fromJsonFactory = _$UserGroupSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupSingleExtension on UserGroupSingle {
  UserGroupSingle copyWith({UserGroupRead? data}) {
    return UserGroupSingle(data: data ?? this.data);
  }

  UserGroupSingle copyWithWrapped({Wrapped<UserGroupRead>? data}) {
    return UserGroupSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupUpdate {
  const UserGroupUpdate({
    required this.title,
    this.primaryCurrencyId,
    this.primaryCurrencyCode,
  });

  factory UserGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserGroupUpdateFromJson(json);

  static const toJsonFactory = _$UserGroupUpdateToJson;
  Map<String, dynamic> toJson() => _$UserGroupUpdateToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  static const fromJsonFactory = _$UserGroupUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserGroupUpdateExtension on UserGroupUpdate {
  UserGroupUpdate copyWith({
    String? title,
    String? primaryCurrencyId,
    String? primaryCurrencyCode,
  }) {
    return UserGroupUpdate(
      title: title ?? this.title,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
    );
  }

  UserGroupUpdate copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyCode,
  }) {
    return UserGroupUpdate(
      title: (title != null ? title.value : this.title),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
    );
  }
}

typedef WebhookDeliveryArray = List<String>;

@JsonSerializable(explicitToJson: true)
class WebhookProperties {
  const WebhookProperties({
    this.createdAt,
    this.updatedAt,
    this.active,
    required this.title,
    this.secret,
    this.triggers,
    this.responses,
    this.deliveries,
    required this.url,
  });

  factory WebhookProperties.fromJson(Map<String, dynamic> json) =>
      _$WebhookPropertiesFromJson(json);

  static const toJsonFactory = _$WebhookPropertiesToJson;
  Map<String, dynamic> toJson() => _$WebhookPropertiesToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'secret', includeIfNull: false)
  final String? secret;
  @JsonKey(name: 'triggers', includeIfNull: false)
  final List<String>? triggers;
  @JsonKey(name: 'responses', includeIfNull: false)
  final List<String>? responses;
  @JsonKey(name: 'deliveries', includeIfNull: false)
  final List<String>? deliveries;
  @JsonKey(name: 'url', includeIfNull: false)
  final String url;
  static const fromJsonFactory = _$WebhookPropertiesFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookPropertiesExtension on WebhookProperties {
  WebhookProperties copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? active,
    String? title,
    String? secret,
    List<String>? triggers,
    List<String>? responses,
    List<String>? deliveries,
    String? url,
  }) {
    return WebhookProperties(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      active: active ?? this.active,
      title: title ?? this.title,
      secret: secret ?? this.secret,
      triggers: triggers ?? this.triggers,
      responses: responses ?? this.responses,
      deliveries: deliveries ?? this.deliveries,
      url: url ?? this.url,
    );
  }

  WebhookProperties copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? active,
    Wrapped<String>? title,
    Wrapped<String?>? secret,
    Wrapped<List<String>?>? triggers,
    Wrapped<List<String>?>? responses,
    Wrapped<List<String>?>? deliveries,
    Wrapped<String>? url,
  }) {
    return WebhookProperties(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      active: (active != null ? active.value : this.active),
      title: (title != null ? title.value : this.title),
      secret: (secret != null ? secret.value : this.secret),
      triggers: (triggers != null ? triggers.value : this.triggers),
      responses: (responses != null ? responses.value : this.responses),
      deliveries: (deliveries != null ? deliveries.value : this.deliveries),
      url: (url != null ? url.value : this.url),
    );
  }
}

typedef WebhookResponseArray = List<String>;

@JsonSerializable(explicitToJson: true)
class WebhookStore {
  const WebhookStore({
    this.active,
    required this.title,
    this.triggers,
    this.responses,
    this.deliveries,
    required this.url,
  });

  factory WebhookStore.fromJson(Map<String, dynamic> json) =>
      _$WebhookStoreFromJson(json);

  static const toJsonFactory = _$WebhookStoreToJson;
  Map<String, dynamic> toJson() => _$WebhookStoreToJson(this);

  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'triggers', includeIfNull: false)
  final List<String>? triggers;
  @JsonKey(name: 'responses', includeIfNull: false)
  final List<String>? responses;
  @JsonKey(name: 'deliveries', includeIfNull: false)
  final List<String>? deliveries;
  @JsonKey(name: 'url', includeIfNull: false)
  final String url;
  static const fromJsonFactory = _$WebhookStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookStoreExtension on WebhookStore {
  WebhookStore copyWith({
    bool? active,
    String? title,
    List<String>? triggers,
    List<String>? responses,
    List<String>? deliveries,
    String? url,
  }) {
    return WebhookStore(
      active: active ?? this.active,
      title: title ?? this.title,
      triggers: triggers ?? this.triggers,
      responses: responses ?? this.responses,
      deliveries: deliveries ?? this.deliveries,
      url: url ?? this.url,
    );
  }

  WebhookStore copyWithWrapped({
    Wrapped<bool?>? active,
    Wrapped<String>? title,
    Wrapped<List<String>?>? triggers,
    Wrapped<List<String>?>? responses,
    Wrapped<List<String>?>? deliveries,
    Wrapped<String>? url,
  }) {
    return WebhookStore(
      active: (active != null ? active.value : this.active),
      title: (title != null ? title.value : this.title),
      triggers: (triggers != null ? triggers.value : this.triggers),
      responses: (responses != null ? responses.value : this.responses),
      deliveries: (deliveries != null ? deliveries.value : this.deliveries),
      url: (url != null ? url.value : this.url),
    );
  }
}

typedef WebhookTriggerArray = List<String>;

@JsonSerializable(explicitToJson: true)
class WebhookUpdate {
  const WebhookUpdate({
    this.active,
    this.title,
    this.secret,
    this.triggers,
    this.responses,
    this.deliveries,
    this.url,
  });

  factory WebhookUpdate.fromJson(Map<String, dynamic> json) =>
      _$WebhookUpdateFromJson(json);

  static const toJsonFactory = _$WebhookUpdateToJson;
  Map<String, dynamic> toJson() => _$WebhookUpdateToJson(this);

  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'secret', includeIfNull: false)
  final String? secret;
  @JsonKey(name: 'triggers', includeIfNull: false)
  final List<String>? triggers;
  @JsonKey(name: 'responses', includeIfNull: false)
  final List<String>? responses;
  @JsonKey(name: 'deliveries', includeIfNull: false)
  final List<String>? deliveries;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  static const fromJsonFactory = _$WebhookUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookUpdateExtension on WebhookUpdate {
  WebhookUpdate copyWith({
    bool? active,
    String? title,
    String? secret,
    List<String>? triggers,
    List<String>? responses,
    List<String>? deliveries,
    String? url,
  }) {
    return WebhookUpdate(
      active: active ?? this.active,
      title: title ?? this.title,
      secret: secret ?? this.secret,
      triggers: triggers ?? this.triggers,
      responses: responses ?? this.responses,
      deliveries: deliveries ?? this.deliveries,
      url: url ?? this.url,
    );
  }

  WebhookUpdate copyWithWrapped({
    Wrapped<bool?>? active,
    Wrapped<String?>? title,
    Wrapped<String?>? secret,
    Wrapped<List<String>?>? triggers,
    Wrapped<List<String>?>? responses,
    Wrapped<List<String>?>? deliveries,
    Wrapped<String?>? url,
  }) {
    return WebhookUpdate(
      active: (active != null ? active.value : this.active),
      title: (title != null ? title.value : this.title),
      secret: (secret != null ? secret.value : this.secret),
      triggers: (triggers != null ? triggers.value : this.triggers),
      responses: (responses != null ? responses.value : this.responses),
      deliveries: (deliveries != null ? deliveries.value : this.deliveries),
      url: (url != null ? url.value : this.url),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookAttempt {
  const WebhookAttempt({
    this.createdAt,
    this.updatedAt,
    this.webhookMessageId,
    this.statusCode,
    this.logs,
    this.response,
  });

  factory WebhookAttempt.fromJson(Map<String, dynamic> json) =>
      _$WebhookAttemptFromJson(json);

  static const toJsonFactory = _$WebhookAttemptToJson;
  Map<String, dynamic> toJson() => _$WebhookAttemptToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'webhook_message_id', includeIfNull: false)
  final String? webhookMessageId;
  @JsonKey(name: 'status_code', includeIfNull: false)
  final int? statusCode;
  @JsonKey(name: 'logs', includeIfNull: false)
  final String? logs;
  @JsonKey(name: 'response', includeIfNull: false)
  final String? response;
  static const fromJsonFactory = _$WebhookAttemptFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookAttemptExtension on WebhookAttempt {
  WebhookAttempt copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? webhookMessageId,
    int? statusCode,
    String? logs,
    String? response,
  }) {
    return WebhookAttempt(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      webhookMessageId: webhookMessageId ?? this.webhookMessageId,
      statusCode: statusCode ?? this.statusCode,
      logs: logs ?? this.logs,
      response: response ?? this.response,
    );
  }

  WebhookAttempt copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? webhookMessageId,
    Wrapped<int?>? statusCode,
    Wrapped<String?>? logs,
    Wrapped<String?>? response,
  }) {
    return WebhookAttempt(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      webhookMessageId:
          (webhookMessageId != null
              ? webhookMessageId.value
              : this.webhookMessageId),
      statusCode: (statusCode != null ? statusCode.value : this.statusCode),
      logs: (logs != null ? logs.value : this.logs),
      response: (response != null ? response.value : this.response),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookMessage {
  const WebhookMessage({
    this.createdAt,
    this.updatedAt,
    this.sent,
    this.errored,
    this.webhookId,
    this.uuid,
    this.message,
  });

  factory WebhookMessage.fromJson(Map<String, dynamic> json) =>
      _$WebhookMessageFromJson(json);

  static const toJsonFactory = _$WebhookMessageToJson;
  Map<String, dynamic> toJson() => _$WebhookMessageToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'sent', includeIfNull: false)
  final bool? sent;
  @JsonKey(name: 'errored', includeIfNull: false)
  final bool? errored;
  @JsonKey(name: 'webhook_id', includeIfNull: false)
  final String? webhookId;
  @JsonKey(name: 'uuid', includeIfNull: false)
  final String? uuid;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$WebhookMessageFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WebhookMessageExtension on WebhookMessage {
  WebhookMessage copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? sent,
    bool? errored,
    String? webhookId,
    String? uuid,
    String? message,
  }) {
    return WebhookMessage(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sent: sent ?? this.sent,
      errored: errored ?? this.errored,
      webhookId: webhookId ?? this.webhookId,
      uuid: uuid ?? this.uuid,
      message: message ?? this.message,
    );
  }

  WebhookMessage copyWithWrapped({
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<bool?>? sent,
    Wrapped<bool?>? errored,
    Wrapped<String?>? webhookId,
    Wrapped<String?>? uuid,
    Wrapped<String?>? message,
  }) {
    return WebhookMessage(
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      sent: (sent != null ? sent.value : this.sent),
      errored: (errored != null ? errored.value : this.errored),
      webhookId: (webhookId != null ? webhookId.value : this.webhookId),
      uuid: (uuid != null ? uuid.value : this.uuid),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PolymorphicProperty {
  const PolymorphicProperty();

  factory PolymorphicProperty.fromJson(Map<String, dynamic> json) =>
      _$PolymorphicPropertyFromJson(json);

  static const toJsonFactory = _$PolymorphicPropertyToJson;
  Map<String, dynamic> toJson() => _$PolymorphicPropertyToJson(this);

  static const fromJsonFactory = _$PolymorphicPropertyFromJson;

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(explicitToJson: true)
class BasicSummary {
  const BasicSummary();

  factory BasicSummary.fromJson(Map<String, dynamic> json) =>
      _$BasicSummaryFromJson(json);

  static const toJsonFactory = _$BasicSummaryToJson;
  Map<String, dynamic> toJson() => _$BasicSummaryToJson(this);

  static const fromJsonFactory = _$BasicSummaryFromJson;

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(explicitToJson: true)
class BasicSummaryEntry {
  const BasicSummaryEntry({
    this.key,
    this.title,
    this.monetaryValue,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.noAvailableBudgets,
    this.valueParsed,
    this.localIcon,
    this.subTitle,
  });

  factory BasicSummaryEntry.fromJson(Map<String, dynamic> json) =>
      _$BasicSummaryEntryFromJson(json);

  static const toJsonFactory = _$BasicSummaryEntryToJson;
  Map<String, dynamic> toJson() => _$BasicSummaryEntryToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String? key;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'monetary_value', includeIfNull: false)
  final double? monetaryValue;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'no_available_budgets', includeIfNull: false)
  final bool? noAvailableBudgets;
  @JsonKey(name: 'value_parsed', includeIfNull: false)
  final String? valueParsed;
  @JsonKey(name: 'local_icon', includeIfNull: false)
  final String? localIcon;
  @JsonKey(name: 'sub_title', includeIfNull: false)
  final String? subTitle;
  static const fromJsonFactory = _$BasicSummaryEntryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BasicSummaryEntryExtension on BasicSummaryEntry {
  BasicSummaryEntry copyWith({
    String? key,
    String? title,
    double? monetaryValue,
    String? currencyId,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    bool? noAvailableBudgets,
    String? valueParsed,
    String? localIcon,
    String? subTitle,
  }) {
    return BasicSummaryEntry(
      key: key ?? this.key,
      title: title ?? this.title,
      monetaryValue: monetaryValue ?? this.monetaryValue,
      currencyId: currencyId ?? this.currencyId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      noAvailableBudgets: noAvailableBudgets ?? this.noAvailableBudgets,
      valueParsed: valueParsed ?? this.valueParsed,
      localIcon: localIcon ?? this.localIcon,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  BasicSummaryEntry copyWithWrapped({
    Wrapped<String?>? key,
    Wrapped<String?>? title,
    Wrapped<double?>? monetaryValue,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<bool?>? noAvailableBudgets,
    Wrapped<String?>? valueParsed,
    Wrapped<String?>? localIcon,
    Wrapped<String?>? subTitle,
  }) {
    return BasicSummaryEntry(
      key: (key != null ? key.value : this.key),
      title: (title != null ? title.value : this.title),
      monetaryValue:
          (monetaryValue != null ? monetaryValue.value : this.monetaryValue),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      noAvailableBudgets:
          (noAvailableBudgets != null
              ? noAvailableBudgets.value
              : this.noAvailableBudgets),
      valueParsed: (valueParsed != null ? valueParsed.value : this.valueParsed),
      localIcon: (localIcon != null ? localIcon.value : this.localIcon),
      subTitle: (subTitle != null ? subTitle.value : this.subTitle),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Configuration {
  const Configuration({
    required this.title,
    required this.$value,
    required this.editable,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  static const toJsonFactory = _$ConfigurationToJson;
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @JsonKey(
    name: 'title',
    includeIfNull: false,
    toJson: configValueFilterToJson,
    fromJson: configValueFilterFromJson,
  )
  final enums.ConfigValueFilter title;
  @JsonKey(name: 'value', includeIfNull: false)
  final PolymorphicProperty $value;
  @JsonKey(name: 'editable', includeIfNull: false)
  final bool editable;
  static const fromJsonFactory = _$ConfigurationFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ConfigurationExtension on Configuration {
  Configuration copyWith({
    enums.ConfigValueFilter? title,
    PolymorphicProperty? $value,
    bool? editable,
  }) {
    return Configuration(
      title: title ?? this.title,
      $value: $value ?? this.$value,
      editable: editable ?? this.editable,
    );
  }

  Configuration copyWithWrapped({
    Wrapped<enums.ConfigValueFilter>? title,
    Wrapped<PolymorphicProperty>? $value,
    Wrapped<bool>? editable,
  }) {
    return Configuration(
      title: (title != null ? title.value : this.title),
      $value: ($value != null ? $value.value : this.$value),
      editable: (editable != null ? editable.value : this.editable),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigurationUpdate {
  const ConfigurationUpdate({required this.$value});

  factory ConfigurationUpdate.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationUpdateFromJson(json);

  static const toJsonFactory = _$ConfigurationUpdateToJson;
  Map<String, dynamic> toJson() => _$ConfigurationUpdateToJson(this);

  @JsonKey(name: 'value', includeIfNull: false)
  final PolymorphicProperty $value;
  static const fromJsonFactory = _$ConfigurationUpdateFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ConfigurationUpdateExtension on ConfigurationUpdate {
  ConfigurationUpdate copyWith({PolymorphicProperty? $value}) {
    return ConfigurationUpdate($value: $value ?? this.$value);
  }

  ConfigurationUpdate copyWithWrapped({Wrapped<PolymorphicProperty>? $value}) {
    return ConfigurationUpdate(
      $value: ($value != null ? $value.value : this.$value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CronResult {
  const CronResult({
    this.recurringTransactions,
    this.autoBudgets,
    this.telemetry,
  });

  factory CronResult.fromJson(Map<String, dynamic> json) =>
      _$CronResultFromJson(json);

  static const toJsonFactory = _$CronResultToJson;
  Map<String, dynamic> toJson() => _$CronResultToJson(this);

  @JsonKey(name: 'recurring_transactions', includeIfNull: false)
  final CronResultRow? recurringTransactions;
  @JsonKey(name: 'auto_budgets', includeIfNull: false)
  final CronResultRow? autoBudgets;
  @JsonKey(name: 'telemetry', includeIfNull: false)
  final CronResultRow? telemetry;
  static const fromJsonFactory = _$CronResultFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CronResultExtension on CronResult {
  CronResult copyWith({
    CronResultRow? recurringTransactions,
    CronResultRow? autoBudgets,
    CronResultRow? telemetry,
  }) {
    return CronResult(
      recurringTransactions:
          recurringTransactions ?? this.recurringTransactions,
      autoBudgets: autoBudgets ?? this.autoBudgets,
      telemetry: telemetry ?? this.telemetry,
    );
  }

  CronResult copyWithWrapped({
    Wrapped<CronResultRow?>? recurringTransactions,
    Wrapped<CronResultRow?>? autoBudgets,
    Wrapped<CronResultRow?>? telemetry,
  }) {
    return CronResult(
      recurringTransactions:
          (recurringTransactions != null
              ? recurringTransactions.value
              : this.recurringTransactions),
      autoBudgets: (autoBudgets != null ? autoBudgets.value : this.autoBudgets),
      telemetry: (telemetry != null ? telemetry.value : this.telemetry),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CronResultRow {
  const CronResultRow({
    this.jobFired,
    this.jobSucceeded,
    this.jobErrored,
    this.message,
  });

  factory CronResultRow.fromJson(Map<String, dynamic> json) =>
      _$CronResultRowFromJson(json);

  static const toJsonFactory = _$CronResultRowToJson;
  Map<String, dynamic> toJson() => _$CronResultRowToJson(this);

  @JsonKey(name: 'job_fired', includeIfNull: false)
  final bool? jobFired;
  @JsonKey(name: 'job_succeeded', includeIfNull: false)
  final bool? jobSucceeded;
  @JsonKey(name: 'job_errored', includeIfNull: false)
  final bool? jobErrored;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$CronResultRowFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CronResultRowExtension on CronResultRow {
  CronResultRow copyWith({
    bool? jobFired,
    bool? jobSucceeded,
    bool? jobErrored,
    String? message,
  }) {
    return CronResultRow(
      jobFired: jobFired ?? this.jobFired,
      jobSucceeded: jobSucceeded ?? this.jobSucceeded,
      jobErrored: jobErrored ?? this.jobErrored,
      message: message ?? this.message,
    );
  }

  CronResultRow copyWithWrapped({
    Wrapped<bool?>? jobFired,
    Wrapped<bool?>? jobSucceeded,
    Wrapped<bool?>? jobErrored,
    Wrapped<String?>? message,
  }) {
    return CronResultRow(
      jobFired: (jobFired != null ? jobFired.value : this.jobFired),
      jobSucceeded:
          (jobSucceeded != null ? jobSucceeded.value : this.jobSucceeded),
      jobErrored: (jobErrored != null ? jobErrored.value : this.jobErrored),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SystemInfo {
  const SystemInfo({this.data});

  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoFromJson(json);

  static const toJsonFactory = _$SystemInfoToJson;
  Map<String, dynamic> toJson() => _$SystemInfoToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final SystemInfo$Data? data;
  static const fromJsonFactory = _$SystemInfoFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SystemInfoExtension on SystemInfo {
  SystemInfo copyWith({SystemInfo$Data? data}) {
    return SystemInfo(data: data ?? this.data);
  }

  SystemInfo copyWithWrapped({Wrapped<SystemInfo$Data?>? data}) {
    return SystemInfo(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class UserSingle {
  const UserSingle({required this.data});

  factory UserSingle.fromJson(Map<String, dynamic> json) =>
      _$UserSingleFromJson(json);

  static const toJsonFactory = _$UserSingleToJson;
  Map<String, dynamic> toJson() => _$UserSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final UserRead data;
  static const fromJsonFactory = _$UserSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UserSingleExtension on UserSingle {
  UserSingle copyWith({UserRead? data}) {
    return UserSingle(data: data ?? this.data);
  }

  UserSingle copyWithWrapped({Wrapped<UserRead>? data}) {
    return UserSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class Meta {
  const Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  static const toJsonFactory = _$MetaToJson;
  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @JsonKey(name: 'pagination', includeIfNull: false)
  final Meta$Pagination? pagination;
  static const fromJsonFactory = _$MetaFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $MetaExtension on Meta {
  Meta copyWith({Meta$Pagination? pagination}) {
    return Meta(pagination: pagination ?? this.pagination);
  }

  Meta copyWithWrapped({Wrapped<Meta$Pagination?>? pagination}) {
    return Meta(
      pagination: (pagination != null ? pagination.value : this.pagination),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BadRequestResponse {
  const BadRequestResponse({this.message, this.exception});

  factory BadRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$BadRequestResponseFromJson(json);

  static const toJsonFactory = _$BadRequestResponseToJson;
  Map<String, dynamic> toJson() => _$BadRequestResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String? exception;
  static const fromJsonFactory = _$BadRequestResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BadRequestResponseExtension on BadRequestResponse {
  BadRequestResponse copyWith({String? message, String? exception}) {
    return BadRequestResponse(
      message: message ?? this.message,
      exception: exception ?? this.exception,
    );
  }

  BadRequestResponse copyWithWrapped({
    Wrapped<String?>? message,
    Wrapped<String?>? exception,
  }) {
    return BadRequestResponse(
      message: (message != null ? message.value : this.message),
      exception: (exception != null ? exception.value : this.exception),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InternalExceptionResponse {
  const InternalExceptionResponse({this.message, this.exception});

  factory InternalExceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$InternalExceptionResponseFromJson(json);

  static const toJsonFactory = _$InternalExceptionResponseToJson;
  Map<String, dynamic> toJson() => _$InternalExceptionResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String? exception;
  static const fromJsonFactory = _$InternalExceptionResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $InternalExceptionResponseExtension on InternalExceptionResponse {
  InternalExceptionResponse copyWith({String? message, String? exception}) {
    return InternalExceptionResponse(
      message: message ?? this.message,
      exception: exception ?? this.exception,
    );
  }

  InternalExceptionResponse copyWithWrapped({
    Wrapped<String?>? message,
    Wrapped<String?>? exception,
  }) {
    return InternalExceptionResponse(
      message: (message != null ? message.value : this.message),
      exception: (exception != null ? exception.value : this.exception),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NotFoundResponse {
  const NotFoundResponse({this.message, this.exception});

  factory NotFoundResponse.fromJson(Map<String, dynamic> json) =>
      _$NotFoundResponseFromJson(json);

  static const toJsonFactory = _$NotFoundResponseToJson;
  Map<String, dynamic> toJson() => _$NotFoundResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String? exception;
  static const fromJsonFactory = _$NotFoundResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $NotFoundResponseExtension on NotFoundResponse {
  NotFoundResponse copyWith({String? message, String? exception}) {
    return NotFoundResponse(
      message: message ?? this.message,
      exception: exception ?? this.exception,
    );
  }

  NotFoundResponse copyWithWrapped({
    Wrapped<String?>? message,
    Wrapped<String?>? exception,
  }) {
    return NotFoundResponse(
      message: (message != null ? message.value : this.message),
      exception: (exception != null ? exception.value : this.exception),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UnauthenticatedResponse {
  const UnauthenticatedResponse({this.message, this.exception});

  factory UnauthenticatedResponse.fromJson(Map<String, dynamic> json) =>
      _$UnauthenticatedResponseFromJson(json);

  static const toJsonFactory = _$UnauthenticatedResponseToJson;
  Map<String, dynamic> toJson() => _$UnauthenticatedResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String? exception;
  static const fromJsonFactory = _$UnauthenticatedResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UnauthenticatedResponseExtension on UnauthenticatedResponse {
  UnauthenticatedResponse copyWith({String? message, String? exception}) {
    return UnauthenticatedResponse(
      message: message ?? this.message,
      exception: exception ?? this.exception,
    );
  }

  UnauthenticatedResponse copyWithWrapped({
    Wrapped<String?>? message,
    Wrapped<String?>? exception,
  }) {
    return UnauthenticatedResponse(
      message: (message != null ? message.value : this.message),
      exception: (exception != null ? exception.value : this.exception),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationErrorResponse {
  const ValidationErrorResponse({this.message, this.errors});

  factory ValidationErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorResponseFromJson(json);

  static const toJsonFactory = _$ValidationErrorResponseToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'errors', includeIfNull: false)
  final ValidationErrorResponse$Errors? errors;
  static const fromJsonFactory = _$ValidationErrorResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ValidationErrorResponseExtension on ValidationErrorResponse {
  ValidationErrorResponse copyWith({
    String? message,
    ValidationErrorResponse$Errors? errors,
  }) {
    return ValidationErrorResponse(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  ValidationErrorResponse copyWithWrapped({
    Wrapped<String?>? message,
    Wrapped<ValidationErrorResponse$Errors?>? errors,
  }) {
    return ValidationErrorResponse(
      message: (message != null ? message.value : this.message),
      errors: (errors != null ? errors.value : this.errors),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BillProperties$PaidDates$Item {
  const BillProperties$PaidDates$Item({
    this.transactionGroupId,
    this.transactionJournalId,
    this.date,
    this.subscriptionId,
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.primaryCurrencyId,
    this.primaryCurrencyName,
    this.primaryCurrencyCode,
    this.primaryCurrencySymbol,
    this.primaryCurrencyDecimalPlaces,
    this.amount,
    this.pcAmount,
    this.foreignAmount,
    this.pcForeignAmount,
  });

  factory BillProperties$PaidDates$Item.fromJson(Map<String, dynamic> json) =>
      _$BillProperties$PaidDates$ItemFromJson(json);

  static const toJsonFactory = _$BillProperties$PaidDates$ItemToJson;
  Map<String, dynamic> toJson() => _$BillProperties$PaidDates$ItemToJson(this);

  @JsonKey(name: 'transaction_group_id', includeIfNull: false)
  final String? transactionGroupId;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(name: 'subscription_id', includeIfNull: false)
  final String? subscriptionId;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'primary_currency_id', includeIfNull: false)
  final String? primaryCurrencyId;
  @JsonKey(name: 'primary_currency_name', includeIfNull: false)
  final String? primaryCurrencyName;
  @JsonKey(name: 'primary_currency_code', includeIfNull: false)
  final String? primaryCurrencyCode;
  @JsonKey(name: 'primary_currency_symbol', includeIfNull: false)
  final String? primaryCurrencySymbol;
  @JsonKey(name: 'primary_currency_decimal_places', includeIfNull: false)
  final int? primaryCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String? amount;
  @JsonKey(name: 'pc_amount', includeIfNull: false)
  final String? pcAmount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'pc_foreign_amount', includeIfNull: false)
  final String? pcForeignAmount;
  static const fromJsonFactory = _$BillProperties$PaidDates$ItemFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BillProperties$PaidDates$ItemExtension
    on BillProperties$PaidDates$Item {
  BillProperties$PaidDates$Item copyWith({
    String? transactionGroupId,
    String? transactionJournalId,
    DateTime? date,
    String? subscriptionId,
    String? currencyId,
    String? currencyName,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? primaryCurrencyId,
    String? primaryCurrencyName,
    String? primaryCurrencyCode,
    String? primaryCurrencySymbol,
    int? primaryCurrencyDecimalPlaces,
    String? amount,
    String? pcAmount,
    String? foreignAmount,
    String? pcForeignAmount,
  }) {
    return BillProperties$PaidDates$Item(
      transactionGroupId: transactionGroupId ?? this.transactionGroupId,
      transactionJournalId: transactionJournalId ?? this.transactionJournalId,
      date: date ?? this.date,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      currencyId: currencyId ?? this.currencyId,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
      primaryCurrencyName: primaryCurrencyName ?? this.primaryCurrencyName,
      primaryCurrencyCode: primaryCurrencyCode ?? this.primaryCurrencyCode,
      primaryCurrencySymbol:
          primaryCurrencySymbol ?? this.primaryCurrencySymbol,
      primaryCurrencyDecimalPlaces:
          primaryCurrencyDecimalPlaces ?? this.primaryCurrencyDecimalPlaces,
      amount: amount ?? this.amount,
      pcAmount: pcAmount ?? this.pcAmount,
      foreignAmount: foreignAmount ?? this.foreignAmount,
      pcForeignAmount: pcForeignAmount ?? this.pcForeignAmount,
    );
  }

  BillProperties$PaidDates$Item copyWithWrapped({
    Wrapped<String?>? transactionGroupId,
    Wrapped<String?>? transactionJournalId,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? subscriptionId,
    Wrapped<String?>? currencyId,
    Wrapped<String?>? currencyName,
    Wrapped<String?>? currencyCode,
    Wrapped<String?>? currencySymbol,
    Wrapped<int?>? currencyDecimalPlaces,
    Wrapped<String?>? primaryCurrencyId,
    Wrapped<String?>? primaryCurrencyName,
    Wrapped<String?>? primaryCurrencyCode,
    Wrapped<String?>? primaryCurrencySymbol,
    Wrapped<int?>? primaryCurrencyDecimalPlaces,
    Wrapped<String?>? amount,
    Wrapped<String?>? pcAmount,
    Wrapped<String?>? foreignAmount,
    Wrapped<String?>? pcForeignAmount,
  }) {
    return BillProperties$PaidDates$Item(
      transactionGroupId:
          (transactionGroupId != null
              ? transactionGroupId.value
              : this.transactionGroupId),
      transactionJournalId:
          (transactionJournalId != null
              ? transactionJournalId.value
              : this.transactionJournalId),
      date: (date != null ? date.value : this.date),
      subscriptionId:
          (subscriptionId != null ? subscriptionId.value : this.subscriptionId),
      currencyId: (currencyId != null ? currencyId.value : this.currencyId),
      currencyName:
          (currencyName != null ? currencyName.value : this.currencyName),
      currencyCode:
          (currencyCode != null ? currencyCode.value : this.currencyCode),
      currencySymbol:
          (currencySymbol != null ? currencySymbol.value : this.currencySymbol),
      currencyDecimalPlaces:
          (currencyDecimalPlaces != null
              ? currencyDecimalPlaces.value
              : this.currencyDecimalPlaces),
      primaryCurrencyId:
          (primaryCurrencyId != null
              ? primaryCurrencyId.value
              : this.primaryCurrencyId),
      primaryCurrencyName:
          (primaryCurrencyName != null
              ? primaryCurrencyName.value
              : this.primaryCurrencyName),
      primaryCurrencyCode:
          (primaryCurrencyCode != null
              ? primaryCurrencyCode.value
              : this.primaryCurrencyCode),
      primaryCurrencySymbol:
          (primaryCurrencySymbol != null
              ? primaryCurrencySymbol.value
              : this.primaryCurrencySymbol),
      primaryCurrencyDecimalPlaces:
          (primaryCurrencyDecimalPlaces != null
              ? primaryCurrencyDecimalPlaces.value
              : this.primaryCurrencyDecimalPlaces),
      amount: (amount != null ? amount.value : this.amount),
      pcAmount: (pcAmount != null ? pcAmount.value : this.pcAmount),
      foreignAmount:
          (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
      pcForeignAmount:
          (pcForeignAmount != null
              ? pcForeignAmount.value
              : this.pcForeignAmount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SystemInfo$Data {
  const SystemInfo$Data({
    this.version,
    this.apiVersion,
    this.phpVersion,
    this.os,
    this.driver,
  });

  factory SystemInfo$Data.fromJson(Map<String, dynamic> json) =>
      _$SystemInfo$DataFromJson(json);

  static const toJsonFactory = _$SystemInfo$DataToJson;
  Map<String, dynamic> toJson() => _$SystemInfo$DataToJson(this);

  @JsonKey(name: 'version', includeIfNull: false)
  final String? version;
  @JsonKey(name: 'api_version', includeIfNull: false)
  final String? apiVersion;
  @JsonKey(name: 'php_version', includeIfNull: false)
  final String? phpVersion;
  @JsonKey(name: 'os', includeIfNull: false)
  final String? os;
  @JsonKey(name: 'driver', includeIfNull: false)
  final String? driver;
  static const fromJsonFactory = _$SystemInfo$DataFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SystemInfo$DataExtension on SystemInfo$Data {
  SystemInfo$Data copyWith({
    String? version,
    String? apiVersion,
    String? phpVersion,
    String? os,
    String? driver,
  }) {
    return SystemInfo$Data(
      version: version ?? this.version,
      apiVersion: apiVersion ?? this.apiVersion,
      phpVersion: phpVersion ?? this.phpVersion,
      os: os ?? this.os,
      driver: driver ?? this.driver,
    );
  }

  SystemInfo$Data copyWithWrapped({
    Wrapped<String?>? version,
    Wrapped<String?>? apiVersion,
    Wrapped<String?>? phpVersion,
    Wrapped<String?>? os,
    Wrapped<String?>? driver,
  }) {
    return SystemInfo$Data(
      version: (version != null ? version.value : this.version),
      apiVersion: (apiVersion != null ? apiVersion.value : this.apiVersion),
      phpVersion: (phpVersion != null ? phpVersion.value : this.phpVersion),
      os: (os != null ? os.value : this.os),
      driver: (driver != null ? driver.value : this.driver),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Meta$Pagination {
  const Meta$Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Meta$Pagination.fromJson(Map<String, dynamic> json) =>
      _$Meta$PaginationFromJson(json);

  static const toJsonFactory = _$Meta$PaginationToJson;
  Map<String, dynamic> toJson() => _$Meta$PaginationToJson(this);

  @JsonKey(name: 'total', includeIfNull: false)
  final int? total;
  @JsonKey(name: 'count', includeIfNull: false)
  final int? count;
  @JsonKey(name: 'per_page', includeIfNull: false)
  final int? perPage;
  @JsonKey(name: 'current_page', includeIfNull: false)
  final int? currentPage;
  @JsonKey(name: 'total_pages', includeIfNull: false)
  final int? totalPages;
  static const fromJsonFactory = _$Meta$PaginationFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $Meta$PaginationExtension on Meta$Pagination {
  Meta$Pagination copyWith({
    int? total,
    int? count,
    int? perPage,
    int? currentPage,
    int? totalPages,
  }) {
    return Meta$Pagination(
      total: total ?? this.total,
      count: count ?? this.count,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  Meta$Pagination copyWithWrapped({
    Wrapped<int?>? total,
    Wrapped<int?>? count,
    Wrapped<int?>? perPage,
    Wrapped<int?>? currentPage,
    Wrapped<int?>? totalPages,
  }) {
    return Meta$Pagination(
      total: (total != null ? total.value : this.total),
      count: (count != null ? count.value : this.count),
      perPage: (perPage != null ? perPage.value : this.perPage),
      currentPage: (currentPage != null ? currentPage.value : this.currentPage),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationErrorResponse$Errors {
  const ValidationErrorResponse$Errors({
    this.email,
    this.force,
    this.blocked,
    this.field,
    this.role,
    this.blockedCode,
    this.name,
    this.type,
    this.iban,
    this.start,
    this.end,
    this.date,
  });

  factory ValidationErrorResponse$Errors.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorResponse$ErrorsFromJson(json);

  static const toJsonFactory = _$ValidationErrorResponse$ErrorsToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorResponse$ErrorsToJson(this);

  @JsonKey(name: 'email', includeIfNull: false, defaultValue: <String>[])
  final List<String>? email;
  @JsonKey(name: 'force', includeIfNull: false, defaultValue: <String>[])
  final List<String>? force;
  @JsonKey(name: 'blocked', includeIfNull: false, defaultValue: <String>[])
  final List<String>? blocked;
  @JsonKey(name: 'field', includeIfNull: false, defaultValue: <String>[])
  final List<String>? field;
  @JsonKey(name: 'role', includeIfNull: false, defaultValue: <String>[])
  final List<String>? role;
  @JsonKey(name: 'blocked_code', includeIfNull: false, defaultValue: <String>[])
  final List<String>? blockedCode;
  @JsonKey(name: 'name', includeIfNull: false, defaultValue: <String>[])
  final List<String>? name;
  @JsonKey(name: 'type', includeIfNull: false, defaultValue: <String>[])
  final List<String>? type;
  @JsonKey(name: 'iban', includeIfNull: false, defaultValue: <String>[])
  final List<String>? iban;
  @JsonKey(name: 'start', includeIfNull: false, defaultValue: <String>[])
  final List<String>? start;
  @JsonKey(name: 'end', includeIfNull: false, defaultValue: <String>[])
  final List<String>? end;
  @JsonKey(name: 'date', includeIfNull: false, defaultValue: <String>[])
  final List<String>? date;
  static const fromJsonFactory = _$ValidationErrorResponse$ErrorsFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ValidationErrorResponse$ErrorsExtension
    on ValidationErrorResponse$Errors {
  ValidationErrorResponse$Errors copyWith({
    List<String>? email,
    List<String>? force,
    List<String>? blocked,
    List<String>? field,
    List<String>? role,
    List<String>? blockedCode,
    List<String>? name,
    List<String>? type,
    List<String>? iban,
    List<String>? start,
    List<String>? end,
    List<String>? date,
  }) {
    return ValidationErrorResponse$Errors(
      email: email ?? this.email,
      force: force ?? this.force,
      blocked: blocked ?? this.blocked,
      field: field ?? this.field,
      role: role ?? this.role,
      blockedCode: blockedCode ?? this.blockedCode,
      name: name ?? this.name,
      type: type ?? this.type,
      iban: iban ?? this.iban,
      start: start ?? this.start,
      end: end ?? this.end,
      date: date ?? this.date,
    );
  }

  ValidationErrorResponse$Errors copyWithWrapped({
    Wrapped<List<String>?>? email,
    Wrapped<List<String>?>? force,
    Wrapped<List<String>?>? blocked,
    Wrapped<List<String>?>? field,
    Wrapped<List<String>?>? role,
    Wrapped<List<String>?>? blockedCode,
    Wrapped<List<String>?>? name,
    Wrapped<List<String>?>? type,
    Wrapped<List<String>?>? iban,
    Wrapped<List<String>?>? start,
    Wrapped<List<String>?>? end,
    Wrapped<List<String>?>? date,
  }) {
    return ValidationErrorResponse$Errors(
      email: (email != null ? email.value : this.email),
      force: (force != null ? force.value : this.force),
      blocked: (blocked != null ? blocked.value : this.blocked),
      field: (field != null ? field.value : this.field),
      role: (role != null ? role.value : this.role),
      blockedCode: (blockedCode != null ? blockedCode.value : this.blockedCode),
      name: (name != null ? name.value : this.name),
      type: (type != null ? type.value : this.type),
      iban: (iban != null ? iban.value : this.iban),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      date: (date != null ? date.value : this.date),
    );
  }
}

String? dataDestroyObjectNullableToJson(
  enums.DataDestroyObject? dataDestroyObject,
) {
  return dataDestroyObject?.value;
}

String? dataDestroyObjectToJson(enums.DataDestroyObject dataDestroyObject) {
  return dataDestroyObject.value;
}

enums.DataDestroyObject dataDestroyObjectFromJson(
  Object? dataDestroyObject, [
  enums.DataDestroyObject? defaultValue,
]) {
  return enums.DataDestroyObject.values.firstWhereOrNull(
        (e) => e.value == dataDestroyObject,
      ) ??
      defaultValue ??
      enums.DataDestroyObject.swaggerGeneratedUnknown;
}

enums.DataDestroyObject? dataDestroyObjectNullableFromJson(
  Object? dataDestroyObject, [
  enums.DataDestroyObject? defaultValue,
]) {
  if (dataDestroyObject == null) {
    return null;
  }
  return enums.DataDestroyObject.values.firstWhereOrNull(
        (e) => e.value == dataDestroyObject,
      ) ??
      defaultValue;
}

String dataDestroyObjectExplodedListToJson(
  List<enums.DataDestroyObject>? dataDestroyObject,
) {
  return dataDestroyObject?.map((e) => e.value!).join(',') ?? '';
}

List<String> dataDestroyObjectListToJson(
  List<enums.DataDestroyObject>? dataDestroyObject,
) {
  if (dataDestroyObject == null) {
    return [];
  }

  return dataDestroyObject.map((e) => e.value!).toList();
}

List<enums.DataDestroyObject> dataDestroyObjectListFromJson(
  List? dataDestroyObject, [
  List<enums.DataDestroyObject>? defaultValue,
]) {
  if (dataDestroyObject == null) {
    return defaultValue ?? [];
  }

  return dataDestroyObject
      .map((e) => dataDestroyObjectFromJson(e.toString()))
      .toList();
}

List<enums.DataDestroyObject>? dataDestroyObjectNullableListFromJson(
  List? dataDestroyObject, [
  List<enums.DataDestroyObject>? defaultValue,
]) {
  if (dataDestroyObject == null) {
    return defaultValue;
  }

  return dataDestroyObject
      .map((e) => dataDestroyObjectFromJson(e.toString()))
      .toList();
}

String? accountSearchFieldFilterNullableToJson(
  enums.AccountSearchFieldFilter? accountSearchFieldFilter,
) {
  return accountSearchFieldFilter?.value;
}

String? accountSearchFieldFilterToJson(
  enums.AccountSearchFieldFilter accountSearchFieldFilter,
) {
  return accountSearchFieldFilter.value;
}

enums.AccountSearchFieldFilter accountSearchFieldFilterFromJson(
  Object? accountSearchFieldFilter, [
  enums.AccountSearchFieldFilter? defaultValue,
]) {
  return enums.AccountSearchFieldFilter.values.firstWhereOrNull(
        (e) => e.value == accountSearchFieldFilter,
      ) ??
      defaultValue ??
      enums.AccountSearchFieldFilter.swaggerGeneratedUnknown;
}

enums.AccountSearchFieldFilter? accountSearchFieldFilterNullableFromJson(
  Object? accountSearchFieldFilter, [
  enums.AccountSearchFieldFilter? defaultValue,
]) {
  if (accountSearchFieldFilter == null) {
    return null;
  }
  return enums.AccountSearchFieldFilter.values.firstWhereOrNull(
        (e) => e.value == accountSearchFieldFilter,
      ) ??
      defaultValue;
}

String accountSearchFieldFilterExplodedListToJson(
  List<enums.AccountSearchFieldFilter>? accountSearchFieldFilter,
) {
  return accountSearchFieldFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountSearchFieldFilterListToJson(
  List<enums.AccountSearchFieldFilter>? accountSearchFieldFilter,
) {
  if (accountSearchFieldFilter == null) {
    return [];
  }

  return accountSearchFieldFilter.map((e) => e.value!).toList();
}

List<enums.AccountSearchFieldFilter> accountSearchFieldFilterListFromJson(
  List? accountSearchFieldFilter, [
  List<enums.AccountSearchFieldFilter>? defaultValue,
]) {
  if (accountSearchFieldFilter == null) {
    return defaultValue ?? [];
  }

  return accountSearchFieldFilter
      .map((e) => accountSearchFieldFilterFromJson(e.toString()))
      .toList();
}

List<enums.AccountSearchFieldFilter>?
accountSearchFieldFilterNullableListFromJson(
  List? accountSearchFieldFilter, [
  List<enums.AccountSearchFieldFilter>? defaultValue,
]) {
  if (accountSearchFieldFilter == null) {
    return defaultValue;
  }

  return accountSearchFieldFilter
      .map((e) => accountSearchFieldFilterFromJson(e.toString()))
      .toList();
}

String? configValueFilterNullableToJson(
  enums.ConfigValueFilter? configValueFilter,
) {
  return configValueFilter?.value;
}

String? configValueFilterToJson(enums.ConfigValueFilter configValueFilter) {
  return configValueFilter.value;
}

enums.ConfigValueFilter configValueFilterFromJson(
  Object? configValueFilter, [
  enums.ConfigValueFilter? defaultValue,
]) {
  return enums.ConfigValueFilter.values.firstWhereOrNull(
        (e) => e.value == configValueFilter,
      ) ??
      defaultValue ??
      enums.ConfigValueFilter.swaggerGeneratedUnknown;
}

enums.ConfigValueFilter? configValueFilterNullableFromJson(
  Object? configValueFilter, [
  enums.ConfigValueFilter? defaultValue,
]) {
  if (configValueFilter == null) {
    return null;
  }
  return enums.ConfigValueFilter.values.firstWhereOrNull(
        (e) => e.value == configValueFilter,
      ) ??
      defaultValue;
}

String configValueFilterExplodedListToJson(
  List<enums.ConfigValueFilter>? configValueFilter,
) {
  return configValueFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> configValueFilterListToJson(
  List<enums.ConfigValueFilter>? configValueFilter,
) {
  if (configValueFilter == null) {
    return [];
  }

  return configValueFilter.map((e) => e.value!).toList();
}

List<enums.ConfigValueFilter> configValueFilterListFromJson(
  List? configValueFilter, [
  List<enums.ConfigValueFilter>? defaultValue,
]) {
  if (configValueFilter == null) {
    return defaultValue ?? [];
  }

  return configValueFilter
      .map((e) => configValueFilterFromJson(e.toString()))
      .toList();
}

List<enums.ConfigValueFilter>? configValueFilterNullableListFromJson(
  List? configValueFilter, [
  List<enums.ConfigValueFilter>? defaultValue,
]) {
  if (configValueFilter == null) {
    return defaultValue;
  }

  return configValueFilter
      .map((e) => configValueFilterFromJson(e.toString()))
      .toList();
}

String? configValueUpdateFilterNullableToJson(
  enums.ConfigValueUpdateFilter? configValueUpdateFilter,
) {
  return configValueUpdateFilter?.value;
}

String? configValueUpdateFilterToJson(
  enums.ConfigValueUpdateFilter configValueUpdateFilter,
) {
  return configValueUpdateFilter.value;
}

enums.ConfigValueUpdateFilter configValueUpdateFilterFromJson(
  Object? configValueUpdateFilter, [
  enums.ConfigValueUpdateFilter? defaultValue,
]) {
  return enums.ConfigValueUpdateFilter.values.firstWhereOrNull(
        (e) => e.value == configValueUpdateFilter,
      ) ??
      defaultValue ??
      enums.ConfigValueUpdateFilter.swaggerGeneratedUnknown;
}

enums.ConfigValueUpdateFilter? configValueUpdateFilterNullableFromJson(
  Object? configValueUpdateFilter, [
  enums.ConfigValueUpdateFilter? defaultValue,
]) {
  if (configValueUpdateFilter == null) {
    return null;
  }
  return enums.ConfigValueUpdateFilter.values.firstWhereOrNull(
        (e) => e.value == configValueUpdateFilter,
      ) ??
      defaultValue;
}

String configValueUpdateFilterExplodedListToJson(
  List<enums.ConfigValueUpdateFilter>? configValueUpdateFilter,
) {
  return configValueUpdateFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> configValueUpdateFilterListToJson(
  List<enums.ConfigValueUpdateFilter>? configValueUpdateFilter,
) {
  if (configValueUpdateFilter == null) {
    return [];
  }

  return configValueUpdateFilter.map((e) => e.value!).toList();
}

List<enums.ConfigValueUpdateFilter> configValueUpdateFilterListFromJson(
  List? configValueUpdateFilter, [
  List<enums.ConfigValueUpdateFilter>? defaultValue,
]) {
  if (configValueUpdateFilter == null) {
    return defaultValue ?? [];
  }

  return configValueUpdateFilter
      .map((e) => configValueUpdateFilterFromJson(e.toString()))
      .toList();
}

List<enums.ConfigValueUpdateFilter>?
configValueUpdateFilterNullableListFromJson(
  List? configValueUpdateFilter, [
  List<enums.ConfigValueUpdateFilter>? defaultValue,
]) {
  if (configValueUpdateFilter == null) {
    return defaultValue;
  }

  return configValueUpdateFilter
      .map((e) => configValueUpdateFilterFromJson(e.toString()))
      .toList();
}

String? exportFileFilterNullableToJson(
  enums.ExportFileFilter? exportFileFilter,
) {
  return exportFileFilter?.value;
}

String? exportFileFilterToJson(enums.ExportFileFilter exportFileFilter) {
  return exportFileFilter.value;
}

enums.ExportFileFilter exportFileFilterFromJson(
  Object? exportFileFilter, [
  enums.ExportFileFilter? defaultValue,
]) {
  return enums.ExportFileFilter.values.firstWhereOrNull(
        (e) => e.value == exportFileFilter,
      ) ??
      defaultValue ??
      enums.ExportFileFilter.swaggerGeneratedUnknown;
}

enums.ExportFileFilter? exportFileFilterNullableFromJson(
  Object? exportFileFilter, [
  enums.ExportFileFilter? defaultValue,
]) {
  if (exportFileFilter == null) {
    return null;
  }
  return enums.ExportFileFilter.values.firstWhereOrNull(
        (e) => e.value == exportFileFilter,
      ) ??
      defaultValue;
}

String exportFileFilterExplodedListToJson(
  List<enums.ExportFileFilter>? exportFileFilter,
) {
  return exportFileFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> exportFileFilterListToJson(
  List<enums.ExportFileFilter>? exportFileFilter,
) {
  if (exportFileFilter == null) {
    return [];
  }

  return exportFileFilter.map((e) => e.value!).toList();
}

List<enums.ExportFileFilter> exportFileFilterListFromJson(
  List? exportFileFilter, [
  List<enums.ExportFileFilter>? defaultValue,
]) {
  if (exportFileFilter == null) {
    return defaultValue ?? [];
  }

  return exportFileFilter
      .map((e) => exportFileFilterFromJson(e.toString()))
      .toList();
}

List<enums.ExportFileFilter>? exportFileFilterNullableListFromJson(
  List? exportFileFilter, [
  List<enums.ExportFileFilter>? defaultValue,
]) {
  if (exportFileFilter == null) {
    return defaultValue;
  }

  return exportFileFilter
      .map((e) => exportFileFilterFromJson(e.toString()))
      .toList();
}

String? currencyUpdatePrimaryNullableToJson(
  enums.CurrencyUpdatePrimary? currencyUpdatePrimary,
) {
  return currencyUpdatePrimary?.value;
}

String? currencyUpdatePrimaryToJson(
  enums.CurrencyUpdatePrimary currencyUpdatePrimary,
) {
  return currencyUpdatePrimary.value;
}

enums.CurrencyUpdatePrimary currencyUpdatePrimaryFromJson(
  Object? currencyUpdatePrimary, [
  enums.CurrencyUpdatePrimary? defaultValue,
]) {
  return enums.CurrencyUpdatePrimary.values.firstWhereOrNull(
        (e) => e.value == currencyUpdatePrimary,
      ) ??
      defaultValue ??
      enums.CurrencyUpdatePrimary.swaggerGeneratedUnknown;
}

enums.CurrencyUpdatePrimary? currencyUpdatePrimaryNullableFromJson(
  Object? currencyUpdatePrimary, [
  enums.CurrencyUpdatePrimary? defaultValue,
]) {
  if (currencyUpdatePrimary == null) {
    return null;
  }
  return enums.CurrencyUpdatePrimary.values.firstWhereOrNull(
        (e) => e.value == currencyUpdatePrimary,
      ) ??
      defaultValue;
}

String currencyUpdatePrimaryExplodedListToJson(
  List<enums.CurrencyUpdatePrimary>? currencyUpdatePrimary,
) {
  return currencyUpdatePrimary?.map((e) => e.value!).join(',') ?? '';
}

List<String> currencyUpdatePrimaryListToJson(
  List<enums.CurrencyUpdatePrimary>? currencyUpdatePrimary,
) {
  if (currencyUpdatePrimary == null) {
    return [];
  }

  return currencyUpdatePrimary.map((e) => e.value!).toList();
}

List<enums.CurrencyUpdatePrimary> currencyUpdatePrimaryListFromJson(
  List? currencyUpdatePrimary, [
  List<enums.CurrencyUpdatePrimary>? defaultValue,
]) {
  if (currencyUpdatePrimary == null) {
    return defaultValue ?? [];
  }

  return currencyUpdatePrimary
      .map((e) => currencyUpdatePrimaryFromJson(e.toString()))
      .toList();
}

List<enums.CurrencyUpdatePrimary>? currencyUpdatePrimaryNullableListFromJson(
  List? currencyUpdatePrimary, [
  List<enums.CurrencyUpdatePrimary>? defaultValue,
]) {
  if (currencyUpdatePrimary == null) {
    return defaultValue;
  }

  return currencyUpdatePrimary
      .map((e) => currencyUpdatePrimaryFromJson(e.toString()))
      .toList();
}

String? userGroupReadRoleNullableToJson(
  enums.UserGroupReadRole? userGroupReadRole,
) {
  return userGroupReadRole?.value;
}

String? userGroupReadRoleToJson(enums.UserGroupReadRole userGroupReadRole) {
  return userGroupReadRole.value;
}

enums.UserGroupReadRole userGroupReadRoleFromJson(
  Object? userGroupReadRole, [
  enums.UserGroupReadRole? defaultValue,
]) {
  return enums.UserGroupReadRole.values.firstWhereOrNull(
        (e) => e.value == userGroupReadRole,
      ) ??
      defaultValue ??
      enums.UserGroupReadRole.swaggerGeneratedUnknown;
}

enums.UserGroupReadRole? userGroupReadRoleNullableFromJson(
  Object? userGroupReadRole, [
  enums.UserGroupReadRole? defaultValue,
]) {
  if (userGroupReadRole == null) {
    return null;
  }
  return enums.UserGroupReadRole.values.firstWhereOrNull(
        (e) => e.value == userGroupReadRole,
      ) ??
      defaultValue;
}

String userGroupReadRoleExplodedListToJson(
  List<enums.UserGroupReadRole>? userGroupReadRole,
) {
  return userGroupReadRole?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGroupReadRoleListToJson(
  List<enums.UserGroupReadRole>? userGroupReadRole,
) {
  if (userGroupReadRole == null) {
    return [];
  }

  return userGroupReadRole.map((e) => e.value!).toList();
}

List<enums.UserGroupReadRole> userGroupReadRoleListFromJson(
  List? userGroupReadRole, [
  List<enums.UserGroupReadRole>? defaultValue,
]) {
  if (userGroupReadRole == null) {
    return defaultValue ?? [];
  }

  return userGroupReadRole
      .map((e) => userGroupReadRoleFromJson(e.toString()))
      .toList();
}

List<enums.UserGroupReadRole>? userGroupReadRoleNullableListFromJson(
  List? userGroupReadRole, [
  List<enums.UserGroupReadRole>? defaultValue,
]) {
  if (userGroupReadRole == null) {
    return defaultValue;
  }

  return userGroupReadRole
      .map((e) => userGroupReadRoleFromJson(e.toString()))
      .toList();
}

String? webhookDeliveryNullableToJson(enums.WebhookDelivery? webhookDelivery) {
  return webhookDelivery?.value;
}

String? webhookDeliveryToJson(enums.WebhookDelivery webhookDelivery) {
  return webhookDelivery.value;
}

enums.WebhookDelivery webhookDeliveryFromJson(
  Object? webhookDelivery, [
  enums.WebhookDelivery? defaultValue,
]) {
  return enums.WebhookDelivery.values.firstWhereOrNull(
        (e) => e.value == webhookDelivery,
      ) ??
      defaultValue ??
      enums.WebhookDelivery.swaggerGeneratedUnknown;
}

enums.WebhookDelivery? webhookDeliveryNullableFromJson(
  Object? webhookDelivery, [
  enums.WebhookDelivery? defaultValue,
]) {
  if (webhookDelivery == null) {
    return null;
  }
  return enums.WebhookDelivery.values.firstWhereOrNull(
        (e) => e.value == webhookDelivery,
      ) ??
      defaultValue;
}

String webhookDeliveryExplodedListToJson(
  List<enums.WebhookDelivery>? webhookDelivery,
) {
  return webhookDelivery?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookDeliveryListToJson(
  List<enums.WebhookDelivery>? webhookDelivery,
) {
  if (webhookDelivery == null) {
    return [];
  }

  return webhookDelivery.map((e) => e.value!).toList();
}

List<enums.WebhookDelivery> webhookDeliveryListFromJson(
  List? webhookDelivery, [
  List<enums.WebhookDelivery>? defaultValue,
]) {
  if (webhookDelivery == null) {
    return defaultValue ?? [];
  }

  return webhookDelivery
      .map((e) => webhookDeliveryFromJson(e.toString()))
      .toList();
}

List<enums.WebhookDelivery>? webhookDeliveryNullableListFromJson(
  List? webhookDelivery, [
  List<enums.WebhookDelivery>? defaultValue,
]) {
  if (webhookDelivery == null) {
    return defaultValue;
  }

  return webhookDelivery
      .map((e) => webhookDeliveryFromJson(e.toString()))
      .toList();
}

String? webhookResponseNullableToJson(enums.WebhookResponse? webhookResponse) {
  return webhookResponse?.value;
}

String? webhookResponseToJson(enums.WebhookResponse webhookResponse) {
  return webhookResponse.value;
}

enums.WebhookResponse webhookResponseFromJson(
  Object? webhookResponse, [
  enums.WebhookResponse? defaultValue,
]) {
  return enums.WebhookResponse.values.firstWhereOrNull(
        (e) => e.value == webhookResponse,
      ) ??
      defaultValue ??
      enums.WebhookResponse.swaggerGeneratedUnknown;
}

enums.WebhookResponse? webhookResponseNullableFromJson(
  Object? webhookResponse, [
  enums.WebhookResponse? defaultValue,
]) {
  if (webhookResponse == null) {
    return null;
  }
  return enums.WebhookResponse.values.firstWhereOrNull(
        (e) => e.value == webhookResponse,
      ) ??
      defaultValue;
}

String webhookResponseExplodedListToJson(
  List<enums.WebhookResponse>? webhookResponse,
) {
  return webhookResponse?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookResponseListToJson(
  List<enums.WebhookResponse>? webhookResponse,
) {
  if (webhookResponse == null) {
    return [];
  }

  return webhookResponse.map((e) => e.value!).toList();
}

List<enums.WebhookResponse> webhookResponseListFromJson(
  List? webhookResponse, [
  List<enums.WebhookResponse>? defaultValue,
]) {
  if (webhookResponse == null) {
    return defaultValue ?? [];
  }

  return webhookResponse
      .map((e) => webhookResponseFromJson(e.toString()))
      .toList();
}

List<enums.WebhookResponse>? webhookResponseNullableListFromJson(
  List? webhookResponse, [
  List<enums.WebhookResponse>? defaultValue,
]) {
  if (webhookResponse == null) {
    return defaultValue;
  }

  return webhookResponse
      .map((e) => webhookResponseFromJson(e.toString()))
      .toList();
}

String? webhookTriggerNullableToJson(enums.WebhookTrigger? webhookTrigger) {
  return webhookTrigger?.value;
}

String? webhookTriggerToJson(enums.WebhookTrigger webhookTrigger) {
  return webhookTrigger.value;
}

enums.WebhookTrigger webhookTriggerFromJson(
  Object? webhookTrigger, [
  enums.WebhookTrigger? defaultValue,
]) {
  return enums.WebhookTrigger.values.firstWhereOrNull(
        (e) => e.value == webhookTrigger,
      ) ??
      defaultValue ??
      enums.WebhookTrigger.swaggerGeneratedUnknown;
}

enums.WebhookTrigger? webhookTriggerNullableFromJson(
  Object? webhookTrigger, [
  enums.WebhookTrigger? defaultValue,
]) {
  if (webhookTrigger == null) {
    return null;
  }
  return enums.WebhookTrigger.values.firstWhereOrNull(
        (e) => e.value == webhookTrigger,
      ) ??
      defaultValue;
}

String webhookTriggerExplodedListToJson(
  List<enums.WebhookTrigger>? webhookTrigger,
) {
  return webhookTrigger?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookTriggerListToJson(
  List<enums.WebhookTrigger>? webhookTrigger,
) {
  if (webhookTrigger == null) {
    return [];
  }

  return webhookTrigger.map((e) => e.value!).toList();
}

List<enums.WebhookTrigger> webhookTriggerListFromJson(
  List? webhookTrigger, [
  List<enums.WebhookTrigger>? defaultValue,
]) {
  if (webhookTrigger == null) {
    return defaultValue ?? [];
  }

  return webhookTrigger
      .map((e) => webhookTriggerFromJson(e.toString()))
      .toList();
}

List<enums.WebhookTrigger>? webhookTriggerNullableListFromJson(
  List? webhookTrigger, [
  List<enums.WebhookTrigger>? defaultValue,
]) {
  if (webhookTrigger == null) {
    return defaultValue;
  }

  return webhookTrigger
      .map((e) => webhookTriggerFromJson(e.toString()))
      .toList();
}

String? attachableTypeNullableToJson(enums.AttachableType? attachableType) {
  return attachableType?.value;
}

String? attachableTypeToJson(enums.AttachableType attachableType) {
  return attachableType.value;
}

enums.AttachableType attachableTypeFromJson(
  Object? attachableType, [
  enums.AttachableType? defaultValue,
]) {
  return enums.AttachableType.values.firstWhereOrNull(
        (e) => e.value == attachableType,
      ) ??
      defaultValue ??
      enums.AttachableType.swaggerGeneratedUnknown;
}

enums.AttachableType? attachableTypeNullableFromJson(
  Object? attachableType, [
  enums.AttachableType? defaultValue,
]) {
  if (attachableType == null) {
    return null;
  }
  return enums.AttachableType.values.firstWhereOrNull(
        (e) => e.value == attachableType,
      ) ??
      defaultValue;
}

String attachableTypeExplodedListToJson(
  List<enums.AttachableType>? attachableType,
) {
  return attachableType?.map((e) => e.value!).join(',') ?? '';
}

List<String> attachableTypeListToJson(
  List<enums.AttachableType>? attachableType,
) {
  if (attachableType == null) {
    return [];
  }

  return attachableType.map((e) => e.value!).toList();
}

List<enums.AttachableType> attachableTypeListFromJson(
  List? attachableType, [
  List<enums.AttachableType>? defaultValue,
]) {
  if (attachableType == null) {
    return defaultValue ?? [];
  }

  return attachableType
      .map((e) => attachableTypeFromJson(e.toString()))
      .toList();
}

List<enums.AttachableType>? attachableTypeNullableListFromJson(
  List? attachableType, [
  List<enums.AttachableType>? defaultValue,
]) {
  if (attachableType == null) {
    return defaultValue;
  }

  return attachableType
      .map((e) => attachableTypeFromJson(e.toString()))
      .toList();
}

String? autoBudgetPeriodNullableToJson(
  enums.AutoBudgetPeriod? autoBudgetPeriod,
) {
  return autoBudgetPeriod?.value;
}

String? autoBudgetPeriodToJson(enums.AutoBudgetPeriod autoBudgetPeriod) {
  return autoBudgetPeriod.value;
}

enums.AutoBudgetPeriod autoBudgetPeriodFromJson(
  Object? autoBudgetPeriod, [
  enums.AutoBudgetPeriod? defaultValue,
]) {
  return enums.AutoBudgetPeriod.values.firstWhereOrNull(
        (e) => e.value == autoBudgetPeriod,
      ) ??
      defaultValue ??
      enums.AutoBudgetPeriod.swaggerGeneratedUnknown;
}

enums.AutoBudgetPeriod? autoBudgetPeriodNullableFromJson(
  Object? autoBudgetPeriod, [
  enums.AutoBudgetPeriod? defaultValue,
]) {
  if (autoBudgetPeriod == null) {
    return null;
  }
  return enums.AutoBudgetPeriod.values.firstWhereOrNull(
        (e) => e.value == autoBudgetPeriod,
      ) ??
      defaultValue;
}

String autoBudgetPeriodExplodedListToJson(
  List<enums.AutoBudgetPeriod>? autoBudgetPeriod,
) {
  return autoBudgetPeriod?.map((e) => e.value!).join(',') ?? '';
}

List<String> autoBudgetPeriodListToJson(
  List<enums.AutoBudgetPeriod>? autoBudgetPeriod,
) {
  if (autoBudgetPeriod == null) {
    return [];
  }

  return autoBudgetPeriod.map((e) => e.value!).toList();
}

List<enums.AutoBudgetPeriod> autoBudgetPeriodListFromJson(
  List? autoBudgetPeriod, [
  List<enums.AutoBudgetPeriod>? defaultValue,
]) {
  if (autoBudgetPeriod == null) {
    return defaultValue ?? [];
  }

  return autoBudgetPeriod
      .map((e) => autoBudgetPeriodFromJson(e.toString()))
      .toList();
}

List<enums.AutoBudgetPeriod>? autoBudgetPeriodNullableListFromJson(
  List? autoBudgetPeriod, [
  List<enums.AutoBudgetPeriod>? defaultValue,
]) {
  if (autoBudgetPeriod == null) {
    return defaultValue;
  }

  return autoBudgetPeriod
      .map((e) => autoBudgetPeriodFromJson(e.toString()))
      .toList();
}

String? autoBudgetTypeNullableToJson(enums.AutoBudgetType? autoBudgetType) {
  return autoBudgetType?.value;
}

String? autoBudgetTypeToJson(enums.AutoBudgetType autoBudgetType) {
  return autoBudgetType.value;
}

enums.AutoBudgetType autoBudgetTypeFromJson(
  Object? autoBudgetType, [
  enums.AutoBudgetType? defaultValue,
]) {
  return enums.AutoBudgetType.values.firstWhereOrNull(
        (e) => e.value == autoBudgetType,
      ) ??
      defaultValue ??
      enums.AutoBudgetType.swaggerGeneratedUnknown;
}

enums.AutoBudgetType? autoBudgetTypeNullableFromJson(
  Object? autoBudgetType, [
  enums.AutoBudgetType? defaultValue,
]) {
  if (autoBudgetType == null) {
    return null;
  }
  return enums.AutoBudgetType.values.firstWhereOrNull(
        (e) => e.value == autoBudgetType,
      ) ??
      defaultValue;
}

String autoBudgetTypeExplodedListToJson(
  List<enums.AutoBudgetType>? autoBudgetType,
) {
  return autoBudgetType?.map((e) => e.value!).join(',') ?? '';
}

List<String> autoBudgetTypeListToJson(
  List<enums.AutoBudgetType>? autoBudgetType,
) {
  if (autoBudgetType == null) {
    return [];
  }

  return autoBudgetType.map((e) => e.value!).toList();
}

List<enums.AutoBudgetType> autoBudgetTypeListFromJson(
  List? autoBudgetType, [
  List<enums.AutoBudgetType>? defaultValue,
]) {
  if (autoBudgetType == null) {
    return defaultValue ?? [];
  }

  return autoBudgetType
      .map((e) => autoBudgetTypeFromJson(e.toString()))
      .toList();
}

List<enums.AutoBudgetType>? autoBudgetTypeNullableListFromJson(
  List? autoBudgetType, [
  List<enums.AutoBudgetType>? defaultValue,
]) {
  if (autoBudgetType == null) {
    return defaultValue;
  }

  return autoBudgetType
      .map((e) => autoBudgetTypeFromJson(e.toString()))
      .toList();
}

String? billRepeatFrequencyNullableToJson(
  enums.BillRepeatFrequency? billRepeatFrequency,
) {
  return billRepeatFrequency?.value;
}

String? billRepeatFrequencyToJson(
  enums.BillRepeatFrequency billRepeatFrequency,
) {
  return billRepeatFrequency.value;
}

enums.BillRepeatFrequency billRepeatFrequencyFromJson(
  Object? billRepeatFrequency, [
  enums.BillRepeatFrequency? defaultValue,
]) {
  return enums.BillRepeatFrequency.values.firstWhereOrNull(
        (e) => e.value == billRepeatFrequency,
      ) ??
      defaultValue ??
      enums.BillRepeatFrequency.swaggerGeneratedUnknown;
}

enums.BillRepeatFrequency? billRepeatFrequencyNullableFromJson(
  Object? billRepeatFrequency, [
  enums.BillRepeatFrequency? defaultValue,
]) {
  if (billRepeatFrequency == null) {
    return null;
  }
  return enums.BillRepeatFrequency.values.firstWhereOrNull(
        (e) => e.value == billRepeatFrequency,
      ) ??
      defaultValue;
}

String billRepeatFrequencyExplodedListToJson(
  List<enums.BillRepeatFrequency>? billRepeatFrequency,
) {
  return billRepeatFrequency?.map((e) => e.value!).join(',') ?? '';
}

List<String> billRepeatFrequencyListToJson(
  List<enums.BillRepeatFrequency>? billRepeatFrequency,
) {
  if (billRepeatFrequency == null) {
    return [];
  }

  return billRepeatFrequency.map((e) => e.value!).toList();
}

List<enums.BillRepeatFrequency> billRepeatFrequencyListFromJson(
  List? billRepeatFrequency, [
  List<enums.BillRepeatFrequency>? defaultValue,
]) {
  if (billRepeatFrequency == null) {
    return defaultValue ?? [];
  }

  return billRepeatFrequency
      .map((e) => billRepeatFrequencyFromJson(e.toString()))
      .toList();
}

List<enums.BillRepeatFrequency>? billRepeatFrequencyNullableListFromJson(
  List? billRepeatFrequency, [
  List<enums.BillRepeatFrequency>? defaultValue,
]) {
  if (billRepeatFrequency == null) {
    return defaultValue;
  }

  return billRepeatFrequency
      .map((e) => billRepeatFrequencyFromJson(e.toString()))
      .toList();
}

String? recurrenceRepetitionTypeNullableToJson(
  enums.RecurrenceRepetitionType? recurrenceRepetitionType,
) {
  return recurrenceRepetitionType?.value;
}

String? recurrenceRepetitionTypeToJson(
  enums.RecurrenceRepetitionType recurrenceRepetitionType,
) {
  return recurrenceRepetitionType.value;
}

enums.RecurrenceRepetitionType recurrenceRepetitionTypeFromJson(
  Object? recurrenceRepetitionType, [
  enums.RecurrenceRepetitionType? defaultValue,
]) {
  return enums.RecurrenceRepetitionType.values.firstWhereOrNull(
        (e) => e.value == recurrenceRepetitionType,
      ) ??
      defaultValue ??
      enums.RecurrenceRepetitionType.swaggerGeneratedUnknown;
}

enums.RecurrenceRepetitionType? recurrenceRepetitionTypeNullableFromJson(
  Object? recurrenceRepetitionType, [
  enums.RecurrenceRepetitionType? defaultValue,
]) {
  if (recurrenceRepetitionType == null) {
    return null;
  }
  return enums.RecurrenceRepetitionType.values.firstWhereOrNull(
        (e) => e.value == recurrenceRepetitionType,
      ) ??
      defaultValue;
}

String recurrenceRepetitionTypeExplodedListToJson(
  List<enums.RecurrenceRepetitionType>? recurrenceRepetitionType,
) {
  return recurrenceRepetitionType?.map((e) => e.value!).join(',') ?? '';
}

List<String> recurrenceRepetitionTypeListToJson(
  List<enums.RecurrenceRepetitionType>? recurrenceRepetitionType,
) {
  if (recurrenceRepetitionType == null) {
    return [];
  }

  return recurrenceRepetitionType.map((e) => e.value!).toList();
}

List<enums.RecurrenceRepetitionType> recurrenceRepetitionTypeListFromJson(
  List? recurrenceRepetitionType, [
  List<enums.RecurrenceRepetitionType>? defaultValue,
]) {
  if (recurrenceRepetitionType == null) {
    return defaultValue ?? [];
  }

  return recurrenceRepetitionType
      .map((e) => recurrenceRepetitionTypeFromJson(e.toString()))
      .toList();
}

List<enums.RecurrenceRepetitionType>?
recurrenceRepetitionTypeNullableListFromJson(
  List? recurrenceRepetitionType, [
  List<enums.RecurrenceRepetitionType>? defaultValue,
]) {
  if (recurrenceRepetitionType == null) {
    return defaultValue;
  }

  return recurrenceRepetitionType
      .map((e) => recurrenceRepetitionTypeFromJson(e.toString()))
      .toList();
}

String? recurrenceTransactionTypeNullableToJson(
  enums.RecurrenceTransactionType? recurrenceTransactionType,
) {
  return recurrenceTransactionType?.value;
}

String? recurrenceTransactionTypeToJson(
  enums.RecurrenceTransactionType recurrenceTransactionType,
) {
  return recurrenceTransactionType.value;
}

enums.RecurrenceTransactionType recurrenceTransactionTypeFromJson(
  Object? recurrenceTransactionType, [
  enums.RecurrenceTransactionType? defaultValue,
]) {
  return enums.RecurrenceTransactionType.values.firstWhereOrNull(
        (e) => e.value == recurrenceTransactionType,
      ) ??
      defaultValue ??
      enums.RecurrenceTransactionType.swaggerGeneratedUnknown;
}

enums.RecurrenceTransactionType? recurrenceTransactionTypeNullableFromJson(
  Object? recurrenceTransactionType, [
  enums.RecurrenceTransactionType? defaultValue,
]) {
  if (recurrenceTransactionType == null) {
    return null;
  }
  return enums.RecurrenceTransactionType.values.firstWhereOrNull(
        (e) => e.value == recurrenceTransactionType,
      ) ??
      defaultValue;
}

String recurrenceTransactionTypeExplodedListToJson(
  List<enums.RecurrenceTransactionType>? recurrenceTransactionType,
) {
  return recurrenceTransactionType?.map((e) => e.value!).join(',') ?? '';
}

List<String> recurrenceTransactionTypeListToJson(
  List<enums.RecurrenceTransactionType>? recurrenceTransactionType,
) {
  if (recurrenceTransactionType == null) {
    return [];
  }

  return recurrenceTransactionType.map((e) => e.value!).toList();
}

List<enums.RecurrenceTransactionType> recurrenceTransactionTypeListFromJson(
  List? recurrenceTransactionType, [
  List<enums.RecurrenceTransactionType>? defaultValue,
]) {
  if (recurrenceTransactionType == null) {
    return defaultValue ?? [];
  }

  return recurrenceTransactionType
      .map((e) => recurrenceTransactionTypeFromJson(e.toString()))
      .toList();
}

List<enums.RecurrenceTransactionType>?
recurrenceTransactionTypeNullableListFromJson(
  List? recurrenceTransactionType, [
  List<enums.RecurrenceTransactionType>? defaultValue,
]) {
  if (recurrenceTransactionType == null) {
    return defaultValue;
  }

  return recurrenceTransactionType
      .map((e) => recurrenceTransactionTypeFromJson(e.toString()))
      .toList();
}

String? ruleActionKeywordNullableToJson(
  enums.RuleActionKeyword? ruleActionKeyword,
) {
  return ruleActionKeyword?.value;
}

String? ruleActionKeywordToJson(enums.RuleActionKeyword ruleActionKeyword) {
  return ruleActionKeyword.value;
}

enums.RuleActionKeyword ruleActionKeywordFromJson(
  Object? ruleActionKeyword, [
  enums.RuleActionKeyword? defaultValue,
]) {
  return enums.RuleActionKeyword.values.firstWhereOrNull(
        (e) => e.value == ruleActionKeyword,
      ) ??
      defaultValue ??
      enums.RuleActionKeyword.swaggerGeneratedUnknown;
}

enums.RuleActionKeyword? ruleActionKeywordNullableFromJson(
  Object? ruleActionKeyword, [
  enums.RuleActionKeyword? defaultValue,
]) {
  if (ruleActionKeyword == null) {
    return null;
  }
  return enums.RuleActionKeyword.values.firstWhereOrNull(
        (e) => e.value == ruleActionKeyword,
      ) ??
      defaultValue;
}

String ruleActionKeywordExplodedListToJson(
  List<enums.RuleActionKeyword>? ruleActionKeyword,
) {
  return ruleActionKeyword?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleActionKeywordListToJson(
  List<enums.RuleActionKeyword>? ruleActionKeyword,
) {
  if (ruleActionKeyword == null) {
    return [];
  }

  return ruleActionKeyword.map((e) => e.value!).toList();
}

List<enums.RuleActionKeyword> ruleActionKeywordListFromJson(
  List? ruleActionKeyword, [
  List<enums.RuleActionKeyword>? defaultValue,
]) {
  if (ruleActionKeyword == null) {
    return defaultValue ?? [];
  }

  return ruleActionKeyword
      .map((e) => ruleActionKeywordFromJson(e.toString()))
      .toList();
}

List<enums.RuleActionKeyword>? ruleActionKeywordNullableListFromJson(
  List? ruleActionKeyword, [
  List<enums.RuleActionKeyword>? defaultValue,
]) {
  if (ruleActionKeyword == null) {
    return defaultValue;
  }

  return ruleActionKeyword
      .map((e) => ruleActionKeywordFromJson(e.toString()))
      .toList();
}

String? ruleTriggerKeywordNullableToJson(
  enums.RuleTriggerKeyword? ruleTriggerKeyword,
) {
  return ruleTriggerKeyword?.value;
}

String? ruleTriggerKeywordToJson(enums.RuleTriggerKeyword ruleTriggerKeyword) {
  return ruleTriggerKeyword.value;
}

enums.RuleTriggerKeyword ruleTriggerKeywordFromJson(
  Object? ruleTriggerKeyword, [
  enums.RuleTriggerKeyword? defaultValue,
]) {
  return enums.RuleTriggerKeyword.values.firstWhereOrNull(
        (e) => e.value == ruleTriggerKeyword,
      ) ??
      defaultValue ??
      enums.RuleTriggerKeyword.swaggerGeneratedUnknown;
}

enums.RuleTriggerKeyword? ruleTriggerKeywordNullableFromJson(
  Object? ruleTriggerKeyword, [
  enums.RuleTriggerKeyword? defaultValue,
]) {
  if (ruleTriggerKeyword == null) {
    return null;
  }
  return enums.RuleTriggerKeyword.values.firstWhereOrNull(
        (e) => e.value == ruleTriggerKeyword,
      ) ??
      defaultValue;
}

String ruleTriggerKeywordExplodedListToJson(
  List<enums.RuleTriggerKeyword>? ruleTriggerKeyword,
) {
  return ruleTriggerKeyword?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleTriggerKeywordListToJson(
  List<enums.RuleTriggerKeyword>? ruleTriggerKeyword,
) {
  if (ruleTriggerKeyword == null) {
    return [];
  }

  return ruleTriggerKeyword.map((e) => e.value!).toList();
}

List<enums.RuleTriggerKeyword> ruleTriggerKeywordListFromJson(
  List? ruleTriggerKeyword, [
  List<enums.RuleTriggerKeyword>? defaultValue,
]) {
  if (ruleTriggerKeyword == null) {
    return defaultValue ?? [];
  }

  return ruleTriggerKeyword
      .map((e) => ruleTriggerKeywordFromJson(e.toString()))
      .toList();
}

List<enums.RuleTriggerKeyword>? ruleTriggerKeywordNullableListFromJson(
  List? ruleTriggerKeyword, [
  List<enums.RuleTriggerKeyword>? defaultValue,
]) {
  if (ruleTriggerKeyword == null) {
    return defaultValue;
  }

  return ruleTriggerKeyword
      .map((e) => ruleTriggerKeywordFromJson(e.toString()))
      .toList();
}

String? ruleTriggerTypeNullableToJson(enums.RuleTriggerType? ruleTriggerType) {
  return ruleTriggerType?.value;
}

String? ruleTriggerTypeToJson(enums.RuleTriggerType ruleTriggerType) {
  return ruleTriggerType.value;
}

enums.RuleTriggerType ruleTriggerTypeFromJson(
  Object? ruleTriggerType, [
  enums.RuleTriggerType? defaultValue,
]) {
  return enums.RuleTriggerType.values.firstWhereOrNull(
        (e) => e.value == ruleTriggerType,
      ) ??
      defaultValue ??
      enums.RuleTriggerType.swaggerGeneratedUnknown;
}

enums.RuleTriggerType? ruleTriggerTypeNullableFromJson(
  Object? ruleTriggerType, [
  enums.RuleTriggerType? defaultValue,
]) {
  if (ruleTriggerType == null) {
    return null;
  }
  return enums.RuleTriggerType.values.firstWhereOrNull(
        (e) => e.value == ruleTriggerType,
      ) ??
      defaultValue;
}

String ruleTriggerTypeExplodedListToJson(
  List<enums.RuleTriggerType>? ruleTriggerType,
) {
  return ruleTriggerType?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleTriggerTypeListToJson(
  List<enums.RuleTriggerType>? ruleTriggerType,
) {
  if (ruleTriggerType == null) {
    return [];
  }

  return ruleTriggerType.map((e) => e.value!).toList();
}

List<enums.RuleTriggerType> ruleTriggerTypeListFromJson(
  List? ruleTriggerType, [
  List<enums.RuleTriggerType>? defaultValue,
]) {
  if (ruleTriggerType == null) {
    return defaultValue ?? [];
  }

  return ruleTriggerType
      .map((e) => ruleTriggerTypeFromJson(e.toString()))
      .toList();
}

List<enums.RuleTriggerType>? ruleTriggerTypeNullableListFromJson(
  List? ruleTriggerType, [
  List<enums.RuleTriggerType>? defaultValue,
]) {
  if (ruleTriggerType == null) {
    return defaultValue;
  }

  return ruleTriggerType
      .map((e) => ruleTriggerTypeFromJson(e.toString()))
      .toList();
}

String? userBlockedCodePropertyNullableToJson(
  enums.UserBlockedCodeProperty? userBlockedCodeProperty,
) {
  return userBlockedCodeProperty?.value;
}

String? userBlockedCodePropertyToJson(
  enums.UserBlockedCodeProperty userBlockedCodeProperty,
) {
  return userBlockedCodeProperty.value;
}

enums.UserBlockedCodeProperty userBlockedCodePropertyFromJson(
  Object? userBlockedCodeProperty, [
  enums.UserBlockedCodeProperty? defaultValue,
]) {
  return enums.UserBlockedCodeProperty.values.firstWhereOrNull(
        (e) => e.value == userBlockedCodeProperty,
      ) ??
      defaultValue ??
      enums.UserBlockedCodeProperty.swaggerGeneratedUnknown;
}

enums.UserBlockedCodeProperty? userBlockedCodePropertyNullableFromJson(
  Object? userBlockedCodeProperty, [
  enums.UserBlockedCodeProperty? defaultValue,
]) {
  if (userBlockedCodeProperty == null) {
    return null;
  }
  return enums.UserBlockedCodeProperty.values.firstWhereOrNull(
        (e) => e.value == userBlockedCodeProperty,
      ) ??
      defaultValue;
}

String userBlockedCodePropertyExplodedListToJson(
  List<enums.UserBlockedCodeProperty>? userBlockedCodeProperty,
) {
  return userBlockedCodeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> userBlockedCodePropertyListToJson(
  List<enums.UserBlockedCodeProperty>? userBlockedCodeProperty,
) {
  if (userBlockedCodeProperty == null) {
    return [];
  }

  return userBlockedCodeProperty.map((e) => e.value!).toList();
}

List<enums.UserBlockedCodeProperty> userBlockedCodePropertyListFromJson(
  List? userBlockedCodeProperty, [
  List<enums.UserBlockedCodeProperty>? defaultValue,
]) {
  if (userBlockedCodeProperty == null) {
    return defaultValue ?? [];
  }

  return userBlockedCodeProperty
      .map((e) => userBlockedCodePropertyFromJson(e.toString()))
      .toList();
}

List<enums.UserBlockedCodeProperty>?
userBlockedCodePropertyNullableListFromJson(
  List? userBlockedCodeProperty, [
  List<enums.UserBlockedCodeProperty>? defaultValue,
]) {
  if (userBlockedCodeProperty == null) {
    return defaultValue;
  }

  return userBlockedCodeProperty
      .map((e) => userBlockedCodePropertyFromJson(e.toString()))
      .toList();
}

String? userRolePropertyNullableToJson(
  enums.UserRoleProperty? userRoleProperty,
) {
  return userRoleProperty?.value;
}

String? userRolePropertyToJson(enums.UserRoleProperty userRoleProperty) {
  return userRoleProperty.value;
}

enums.UserRoleProperty userRolePropertyFromJson(
  Object? userRoleProperty, [
  enums.UserRoleProperty? defaultValue,
]) {
  return enums.UserRoleProperty.values.firstWhereOrNull(
        (e) => e.value == userRoleProperty,
      ) ??
      defaultValue ??
      enums.UserRoleProperty.swaggerGeneratedUnknown;
}

enums.UserRoleProperty? userRolePropertyNullableFromJson(
  Object? userRoleProperty, [
  enums.UserRoleProperty? defaultValue,
]) {
  if (userRoleProperty == null) {
    return null;
  }
  return enums.UserRoleProperty.values.firstWhereOrNull(
        (e) => e.value == userRoleProperty,
      ) ??
      defaultValue;
}

String userRolePropertyExplodedListToJson(
  List<enums.UserRoleProperty>? userRoleProperty,
) {
  return userRoleProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> userRolePropertyListToJson(
  List<enums.UserRoleProperty>? userRoleProperty,
) {
  if (userRoleProperty == null) {
    return [];
  }

  return userRoleProperty.map((e) => e.value!).toList();
}

List<enums.UserRoleProperty> userRolePropertyListFromJson(
  List? userRoleProperty, [
  List<enums.UserRoleProperty>? defaultValue,
]) {
  if (userRoleProperty == null) {
    return defaultValue ?? [];
  }

  return userRoleProperty
      .map((e) => userRolePropertyFromJson(e.toString()))
      .toList();
}

List<enums.UserRoleProperty>? userRolePropertyNullableListFromJson(
  List? userRoleProperty, [
  List<enums.UserRoleProperty>? defaultValue,
]) {
  if (userRoleProperty == null) {
    return defaultValue;
  }

  return userRoleProperty
      .map((e) => userRolePropertyFromJson(e.toString()))
      .toList();
}

String? accountTypeFilterNullableToJson(
  enums.AccountTypeFilter? accountTypeFilter,
) {
  return accountTypeFilter?.value;
}

String? accountTypeFilterToJson(enums.AccountTypeFilter accountTypeFilter) {
  return accountTypeFilter.value;
}

enums.AccountTypeFilter accountTypeFilterFromJson(
  Object? accountTypeFilter, [
  enums.AccountTypeFilter? defaultValue,
]) {
  return enums.AccountTypeFilter.values.firstWhereOrNull(
        (e) => e.value == accountTypeFilter,
      ) ??
      defaultValue ??
      enums.AccountTypeFilter.swaggerGeneratedUnknown;
}

enums.AccountTypeFilter? accountTypeFilterNullableFromJson(
  Object? accountTypeFilter, [
  enums.AccountTypeFilter? defaultValue,
]) {
  if (accountTypeFilter == null) {
    return null;
  }
  return enums.AccountTypeFilter.values.firstWhereOrNull(
        (e) => e.value == accountTypeFilter,
      ) ??
      defaultValue;
}

String accountTypeFilterExplodedListToJson(
  List<enums.AccountTypeFilter>? accountTypeFilter,
) {
  return accountTypeFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypeFilterListToJson(
  List<enums.AccountTypeFilter>? accountTypeFilter,
) {
  if (accountTypeFilter == null) {
    return [];
  }

  return accountTypeFilter.map((e) => e.value!).toList();
}

List<enums.AccountTypeFilter> accountTypeFilterListFromJson(
  List? accountTypeFilter, [
  List<enums.AccountTypeFilter>? defaultValue,
]) {
  if (accountTypeFilter == null) {
    return defaultValue ?? [];
  }

  return accountTypeFilter
      .map((e) => accountTypeFilterFromJson(e.toString()))
      .toList();
}

List<enums.AccountTypeFilter>? accountTypeFilterNullableListFromJson(
  List? accountTypeFilter, [
  List<enums.AccountTypeFilter>? defaultValue,
]) {
  if (accountTypeFilter == null) {
    return defaultValue;
  }

  return accountTypeFilter
      .map((e) => accountTypeFilterFromJson(e.toString()))
      .toList();
}

String? transactionTypeFilterNullableToJson(
  enums.TransactionTypeFilter? transactionTypeFilter,
) {
  return transactionTypeFilter?.value;
}

String? transactionTypeFilterToJson(
  enums.TransactionTypeFilter transactionTypeFilter,
) {
  return transactionTypeFilter.value;
}

enums.TransactionTypeFilter transactionTypeFilterFromJson(
  Object? transactionTypeFilter, [
  enums.TransactionTypeFilter? defaultValue,
]) {
  return enums.TransactionTypeFilter.values.firstWhereOrNull(
        (e) => e.value == transactionTypeFilter,
      ) ??
      defaultValue ??
      enums.TransactionTypeFilter.swaggerGeneratedUnknown;
}

enums.TransactionTypeFilter? transactionTypeFilterNullableFromJson(
  Object? transactionTypeFilter, [
  enums.TransactionTypeFilter? defaultValue,
]) {
  if (transactionTypeFilter == null) {
    return null;
  }
  return enums.TransactionTypeFilter.values.firstWhereOrNull(
        (e) => e.value == transactionTypeFilter,
      ) ??
      defaultValue;
}

String transactionTypeFilterExplodedListToJson(
  List<enums.TransactionTypeFilter>? transactionTypeFilter,
) {
  return transactionTypeFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypeFilterListToJson(
  List<enums.TransactionTypeFilter>? transactionTypeFilter,
) {
  if (transactionTypeFilter == null) {
    return [];
  }

  return transactionTypeFilter.map((e) => e.value!).toList();
}

List<enums.TransactionTypeFilter> transactionTypeFilterListFromJson(
  List? transactionTypeFilter, [
  List<enums.TransactionTypeFilter>? defaultValue,
]) {
  if (transactionTypeFilter == null) {
    return defaultValue ?? [];
  }

  return transactionTypeFilter
      .map((e) => transactionTypeFilterFromJson(e.toString()))
      .toList();
}

List<enums.TransactionTypeFilter>? transactionTypeFilterNullableListFromJson(
  List? transactionTypeFilter, [
  List<enums.TransactionTypeFilter>? defaultValue,
]) {
  if (transactionTypeFilter == null) {
    return defaultValue;
  }

  return transactionTypeFilter
      .map((e) => transactionTypeFilterFromJson(e.toString()))
      .toList();
}

String? accountRolePropertyNullableToJson(
  enums.AccountRoleProperty? accountRoleProperty,
) {
  return accountRoleProperty?.value;
}

String? accountRolePropertyToJson(
  enums.AccountRoleProperty accountRoleProperty,
) {
  return accountRoleProperty.value;
}

enums.AccountRoleProperty accountRolePropertyFromJson(
  Object? accountRoleProperty, [
  enums.AccountRoleProperty? defaultValue,
]) {
  return enums.AccountRoleProperty.values.firstWhereOrNull(
        (e) => e.value == accountRoleProperty,
      ) ??
      defaultValue ??
      enums.AccountRoleProperty.swaggerGeneratedUnknown;
}

enums.AccountRoleProperty? accountRolePropertyNullableFromJson(
  Object? accountRoleProperty, [
  enums.AccountRoleProperty? defaultValue,
]) {
  if (accountRoleProperty == null) {
    return null;
  }
  return enums.AccountRoleProperty.values.firstWhereOrNull(
        (e) => e.value == accountRoleProperty,
      ) ??
      defaultValue;
}

String accountRolePropertyExplodedListToJson(
  List<enums.AccountRoleProperty>? accountRoleProperty,
) {
  return accountRoleProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountRolePropertyListToJson(
  List<enums.AccountRoleProperty>? accountRoleProperty,
) {
  if (accountRoleProperty == null) {
    return [];
  }

  return accountRoleProperty.map((e) => e.value!).toList();
}

List<enums.AccountRoleProperty> accountRolePropertyListFromJson(
  List? accountRoleProperty, [
  List<enums.AccountRoleProperty>? defaultValue,
]) {
  if (accountRoleProperty == null) {
    return defaultValue ?? [];
  }

  return accountRoleProperty
      .map((e) => accountRolePropertyFromJson(e.toString()))
      .toList();
}

List<enums.AccountRoleProperty>? accountRolePropertyNullableListFromJson(
  List? accountRoleProperty, [
  List<enums.AccountRoleProperty>? defaultValue,
]) {
  if (accountRoleProperty == null) {
    return defaultValue;
  }

  return accountRoleProperty
      .map((e) => accountRolePropertyFromJson(e.toString()))
      .toList();
}

String? accountTypePropertyNullableToJson(
  enums.AccountTypeProperty? accountTypeProperty,
) {
  return accountTypeProperty?.value;
}

String? accountTypePropertyToJson(
  enums.AccountTypeProperty accountTypeProperty,
) {
  return accountTypeProperty.value;
}

enums.AccountTypeProperty accountTypePropertyFromJson(
  Object? accountTypeProperty, [
  enums.AccountTypeProperty? defaultValue,
]) {
  return enums.AccountTypeProperty.values.firstWhereOrNull(
        (e) => e.value == accountTypeProperty,
      ) ??
      defaultValue ??
      enums.AccountTypeProperty.swaggerGeneratedUnknown;
}

enums.AccountTypeProperty? accountTypePropertyNullableFromJson(
  Object? accountTypeProperty, [
  enums.AccountTypeProperty? defaultValue,
]) {
  if (accountTypeProperty == null) {
    return null;
  }
  return enums.AccountTypeProperty.values.firstWhereOrNull(
        (e) => e.value == accountTypeProperty,
      ) ??
      defaultValue;
}

String accountTypePropertyExplodedListToJson(
  List<enums.AccountTypeProperty>? accountTypeProperty,
) {
  return accountTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypePropertyListToJson(
  List<enums.AccountTypeProperty>? accountTypeProperty,
) {
  if (accountTypeProperty == null) {
    return [];
  }

  return accountTypeProperty.map((e) => e.value!).toList();
}

List<enums.AccountTypeProperty> accountTypePropertyListFromJson(
  List? accountTypeProperty, [
  List<enums.AccountTypeProperty>? defaultValue,
]) {
  if (accountTypeProperty == null) {
    return defaultValue ?? [];
  }

  return accountTypeProperty
      .map((e) => accountTypePropertyFromJson(e.toString()))
      .toList();
}

List<enums.AccountTypeProperty>? accountTypePropertyNullableListFromJson(
  List? accountTypeProperty, [
  List<enums.AccountTypeProperty>? defaultValue,
]) {
  if (accountTypeProperty == null) {
    return defaultValue;
  }

  return accountTypeProperty
      .map((e) => accountTypePropertyFromJson(e.toString()))
      .toList();
}

String? chartDatasetPeriodPropertyNullableToJson(
  enums.ChartDatasetPeriodProperty? chartDatasetPeriodProperty,
) {
  return chartDatasetPeriodProperty?.value;
}

String? chartDatasetPeriodPropertyToJson(
  enums.ChartDatasetPeriodProperty chartDatasetPeriodProperty,
) {
  return chartDatasetPeriodProperty.value;
}

enums.ChartDatasetPeriodProperty chartDatasetPeriodPropertyFromJson(
  Object? chartDatasetPeriodProperty, [
  enums.ChartDatasetPeriodProperty? defaultValue,
]) {
  return enums.ChartDatasetPeriodProperty.values.firstWhereOrNull(
        (e) => e.value == chartDatasetPeriodProperty,
      ) ??
      defaultValue ??
      enums.ChartDatasetPeriodProperty.swaggerGeneratedUnknown;
}

enums.ChartDatasetPeriodProperty? chartDatasetPeriodPropertyNullableFromJson(
  Object? chartDatasetPeriodProperty, [
  enums.ChartDatasetPeriodProperty? defaultValue,
]) {
  if (chartDatasetPeriodProperty == null) {
    return null;
  }
  return enums.ChartDatasetPeriodProperty.values.firstWhereOrNull(
        (e) => e.value == chartDatasetPeriodProperty,
      ) ??
      defaultValue;
}

String chartDatasetPeriodPropertyExplodedListToJson(
  List<enums.ChartDatasetPeriodProperty>? chartDatasetPeriodProperty,
) {
  return chartDatasetPeriodProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> chartDatasetPeriodPropertyListToJson(
  List<enums.ChartDatasetPeriodProperty>? chartDatasetPeriodProperty,
) {
  if (chartDatasetPeriodProperty == null) {
    return [];
  }

  return chartDatasetPeriodProperty.map((e) => e.value!).toList();
}

List<enums.ChartDatasetPeriodProperty> chartDatasetPeriodPropertyListFromJson(
  List? chartDatasetPeriodProperty, [
  List<enums.ChartDatasetPeriodProperty>? defaultValue,
]) {
  if (chartDatasetPeriodProperty == null) {
    return defaultValue ?? [];
  }

  return chartDatasetPeriodProperty
      .map((e) => chartDatasetPeriodPropertyFromJson(e.toString()))
      .toList();
}

List<enums.ChartDatasetPeriodProperty>?
chartDatasetPeriodPropertyNullableListFromJson(
  List? chartDatasetPeriodProperty, [
  List<enums.ChartDatasetPeriodProperty>? defaultValue,
]) {
  if (chartDatasetPeriodProperty == null) {
    return defaultValue;
  }

  return chartDatasetPeriodProperty
      .map((e) => chartDatasetPeriodPropertyFromJson(e.toString()))
      .toList();
}

String? creditCardTypePropertyNullableToJson(
  enums.CreditCardTypeProperty? creditCardTypeProperty,
) {
  return creditCardTypeProperty?.value;
}

String? creditCardTypePropertyToJson(
  enums.CreditCardTypeProperty creditCardTypeProperty,
) {
  return creditCardTypeProperty.value;
}

enums.CreditCardTypeProperty creditCardTypePropertyFromJson(
  Object? creditCardTypeProperty, [
  enums.CreditCardTypeProperty? defaultValue,
]) {
  return enums.CreditCardTypeProperty.values.firstWhereOrNull(
        (e) => e.value == creditCardTypeProperty,
      ) ??
      defaultValue ??
      enums.CreditCardTypeProperty.swaggerGeneratedUnknown;
}

enums.CreditCardTypeProperty? creditCardTypePropertyNullableFromJson(
  Object? creditCardTypeProperty, [
  enums.CreditCardTypeProperty? defaultValue,
]) {
  if (creditCardTypeProperty == null) {
    return null;
  }
  return enums.CreditCardTypeProperty.values.firstWhereOrNull(
        (e) => e.value == creditCardTypeProperty,
      ) ??
      defaultValue;
}

String creditCardTypePropertyExplodedListToJson(
  List<enums.CreditCardTypeProperty>? creditCardTypeProperty,
) {
  return creditCardTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> creditCardTypePropertyListToJson(
  List<enums.CreditCardTypeProperty>? creditCardTypeProperty,
) {
  if (creditCardTypeProperty == null) {
    return [];
  }

  return creditCardTypeProperty.map((e) => e.value!).toList();
}

List<enums.CreditCardTypeProperty> creditCardTypePropertyListFromJson(
  List? creditCardTypeProperty, [
  List<enums.CreditCardTypeProperty>? defaultValue,
]) {
  if (creditCardTypeProperty == null) {
    return defaultValue ?? [];
  }

  return creditCardTypeProperty
      .map((e) => creditCardTypePropertyFromJson(e.toString()))
      .toList();
}

List<enums.CreditCardTypeProperty>? creditCardTypePropertyNullableListFromJson(
  List? creditCardTypeProperty, [
  List<enums.CreditCardTypeProperty>? defaultValue,
]) {
  if (creditCardTypeProperty == null) {
    return defaultValue;
  }

  return creditCardTypeProperty
      .map((e) => creditCardTypePropertyFromJson(e.toString()))
      .toList();
}

String? interestPeriodPropertyNullableToJson(
  enums.InterestPeriodProperty? interestPeriodProperty,
) {
  return interestPeriodProperty?.value;
}

String? interestPeriodPropertyToJson(
  enums.InterestPeriodProperty interestPeriodProperty,
) {
  return interestPeriodProperty.value;
}

enums.InterestPeriodProperty interestPeriodPropertyFromJson(
  Object? interestPeriodProperty, [
  enums.InterestPeriodProperty? defaultValue,
]) {
  return enums.InterestPeriodProperty.values.firstWhereOrNull(
        (e) => e.value == interestPeriodProperty,
      ) ??
      defaultValue ??
      enums.InterestPeriodProperty.swaggerGeneratedUnknown;
}

enums.InterestPeriodProperty? interestPeriodPropertyNullableFromJson(
  Object? interestPeriodProperty, [
  enums.InterestPeriodProperty? defaultValue,
]) {
  if (interestPeriodProperty == null) {
    return null;
  }
  return enums.InterestPeriodProperty.values.firstWhereOrNull(
        (e) => e.value == interestPeriodProperty,
      ) ??
      defaultValue;
}

String interestPeriodPropertyExplodedListToJson(
  List<enums.InterestPeriodProperty>? interestPeriodProperty,
) {
  return interestPeriodProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> interestPeriodPropertyListToJson(
  List<enums.InterestPeriodProperty>? interestPeriodProperty,
) {
  if (interestPeriodProperty == null) {
    return [];
  }

  return interestPeriodProperty.map((e) => e.value!).toList();
}

List<enums.InterestPeriodProperty> interestPeriodPropertyListFromJson(
  List? interestPeriodProperty, [
  List<enums.InterestPeriodProperty>? defaultValue,
]) {
  if (interestPeriodProperty == null) {
    return defaultValue ?? [];
  }

  return interestPeriodProperty
      .map((e) => interestPeriodPropertyFromJson(e.toString()))
      .toList();
}

List<enums.InterestPeriodProperty>? interestPeriodPropertyNullableListFromJson(
  List? interestPeriodProperty, [
  List<enums.InterestPeriodProperty>? defaultValue,
]) {
  if (interestPeriodProperty == null) {
    return defaultValue;
  }

  return interestPeriodProperty
      .map((e) => interestPeriodPropertyFromJson(e.toString()))
      .toList();
}

String? liabilityDirectionPropertyNullableToJson(
  enums.LiabilityDirectionProperty? liabilityDirectionProperty,
) {
  return liabilityDirectionProperty?.value;
}

String? liabilityDirectionPropertyToJson(
  enums.LiabilityDirectionProperty liabilityDirectionProperty,
) {
  return liabilityDirectionProperty.value;
}

enums.LiabilityDirectionProperty liabilityDirectionPropertyFromJson(
  Object? liabilityDirectionProperty, [
  enums.LiabilityDirectionProperty? defaultValue,
]) {
  return enums.LiabilityDirectionProperty.values.firstWhereOrNull(
        (e) => e.value == liabilityDirectionProperty,
      ) ??
      defaultValue ??
      enums.LiabilityDirectionProperty.swaggerGeneratedUnknown;
}

enums.LiabilityDirectionProperty? liabilityDirectionPropertyNullableFromJson(
  Object? liabilityDirectionProperty, [
  enums.LiabilityDirectionProperty? defaultValue,
]) {
  if (liabilityDirectionProperty == null) {
    return null;
  }
  return enums.LiabilityDirectionProperty.values.firstWhereOrNull(
        (e) => e.value == liabilityDirectionProperty,
      ) ??
      defaultValue;
}

String liabilityDirectionPropertyExplodedListToJson(
  List<enums.LiabilityDirectionProperty>? liabilityDirectionProperty,
) {
  return liabilityDirectionProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> liabilityDirectionPropertyListToJson(
  List<enums.LiabilityDirectionProperty>? liabilityDirectionProperty,
) {
  if (liabilityDirectionProperty == null) {
    return [];
  }

  return liabilityDirectionProperty.map((e) => e.value!).toList();
}

List<enums.LiabilityDirectionProperty> liabilityDirectionPropertyListFromJson(
  List? liabilityDirectionProperty, [
  List<enums.LiabilityDirectionProperty>? defaultValue,
]) {
  if (liabilityDirectionProperty == null) {
    return defaultValue ?? [];
  }

  return liabilityDirectionProperty
      .map((e) => liabilityDirectionPropertyFromJson(e.toString()))
      .toList();
}

List<enums.LiabilityDirectionProperty>?
liabilityDirectionPropertyNullableListFromJson(
  List? liabilityDirectionProperty, [
  List<enums.LiabilityDirectionProperty>? defaultValue,
]) {
  if (liabilityDirectionProperty == null) {
    return defaultValue;
  }

  return liabilityDirectionProperty
      .map((e) => liabilityDirectionPropertyFromJson(e.toString()))
      .toList();
}

String? liabilityTypePropertyNullableToJson(
  enums.LiabilityTypeProperty? liabilityTypeProperty,
) {
  return liabilityTypeProperty?.value;
}

String? liabilityTypePropertyToJson(
  enums.LiabilityTypeProperty liabilityTypeProperty,
) {
  return liabilityTypeProperty.value;
}

enums.LiabilityTypeProperty liabilityTypePropertyFromJson(
  Object? liabilityTypeProperty, [
  enums.LiabilityTypeProperty? defaultValue,
]) {
  return enums.LiabilityTypeProperty.values.firstWhereOrNull(
        (e) => e.value == liabilityTypeProperty,
      ) ??
      defaultValue ??
      enums.LiabilityTypeProperty.swaggerGeneratedUnknown;
}

enums.LiabilityTypeProperty? liabilityTypePropertyNullableFromJson(
  Object? liabilityTypeProperty, [
  enums.LiabilityTypeProperty? defaultValue,
]) {
  if (liabilityTypeProperty == null) {
    return null;
  }
  return enums.LiabilityTypeProperty.values.firstWhereOrNull(
        (e) => e.value == liabilityTypeProperty,
      ) ??
      defaultValue;
}

String liabilityTypePropertyExplodedListToJson(
  List<enums.LiabilityTypeProperty>? liabilityTypeProperty,
) {
  return liabilityTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> liabilityTypePropertyListToJson(
  List<enums.LiabilityTypeProperty>? liabilityTypeProperty,
) {
  if (liabilityTypeProperty == null) {
    return [];
  }

  return liabilityTypeProperty.map((e) => e.value!).toList();
}

List<enums.LiabilityTypeProperty> liabilityTypePropertyListFromJson(
  List? liabilityTypeProperty, [
  List<enums.LiabilityTypeProperty>? defaultValue,
]) {
  if (liabilityTypeProperty == null) {
    return defaultValue ?? [];
  }

  return liabilityTypeProperty
      .map((e) => liabilityTypePropertyFromJson(e.toString()))
      .toList();
}

List<enums.LiabilityTypeProperty>? liabilityTypePropertyNullableListFromJson(
  List? liabilityTypeProperty, [
  List<enums.LiabilityTypeProperty>? defaultValue,
]) {
  if (liabilityTypeProperty == null) {
    return defaultValue;
  }

  return liabilityTypeProperty
      .map((e) => liabilityTypePropertyFromJson(e.toString()))
      .toList();
}

String? shortAccountTypePropertyNullableToJson(
  enums.ShortAccountTypeProperty? shortAccountTypeProperty,
) {
  return shortAccountTypeProperty?.value;
}

String? shortAccountTypePropertyToJson(
  enums.ShortAccountTypeProperty shortAccountTypeProperty,
) {
  return shortAccountTypeProperty.value;
}

enums.ShortAccountTypeProperty shortAccountTypePropertyFromJson(
  Object? shortAccountTypeProperty, [
  enums.ShortAccountTypeProperty? defaultValue,
]) {
  return enums.ShortAccountTypeProperty.values.firstWhereOrNull(
        (e) => e.value == shortAccountTypeProperty,
      ) ??
      defaultValue ??
      enums.ShortAccountTypeProperty.swaggerGeneratedUnknown;
}

enums.ShortAccountTypeProperty? shortAccountTypePropertyNullableFromJson(
  Object? shortAccountTypeProperty, [
  enums.ShortAccountTypeProperty? defaultValue,
]) {
  if (shortAccountTypeProperty == null) {
    return null;
  }
  return enums.ShortAccountTypeProperty.values.firstWhereOrNull(
        (e) => e.value == shortAccountTypeProperty,
      ) ??
      defaultValue;
}

String shortAccountTypePropertyExplodedListToJson(
  List<enums.ShortAccountTypeProperty>? shortAccountTypeProperty,
) {
  return shortAccountTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> shortAccountTypePropertyListToJson(
  List<enums.ShortAccountTypeProperty>? shortAccountTypeProperty,
) {
  if (shortAccountTypeProperty == null) {
    return [];
  }

  return shortAccountTypeProperty.map((e) => e.value!).toList();
}

List<enums.ShortAccountTypeProperty> shortAccountTypePropertyListFromJson(
  List? shortAccountTypeProperty, [
  List<enums.ShortAccountTypeProperty>? defaultValue,
]) {
  if (shortAccountTypeProperty == null) {
    return defaultValue ?? [];
  }

  return shortAccountTypeProperty
      .map((e) => shortAccountTypePropertyFromJson(e.toString()))
      .toList();
}

List<enums.ShortAccountTypeProperty>?
shortAccountTypePropertyNullableListFromJson(
  List? shortAccountTypeProperty, [
  List<enums.ShortAccountTypeProperty>? defaultValue,
]) {
  if (shortAccountTypeProperty == null) {
    return defaultValue;
  }

  return shortAccountTypeProperty
      .map((e) => shortAccountTypePropertyFromJson(e.toString()))
      .toList();
}

String? transactionTypePropertyNullableToJson(
  enums.TransactionTypeProperty? transactionTypeProperty,
) {
  return transactionTypeProperty?.value;
}

String? transactionTypePropertyToJson(
  enums.TransactionTypeProperty transactionTypeProperty,
) {
  return transactionTypeProperty.value;
}

enums.TransactionTypeProperty transactionTypePropertyFromJson(
  Object? transactionTypeProperty, [
  enums.TransactionTypeProperty? defaultValue,
]) {
  return enums.TransactionTypeProperty.values.firstWhereOrNull(
        (e) => e.value == transactionTypeProperty,
      ) ??
      defaultValue ??
      enums.TransactionTypeProperty.swaggerGeneratedUnknown;
}

enums.TransactionTypeProperty? transactionTypePropertyNullableFromJson(
  Object? transactionTypeProperty, [
  enums.TransactionTypeProperty? defaultValue,
]) {
  if (transactionTypeProperty == null) {
    return null;
  }
  return enums.TransactionTypeProperty.values.firstWhereOrNull(
        (e) => e.value == transactionTypeProperty,
      ) ??
      defaultValue;
}

String transactionTypePropertyExplodedListToJson(
  List<enums.TransactionTypeProperty>? transactionTypeProperty,
) {
  return transactionTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypePropertyListToJson(
  List<enums.TransactionTypeProperty>? transactionTypeProperty,
) {
  if (transactionTypeProperty == null) {
    return [];
  }

  return transactionTypeProperty.map((e) => e.value!).toList();
}

List<enums.TransactionTypeProperty> transactionTypePropertyListFromJson(
  List? transactionTypeProperty, [
  List<enums.TransactionTypeProperty>? defaultValue,
]) {
  if (transactionTypeProperty == null) {
    return defaultValue ?? [];
  }

  return transactionTypeProperty
      .map((e) => transactionTypePropertyFromJson(e.toString()))
      .toList();
}

List<enums.TransactionTypeProperty>?
transactionTypePropertyNullableListFromJson(
  List? transactionTypeProperty, [
  List<enums.TransactionTypeProperty>? defaultValue,
]) {
  if (transactionTypeProperty == null) {
    return defaultValue;
  }

  return transactionTypeProperty
      .map((e) => transactionTypePropertyFromJson(e.toString()))
      .toList();
}

String? v1ChartAccountOverviewGetPeriodNullableToJson(
  enums.V1ChartAccountOverviewGetPeriod? v1ChartAccountOverviewGetPeriod,
) {
  return v1ChartAccountOverviewGetPeriod?.value;
}

String? v1ChartAccountOverviewGetPeriodToJson(
  enums.V1ChartAccountOverviewGetPeriod v1ChartAccountOverviewGetPeriod,
) {
  return v1ChartAccountOverviewGetPeriod.value;
}

enums.V1ChartAccountOverviewGetPeriod v1ChartAccountOverviewGetPeriodFromJson(
  Object? v1ChartAccountOverviewGetPeriod, [
  enums.V1ChartAccountOverviewGetPeriod? defaultValue,
]) {
  return enums.V1ChartAccountOverviewGetPeriod.values.firstWhereOrNull(
        (e) => e.value == v1ChartAccountOverviewGetPeriod,
      ) ??
      defaultValue ??
      enums.V1ChartAccountOverviewGetPeriod.swaggerGeneratedUnknown;
}

enums.V1ChartAccountOverviewGetPeriod?
v1ChartAccountOverviewGetPeriodNullableFromJson(
  Object? v1ChartAccountOverviewGetPeriod, [
  enums.V1ChartAccountOverviewGetPeriod? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPeriod == null) {
    return null;
  }
  return enums.V1ChartAccountOverviewGetPeriod.values.firstWhereOrNull(
        (e) => e.value == v1ChartAccountOverviewGetPeriod,
      ) ??
      defaultValue;
}

String v1ChartAccountOverviewGetPeriodExplodedListToJson(
  List<enums.V1ChartAccountOverviewGetPeriod>? v1ChartAccountOverviewGetPeriod,
) {
  return v1ChartAccountOverviewGetPeriod?.map((e) => e.value!).join(',') ?? '';
}

List<String> v1ChartAccountOverviewGetPeriodListToJson(
  List<enums.V1ChartAccountOverviewGetPeriod>? v1ChartAccountOverviewGetPeriod,
) {
  if (v1ChartAccountOverviewGetPeriod == null) {
    return [];
  }

  return v1ChartAccountOverviewGetPeriod.map((e) => e.value!).toList();
}

List<enums.V1ChartAccountOverviewGetPeriod>
v1ChartAccountOverviewGetPeriodListFromJson(
  List? v1ChartAccountOverviewGetPeriod, [
  List<enums.V1ChartAccountOverviewGetPeriod>? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPeriod == null) {
    return defaultValue ?? [];
  }

  return v1ChartAccountOverviewGetPeriod
      .map((e) => v1ChartAccountOverviewGetPeriodFromJson(e.toString()))
      .toList();
}

List<enums.V1ChartAccountOverviewGetPeriod>?
v1ChartAccountOverviewGetPeriodNullableListFromJson(
  List? v1ChartAccountOverviewGetPeriod, [
  List<enums.V1ChartAccountOverviewGetPeriod>? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPeriod == null) {
    return defaultValue;
  }

  return v1ChartAccountOverviewGetPeriod
      .map((e) => v1ChartAccountOverviewGetPeriodFromJson(e.toString()))
      .toList();
}

String? v1ChartAccountOverviewGetPreselectedNullableToJson(
  enums.V1ChartAccountOverviewGetPreselected?
  v1ChartAccountOverviewGetPreselected,
) {
  return v1ChartAccountOverviewGetPreselected?.value;
}

String? v1ChartAccountOverviewGetPreselectedToJson(
  enums.V1ChartAccountOverviewGetPreselected
  v1ChartAccountOverviewGetPreselected,
) {
  return v1ChartAccountOverviewGetPreselected.value;
}

enums.V1ChartAccountOverviewGetPreselected
v1ChartAccountOverviewGetPreselectedFromJson(
  Object? v1ChartAccountOverviewGetPreselected, [
  enums.V1ChartAccountOverviewGetPreselected? defaultValue,
]) {
  return enums.V1ChartAccountOverviewGetPreselected.values.firstWhereOrNull(
        (e) => e.value == v1ChartAccountOverviewGetPreselected,
      ) ??
      defaultValue ??
      enums.V1ChartAccountOverviewGetPreselected.swaggerGeneratedUnknown;
}

enums.V1ChartAccountOverviewGetPreselected?
v1ChartAccountOverviewGetPreselectedNullableFromJson(
  Object? v1ChartAccountOverviewGetPreselected, [
  enums.V1ChartAccountOverviewGetPreselected? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPreselected == null) {
    return null;
  }
  return enums.V1ChartAccountOverviewGetPreselected.values.firstWhereOrNull(
        (e) => e.value == v1ChartAccountOverviewGetPreselected,
      ) ??
      defaultValue;
}

String v1ChartAccountOverviewGetPreselectedExplodedListToJson(
  List<enums.V1ChartAccountOverviewGetPreselected>?
  v1ChartAccountOverviewGetPreselected,
) {
  return v1ChartAccountOverviewGetPreselected?.map((e) => e.value!).join(',') ??
      '';
}

List<String> v1ChartAccountOverviewGetPreselectedListToJson(
  List<enums.V1ChartAccountOverviewGetPreselected>?
  v1ChartAccountOverviewGetPreselected,
) {
  if (v1ChartAccountOverviewGetPreselected == null) {
    return [];
  }

  return v1ChartAccountOverviewGetPreselected.map((e) => e.value!).toList();
}

List<enums.V1ChartAccountOverviewGetPreselected>
v1ChartAccountOverviewGetPreselectedListFromJson(
  List? v1ChartAccountOverviewGetPreselected, [
  List<enums.V1ChartAccountOverviewGetPreselected>? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPreselected == null) {
    return defaultValue ?? [];
  }

  return v1ChartAccountOverviewGetPreselected
      .map((e) => v1ChartAccountOverviewGetPreselectedFromJson(e.toString()))
      .toList();
}

List<enums.V1ChartAccountOverviewGetPreselected>?
v1ChartAccountOverviewGetPreselectedNullableListFromJson(
  List? v1ChartAccountOverviewGetPreselected, [
  List<enums.V1ChartAccountOverviewGetPreselected>? defaultValue,
]) {
  if (v1ChartAccountOverviewGetPreselected == null) {
    return defaultValue;
  }

  return v1ChartAccountOverviewGetPreselected
      .map((e) => v1ChartAccountOverviewGetPreselectedFromJson(e.toString()))
      .toList();
}

String? v1ChartBalanceBalanceGetPeriodNullableToJson(
  enums.V1ChartBalanceBalanceGetPeriod? v1ChartBalanceBalanceGetPeriod,
) {
  return v1ChartBalanceBalanceGetPeriod?.value;
}

String? v1ChartBalanceBalanceGetPeriodToJson(
  enums.V1ChartBalanceBalanceGetPeriod v1ChartBalanceBalanceGetPeriod,
) {
  return v1ChartBalanceBalanceGetPeriod.value;
}

enums.V1ChartBalanceBalanceGetPeriod v1ChartBalanceBalanceGetPeriodFromJson(
  Object? v1ChartBalanceBalanceGetPeriod, [
  enums.V1ChartBalanceBalanceGetPeriod? defaultValue,
]) {
  return enums.V1ChartBalanceBalanceGetPeriod.values.firstWhereOrNull(
        (e) => e.value == v1ChartBalanceBalanceGetPeriod,
      ) ??
      defaultValue ??
      enums.V1ChartBalanceBalanceGetPeriod.swaggerGeneratedUnknown;
}

enums.V1ChartBalanceBalanceGetPeriod?
v1ChartBalanceBalanceGetPeriodNullableFromJson(
  Object? v1ChartBalanceBalanceGetPeriod, [
  enums.V1ChartBalanceBalanceGetPeriod? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPeriod == null) {
    return null;
  }
  return enums.V1ChartBalanceBalanceGetPeriod.values.firstWhereOrNull(
        (e) => e.value == v1ChartBalanceBalanceGetPeriod,
      ) ??
      defaultValue;
}

String v1ChartBalanceBalanceGetPeriodExplodedListToJson(
  List<enums.V1ChartBalanceBalanceGetPeriod>? v1ChartBalanceBalanceGetPeriod,
) {
  return v1ChartBalanceBalanceGetPeriod?.map((e) => e.value!).join(',') ?? '';
}

List<String> v1ChartBalanceBalanceGetPeriodListToJson(
  List<enums.V1ChartBalanceBalanceGetPeriod>? v1ChartBalanceBalanceGetPeriod,
) {
  if (v1ChartBalanceBalanceGetPeriod == null) {
    return [];
  }

  return v1ChartBalanceBalanceGetPeriod.map((e) => e.value!).toList();
}

List<enums.V1ChartBalanceBalanceGetPeriod>
v1ChartBalanceBalanceGetPeriodListFromJson(
  List? v1ChartBalanceBalanceGetPeriod, [
  List<enums.V1ChartBalanceBalanceGetPeriod>? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPeriod == null) {
    return defaultValue ?? [];
  }

  return v1ChartBalanceBalanceGetPeriod
      .map((e) => v1ChartBalanceBalanceGetPeriodFromJson(e.toString()))
      .toList();
}

List<enums.V1ChartBalanceBalanceGetPeriod>?
v1ChartBalanceBalanceGetPeriodNullableListFromJson(
  List? v1ChartBalanceBalanceGetPeriod, [
  List<enums.V1ChartBalanceBalanceGetPeriod>? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPeriod == null) {
    return defaultValue;
  }

  return v1ChartBalanceBalanceGetPeriod
      .map((e) => v1ChartBalanceBalanceGetPeriodFromJson(e.toString()))
      .toList();
}

String? v1ChartBalanceBalanceGetPreselectedNullableToJson(
  enums.V1ChartBalanceBalanceGetPreselected?
  v1ChartBalanceBalanceGetPreselected,
) {
  return v1ChartBalanceBalanceGetPreselected?.value;
}

String? v1ChartBalanceBalanceGetPreselectedToJson(
  enums.V1ChartBalanceBalanceGetPreselected v1ChartBalanceBalanceGetPreselected,
) {
  return v1ChartBalanceBalanceGetPreselected.value;
}

enums.V1ChartBalanceBalanceGetPreselected
v1ChartBalanceBalanceGetPreselectedFromJson(
  Object? v1ChartBalanceBalanceGetPreselected, [
  enums.V1ChartBalanceBalanceGetPreselected? defaultValue,
]) {
  return enums.V1ChartBalanceBalanceGetPreselected.values.firstWhereOrNull(
        (e) => e.value == v1ChartBalanceBalanceGetPreselected,
      ) ??
      defaultValue ??
      enums.V1ChartBalanceBalanceGetPreselected.swaggerGeneratedUnknown;
}

enums.V1ChartBalanceBalanceGetPreselected?
v1ChartBalanceBalanceGetPreselectedNullableFromJson(
  Object? v1ChartBalanceBalanceGetPreselected, [
  enums.V1ChartBalanceBalanceGetPreselected? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPreselected == null) {
    return null;
  }
  return enums.V1ChartBalanceBalanceGetPreselected.values.firstWhereOrNull(
        (e) => e.value == v1ChartBalanceBalanceGetPreselected,
      ) ??
      defaultValue;
}

String v1ChartBalanceBalanceGetPreselectedExplodedListToJson(
  List<enums.V1ChartBalanceBalanceGetPreselected>?
  v1ChartBalanceBalanceGetPreselected,
) {
  return v1ChartBalanceBalanceGetPreselected?.map((e) => e.value!).join(',') ??
      '';
}

List<String> v1ChartBalanceBalanceGetPreselectedListToJson(
  List<enums.V1ChartBalanceBalanceGetPreselected>?
  v1ChartBalanceBalanceGetPreselected,
) {
  if (v1ChartBalanceBalanceGetPreselected == null) {
    return [];
  }

  return v1ChartBalanceBalanceGetPreselected.map((e) => e.value!).toList();
}

List<enums.V1ChartBalanceBalanceGetPreselected>
v1ChartBalanceBalanceGetPreselectedListFromJson(
  List? v1ChartBalanceBalanceGetPreselected, [
  List<enums.V1ChartBalanceBalanceGetPreselected>? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPreselected == null) {
    return defaultValue ?? [];
  }

  return v1ChartBalanceBalanceGetPreselected
      .map((e) => v1ChartBalanceBalanceGetPreselectedFromJson(e.toString()))
      .toList();
}

List<enums.V1ChartBalanceBalanceGetPreselected>?
v1ChartBalanceBalanceGetPreselectedNullableListFromJson(
  List? v1ChartBalanceBalanceGetPreselected, [
  List<enums.V1ChartBalanceBalanceGetPreselected>? defaultValue,
]) {
  if (v1ChartBalanceBalanceGetPreselected == null) {
    return defaultValue;
  }

  return v1ChartBalanceBalanceGetPreselected
      .map((e) => v1ChartBalanceBalanceGetPreselectedFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
