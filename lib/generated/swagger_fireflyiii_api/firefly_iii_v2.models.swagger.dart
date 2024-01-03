// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'firefly_iii_v2.enums.swagger.dart' as enums;

part 'firefly_iii_v2.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionSum {
  const TransactionSum({
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.currencyCode,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyName,
    this.nativeCurrencySymbol,
    this.nativeCurrencyCode,
    this.nativeCurrencyDecimalPlaces,
    this.sum,
    this.nativeSum,
  });

  factory TransactionSum.fromJson(Map<String, dynamic> json) =>
      _$TransactionSumFromJson(json);

  static const toJsonFactory = _$TransactionSumToJson;
  Map<String, dynamic> toJson() => _$TransactionSumToJson(this);

  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_name', includeIfNull: false)
  final String? nativeCurrencyName;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'sum', includeIfNull: false)
  final String? sum;
  @JsonKey(name: 'native_sum', includeIfNull: false)
  final String? nativeSum;
  static const fromJsonFactory = _$TransactionSumFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSumExtension on TransactionSum {
  TransactionSum copyWith(
      {String? currencyId,
      String? currencyName,
      String? currencySymbol,
      String? currencyCode,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyName,
      String? nativeCurrencySymbol,
      String? nativeCurrencyCode,
      int? nativeCurrencyDecimalPlaces,
      String? sum,
      String? nativeSum}) {
    return TransactionSum(
        currencyId: currencyId ?? this.currencyId,
        currencyName: currencyName ?? this.currencyName,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyCode: currencyCode ?? this.currencyCode,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyName: nativeCurrencyName ?? this.nativeCurrencyName,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
        sum: sum ?? this.sum,
        nativeSum: nativeSum ?? this.nativeSum);
  }

  TransactionSum copyWithWrapped(
      {Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyName,
      Wrapped<String?>? currencySymbol,
      Wrapped<String?>? currencyCode,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyName,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<String?>? sum,
      Wrapped<String?>? nativeSum}) {
    return TransactionSum(
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyName:
            (currencyName != null ? currencyName.value : this.currencyName),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyName: (nativeCurrencyName != null
            ? nativeCurrencyName.value
            : this.nativeCurrencyName),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
        sum: (sum != null ? sum.value : this.sum),
        nativeSum: (nativeSum != null ? nativeSum.value : this.nativeSum));
  }
}

typedef TransactionSumArray = List<TransactionSum>;
typedef AutocompleteAccountV2Array = List<AutocompleteAccountV2>;

@JsonSerializable(explicitToJson: true)
class AutocompleteAccountV2 {
  const AutocompleteAccountV2({
    required this.id,
    required this.name,
    required this.nameWithBalance,
    required this.type,
    required this.currencyId,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
  });

  factory AutocompleteAccountV2.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteAccountV2FromJson(json);

  static const toJsonFactory = _$AutocompleteAccountV2ToJson;
  Map<String, dynamic> toJson() => _$AutocompleteAccountV2ToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'name_with_balance', includeIfNull: false)
  final String nameWithBalance;
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
  static const fromJsonFactory = _$AutocompleteAccountV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteAccountV2Extension on AutocompleteAccountV2 {
  AutocompleteAccountV2 copyWith(
      {String? id,
      String? name,
      String? nameWithBalance,
      String? type,
      String? currencyId,
      String? currencyName,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces}) {
    return AutocompleteAccountV2(
        id: id ?? this.id,
        name: name ?? this.name,
        nameWithBalance: nameWithBalance ?? this.nameWithBalance,
        type: type ?? this.type,
        currencyId: currencyId ?? this.currencyId,
        currencyName: currencyName ?? this.currencyName,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces);
  }

  AutocompleteAccountV2 copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<String>? nameWithBalance,
      Wrapped<String>? type,
      Wrapped<String>? currencyId,
      Wrapped<String>? currencyName,
      Wrapped<String>? currencyCode,
      Wrapped<String>? currencySymbol,
      Wrapped<int>? currencyDecimalPlaces}) {
    return AutocompleteAccountV2(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        nameWithBalance: (nameWithBalance != null
            ? nameWithBalance.value
            : this.nameWithBalance),
        type: (type != null ? type.value : this.type),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyName:
            (currencyName != null ? currencyName.value : this.currencyName),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces));
  }
}

@JsonSerializable(explicitToJson: true)
class AutocompleteTD {
  const AutocompleteTD({
    required this.id,
    this.transactionJournalId,
    required this.name,
    required this.description,
  });

  factory AutocompleteTD.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteTDFromJson(json);

  static const toJsonFactory = _$AutocompleteTDToJson;
  Map<String, dynamic> toJson() => _$AutocompleteTDToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  static const fromJsonFactory = _$AutocompleteTDFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AutocompleteTDExtension on AutocompleteTD {
  AutocompleteTD copyWith(
      {String? id,
      String? transactionJournalId,
      String? name,
      String? description}) {
    return AutocompleteTD(
        id: id ?? this.id,
        transactionJournalId: transactionJournalId ?? this.transactionJournalId,
        name: name ?? this.name,
        description: description ?? this.description);
  }

  AutocompleteTD copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String?>? transactionJournalId,
      Wrapped<String>? name,
      Wrapped<String>? description}) {
    return AutocompleteTD(
        id: (id != null ? id.value : this.id),
        transactionJournalId: (transactionJournalId != null
            ? transactionJournalId.value
            : this.transactionJournalId),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description));
  }
}

typedef AutocompleteTDArray = List<AutocompleteTD>;

@JsonSerializable(explicitToJson: true)
class ObjectLinkV2 {
  const ObjectLinkV2();

  factory ObjectLinkV2.fromJson(Map<String, dynamic> json) =>
      _$ObjectLinkV2FromJson(json);

  static const toJsonFactory = _$ObjectLinkV2ToJson;
  Map<String, dynamic> toJson() => _$ObjectLinkV2ToJson(this);

  static const fromJsonFactory = _$ObjectLinkV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(explicitToJson: true)
class PageLinkV2 {
  const PageLinkV2({
    this.self,
    this.first,
    this.next,
    this.prev,
    this.last,
  });

  factory PageLinkV2.fromJson(Map<String, dynamic> json) =>
      _$PageLinkV2FromJson(json);

  static const toJsonFactory = _$PageLinkV2ToJson;
  Map<String, dynamic> toJson() => _$PageLinkV2ToJson(this);

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
  static const fromJsonFactory = _$PageLinkV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PageLinkV2Extension on PageLinkV2 {
  PageLinkV2 copyWith(
      {String? self, String? first, String? next, String? prev, String? last}) {
    return PageLinkV2(
        self: self ?? this.self,
        first: first ?? this.first,
        next: next ?? this.next,
        prev: prev ?? this.prev,
        last: last ?? this.last);
  }

  PageLinkV2 copyWithWrapped(
      {Wrapped<String?>? self,
      Wrapped<String?>? first,
      Wrapped<String?>? next,
      Wrapped<String?>? prev,
      Wrapped<String?>? last}) {
    return PageLinkV2(
        self: (self != null ? self.value : this.self),
        first: (first != null ? first.value : this.first),
        next: (next != null ? next.value : this.next),
        prev: (prev != null ? prev.value : this.prev),
        last: (last != null ? last.value : this.last));
  }
}

@JsonSerializable(explicitToJson: true)
class AccountV2 {
  const AccountV2({
    this.createdAt,
    this.updatedAt,
    this.active,
    this.order,
    required this.name,
    this.iban,
    required this.type,
    this.accountRole,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyDecimalPlaces,
    this.currentBalance,
    this.nativeCurrentBalance,
    this.currentBalanceDate,
  });

  factory AccountV2.fromJson(Map<String, dynamic> json) =>
      _$AccountV2FromJson(json);

  static const toJsonFactory = _$AccountV2ToJson;
  Map<String, dynamic> toJson() => _$AccountV2ToJson(this);

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
  @JsonKey(name: 'iban', includeIfNull: false)
  final String? iban;
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
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'current_balance', includeIfNull: false)
  final String? currentBalance;
  @JsonKey(name: 'native_current_balance', includeIfNull: false)
  final String? nativeCurrentBalance;
  @JsonKey(name: 'current_balance_date', includeIfNull: false)
  final DateTime? currentBalanceDate;
  static const fromJsonFactory = _$AccountV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountV2Extension on AccountV2 {
  AccountV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      bool? active,
      int? order,
      String? name,
      String? iban,
      enums.ShortAccountTypeProperty? type,
      enums.AccountRoleProperty? accountRole,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyCode,
      String? nativeCurrencySymbol,
      int? nativeCurrencyDecimalPlaces,
      String? currentBalance,
      String? nativeCurrentBalance,
      DateTime? currentBalanceDate}) {
    return AccountV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        active: active ?? this.active,
        order: order ?? this.order,
        name: name ?? this.name,
        iban: iban ?? this.iban,
        type: type ?? this.type,
        accountRole: accountRole ?? this.accountRole,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
        currentBalance: currentBalance ?? this.currentBalance,
        nativeCurrentBalance: nativeCurrentBalance ?? this.nativeCurrentBalance,
        currentBalanceDate: currentBalanceDate ?? this.currentBalanceDate);
  }

  AccountV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? active,
      Wrapped<int?>? order,
      Wrapped<String>? name,
      Wrapped<String?>? iban,
      Wrapped<enums.ShortAccountTypeProperty>? type,
      Wrapped<enums.AccountRoleProperty?>? accountRole,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<String?>? currentBalance,
      Wrapped<String?>? nativeCurrentBalance,
      Wrapped<DateTime?>? currentBalanceDate}) {
    return AccountV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        active: (active != null ? active.value : this.active),
        order: (order != null ? order.value : this.order),
        name: (name != null ? name.value : this.name),
        iban: (iban != null ? iban.value : this.iban),
        type: (type != null ? type.value : this.type),
        accountRole:
            (accountRole != null ? accountRole.value : this.accountRole),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
        currentBalance: (currentBalance != null
            ? currentBalance.value
            : this.currentBalance),
        nativeCurrentBalance: (nativeCurrentBalance != null
            ? nativeCurrentBalance.value
            : this.nativeCurrentBalance),
        currentBalanceDate: (currentBalanceDate != null
            ? currentBalanceDate.value
            : this.currentBalanceDate));
  }
}

@JsonSerializable(explicitToJson: true)
class AccountV2Read {
  const AccountV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory AccountV2Read.fromJson(Map<String, dynamic> json) =>
      _$AccountV2ReadFromJson(json);

  static const toJsonFactory = _$AccountV2ReadToJson;
  Map<String, dynamic> toJson() => _$AccountV2ReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final AccountV2 attributes;
  static const fromJsonFactory = _$AccountV2ReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountV2ReadExtension on AccountV2Read {
  AccountV2Read copyWith({String? type, String? id, AccountV2? attributes}) {
    return AccountV2Read(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes);
  }

  AccountV2Read copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<AccountV2>? attributes}) {
    return AccountV2Read(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class AccountV2Single {
  const AccountV2Single({
    required this.data,
  });

  factory AccountV2Single.fromJson(Map<String, dynamic> json) =>
      _$AccountV2SingleFromJson(json);

  static const toJsonFactory = _$AccountV2SingleToJson;
  Map<String, dynamic> toJson() => _$AccountV2SingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final AccountV2Read data;
  static const fromJsonFactory = _$AccountV2SingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $AccountV2SingleExtension on AccountV2Single {
  AccountV2Single copyWith({AccountV2Read? data}) {
    return AccountV2Single(data: data ?? this.data);
  }

  AccountV2Single copyWithWrapped({Wrapped<AccountV2Read>? data}) {
    return AccountV2Single(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitV2 {
  const BudgetLimitV2({
    this.createdAt,
    this.updatedAt,
    required this.start,
    required this.end,
    this.currencyId,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    required this.budgetId,
    this.period,
    required this.amount,
  });

  factory BudgetLimitV2.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitV2FromJson(json);

  static const toJsonFactory = _$BudgetLimitV2ToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime end;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'budget_id', includeIfNull: false)
  final String budgetId;
  @JsonKey(name: 'period', includeIfNull: false)
  final String? period;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  static const fromJsonFactory = _$BudgetLimitV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitV2Extension on BudgetLimitV2 {
  BudgetLimitV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? start,
      DateTime? end,
      String? currencyId,
      String? currencyCode,
      String? currencyName,
      String? currencySymbol,
      int? currencyDecimalPlaces,
      String? budgetId,
      String? period,
      String? amount}) {
    return BudgetLimitV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        start: start ?? this.start,
        end: end ?? this.end,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencyName: currencyName ?? this.currencyName,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        budgetId: budgetId ?? this.budgetId,
        period: period ?? this.period,
        amount: amount ?? this.amount);
  }

  BudgetLimitV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencyName,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String>? budgetId,
      Wrapped<String?>? period,
      Wrapped<String>? amount}) {
    return BudgetLimitV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencyName:
            (currencyName != null ? currencyName.value : this.currencyName),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        budgetId: (budgetId != null ? budgetId.value : this.budgetId),
        period: (period != null ? period.value : this.period),
        amount: (amount != null ? amount.value : this.amount));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitV2Array {
  const BudgetLimitV2Array({
    required this.data,
    required this.meta,
  });

  factory BudgetLimitV2Array.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitV2ArrayFromJson(json);

  static const toJsonFactory = _$BudgetLimitV2ArrayToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitV2ArrayToJson(this);

  @JsonKey(
      name: 'data', includeIfNull: false, defaultValue: <BudgetLimitReadV2>[])
  final List<BudgetLimitReadV2> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$BudgetLimitV2ArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitV2ArrayExtension on BudgetLimitV2Array {
  BudgetLimitV2Array copyWith({List<BudgetLimitReadV2>? data, Meta? meta}) {
    return BudgetLimitV2Array(data: data ?? this.data, meta: meta ?? this.meta);
  }

  BudgetLimitV2Array copyWithWrapped(
      {Wrapped<List<BudgetLimitReadV2>>? data, Wrapped<Meta>? meta}) {
    return BudgetLimitV2Array(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetLimitReadV2 {
  const BudgetLimitReadV2({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BudgetLimitReadV2.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitReadV2FromJson(json);

  static const toJsonFactory = _$BudgetLimitReadV2ToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitReadV2ToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final BudgetLimitV2 attributes;
  static const fromJsonFactory = _$BudgetLimitReadV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetLimitReadV2Extension on BudgetLimitReadV2 {
  BudgetLimitReadV2 copyWith(
      {String? type, String? id, BudgetLimitV2? attributes}) {
    return BudgetLimitReadV2(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes);
  }

  BudgetLimitReadV2 copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<BudgetLimitV2>? attributes}) {
    return BudgetLimitReadV2(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetV2 {
  const BudgetV2({
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.active,
    this.order,
  });

  factory BudgetV2.fromJson(Map<String, dynamic> json) =>
      _$BudgetV2FromJson(json);

  static const toJsonFactory = _$BudgetV2ToJson;
  Map<String, dynamic> toJson() => _$BudgetV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int? order;
  static const fromJsonFactory = _$BudgetV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetV2Extension on BudgetV2 {
  BudgetV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? name,
      bool? active,
      int? order}) {
    return BudgetV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        active: active ?? this.active,
        order: order ?? this.order);
  }

  BudgetV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<String>? name,
      Wrapped<bool?>? active,
      Wrapped<int?>? order}) {
    return BudgetV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        name: (name != null ? name.value : this.name),
        active: (active != null ? active.value : this.active),
        order: (order != null ? order.value : this.order));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetV2Array {
  const BudgetV2Array({
    required this.data,
    required this.meta,
  });

  factory BudgetV2Array.fromJson(Map<String, dynamic> json) =>
      _$BudgetV2ArrayFromJson(json);

  static const toJsonFactory = _$BudgetV2ArrayToJson;
  Map<String, dynamic> toJson() => _$BudgetV2ArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <BudgetV2Read>[])
  final List<BudgetV2Read> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$BudgetV2ArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetV2ArrayExtension on BudgetV2Array {
  BudgetV2Array copyWith({List<BudgetV2Read>? data, Meta? meta}) {
    return BudgetV2Array(data: data ?? this.data, meta: meta ?? this.meta);
  }

  BudgetV2Array copyWithWrapped(
      {Wrapped<List<BudgetV2Read>>? data, Wrapped<Meta>? meta}) {
    return BudgetV2Array(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class BudgetV2Read {
  const BudgetV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory BudgetV2Read.fromJson(Map<String, dynamic> json) =>
      _$BudgetV2ReadFromJson(json);

  static const toJsonFactory = _$BudgetV2ReadToJson;
  Map<String, dynamic> toJson() => _$BudgetV2ReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final BudgetV2 attributes;
  static const fromJsonFactory = _$BudgetV2ReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BudgetV2ReadExtension on BudgetV2Read {
  BudgetV2Read copyWith({String? type, String? id, BudgetV2? attributes}) {
    return BudgetV2Read(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes);
  }

  BudgetV2Read copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<BudgetV2>? attributes}) {
    return BudgetV2Read(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class ChartDataPointV2 {
  const ChartDataPointV2({
    this.key,
  });

  factory ChartDataPointV2.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointV2FromJson(json);

  static const toJsonFactory = _$ChartDataPointV2ToJson;
  Map<String, dynamic> toJson() => _$ChartDataPointV2ToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String? key;
  static const fromJsonFactory = _$ChartDataPointV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ChartDataPointV2Extension on ChartDataPointV2 {
  ChartDataPointV2 copyWith({String? key}) {
    return ChartDataPointV2(key: key ?? this.key);
  }

  ChartDataPointV2 copyWithWrapped({Wrapped<String?>? key}) {
    return ChartDataPointV2(key: (key != null ? key.value : this.key));
  }
}

@JsonSerializable(explicitToJson: true)
class ChartDataSetV2 {
  const ChartDataSetV2({
    this.label,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyDecimalPlaces,
    this.start,
    this.end,
    this.period,
    this.entries,
    this.nativeEntries,
  });

  factory ChartDataSetV2.fromJson(Map<String, dynamic> json) =>
      _$ChartDataSetV2FromJson(json);

  static const toJsonFactory = _$ChartDataSetV2ToJson;
  Map<String, dynamic> toJson() => _$ChartDataSetV2ToJson(this);

  @JsonKey(name: 'label', includeIfNull: false)
  final String? label;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime? start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime? end;
  @JsonKey(
    name: 'period',
    includeIfNull: false,
    toJson: chartV2PeriodPropertyNullableToJson,
    fromJson: chartV2PeriodPropertyNullableFromJson,
  )
  final enums.ChartV2PeriodProperty? period;
  @JsonKey(name: 'entries', includeIfNull: false)
  final Object? entries;
  @JsonKey(name: 'native_entries', includeIfNull: false)
  final Object? nativeEntries;
  static const fromJsonFactory = _$ChartDataSetV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ChartDataSetV2Extension on ChartDataSetV2 {
  ChartDataSetV2 copyWith(
      {String? label,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyCode,
      String? nativeCurrencySymbol,
      int? nativeCurrencyDecimalPlaces,
      DateTime? start,
      DateTime? end,
      enums.ChartV2PeriodProperty? period,
      Object? entries,
      Object? nativeEntries}) {
    return ChartDataSetV2(
        label: label ?? this.label,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
        start: start ?? this.start,
        end: end ?? this.end,
        period: period ?? this.period,
        entries: entries ?? this.entries,
        nativeEntries: nativeEntries ?? this.nativeEntries);
  }

  ChartDataSetV2 copyWithWrapped(
      {Wrapped<String?>? label,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<DateTime?>? start,
      Wrapped<DateTime?>? end,
      Wrapped<enums.ChartV2PeriodProperty?>? period,
      Wrapped<Object?>? entries,
      Wrapped<Object?>? nativeEntries}) {
    return ChartDataSetV2(
        label: (label != null ? label.value : this.label),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        period: (period != null ? period.value : this.period),
        entries: (entries != null ? entries.value : this.entries),
        nativeEntries:
            (nativeEntries != null ? nativeEntries.value : this.nativeEntries));
  }
}

typedef ChartLineV2 = List<ChartDataSetV2>;

@JsonSerializable(explicitToJson: true)
class CurrencyV2 {
  const CurrencyV2({
    this.createdAt,
    this.updatedAt,
    this.enabled,
    this.$default,
    required this.code,
    required this.name,
    required this.symbol,
    this.decimalPlaces,
  });

  factory CurrencyV2.fromJson(Map<String, dynamic> json) =>
      _$CurrencyV2FromJson(json);

  static const toJsonFactory = _$CurrencyV2ToJson;
  Map<String, dynamic> toJson() => _$CurrencyV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'enabled', includeIfNull: false, defaultValue: true)
  final bool? enabled;
  @JsonKey(name: 'default', includeIfNull: false)
  final bool? $default;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int? decimalPlaces;
  static const fromJsonFactory = _$CurrencyV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyV2Extension on CurrencyV2 {
  CurrencyV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      bool? enabled,
      bool? $default,
      String? code,
      String? name,
      String? symbol,
      int? decimalPlaces}) {
    return CurrencyV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        enabled: enabled ?? this.enabled,
        $default: $default ?? this.$default,
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        decimalPlaces: decimalPlaces ?? this.decimalPlaces);
  }

  CurrencyV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? enabled,
      Wrapped<bool?>? $default,
      Wrapped<String>? code,
      Wrapped<String>? name,
      Wrapped<String>? symbol,
      Wrapped<int?>? decimalPlaces}) {
    return CurrencyV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        enabled: (enabled != null ? enabled.value : this.enabled),
        $default: ($default != null ? $default.value : this.$default),
        code: (code != null ? code.value : this.code),
        name: (name != null ? name.value : this.name),
        symbol: (symbol != null ? symbol.value : this.symbol),
        decimalPlaces:
            (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces));
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyV2Array {
  const CurrencyV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory CurrencyV2Array.fromJson(Map<String, dynamic> json) =>
      _$CurrencyV2ArrayFromJson(json);

  static const toJsonFactory = _$CurrencyV2ArrayToJson;
  Map<String, dynamic> toJson() => _$CurrencyV2ArrayToJson(this);

  @JsonKey(name: 'data', includeIfNull: false, defaultValue: <CurrencyV2Read>[])
  final List<CurrencyV2Read> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLinkV2 links;
  static const fromJsonFactory = _$CurrencyV2ArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyV2ArrayExtension on CurrencyV2Array {
  CurrencyV2Array copyWith(
      {List<CurrencyV2Read>? data, Meta? meta, PageLinkV2? links}) {
    return CurrencyV2Array(
        data: data ?? this.data,
        meta: meta ?? this.meta,
        links: links ?? this.links);
  }

  CurrencyV2Array copyWithWrapped(
      {Wrapped<List<CurrencyV2Read>>? data,
      Wrapped<Meta>? meta,
      Wrapped<PageLinkV2>? links}) {
    return CurrencyV2Array(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class CurrencyV2Read {
  const CurrencyV2Read({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory CurrencyV2Read.fromJson(Map<String, dynamic> json) =>
      _$CurrencyV2ReadFromJson(json);

  static const toJsonFactory = _$CurrencyV2ReadToJson;
  Map<String, dynamic> toJson() => _$CurrencyV2ReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final CurrencyV2 attributes;
  static const fromJsonFactory = _$CurrencyV2ReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CurrencyV2ReadExtension on CurrencyV2Read {
  CurrencyV2Read copyWith({String? type, String? id, CurrencyV2? attributes}) {
    return CurrencyV2Read(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes);
  }

  CurrencyV2Read copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<CurrencyV2>? attributes}) {
    return CurrencyV2Read(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankV2 {
  const PiggyBankV2({
    this.createdAt,
    this.updatedAt,
    required this.accountId,
    this.accountName,
    required this.name,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyDecimalPlaces,
    this.currentAmount,
    this.nativeCurrentAmount,
    required this.targetAmount,
    this.nativeTargetAmount,
    this.percentage,
    this.leftToSave,
    this.nativeLeftToSave,
    this.savePerMonth,
    this.nativeSavePerMonth,
    this.startDate,
    this.targetDate,
    this.order,
    this.active,
    this.notes,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
  });

  factory PiggyBankV2.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankV2FromJson(json);

  static const toJsonFactory = _$PiggyBankV2ToJson;
  Map<String, dynamic> toJson() => _$PiggyBankV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'account_id', includeIfNull: false)
  final String accountId;
  @JsonKey(name: 'account_name', includeIfNull: false)
  final String? accountName;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'current_amount', includeIfNull: false)
  final String? currentAmount;
  @JsonKey(name: 'native_current_amount', includeIfNull: false)
  final String? nativeCurrentAmount;
  @JsonKey(name: 'target_amount', includeIfNull: false)
  final String? targetAmount;
  @JsonKey(name: 'native_target_amount', includeIfNull: false)
  final String? nativeTargetAmount;
  @JsonKey(name: 'percentage', includeIfNull: false)
  final double? percentage;
  @JsonKey(name: 'left_to_save', includeIfNull: false)
  final String? leftToSave;
  @JsonKey(name: 'native_left_to_save', includeIfNull: false)
  final String? nativeLeftToSave;
  @JsonKey(name: 'save_per_month', includeIfNull: false)
  final String? savePerMonth;
  @JsonKey(name: 'native_save_per_month', includeIfNull: false)
  final String? nativeSavePerMonth;
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
  @JsonKey(name: 'object_group_order', includeIfNull: false)
  final int? objectGroupOrder;
  @JsonKey(name: 'object_group_title', includeIfNull: false)
  final String? objectGroupTitle;
  static const fromJsonFactory = _$PiggyBankV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankV2Extension on PiggyBankV2 {
  PiggyBankV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? accountId,
      String? accountName,
      String? name,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyCode,
      String? nativeCurrencySymbol,
      int? nativeCurrencyDecimalPlaces,
      String? currentAmount,
      String? nativeCurrentAmount,
      String? targetAmount,
      String? nativeTargetAmount,
      double? percentage,
      String? leftToSave,
      String? nativeLeftToSave,
      String? savePerMonth,
      String? nativeSavePerMonth,
      DateTime? startDate,
      DateTime? targetDate,
      int? order,
      bool? active,
      String? notes,
      String? objectGroupId,
      int? objectGroupOrder,
      String? objectGroupTitle}) {
    return PiggyBankV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        accountId: accountId ?? this.accountId,
        accountName: accountName ?? this.accountName,
        name: name ?? this.name,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
        currentAmount: currentAmount ?? this.currentAmount,
        nativeCurrentAmount: nativeCurrentAmount ?? this.nativeCurrentAmount,
        targetAmount: targetAmount ?? this.targetAmount,
        nativeTargetAmount: nativeTargetAmount ?? this.nativeTargetAmount,
        percentage: percentage ?? this.percentage,
        leftToSave: leftToSave ?? this.leftToSave,
        nativeLeftToSave: nativeLeftToSave ?? this.nativeLeftToSave,
        savePerMonth: savePerMonth ?? this.savePerMonth,
        nativeSavePerMonth: nativeSavePerMonth ?? this.nativeSavePerMonth,
        startDate: startDate ?? this.startDate,
        targetDate: targetDate ?? this.targetDate,
        order: order ?? this.order,
        active: active ?? this.active,
        notes: notes ?? this.notes,
        objectGroupId: objectGroupId ?? this.objectGroupId,
        objectGroupOrder: objectGroupOrder ?? this.objectGroupOrder,
        objectGroupTitle: objectGroupTitle ?? this.objectGroupTitle);
  }

  PiggyBankV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<String>? accountId,
      Wrapped<String?>? accountName,
      Wrapped<String>? name,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<String?>? currentAmount,
      Wrapped<String?>? nativeCurrentAmount,
      Wrapped<String?>? targetAmount,
      Wrapped<String?>? nativeTargetAmount,
      Wrapped<double?>? percentage,
      Wrapped<String?>? leftToSave,
      Wrapped<String?>? nativeLeftToSave,
      Wrapped<String?>? savePerMonth,
      Wrapped<String?>? nativeSavePerMonth,
      Wrapped<DateTime?>? startDate,
      Wrapped<DateTime?>? targetDate,
      Wrapped<int?>? order,
      Wrapped<bool?>? active,
      Wrapped<String?>? notes,
      Wrapped<String?>? objectGroupId,
      Wrapped<int?>? objectGroupOrder,
      Wrapped<String?>? objectGroupTitle}) {
    return PiggyBankV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        accountId: (accountId != null ? accountId.value : this.accountId),
        accountName:
            (accountName != null ? accountName.value : this.accountName),
        name: (name != null ? name.value : this.name),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
        currentAmount:
            (currentAmount != null ? currentAmount.value : this.currentAmount),
        nativeCurrentAmount: (nativeCurrentAmount != null
            ? nativeCurrentAmount.value
            : this.nativeCurrentAmount),
        targetAmount:
            (targetAmount != null ? targetAmount.value : this.targetAmount),
        nativeTargetAmount: (nativeTargetAmount != null
            ? nativeTargetAmount.value
            : this.nativeTargetAmount),
        percentage: (percentage != null ? percentage.value : this.percentage),
        leftToSave: (leftToSave != null ? leftToSave.value : this.leftToSave),
        nativeLeftToSave: (nativeLeftToSave != null
            ? nativeLeftToSave.value
            : this.nativeLeftToSave),
        savePerMonth:
            (savePerMonth != null ? savePerMonth.value : this.savePerMonth),
        nativeSavePerMonth: (nativeSavePerMonth != null
            ? nativeSavePerMonth.value
            : this.nativeSavePerMonth),
        startDate: (startDate != null ? startDate.value : this.startDate),
        targetDate: (targetDate != null ? targetDate.value : this.targetDate),
        order: (order != null ? order.value : this.order),
        active: (active != null ? active.value : this.active),
        notes: (notes != null ? notes.value : this.notes),
        objectGroupId:
            (objectGroupId != null ? objectGroupId.value : this.objectGroupId),
        objectGroupOrder: (objectGroupOrder != null
            ? objectGroupOrder.value
            : this.objectGroupOrder),
        objectGroupTitle: (objectGroupTitle != null
            ? objectGroupTitle.value
            : this.objectGroupTitle));
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankV2Array {
  const PiggyBankV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory PiggyBankV2Array.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankV2ArrayFromJson(json);

  static const toJsonFactory = _$PiggyBankV2ArrayToJson;
  Map<String, dynamic> toJson() => _$PiggyBankV2ArrayToJson(this);

  @JsonKey(
      name: 'data', includeIfNull: false, defaultValue: <PiggyBankV2Read>[])
  final List<PiggyBankV2Read> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLinkV2 links;
  static const fromJsonFactory = _$PiggyBankV2ArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankV2ArrayExtension on PiggyBankV2Array {
  PiggyBankV2Array copyWith(
      {List<PiggyBankV2Read>? data, Meta? meta, PageLinkV2? links}) {
    return PiggyBankV2Array(
        data: data ?? this.data,
        meta: meta ?? this.meta,
        links: links ?? this.links);
  }

  PiggyBankV2Array copyWithWrapped(
      {Wrapped<List<PiggyBankV2Read>>? data,
      Wrapped<Meta>? meta,
      Wrapped<PageLinkV2>? links}) {
    return PiggyBankV2Array(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class PiggyBankV2Read {
  const PiggyBankV2Read({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory PiggyBankV2Read.fromJson(Map<String, dynamic> json) =>
      _$PiggyBankV2ReadFromJson(json);

  static const toJsonFactory = _$PiggyBankV2ReadToJson;
  Map<String, dynamic> toJson() => _$PiggyBankV2ReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final PiggyBankV2 attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLinkV2 links;
  static const fromJsonFactory = _$PiggyBankV2ReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PiggyBankV2ReadExtension on PiggyBankV2Read {
  PiggyBankV2Read copyWith(
      {String? type,
      String? id,
      PiggyBankV2? attributes,
      ObjectLinkV2? links}) {
    return PiggyBankV2Read(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        links: links ?? this.links);
  }

  PiggyBankV2Read copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<PiggyBankV2>? attributes,
      Wrapped<ObjectLinkV2>? links}) {
    return PiggyBankV2Read(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes),
        links: (links != null ? links.value : this.links));
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
  Preference copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? name,
      PolymorphicProperty? data}) {
    return Preference(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        data: data ?? this.data);
  }

  Preference copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<String>? name,
      Wrapped<PolymorphicProperty>? data}) {
    return Preference(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        name: (name != null ? name.value : this.name),
        data: (data != null ? data.value : this.data));
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
        attributes: attributes ?? this.attributes);
  }

  PreferenceRead copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<Preference>? attributes}) {
    return PreferenceRead(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class PreferenceSingle {
  const PreferenceSingle({
    required this.data,
  });

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
class Subscription {
  const Subscription({
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.amountMin,
    required this.amountMax,
    this.nativeAmountMin,
    this.nativeAmountMax,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyDecimalPlaces,
    required this.date,
    this.endDate,
    this.extensionDate,
    required this.repeatFreq,
    this.skip,
    this.active,
    this.order,
    this.notes,
    this.objectGroupId,
    this.objectGroupOrder,
    this.objectGroupTitle,
    this.nextExpectedMatch,
    this.nextExpectedMatchDiff,
    this.payDates,
    this.paidDates,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  static const toJsonFactory = _$SubscriptionToJson;
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'amount_min', includeIfNull: false)
  final String amountMin;
  @JsonKey(name: 'amount_max', includeIfNull: false)
  final String amountMax;
  @JsonKey(name: 'native_amount_min', includeIfNull: false)
  final String? nativeAmountMin;
  @JsonKey(name: 'native_amount_max', includeIfNull: false)
  final String? nativeAmountMax;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime date;
  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'extension_date', includeIfNull: false)
  final DateTime? extensionDate;
  @JsonKey(
    name: 'repeat_freq',
    includeIfNull: false,
    toJson: subscriptionRepeatPropertyNullableToJson,
    fromJson: subscriptionRepeatPropertyNullableFromJson,
  )
  final enums.SubscriptionRepeatProperty? repeatFreq;
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
  @JsonKey(name: 'next_expected_match', includeIfNull: false)
  final DateTime? nextExpectedMatch;
  @JsonKey(name: 'next_expected_match_diff', includeIfNull: false)
  final String? nextExpectedMatchDiff;
  @JsonKey(name: 'pay_dates', includeIfNull: false, defaultValue: <DateTime>[])
  final List<DateTime>? payDates;
  @JsonKey(name: 'paid_dates', includeIfNull: false)
  final List<Subscription$PaidDates$Item>? paidDates;
  static const fromJsonFactory = _$SubscriptionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SubscriptionExtension on Subscription {
  Subscription copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? name,
      String? amountMin,
      String? amountMax,
      String? nativeAmountMin,
      String? nativeAmountMax,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyCode,
      String? nativeCurrencySymbol,
      int? nativeCurrencyDecimalPlaces,
      DateTime? date,
      DateTime? endDate,
      DateTime? extensionDate,
      enums.SubscriptionRepeatProperty? repeatFreq,
      int? skip,
      bool? active,
      int? order,
      String? notes,
      String? objectGroupId,
      int? objectGroupOrder,
      String? objectGroupTitle,
      DateTime? nextExpectedMatch,
      String? nextExpectedMatchDiff,
      List<DateTime>? payDates,
      List<Subscription$PaidDates$Item>? paidDates}) {
    return Subscription(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        amountMin: amountMin ?? this.amountMin,
        amountMax: amountMax ?? this.amountMax,
        nativeAmountMin: nativeAmountMin ?? this.nativeAmountMin,
        nativeAmountMax: nativeAmountMax ?? this.nativeAmountMax,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
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
        nextExpectedMatch: nextExpectedMatch ?? this.nextExpectedMatch,
        nextExpectedMatchDiff:
            nextExpectedMatchDiff ?? this.nextExpectedMatchDiff,
        payDates: payDates ?? this.payDates,
        paidDates: paidDates ?? this.paidDates);
  }

  Subscription copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<String>? name,
      Wrapped<String>? amountMin,
      Wrapped<String>? amountMax,
      Wrapped<String?>? nativeAmountMin,
      Wrapped<String?>? nativeAmountMax,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<DateTime>? date,
      Wrapped<DateTime?>? endDate,
      Wrapped<DateTime?>? extensionDate,
      Wrapped<enums.SubscriptionRepeatProperty?>? repeatFreq,
      Wrapped<int?>? skip,
      Wrapped<bool?>? active,
      Wrapped<int?>? order,
      Wrapped<String?>? notes,
      Wrapped<String?>? objectGroupId,
      Wrapped<int?>? objectGroupOrder,
      Wrapped<String?>? objectGroupTitle,
      Wrapped<DateTime?>? nextExpectedMatch,
      Wrapped<String?>? nextExpectedMatchDiff,
      Wrapped<List<DateTime>?>? payDates,
      Wrapped<List<Subscription$PaidDates$Item>?>? paidDates}) {
    return Subscription(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        name: (name != null ? name.value : this.name),
        amountMin: (amountMin != null ? amountMin.value : this.amountMin),
        amountMax: (amountMax != null ? amountMax.value : this.amountMax),
        nativeAmountMin: (nativeAmountMin != null
            ? nativeAmountMin.value
            : this.nativeAmountMin),
        nativeAmountMax: (nativeAmountMax != null
            ? nativeAmountMax.value
            : this.nativeAmountMax),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
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
        objectGroupOrder: (objectGroupOrder != null
            ? objectGroupOrder.value
            : this.objectGroupOrder),
        objectGroupTitle: (objectGroupTitle != null
            ? objectGroupTitle.value
            : this.objectGroupTitle),
        nextExpectedMatch: (nextExpectedMatch != null
            ? nextExpectedMatch.value
            : this.nextExpectedMatch),
        nextExpectedMatchDiff: (nextExpectedMatchDiff != null
            ? nextExpectedMatchDiff.value
            : this.nextExpectedMatchDiff),
        payDates: (payDates != null ? payDates.value : this.payDates),
        paidDates: (paidDates != null ? paidDates.value : this.paidDates));
  }
}

@JsonSerializable(explicitToJson: true)
class SubscriptionArray {
  const SubscriptionArray({
    required this.data,
    required this.meta,
  });

  factory SubscriptionArray.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionArrayFromJson(json);

  static const toJsonFactory = _$SubscriptionArrayToJson;
  Map<String, dynamic> toJson() => _$SubscriptionArrayToJson(this);

  @JsonKey(
      name: 'data', includeIfNull: false, defaultValue: <SubscriptionRead>[])
  final List<SubscriptionRead> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  static const fromJsonFactory = _$SubscriptionArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SubscriptionArrayExtension on SubscriptionArray {
  SubscriptionArray copyWith({List<SubscriptionRead>? data, Meta? meta}) {
    return SubscriptionArray(data: data ?? this.data, meta: meta ?? this.meta);
  }

  SubscriptionArray copyWithWrapped(
      {Wrapped<List<SubscriptionRead>>? data, Wrapped<Meta>? meta}) {
    return SubscriptionArray(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class SubscriptionRead {
  const SubscriptionRead({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory SubscriptionRead.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionReadFromJson(json);

  static const toJsonFactory = _$SubscriptionReadToJson;
  Map<String, dynamic> toJson() => _$SubscriptionReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final Subscription attributes;
  static const fromJsonFactory = _$SubscriptionReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SubscriptionReadExtension on SubscriptionRead {
  SubscriptionRead copyWith(
      {String? type, String? id, Subscription? attributes}) {
    return SubscriptionRead(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes);
  }

  SubscriptionRead copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<Subscription>? attributes}) {
    return SubscriptionRead(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes));
  }
}

@JsonSerializable(explicitToJson: true)
class SubscriptionSingle {
  const SubscriptionSingle({
    required this.data,
  });

  factory SubscriptionSingle.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionSingleFromJson(json);

  static const toJsonFactory = _$SubscriptionSingleToJson;
  Map<String, dynamic> toJson() => _$SubscriptionSingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final SubscriptionRead data;
  static const fromJsonFactory = _$SubscriptionSingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $SubscriptionSingleExtension on SubscriptionSingle {
  SubscriptionSingle copyWith({SubscriptionRead? data}) {
    return SubscriptionSingle(data: data ?? this.data);
  }

  SubscriptionSingle copyWithWrapped({Wrapped<SubscriptionRead>? data}) {
    return SubscriptionSingle(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2 {
  const TransactionV2({
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userGroup,
    this.groupTitle,
    required this.transactions,
  });

  factory TransactionV2.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2FromJson(json);

  static const toJsonFactory = _$TransactionV2ToJson;
  Map<String, dynamic> toJson() => _$TransactionV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'user', includeIfNull: false)
  final String? user;
  @JsonKey(name: 'user_group', includeIfNull: false)
  final String? userGroup;
  @JsonKey(name: 'group_title', includeIfNull: false)
  final String? groupTitle;
  @JsonKey(
      name: 'transactions',
      includeIfNull: false,
      defaultValue: <TransactionV2Split>[])
  final List<TransactionV2Split> transactions;
  static const fromJsonFactory = _$TransactionV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2Extension on TransactionV2 {
  TransactionV2 copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? user,
      String? userGroup,
      String? groupTitle,
      List<TransactionV2Split>? transactions}) {
    return TransactionV2(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        userGroup: userGroup ?? this.userGroup,
        groupTitle: groupTitle ?? this.groupTitle,
        transactions: transactions ?? this.transactions);
  }

  TransactionV2 copyWithWrapped(
      {Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<String?>? user,
      Wrapped<String?>? userGroup,
      Wrapped<String?>? groupTitle,
      Wrapped<List<TransactionV2Split>>? transactions}) {
    return TransactionV2(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        user: (user != null ? user.value : this.user),
        userGroup: (userGroup != null ? userGroup.value : this.userGroup),
        groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
        transactions:
            (transactions != null ? transactions.value : this.transactions));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2Array {
  const TransactionV2Array({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory TransactionV2Array.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2ArrayFromJson(json);

  static const toJsonFactory = _$TransactionV2ArrayToJson;
  Map<String, dynamic> toJson() => _$TransactionV2ArrayToJson(this);

  @JsonKey(
      name: 'data', includeIfNull: false, defaultValue: <TransactionV2Read>[])
  final List<TransactionV2Read> data;
  @JsonKey(name: 'meta', includeIfNull: false)
  final Meta meta;
  @JsonKey(name: 'links', includeIfNull: false)
  final PageLinkV2 links;
  static const fromJsonFactory = _$TransactionV2ArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2ArrayExtension on TransactionV2Array {
  TransactionV2Array copyWith(
      {List<TransactionV2Read>? data, Meta? meta, PageLinkV2? links}) {
    return TransactionV2Array(
        data: data ?? this.data,
        meta: meta ?? this.meta,
        links: links ?? this.links);
  }

  TransactionV2Array copyWithWrapped(
      {Wrapped<List<TransactionV2Read>>? data,
      Wrapped<Meta>? meta,
      Wrapped<PageLinkV2>? links}) {
    return TransactionV2Array(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2Read {
  const TransactionV2Read({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  factory TransactionV2Read.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2ReadFromJson(json);

  static const toJsonFactory = _$TransactionV2ReadToJson;
  Map<String, dynamic> toJson() => _$TransactionV2ReadToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String type;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'attributes', includeIfNull: false)
  final TransactionV2 attributes;
  @JsonKey(name: 'links', includeIfNull: false)
  final ObjectLinkV2 links;
  static const fromJsonFactory = _$TransactionV2ReadFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2ReadExtension on TransactionV2Read {
  TransactionV2Read copyWith(
      {String? type,
      String? id,
      TransactionV2? attributes,
      ObjectLinkV2? links}) {
    return TransactionV2Read(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        links: links ?? this.links);
  }

  TransactionV2Read copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<TransactionV2>? attributes,
      Wrapped<ObjectLinkV2>? links}) {
    return TransactionV2Read(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2Single {
  const TransactionV2Single({
    required this.data,
  });

  factory TransactionV2Single.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2SingleFromJson(json);

  static const toJsonFactory = _$TransactionV2SingleToJson;
  Map<String, dynamic> toJson() => _$TransactionV2SingleToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final TransactionV2Read data;
  static const fromJsonFactory = _$TransactionV2SingleFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2SingleExtension on TransactionV2Single {
  TransactionV2Single copyWith({TransactionV2Read? data}) {
    return TransactionV2Single(data: data ?? this.data);
  }

  TransactionV2Single copyWithWrapped({Wrapped<TransactionV2Read>? data}) {
    return TransactionV2Single(data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2Split {
  const TransactionV2Split({
    this.user,
    this.userGroup,
    this.transactionJournalId,
    required this.type,
    required this.date,
    this.order,
    required this.amount,
    this.nativeAmount,
    this.foreignAmount,
    this.nativeForeignAmount,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyCode,
    this.nativeCurrencySymbol,
    this.nativeCurrencyName,
    this.nativeCurrencyDecimalPlaces,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    required this.description,
    required this.sourceId,
    this.sourceName,
    this.sourceIban,
    this.sourceType,
    required this.destinationId,
    this.destinationName,
    this.destinationIban,
    this.destinationType,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.billId,
    this.billName,
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
  });

  factory TransactionV2Split.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2SplitFromJson(json);

  static const toJsonFactory = _$TransactionV2SplitToJson;
  Map<String, dynamic> toJson() => _$TransactionV2SplitToJson(this);

  @JsonKey(name: 'user', includeIfNull: false)
  final String? user;
  @JsonKey(name: 'user_group', includeIfNull: false)
  final String? userGroup;
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
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'native_amount', includeIfNull: false)
  final String? nativeAmount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'native_foreign_amount', includeIfNull: false)
  final String? nativeForeignAmount;
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
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_name', includeIfNull: false)
  final String? nativeCurrencyName;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol', includeIfNull: false)
  final String? foreignCurrencySymbol;
  @JsonKey(name: 'foreign_currency_decimal_places', includeIfNull: false)
  final int? foreignCurrencyDecimalPlaces;
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
  static const fromJsonFactory = _$TransactionV2SplitFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2SplitExtension on TransactionV2Split {
  TransactionV2Split copyWith(
      {String? user,
      String? userGroup,
      String? transactionJournalId,
      enums.TransactionTypeProperty? type,
      DateTime? date,
      int? order,
      String? amount,
      String? nativeAmount,
      String? foreignAmount,
      String? nativeForeignAmount,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      String? currencyName,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyCode,
      String? nativeCurrencySymbol,
      String? nativeCurrencyName,
      int? nativeCurrencyDecimalPlaces,
      String? foreignCurrencyId,
      String? foreignCurrencyCode,
      String? foreignCurrencySymbol,
      int? foreignCurrencyDecimalPlaces,
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
      DateTime? invoiceDate}) {
    return TransactionV2Split(
        user: user ?? this.user,
        userGroup: userGroup ?? this.userGroup,
        transactionJournalId: transactionJournalId ?? this.transactionJournalId,
        type: type ?? this.type,
        date: date ?? this.date,
        order: order ?? this.order,
        amount: amount ?? this.amount,
        nativeAmount: nativeAmount ?? this.nativeAmount,
        foreignAmount: foreignAmount ?? this.foreignAmount,
        nativeForeignAmount: nativeForeignAmount ?? this.nativeForeignAmount,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyName: currencyName ?? this.currencyName,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyName: nativeCurrencyName ?? this.nativeCurrencyName,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces,
        foreignCurrencyId: foreignCurrencyId ?? this.foreignCurrencyId,
        foreignCurrencyCode: foreignCurrencyCode ?? this.foreignCurrencyCode,
        foreignCurrencySymbol:
            foreignCurrencySymbol ?? this.foreignCurrencySymbol,
        foreignCurrencyDecimalPlaces:
            foreignCurrencyDecimalPlaces ?? this.foreignCurrencyDecimalPlaces,
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
        invoiceDate: invoiceDate ?? this.invoiceDate);
  }

  TransactionV2Split copyWithWrapped(
      {Wrapped<String?>? user,
      Wrapped<String?>? userGroup,
      Wrapped<String?>? transactionJournalId,
      Wrapped<enums.TransactionTypeProperty>? type,
      Wrapped<DateTime>? date,
      Wrapped<int?>? order,
      Wrapped<String>? amount,
      Wrapped<String?>? nativeAmount,
      Wrapped<String?>? foreignAmount,
      Wrapped<String?>? nativeForeignAmount,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<String?>? currencyName,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<String?>? nativeCurrencyName,
      Wrapped<int?>? nativeCurrencyDecimalPlaces,
      Wrapped<String?>? foreignCurrencyId,
      Wrapped<String?>? foreignCurrencyCode,
      Wrapped<String?>? foreignCurrencySymbol,
      Wrapped<int?>? foreignCurrencyDecimalPlaces,
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
      Wrapped<DateTime?>? invoiceDate}) {
    return TransactionV2Split(
        user: (user != null ? user.value : this.user),
        userGroup: (userGroup != null ? userGroup.value : this.userGroup),
        transactionJournalId: (transactionJournalId != null
            ? transactionJournalId.value
            : this.transactionJournalId),
        type: (type != null ? type.value : this.type),
        date: (date != null ? date.value : this.date),
        order: (order != null ? order.value : this.order),
        amount: (amount != null ? amount.value : this.amount),
        nativeAmount:
            (nativeAmount != null ? nativeAmount.value : this.nativeAmount),
        foreignAmount:
            (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
        nativeForeignAmount: (nativeForeignAmount != null
            ? nativeForeignAmount.value
            : this.nativeForeignAmount),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyName:
            (currencyName != null ? currencyName.value : this.currencyName),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyName: (nativeCurrencyName != null
            ? nativeCurrencyName.value
            : this.nativeCurrencyName),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces),
        foreignCurrencyId: (foreignCurrencyId != null
            ? foreignCurrencyId.value
            : this.foreignCurrencyId),
        foreignCurrencyCode: (foreignCurrencyCode != null
            ? foreignCurrencyCode.value
            : this.foreignCurrencyCode),
        foreignCurrencySymbol: (foreignCurrencySymbol != null
            ? foreignCurrencySymbol.value
            : this.foreignCurrencySymbol),
        foreignCurrencyDecimalPlaces: (foreignCurrencyDecimalPlaces != null
            ? foreignCurrencyDecimalPlaces.value
            : this.foreignCurrencyDecimalPlaces),
        description:
            (description != null ? description.value : this.description),
        sourceId: (sourceId != null ? sourceId.value : this.sourceId),
        sourceName: (sourceName != null ? sourceName.value : this.sourceName),
        sourceIban: (sourceIban != null ? sourceIban.value : this.sourceIban),
        sourceType: (sourceType != null ? sourceType.value : this.sourceType),
        destinationId:
            (destinationId != null ? destinationId.value : this.destinationId),
        destinationName: (destinationName != null
            ? destinationName.value
            : this.destinationName),
        destinationIban: (destinationIban != null
            ? destinationIban.value
            : this.destinationIban),
        destinationType: (destinationType != null
            ? destinationType.value
            : this.destinationType),
        budgetId: (budgetId != null ? budgetId.value : this.budgetId),
        budgetName: (budgetName != null ? budgetName.value : this.budgetName),
        categoryId: (categoryId != null ? categoryId.value : this.categoryId),
        categoryName:
            (categoryName != null ? categoryName.value : this.categoryName),
        billId: (billId != null ? billId.value : this.billId),
        billName: (billName != null ? billName.value : this.billName),
        reconciled: (reconciled != null ? reconciled.value : this.reconciled),
        notes: (notes != null ? notes.value : this.notes),
        tags: (tags != null ? tags.value : this.tags),
        internalReference: (internalReference != null
            ? internalReference.value
            : this.internalReference),
        externalId: (externalId != null ? externalId.value : this.externalId),
        externalUrl:
            (externalUrl != null ? externalUrl.value : this.externalUrl),
        originalSource: (originalSource != null
            ? originalSource.value
            : this.originalSource),
        recurrenceId:
            (recurrenceId != null ? recurrenceId.value : this.recurrenceId),
        recurrenceTotal: (recurrenceTotal != null
            ? recurrenceTotal.value
            : this.recurrenceTotal),
        recurrenceCount: (recurrenceCount != null
            ? recurrenceCount.value
            : this.recurrenceCount),
        importHashV2:
            (importHashV2 != null ? importHashV2.value : this.importHashV2),
        sepaCc: (sepaCc != null ? sepaCc.value : this.sepaCc),
        sepaCtOp: (sepaCtOp != null ? sepaCtOp.value : this.sepaCtOp),
        sepaCtId: (sepaCtId != null ? sepaCtId.value : this.sepaCtId),
        sepaDb: (sepaDb != null ? sepaDb.value : this.sepaDb),
        sepaCountry:
            (sepaCountry != null ? sepaCountry.value : this.sepaCountry),
        sepaEp: (sepaEp != null ? sepaEp.value : this.sepaEp),
        sepaCi: (sepaCi != null ? sepaCi.value : this.sepaCi),
        sepaBatchId:
            (sepaBatchId != null ? sepaBatchId.value : this.sepaBatchId),
        interestDate:
            (interestDate != null ? interestDate.value : this.interestDate),
        bookDate: (bookDate != null ? bookDate.value : this.bookDate),
        processDate:
            (processDate != null ? processDate.value : this.processDate),
        dueDate: (dueDate != null ? dueDate.value : this.dueDate),
        paymentDate:
            (paymentDate != null ? paymentDate.value : this.paymentDate),
        invoiceDate:
            (invoiceDate != null ? invoiceDate.value : this.invoiceDate));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2SplitStore {
  const TransactionV2SplitStore({
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
    this.bunqPaymentId,
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

  factory TransactionV2SplitStore.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2SplitStoreFromJson(json);

  static const toJsonFactory = _$TransactionV2SplitStoreToJson;
  Map<String, dynamic> toJson() => _$TransactionV2SplitStoreToJson(this);

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
  @JsonKey(name: 'bunq_payment_id', includeIfNull: false)
  final String? bunqPaymentId;
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
  static const fromJsonFactory = _$TransactionV2SplitStoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2SplitStoreExtension on TransactionV2SplitStore {
  TransactionV2SplitStore copyWith(
      {enums.TransactionTypeProperty? type,
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
      String? bunqPaymentId,
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
      DateTime? invoiceDate}) {
    return TransactionV2SplitStore(
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
        bunqPaymentId: bunqPaymentId ?? this.bunqPaymentId,
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
        invoiceDate: invoiceDate ?? this.invoiceDate);
  }

  TransactionV2SplitStore copyWithWrapped(
      {Wrapped<enums.TransactionTypeProperty>? type,
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
      Wrapped<String?>? bunqPaymentId,
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
      Wrapped<DateTime?>? invoiceDate}) {
    return TransactionV2SplitStore(
        type: (type != null ? type.value : this.type),
        date: (date != null ? date.value : this.date),
        amount: (amount != null ? amount.value : this.amount),
        description:
            (description != null ? description.value : this.description),
        order: (order != null ? order.value : this.order),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        foreignAmount:
            (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
        foreignCurrencyId: (foreignCurrencyId != null
            ? foreignCurrencyId.value
            : this.foreignCurrencyId),
        foreignCurrencyCode: (foreignCurrencyCode != null
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
        destinationName: (destinationName != null
            ? destinationName.value
            : this.destinationName),
        reconciled: (reconciled != null ? reconciled.value : this.reconciled),
        piggyBankId:
            (piggyBankId != null ? piggyBankId.value : this.piggyBankId),
        piggyBankName:
            (piggyBankName != null ? piggyBankName.value : this.piggyBankName),
        billId: (billId != null ? billId.value : this.billId),
        billName: (billName != null ? billName.value : this.billName),
        tags: (tags != null ? tags.value : this.tags),
        notes: (notes != null ? notes.value : this.notes),
        internalReference: (internalReference != null
            ? internalReference.value
            : this.internalReference),
        externalId: (externalId != null ? externalId.value : this.externalId),
        externalUrl:
            (externalUrl != null ? externalUrl.value : this.externalUrl),
        bunqPaymentId:
            (bunqPaymentId != null ? bunqPaymentId.value : this.bunqPaymentId),
        sepaCc: (sepaCc != null ? sepaCc.value : this.sepaCc),
        sepaCtOp: (sepaCtOp != null ? sepaCtOp.value : this.sepaCtOp),
        sepaCtId: (sepaCtId != null ? sepaCtId.value : this.sepaCtId),
        sepaDb: (sepaDb != null ? sepaDb.value : this.sepaDb),
        sepaCountry:
            (sepaCountry != null ? sepaCountry.value : this.sepaCountry),
        sepaEp: (sepaEp != null ? sepaEp.value : this.sepaEp),
        sepaCi: (sepaCi != null ? sepaCi.value : this.sepaCi),
        sepaBatchId:
            (sepaBatchId != null ? sepaBatchId.value : this.sepaBatchId),
        interestDate:
            (interestDate != null ? interestDate.value : this.interestDate),
        bookDate: (bookDate != null ? bookDate.value : this.bookDate),
        processDate:
            (processDate != null ? processDate.value : this.processDate),
        dueDate: (dueDate != null ? dueDate.value : this.dueDate),
        paymentDate:
            (paymentDate != null ? paymentDate.value : this.paymentDate),
        invoiceDate:
            (invoiceDate != null ? invoiceDate.value : this.invoiceDate));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionV2Store {
  const TransactionV2Store({
    this.errorIfDuplicateHash,
    this.applyRules,
    this.fireWebhooks,
    this.groupTitle,
    required this.transactions,
  });

  factory TransactionV2Store.fromJson(Map<String, dynamic> json) =>
      _$TransactionV2StoreFromJson(json);

  static const toJsonFactory = _$TransactionV2StoreToJson;
  Map<String, dynamic> toJson() => _$TransactionV2StoreToJson(this);

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
      defaultValue: <TransactionV2SplitStore>[])
  final List<TransactionV2SplitStore> transactions;
  static const fromJsonFactory = _$TransactionV2StoreFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionV2StoreExtension on TransactionV2Store {
  TransactionV2Store copyWith(
      {bool? errorIfDuplicateHash,
      bool? applyRules,
      bool? fireWebhooks,
      String? groupTitle,
      List<TransactionV2SplitStore>? transactions}) {
    return TransactionV2Store(
        errorIfDuplicateHash: errorIfDuplicateHash ?? this.errorIfDuplicateHash,
        applyRules: applyRules ?? this.applyRules,
        fireWebhooks: fireWebhooks ?? this.fireWebhooks,
        groupTitle: groupTitle ?? this.groupTitle,
        transactions: transactions ?? this.transactions);
  }

  TransactionV2Store copyWithWrapped(
      {Wrapped<bool?>? errorIfDuplicateHash,
      Wrapped<bool?>? applyRules,
      Wrapped<bool?>? fireWebhooks,
      Wrapped<String?>? groupTitle,
      Wrapped<List<TransactionV2SplitStore>>? transactions}) {
    return TransactionV2Store(
        errorIfDuplicateHash: (errorIfDuplicateHash != null
            ? errorIfDuplicateHash.value
            : this.errorIfDuplicateHash),
        applyRules: (applyRules != null ? applyRules.value : this.applyRules),
        fireWebhooks:
            (fireWebhooks != null ? fireWebhooks.value : this.fireWebhooks),
        groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
        transactions:
            (transactions != null ? transactions.value : this.transactions));
  }
}

@JsonSerializable(explicitToJson: true)
class NetWorthArray {
  const NetWorthArray({
    this.currencyCode,
  });

  factory NetWorthArray.fromJson(Map<String, dynamic> json) =>
      _$NetWorthArrayFromJson(json);

  static const toJsonFactory = _$NetWorthArrayToJson;
  Map<String, dynamic> toJson() => _$NetWorthArrayToJson(this);

  @JsonKey(name: 'currency_code', includeIfNull: false)
  final NetWorthItem? currencyCode;
  static const fromJsonFactory = _$NetWorthArrayFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $NetWorthArrayExtension on NetWorthArray {
  NetWorthArray copyWith({NetWorthItem? currencyCode}) {
    return NetWorthArray(currencyCode: currencyCode ?? this.currencyCode);
  }

  NetWorthArray copyWithWrapped({Wrapped<NetWorthItem?>? currencyCode}) {
    return NetWorthArray(
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode));
  }
}

@JsonSerializable(explicitToJson: true)
class NetWorthItem {
  const NetWorthItem({
    this.balance,
    this.nativeBalance,
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.currencyCode,
    this.currencyDecimalPlaces,
    this.nativeCurrencyId,
    this.nativeCurrencyName,
    this.nativeCurrencySymbol,
    this.nativeCurrencyCode,
    this.nativeCurrencyDecimalPlaces,
  });

  factory NetWorthItem.fromJson(Map<String, dynamic> json) =>
      _$NetWorthItemFromJson(json);

  static const toJsonFactory = _$NetWorthItemToJson;
  Map<String, dynamic> toJson() => _$NetWorthItemToJson(this);

  @JsonKey(name: 'balance', includeIfNull: false)
  final String? balance;
  @JsonKey(name: 'native_balance', includeIfNull: false)
  final String? nativeBalance;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String? currencyName;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  @JsonKey(name: 'native_currency_id', includeIfNull: false)
  final String? nativeCurrencyId;
  @JsonKey(name: 'native_currency_name', includeIfNull: false)
  final String? nativeCurrencyName;
  @JsonKey(name: 'native_currency_symbol', includeIfNull: false)
  final String? nativeCurrencySymbol;
  @JsonKey(name: 'native_currency_code', includeIfNull: false)
  final String? nativeCurrencyCode;
  @JsonKey(name: 'native_currency_decimal_places', includeIfNull: false)
  final int? nativeCurrencyDecimalPlaces;
  static const fromJsonFactory = _$NetWorthItemFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $NetWorthItemExtension on NetWorthItem {
  NetWorthItem copyWith(
      {String? balance,
      String? nativeBalance,
      String? currencyId,
      String? currencyName,
      String? currencySymbol,
      String? currencyCode,
      int? currencyDecimalPlaces,
      String? nativeCurrencyId,
      String? nativeCurrencyName,
      String? nativeCurrencySymbol,
      String? nativeCurrencyCode,
      int? nativeCurrencyDecimalPlaces}) {
    return NetWorthItem(
        balance: balance ?? this.balance,
        nativeBalance: nativeBalance ?? this.nativeBalance,
        currencyId: currencyId ?? this.currencyId,
        currencyName: currencyName ?? this.currencyName,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyCode: currencyCode ?? this.currencyCode,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces,
        nativeCurrencyId: nativeCurrencyId ?? this.nativeCurrencyId,
        nativeCurrencyName: nativeCurrencyName ?? this.nativeCurrencyName,
        nativeCurrencySymbol: nativeCurrencySymbol ?? this.nativeCurrencySymbol,
        nativeCurrencyCode: nativeCurrencyCode ?? this.nativeCurrencyCode,
        nativeCurrencyDecimalPlaces:
            nativeCurrencyDecimalPlaces ?? this.nativeCurrencyDecimalPlaces);
  }

  NetWorthItem copyWithWrapped(
      {Wrapped<String?>? balance,
      Wrapped<String?>? nativeBalance,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyName,
      Wrapped<String?>? currencySymbol,
      Wrapped<String?>? currencyCode,
      Wrapped<int?>? currencyDecimalPlaces,
      Wrapped<String?>? nativeCurrencyId,
      Wrapped<String?>? nativeCurrencyName,
      Wrapped<String?>? nativeCurrencySymbol,
      Wrapped<String?>? nativeCurrencyCode,
      Wrapped<int?>? nativeCurrencyDecimalPlaces}) {
    return NetWorthItem(
        balance: (balance != null ? balance.value : this.balance),
        nativeBalance:
            (nativeBalance != null ? nativeBalance.value : this.nativeBalance),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyName:
            (currencyName != null ? currencyName.value : this.currencyName),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces),
        nativeCurrencyId: (nativeCurrencyId != null
            ? nativeCurrencyId.value
            : this.nativeCurrencyId),
        nativeCurrencyName: (nativeCurrencyName != null
            ? nativeCurrencyName.value
            : this.nativeCurrencyName),
        nativeCurrencySymbol: (nativeCurrencySymbol != null
            ? nativeCurrencySymbol.value
            : this.nativeCurrencySymbol),
        nativeCurrencyCode: (nativeCurrencyCode != null
            ? nativeCurrencyCode.value
            : this.nativeCurrencyCode),
        nativeCurrencyDecimalPlaces: (nativeCurrencyDecimalPlaces != null
            ? nativeCurrencyDecimalPlaces.value
            : this.nativeCurrencyDecimalPlaces));
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
class BasicSummaryV2 {
  const BasicSummaryV2();

  factory BasicSummaryV2.fromJson(Map<String, dynamic> json) =>
      _$BasicSummaryV2FromJson(json);

  static const toJsonFactory = _$BasicSummaryV2ToJson;
  Map<String, dynamic> toJson() => _$BasicSummaryV2ToJson(this);

  static const fromJsonFactory = _$BasicSummaryV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(explicitToJson: true)
class BasicSummaryV2Entry {
  const BasicSummaryV2Entry({
    this.key,
    this.value,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.currencyDecimalPlaces,
  });

  factory BasicSummaryV2Entry.fromJson(Map<String, dynamic> json) =>
      _$BasicSummaryV2EntryFromJson(json);

  static const toJsonFactory = _$BasicSummaryV2EntryToJson;
  Map<String, dynamic> toJson() => _$BasicSummaryV2EntryToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String? key;
  @JsonKey(name: 'value', includeIfNull: false)
  final double? value;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String? currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int? currencyDecimalPlaces;
  static const fromJsonFactory = _$BasicSummaryV2EntryFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BasicSummaryV2EntryExtension on BasicSummaryV2Entry {
  BasicSummaryV2Entry copyWith(
      {String? key,
      double? value,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      int? currencyDecimalPlaces}) {
    return BasicSummaryV2Entry(
        key: key ?? this.key,
        value: value ?? this.value,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyDecimalPlaces:
            currencyDecimalPlaces ?? this.currencyDecimalPlaces);
  }

  BasicSummaryV2Entry copyWithWrapped(
      {Wrapped<String?>? key,
      Wrapped<double?>? value,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String?>? currencySymbol,
      Wrapped<int?>? currencyDecimalPlaces}) {
    return BasicSummaryV2Entry(
        key: (key != null ? key.value : this.key),
        value: (value != null ? value.value : this.value),
        currencyId: (currencyId != null ? currencyId.value : this.currencyId),
        currencyCode:
            (currencyCode != null ? currencyCode.value : this.currencyCode),
        currencySymbol: (currencySymbol != null
            ? currencySymbol.value
            : this.currencySymbol),
        currencyDecimalPlaces: (currencyDecimalPlaces != null
            ? currencyDecimalPlaces.value
            : this.currencyDecimalPlaces));
  }
}

@JsonSerializable(explicitToJson: true)
class Meta {
  const Meta({
    this.pagination,
  });

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
        pagination: (pagination != null ? pagination.value : this.pagination));
  }
}

@JsonSerializable(explicitToJson: true)
class BadRequestResponse {
  const BadRequestResponse({
    this.message,
    this.exception,
  });

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
        exception: exception ?? this.exception);
  }

  BadRequestResponse copyWithWrapped(
      {Wrapped<String?>? message, Wrapped<String?>? exception}) {
    return BadRequestResponse(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class InternalExceptionResponse {
  const InternalExceptionResponse({
    this.message,
    this.exception,
  });

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
        exception: exception ?? this.exception);
  }

  InternalExceptionResponse copyWithWrapped(
      {Wrapped<String?>? message, Wrapped<String?>? exception}) {
    return InternalExceptionResponse(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class NotFoundResponse {
  const NotFoundResponse({
    this.message,
    this.exception,
  });

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
        exception: exception ?? this.exception);
  }

  NotFoundResponse copyWithWrapped(
      {Wrapped<String?>? message, Wrapped<String?>? exception}) {
    return NotFoundResponse(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class UnauthenticatedResponse {
  const UnauthenticatedResponse({
    this.message,
    this.exception,
  });

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
        exception: exception ?? this.exception);
  }

  UnauthenticatedResponse copyWithWrapped(
      {Wrapped<String?>? message, Wrapped<String?>? exception}) {
    return UnauthenticatedResponse(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationErrorResponse {
  const ValidationErrorResponse({
    this.message,
    this.errors,
  });

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
  ValidationErrorResponse copyWith(
      {String? message, ValidationErrorResponse$Errors? errors}) {
    return ValidationErrorResponse(
        message: message ?? this.message, errors: errors ?? this.errors);
  }

  ValidationErrorResponse copyWithWrapped(
      {Wrapped<String?>? message,
      Wrapped<ValidationErrorResponse$Errors?>? errors}) {
    return ValidationErrorResponse(
        message: (message != null ? message.value : this.message),
        errors: (errors != null ? errors.value : this.errors));
  }
}

@JsonSerializable(explicitToJson: true)
class Subscription$PaidDates$Item {
  const Subscription$PaidDates$Item({
    this.transactionGroupId,
    this.transactionJournalId,
    this.date,
  });

  factory Subscription$PaidDates$Item.fromJson(Map<String, dynamic> json) =>
      _$Subscription$PaidDates$ItemFromJson(json);

  static const toJsonFactory = _$Subscription$PaidDates$ItemToJson;
  Map<String, dynamic> toJson() => _$Subscription$PaidDates$ItemToJson(this);

  @JsonKey(name: 'transaction_group_id', includeIfNull: false)
  final String? transactionGroupId;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String? transactionJournalId;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  static const fromJsonFactory = _$Subscription$PaidDates$ItemFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $Subscription$PaidDates$ItemExtension on Subscription$PaidDates$Item {
  Subscription$PaidDates$Item copyWith(
      {String? transactionGroupId,
      String? transactionJournalId,
      DateTime? date}) {
    return Subscription$PaidDates$Item(
        transactionGroupId: transactionGroupId ?? this.transactionGroupId,
        transactionJournalId: transactionJournalId ?? this.transactionJournalId,
        date: date ?? this.date);
  }

  Subscription$PaidDates$Item copyWithWrapped(
      {Wrapped<String?>? transactionGroupId,
      Wrapped<String?>? transactionJournalId,
      Wrapped<DateTime?>? date}) {
    return Subscription$PaidDates$Item(
        transactionGroupId: (transactionGroupId != null
            ? transactionGroupId.value
            : this.transactionGroupId),
        transactionJournalId: (transactionJournalId != null
            ? transactionJournalId.value
            : this.transactionJournalId),
        date: (date != null ? date.value : this.date));
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
  Meta$Pagination copyWith(
      {int? total,
      int? count,
      int? perPage,
      int? currentPage,
      int? totalPages}) {
    return Meta$Pagination(
        total: total ?? this.total,
        count: count ?? this.count,
        perPage: perPage ?? this.perPage,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages);
  }

  Meta$Pagination copyWithWrapped(
      {Wrapped<int?>? total,
      Wrapped<int?>? count,
      Wrapped<int?>? perPage,
      Wrapped<int?>? currentPage,
      Wrapped<int?>? totalPages}) {
    return Meta$Pagination(
        total: (total != null ? total.value : this.total),
        count: (count != null ? count.value : this.count),
        perPage: (perPage != null ? perPage.value : this.perPage),
        currentPage:
            (currentPage != null ? currentPage.value : this.currentPage),
        totalPages: (totalPages != null ? totalPages.value : this.totalPages));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationErrorResponse$Errors {
  const ValidationErrorResponse$Errors({
    this.email,
    this.blocked,
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
  @JsonKey(name: 'blocked', includeIfNull: false, defaultValue: <String>[])
  final List<String>? blocked;
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
  ValidationErrorResponse$Errors copyWith(
      {List<String>? email,
      List<String>? blocked,
      List<String>? role,
      List<String>? blockedCode,
      List<String>? name,
      List<String>? type,
      List<String>? iban,
      List<String>? start,
      List<String>? end,
      List<String>? date}) {
    return ValidationErrorResponse$Errors(
        email: email ?? this.email,
        blocked: blocked ?? this.blocked,
        role: role ?? this.role,
        blockedCode: blockedCode ?? this.blockedCode,
        name: name ?? this.name,
        type: type ?? this.type,
        iban: iban ?? this.iban,
        start: start ?? this.start,
        end: end ?? this.end,
        date: date ?? this.date);
  }

  ValidationErrorResponse$Errors copyWithWrapped(
      {Wrapped<List<String>?>? email,
      Wrapped<List<String>?>? blocked,
      Wrapped<List<String>?>? role,
      Wrapped<List<String>?>? blockedCode,
      Wrapped<List<String>?>? name,
      Wrapped<List<String>?>? type,
      Wrapped<List<String>?>? iban,
      Wrapped<List<String>?>? start,
      Wrapped<List<String>?>? end,
      Wrapped<List<String>?>? date}) {
    return ValidationErrorResponse$Errors(
        email: (email != null ? email.value : this.email),
        blocked: (blocked != null ? blocked.value : this.blocked),
        role: (role != null ? role.value : this.role),
        blockedCode:
            (blockedCode != null ? blockedCode.value : this.blockedCode),
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        iban: (iban != null ? iban.value : this.iban),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        date: (date != null ? date.value : this.date));
  }
}

String? chartV2PeriodPropertyNullableToJson(
    enums.ChartV2PeriodProperty? chartV2PeriodProperty) {
  return chartV2PeriodProperty?.value;
}

String? chartV2PeriodPropertyToJson(
    enums.ChartV2PeriodProperty chartV2PeriodProperty) {
  return chartV2PeriodProperty.value;
}

enums.ChartV2PeriodProperty chartV2PeriodPropertyFromJson(
  Object? chartV2PeriodProperty, [
  enums.ChartV2PeriodProperty? defaultValue,
]) {
  return enums.ChartV2PeriodProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          chartV2PeriodProperty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ChartV2PeriodProperty.swaggerGeneratedUnknown;
}

enums.ChartV2PeriodProperty? chartV2PeriodPropertyNullableFromJson(
  Object? chartV2PeriodProperty, [
  enums.ChartV2PeriodProperty? defaultValue,
]) {
  if (chartV2PeriodProperty == null) {
    return null;
  }
  return enums.ChartV2PeriodProperty.values
          .firstWhereOrNull((e) => e.value == chartV2PeriodProperty) ??
      defaultValue;
}

String chartV2PeriodPropertyExplodedListToJson(
    List<enums.ChartV2PeriodProperty>? chartV2PeriodProperty) {
  return chartV2PeriodProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> chartV2PeriodPropertyListToJson(
    List<enums.ChartV2PeriodProperty>? chartV2PeriodProperty) {
  if (chartV2PeriodProperty == null) {
    return [];
  }

  return chartV2PeriodProperty.map((e) => e.value!).toList();
}

List<enums.ChartV2PeriodProperty> chartV2PeriodPropertyListFromJson(
  List? chartV2PeriodProperty, [
  List<enums.ChartV2PeriodProperty>? defaultValue,
]) {
  if (chartV2PeriodProperty == null) {
    return defaultValue ?? [];
  }

  return chartV2PeriodProperty
      .map((e) => chartV2PeriodPropertyFromJson(e.toString()))
      .toList();
}

List<enums.ChartV2PeriodProperty>? chartV2PeriodPropertyNullableListFromJson(
  List? chartV2PeriodProperty, [
  List<enums.ChartV2PeriodProperty>? defaultValue,
]) {
  if (chartV2PeriodProperty == null) {
    return defaultValue;
  }

  return chartV2PeriodProperty
      .map((e) => chartV2PeriodPropertyFromJson(e.toString()))
      .toList();
}

String? periodPropertyNullableToJson(enums.PeriodProperty? periodProperty) {
  return periodProperty?.value;
}

String? periodPropertyToJson(enums.PeriodProperty periodProperty) {
  return periodProperty.value;
}

enums.PeriodProperty periodPropertyFromJson(
  Object? periodProperty, [
  enums.PeriodProperty? defaultValue,
]) {
  return enums.PeriodProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          periodProperty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.PeriodProperty.swaggerGeneratedUnknown;
}

enums.PeriodProperty? periodPropertyNullableFromJson(
  Object? periodProperty, [
  enums.PeriodProperty? defaultValue,
]) {
  if (periodProperty == null) {
    return null;
  }
  return enums.PeriodProperty.values
          .firstWhereOrNull((e) => e.value == periodProperty) ??
      defaultValue;
}

String periodPropertyExplodedListToJson(
    List<enums.PeriodProperty>? periodProperty) {
  return periodProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> periodPropertyListToJson(
    List<enums.PeriodProperty>? periodProperty) {
  if (periodProperty == null) {
    return [];
  }

  return periodProperty.map((e) => e.value!).toList();
}

List<enums.PeriodProperty> periodPropertyListFromJson(
  List? periodProperty, [
  List<enums.PeriodProperty>? defaultValue,
]) {
  if (periodProperty == null) {
    return defaultValue ?? [];
  }

  return periodProperty
      .map((e) => periodPropertyFromJson(e.toString()))
      .toList();
}

List<enums.PeriodProperty>? periodPropertyNullableListFromJson(
  List? periodProperty, [
  List<enums.PeriodProperty>? defaultValue,
]) {
  if (periodProperty == null) {
    return defaultValue;
  }

  return periodProperty
      .map((e) => periodPropertyFromJson(e.toString()))
      .toList();
}

String? preselectedAccountPropertyNullableToJson(
    enums.PreselectedAccountProperty? preselectedAccountProperty) {
  return preselectedAccountProperty?.value;
}

String? preselectedAccountPropertyToJson(
    enums.PreselectedAccountProperty preselectedAccountProperty) {
  return preselectedAccountProperty.value;
}

enums.PreselectedAccountProperty preselectedAccountPropertyFromJson(
  Object? preselectedAccountProperty, [
  enums.PreselectedAccountProperty? defaultValue,
]) {
  return enums.PreselectedAccountProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          preselectedAccountProperty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.PreselectedAccountProperty.swaggerGeneratedUnknown;
}

enums.PreselectedAccountProperty? preselectedAccountPropertyNullableFromJson(
  Object? preselectedAccountProperty, [
  enums.PreselectedAccountProperty? defaultValue,
]) {
  if (preselectedAccountProperty == null) {
    return null;
  }
  return enums.PreselectedAccountProperty.values
          .firstWhereOrNull((e) => e.value == preselectedAccountProperty) ??
      defaultValue;
}

String preselectedAccountPropertyExplodedListToJson(
    List<enums.PreselectedAccountProperty>? preselectedAccountProperty) {
  return preselectedAccountProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> preselectedAccountPropertyListToJson(
    List<enums.PreselectedAccountProperty>? preselectedAccountProperty) {
  if (preselectedAccountProperty == null) {
    return [];
  }

  return preselectedAccountProperty.map((e) => e.value!).toList();
}

List<enums.PreselectedAccountProperty> preselectedAccountPropertyListFromJson(
  List? preselectedAccountProperty, [
  List<enums.PreselectedAccountProperty>? defaultValue,
]) {
  if (preselectedAccountProperty == null) {
    return defaultValue ?? [];
  }

  return preselectedAccountProperty
      .map((e) => preselectedAccountPropertyFromJson(e.toString()))
      .toList();
}

List<enums.PreselectedAccountProperty>?
    preselectedAccountPropertyNullableListFromJson(
  List? preselectedAccountProperty, [
  List<enums.PreselectedAccountProperty>? defaultValue,
]) {
  if (preselectedAccountProperty == null) {
    return defaultValue;
  }

  return preselectedAccountProperty
      .map((e) => preselectedAccountPropertyFromJson(e.toString()))
      .toList();
}

String? subscriptionRepeatPropertyNullableToJson(
    enums.SubscriptionRepeatProperty? subscriptionRepeatProperty) {
  return subscriptionRepeatProperty?.value;
}

String? subscriptionRepeatPropertyToJson(
    enums.SubscriptionRepeatProperty subscriptionRepeatProperty) {
  return subscriptionRepeatProperty.value;
}

enums.SubscriptionRepeatProperty subscriptionRepeatPropertyFromJson(
  Object? subscriptionRepeatProperty, [
  enums.SubscriptionRepeatProperty? defaultValue,
]) {
  return enums.SubscriptionRepeatProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          subscriptionRepeatProperty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.SubscriptionRepeatProperty.swaggerGeneratedUnknown;
}

enums.SubscriptionRepeatProperty? subscriptionRepeatPropertyNullableFromJson(
  Object? subscriptionRepeatProperty, [
  enums.SubscriptionRepeatProperty? defaultValue,
]) {
  if (subscriptionRepeatProperty == null) {
    return null;
  }
  return enums.SubscriptionRepeatProperty.values
          .firstWhereOrNull((e) => e.value == subscriptionRepeatProperty) ??
      defaultValue;
}

String subscriptionRepeatPropertyExplodedListToJson(
    List<enums.SubscriptionRepeatProperty>? subscriptionRepeatProperty) {
  return subscriptionRepeatProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> subscriptionRepeatPropertyListToJson(
    List<enums.SubscriptionRepeatProperty>? subscriptionRepeatProperty) {
  if (subscriptionRepeatProperty == null) {
    return [];
  }

  return subscriptionRepeatProperty.map((e) => e.value!).toList();
}

List<enums.SubscriptionRepeatProperty> subscriptionRepeatPropertyListFromJson(
  List? subscriptionRepeatProperty, [
  List<enums.SubscriptionRepeatProperty>? defaultValue,
]) {
  if (subscriptionRepeatProperty == null) {
    return defaultValue ?? [];
  }

  return subscriptionRepeatProperty
      .map((e) => subscriptionRepeatPropertyFromJson(e.toString()))
      .toList();
}

List<enums.SubscriptionRepeatProperty>?
    subscriptionRepeatPropertyNullableListFromJson(
  List? subscriptionRepeatProperty, [
  List<enums.SubscriptionRepeatProperty>? defaultValue,
]) {
  if (subscriptionRepeatProperty == null) {
    return defaultValue;
  }

  return subscriptionRepeatProperty
      .map((e) => subscriptionRepeatPropertyFromJson(e.toString()))
      .toList();
}

String? accountRolePropertyNullableToJson(
    enums.AccountRoleProperty? accountRoleProperty) {
  return accountRoleProperty?.value;
}

String? accountRolePropertyToJson(
    enums.AccountRoleProperty accountRoleProperty) {
  return accountRoleProperty.value;
}

enums.AccountRoleProperty accountRolePropertyFromJson(
  Object? accountRoleProperty, [
  enums.AccountRoleProperty? defaultValue,
]) {
  return enums.AccountRoleProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          accountRoleProperty?.toString().toLowerCase()) ??
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
  return enums.AccountRoleProperty.values
          .firstWhereOrNull((e) => e.value == accountRoleProperty) ??
      defaultValue;
}

String accountRolePropertyExplodedListToJson(
    List<enums.AccountRoleProperty>? accountRoleProperty) {
  return accountRoleProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountRolePropertyListToJson(
    List<enums.AccountRoleProperty>? accountRoleProperty) {
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
    enums.AccountTypeProperty? accountTypeProperty) {
  return accountTypeProperty?.value;
}

String? accountTypePropertyToJson(
    enums.AccountTypeProperty accountTypeProperty) {
  return accountTypeProperty.value;
}

enums.AccountTypeProperty accountTypePropertyFromJson(
  Object? accountTypeProperty, [
  enums.AccountTypeProperty? defaultValue,
]) {
  return enums.AccountTypeProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          accountTypeProperty?.toString().toLowerCase()) ??
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
  return enums.AccountTypeProperty.values
          .firstWhereOrNull((e) => e.value == accountTypeProperty) ??
      defaultValue;
}

String accountTypePropertyExplodedListToJson(
    List<enums.AccountTypeProperty>? accountTypeProperty) {
  return accountTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypePropertyListToJson(
    List<enums.AccountTypeProperty>? accountTypeProperty) {
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

String? creditCardTypePropertyNullableToJson(
    enums.CreditCardTypeProperty? creditCardTypeProperty) {
  return creditCardTypeProperty?.value;
}

String? creditCardTypePropertyToJson(
    enums.CreditCardTypeProperty creditCardTypeProperty) {
  return creditCardTypeProperty.value;
}

enums.CreditCardTypeProperty creditCardTypePropertyFromJson(
  Object? creditCardTypeProperty, [
  enums.CreditCardTypeProperty? defaultValue,
]) {
  return enums.CreditCardTypeProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          creditCardTypeProperty?.toString().toLowerCase()) ??
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
  return enums.CreditCardTypeProperty.values
          .firstWhereOrNull((e) => e.value == creditCardTypeProperty) ??
      defaultValue;
}

String creditCardTypePropertyExplodedListToJson(
    List<enums.CreditCardTypeProperty>? creditCardTypeProperty) {
  return creditCardTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> creditCardTypePropertyListToJson(
    List<enums.CreditCardTypeProperty>? creditCardTypeProperty) {
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
    enums.InterestPeriodProperty? interestPeriodProperty) {
  return interestPeriodProperty?.value;
}

String? interestPeriodPropertyToJson(
    enums.InterestPeriodProperty interestPeriodProperty) {
  return interestPeriodProperty.value;
}

enums.InterestPeriodProperty interestPeriodPropertyFromJson(
  Object? interestPeriodProperty, [
  enums.InterestPeriodProperty? defaultValue,
]) {
  return enums.InterestPeriodProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          interestPeriodProperty?.toString().toLowerCase()) ??
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
  return enums.InterestPeriodProperty.values
          .firstWhereOrNull((e) => e.value == interestPeriodProperty) ??
      defaultValue;
}

String interestPeriodPropertyExplodedListToJson(
    List<enums.InterestPeriodProperty>? interestPeriodProperty) {
  return interestPeriodProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> interestPeriodPropertyListToJson(
    List<enums.InterestPeriodProperty>? interestPeriodProperty) {
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
    enums.LiabilityDirectionProperty? liabilityDirectionProperty) {
  return liabilityDirectionProperty?.value;
}

String? liabilityDirectionPropertyToJson(
    enums.LiabilityDirectionProperty liabilityDirectionProperty) {
  return liabilityDirectionProperty.value;
}

enums.LiabilityDirectionProperty liabilityDirectionPropertyFromJson(
  Object? liabilityDirectionProperty, [
  enums.LiabilityDirectionProperty? defaultValue,
]) {
  return enums.LiabilityDirectionProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          liabilityDirectionProperty?.toString().toLowerCase()) ??
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
  return enums.LiabilityDirectionProperty.values
          .firstWhereOrNull((e) => e.value == liabilityDirectionProperty) ??
      defaultValue;
}

String liabilityDirectionPropertyExplodedListToJson(
    List<enums.LiabilityDirectionProperty>? liabilityDirectionProperty) {
  return liabilityDirectionProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> liabilityDirectionPropertyListToJson(
    List<enums.LiabilityDirectionProperty>? liabilityDirectionProperty) {
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
    enums.LiabilityTypeProperty? liabilityTypeProperty) {
  return liabilityTypeProperty?.value;
}

String? liabilityTypePropertyToJson(
    enums.LiabilityTypeProperty liabilityTypeProperty) {
  return liabilityTypeProperty.value;
}

enums.LiabilityTypeProperty liabilityTypePropertyFromJson(
  Object? liabilityTypeProperty, [
  enums.LiabilityTypeProperty? defaultValue,
]) {
  return enums.LiabilityTypeProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          liabilityTypeProperty?.toString().toLowerCase()) ??
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
  return enums.LiabilityTypeProperty.values
          .firstWhereOrNull((e) => e.value == liabilityTypeProperty) ??
      defaultValue;
}

String liabilityTypePropertyExplodedListToJson(
    List<enums.LiabilityTypeProperty>? liabilityTypeProperty) {
  return liabilityTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> liabilityTypePropertyListToJson(
    List<enums.LiabilityTypeProperty>? liabilityTypeProperty) {
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
    enums.ShortAccountTypeProperty? shortAccountTypeProperty) {
  return shortAccountTypeProperty?.value;
}

String? shortAccountTypePropertyToJson(
    enums.ShortAccountTypeProperty shortAccountTypeProperty) {
  return shortAccountTypeProperty.value;
}

enums.ShortAccountTypeProperty shortAccountTypePropertyFromJson(
  Object? shortAccountTypeProperty, [
  enums.ShortAccountTypeProperty? defaultValue,
]) {
  return enums.ShortAccountTypeProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          shortAccountTypeProperty?.toString().toLowerCase()) ??
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
  return enums.ShortAccountTypeProperty.values
          .firstWhereOrNull((e) => e.value == shortAccountTypeProperty) ??
      defaultValue;
}

String shortAccountTypePropertyExplodedListToJson(
    List<enums.ShortAccountTypeProperty>? shortAccountTypeProperty) {
  return shortAccountTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> shortAccountTypePropertyListToJson(
    List<enums.ShortAccountTypeProperty>? shortAccountTypeProperty) {
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
    enums.TransactionTypeProperty? transactionTypeProperty) {
  return transactionTypeProperty?.value;
}

String? transactionTypePropertyToJson(
    enums.TransactionTypeProperty transactionTypeProperty) {
  return transactionTypeProperty.value;
}

enums.TransactionTypeProperty transactionTypePropertyFromJson(
  Object? transactionTypeProperty, [
  enums.TransactionTypeProperty? defaultValue,
]) {
  return enums.TransactionTypeProperty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          transactionTypeProperty?.toString().toLowerCase()) ??
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
  return enums.TransactionTypeProperty.values
          .firstWhereOrNull((e) => e.value == transactionTypeProperty) ??
      defaultValue;
}

String transactionTypePropertyExplodedListToJson(
    List<enums.TransactionTypeProperty>? transactionTypeProperty) {
  return transactionTypeProperty?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypePropertyListToJson(
    List<enums.TransactionTypeProperty>? transactionTypeProperty) {
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

String? accountTypeFilterNullableToJson(
    enums.AccountTypeFilter? accountTypeFilter) {
  return accountTypeFilter?.value;
}

String? accountTypeFilterToJson(enums.AccountTypeFilter accountTypeFilter) {
  return accountTypeFilter.value;
}

enums.AccountTypeFilter accountTypeFilterFromJson(
  Object? accountTypeFilter, [
  enums.AccountTypeFilter? defaultValue,
]) {
  return enums.AccountTypeFilter.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          accountTypeFilter?.toString().toLowerCase()) ??
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
  return enums.AccountTypeFilter.values
          .firstWhereOrNull((e) => e.value == accountTypeFilter) ??
      defaultValue;
}

String accountTypeFilterExplodedListToJson(
    List<enums.AccountTypeFilter>? accountTypeFilter) {
  return accountTypeFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypeFilterListToJson(
    List<enums.AccountTypeFilter>? accountTypeFilter) {
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
    enums.TransactionTypeFilter? transactionTypeFilter) {
  return transactionTypeFilter?.value;
}

String? transactionTypeFilterToJson(
    enums.TransactionTypeFilter transactionTypeFilter) {
  return transactionTypeFilter.value;
}

enums.TransactionTypeFilter transactionTypeFilterFromJson(
  Object? transactionTypeFilter, [
  enums.TransactionTypeFilter? defaultValue,
]) {
  return enums.TransactionTypeFilter.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          transactionTypeFilter?.toString().toLowerCase()) ??
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
  return enums.TransactionTypeFilter.values
          .firstWhereOrNull((e) => e.value == transactionTypeFilter) ??
      defaultValue;
}

String transactionTypeFilterExplodedListToJson(
    List<enums.TransactionTypeFilter>? transactionTypeFilter) {
  return transactionTypeFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypeFilterListToJson(
    List<enums.TransactionTypeFilter>? transactionTypeFilter) {
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
