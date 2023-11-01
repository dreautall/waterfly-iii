// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'firefly_iii_v2.enums.swagger.dart' as enums;

part 'firefly_iii_v2.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionSum {
  const TransactionSum({
    required this.id,
    required this.name,
    required this.symbol,
    required this.code,
    required this.decimalPlaces,
    required this.sum,
    required this.converted,
    required this.nativeSum,
    required this.nativeId,
    required this.nativeName,
    required this.nativeSymbol,
    required this.nativeCode,
    required this.nativeDecimalPlaces,
  });

  factory TransactionSum.fromJson(Map<String, dynamic> json) =>
      _$TransactionSumFromJson(json);

  static const toJsonFactory = _$TransactionSumToJson;
  Map<String, dynamic> toJson() => _$TransactionSumToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'symbol', includeIfNull: false)
  final String symbol;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'decimal_places', includeIfNull: false)
  final int decimalPlaces;
  @JsonKey(name: 'sum', includeIfNull: false)
  final String sum;
  @JsonKey(name: 'converted', includeIfNull: false)
  final bool converted;
  @JsonKey(name: 'native_sum', includeIfNull: false)
  final String nativeSum;
  @JsonKey(name: 'native_id', includeIfNull: false)
  final String nativeId;
  @JsonKey(name: 'native_name', includeIfNull: false)
  final String nativeName;
  @JsonKey(name: 'native_symbol', includeIfNull: false)
  final String nativeSymbol;
  @JsonKey(name: 'native_code', includeIfNull: false)
  final String nativeCode;
  @JsonKey(name: 'native_decimal_places', includeIfNull: false)
  final int nativeDecimalPlaces;
  static const fromJsonFactory = _$TransactionSumFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSumExtension on TransactionSum {
  TransactionSum copyWith(
      {String? id,
      String? name,
      String? symbol,
      String? code,
      int? decimalPlaces,
      String? sum,
      bool? converted,
      String? nativeSum,
      String? nativeId,
      String? nativeName,
      String? nativeSymbol,
      String? nativeCode,
      int? nativeDecimalPlaces}) {
    return TransactionSum(
        id: id ?? this.id,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        code: code ?? this.code,
        decimalPlaces: decimalPlaces ?? this.decimalPlaces,
        sum: sum ?? this.sum,
        converted: converted ?? this.converted,
        nativeSum: nativeSum ?? this.nativeSum,
        nativeId: nativeId ?? this.nativeId,
        nativeName: nativeName ?? this.nativeName,
        nativeSymbol: nativeSymbol ?? this.nativeSymbol,
        nativeCode: nativeCode ?? this.nativeCode,
        nativeDecimalPlaces: nativeDecimalPlaces ?? this.nativeDecimalPlaces);
  }

  TransactionSum copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<String>? symbol,
      Wrapped<String>? code,
      Wrapped<int>? decimalPlaces,
      Wrapped<String>? sum,
      Wrapped<bool>? converted,
      Wrapped<String>? nativeSum,
      Wrapped<String>? nativeId,
      Wrapped<String>? nativeName,
      Wrapped<String>? nativeSymbol,
      Wrapped<String>? nativeCode,
      Wrapped<int>? nativeDecimalPlaces}) {
    return TransactionSum(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        symbol: (symbol != null ? symbol.value : this.symbol),
        code: (code != null ? code.value : this.code),
        decimalPlaces:
            (decimalPlaces != null ? decimalPlaces.value : this.decimalPlaces),
        sum: (sum != null ? sum.value : this.sum),
        converted: (converted != null ? converted.value : this.converted),
        nativeSum: (nativeSum != null ? nativeSum.value : this.nativeSum),
        nativeId: (nativeId != null ? nativeId.value : this.nativeId),
        nativeName: (nativeName != null ? nativeName.value : this.nativeName),
        nativeSymbol:
            (nativeSymbol != null ? nativeSymbol.value : this.nativeSymbol),
        nativeCode: (nativeCode != null ? nativeCode.value : this.nativeCode),
        nativeDecimalPlaces: (nativeDecimalPlaces != null
            ? nativeDecimalPlaces.value
            : this.nativeDecimalPlaces));
  }
}

typedef TransactionSumArray = List<TransactionSum>;

@JsonSerializable(explicitToJson: true)
class BudgetLimitV2 {
  const BudgetLimitV2({
    required this.createdAt,
    required this.updatedAt,
    required this.start,
    required this.end,
    required this.currencyId,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.budgetId,
    this.period,
    required this.amount,
  });

  factory BudgetLimitV2.fromJson(Map<String, dynamic> json) =>
      _$BudgetLimitV2FromJson(json);

  static const toJsonFactory = _$BudgetLimitV2ToJson;
  Map<String, dynamic> toJson() => _$BudgetLimitV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime updatedAt;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime end;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String currencyCode;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String currencyName;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int currencyDecimalPlaces;
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
      {Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<String>? currencyId,
      Wrapped<String>? currencyCode,
      Wrapped<String>? currencyName,
      Wrapped<String>? currencySymbol,
      Wrapped<int>? currencyDecimalPlaces,
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
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.active,
    required this.order,
  });

  factory BudgetV2.fromJson(Map<String, dynamic> json) =>
      _$BudgetV2FromJson(json);

  static const toJsonFactory = _$BudgetV2ToJson;
  Map<String, dynamic> toJson() => _$BudgetV2ToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime updatedAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'active', includeIfNull: false)
  final bool active;
  @JsonKey(name: 'order', includeIfNull: false)
  final int order;
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
      {Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<String>? name,
      Wrapped<bool>? active,
      Wrapped<int>? order}) {
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
    required this.key,
  });

  factory ChartDataPointV2.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointV2FromJson(json);

  static const toJsonFactory = _$ChartDataPointV2ToJson;
  Map<String, dynamic> toJson() => _$ChartDataPointV2ToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String key;
  static const fromJsonFactory = _$ChartDataPointV2FromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ChartDataPointV2Extension on ChartDataPointV2 {
  ChartDataPointV2 copyWith({String? key}) {
    return ChartDataPointV2(key: key ?? this.key);
  }

  ChartDataPointV2 copyWithWrapped({Wrapped<String>? key}) {
    return ChartDataPointV2(key: (key != null ? key.value : this.key));
  }
}

@JsonSerializable(explicitToJson: true)
class ChartDataSetV2 {
  const ChartDataSetV2({
    required this.label,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.nativeId,
    required this.nativeCode,
    required this.nativeSymbol,
    required this.nativeDecimalPlaces,
    required this.start,
    required this.end,
    required this.period,
    required this.entries,
    required this.nativeEntries,
  });

  factory ChartDataSetV2.fromJson(Map<String, dynamic> json) =>
      _$ChartDataSetV2FromJson(json);

  static const toJsonFactory = _$ChartDataSetV2ToJson;
  Map<String, dynamic> toJson() => _$ChartDataSetV2ToJson(this);

  @JsonKey(name: 'label', includeIfNull: false)
  final String label;
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String currencySymbol;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int currencyDecimalPlaces;
  @JsonKey(name: 'native_id', includeIfNull: false)
  final String nativeId;
  @JsonKey(name: 'native_code', includeIfNull: false)
  final String nativeCode;
  @JsonKey(name: 'native_symbol', includeIfNull: false)
  final String nativeSymbol;
  @JsonKey(name: 'native_decimal_places', includeIfNull: false)
  final int nativeDecimalPlaces;
  @JsonKey(name: 'start', includeIfNull: false)
  final DateTime start;
  @JsonKey(name: 'end', includeIfNull: false)
  final DateTime end;
  @JsonKey(
    name: 'period',
    includeIfNull: false,
    toJson: chartV2PeriodPropertyNullableToJson,
    fromJson: chartV2PeriodPropertyNullableFromJson,
  )
  final enums.ChartV2PeriodProperty? period;
  @JsonKey(name: 'entries', includeIfNull: false)
  final Object entries;
  @JsonKey(name: 'native_entries', includeIfNull: false)
  final Object nativeEntries;
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
      String? nativeId,
      String? nativeCode,
      String? nativeSymbol,
      int? nativeDecimalPlaces,
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
        nativeId: nativeId ?? this.nativeId,
        nativeCode: nativeCode ?? this.nativeCode,
        nativeSymbol: nativeSymbol ?? this.nativeSymbol,
        nativeDecimalPlaces: nativeDecimalPlaces ?? this.nativeDecimalPlaces,
        start: start ?? this.start,
        end: end ?? this.end,
        period: period ?? this.period,
        entries: entries ?? this.entries,
        nativeEntries: nativeEntries ?? this.nativeEntries);
  }

  ChartDataSetV2 copyWithWrapped(
      {Wrapped<String>? label,
      Wrapped<String>? currencyId,
      Wrapped<String>? currencyCode,
      Wrapped<String>? currencySymbol,
      Wrapped<int>? currencyDecimalPlaces,
      Wrapped<String>? nativeId,
      Wrapped<String>? nativeCode,
      Wrapped<String>? nativeSymbol,
      Wrapped<int>? nativeDecimalPlaces,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<enums.ChartV2PeriodProperty?>? period,
      Wrapped<Object>? entries,
      Wrapped<Object>? nativeEntries}) {
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
        nativeId: (nativeId != null ? nativeId.value : this.nativeId),
        nativeCode: (nativeCode != null ? nativeCode.value : this.nativeCode),
        nativeSymbol:
            (nativeSymbol != null ? nativeSymbol.value : this.nativeSymbol),
        nativeDecimalPlaces: (nativeDecimalPlaces != null
            ? nativeDecimalPlaces.value
            : this.nativeDecimalPlaces),
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
class Preference {
  const Preference({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.data,
  });

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  static const toJsonFactory = _$PreferenceToJson;
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime updatedAt;
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
      {Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
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
      name: 'data', includeIfNull: false, defaultValue: <TransactionRead>[])
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
  TransactionArray copyWith(
      {List<TransactionRead>? data, Meta? meta, PageLink? links}) {
    return TransactionArray(
        data: data ?? this.data,
        meta: meta ?? this.meta,
        links: links ?? this.links);
  }

  TransactionArray copyWithWrapped(
      {Wrapped<List<TransactionRead>>? data,
      Wrapped<Meta>? meta,
      Wrapped<PageLink>? links}) {
    return TransactionArray(
        data: (data != null ? data.value : this.data),
        meta: (meta != null ? meta.value : this.meta),
        links: (links != null ? links.value : this.links));
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
  TransactionRead copyWith(
      {String? type, String? id, Transaction? attributes, ObjectLink? links}) {
    return TransactionRead(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        links: links ?? this.links);
  }

  TransactionRead copyWithWrapped(
      {Wrapped<String>? type,
      Wrapped<String>? id,
      Wrapped<Transaction>? attributes,
      Wrapped<ObjectLink>? links}) {
    return TransactionRead(
        type: (type != null ? type.value : this.type),
        id: (id != null ? id.value : this.id),
        attributes: (attributes != null ? attributes.value : this.attributes),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class Meta {
  const Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  static const toJsonFactory = _$MetaToJson;
  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @JsonKey(name: 'pagination', includeIfNull: false)
  final Meta$Pagination pagination;
  static const fromJsonFactory = _$MetaFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $MetaExtension on Meta {
  Meta copyWith({Meta$Pagination? pagination}) {
    return Meta(pagination: pagination ?? this.pagination);
  }

  Meta copyWithWrapped({Wrapped<Meta$Pagination>? pagination}) {
    return Meta(
        pagination: (pagination != null ? pagination.value : this.pagination));
  }
}

@JsonSerializable(explicitToJson: true)
class ObjectLink {
  const ObjectLink({
    required this.self,
  });

  factory ObjectLink.fromJson(Map<String, dynamic> json) =>
      _$ObjectLinkFromJson(json);

  static const toJsonFactory = _$ObjectLinkToJson;
  Map<String, dynamic> toJson() => _$ObjectLinkToJson(this);

  @JsonKey(name: 'self', includeIfNull: false)
  final String self;
  static const fromJsonFactory = _$ObjectLinkFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectLinkExtension on ObjectLink {
  ObjectLink copyWith({String? self}) {
    return ObjectLink(self: self ?? this.self);
  }

  ObjectLink copyWithWrapped({Wrapped<String>? self}) {
    return ObjectLink(self: (self != null ? self.value : this.self));
  }
}

@JsonSerializable(explicitToJson: true)
class PageLink {
  const PageLink({
    required this.self,
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) =>
      _$PageLinkFromJson(json);

  static const toJsonFactory = _$PageLinkToJson;
  Map<String, dynamic> toJson() => _$PageLinkToJson(this);

  @JsonKey(name: 'self', includeIfNull: false)
  final String self;
  @JsonKey(name: 'first', includeIfNull: false)
  final String first;
  @JsonKey(name: 'next', includeIfNull: false)
  final String next;
  @JsonKey(name: 'prev', includeIfNull: false)
  final String prev;
  @JsonKey(name: 'last', includeIfNull: false)
  final String last;
  static const fromJsonFactory = _$PageLinkFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PageLinkExtension on PageLink {
  PageLink copyWith(
      {String? self, String? first, String? next, String? prev, String? last}) {
    return PageLink(
        self: self ?? this.self,
        first: first ?? this.first,
        next: next ?? this.next,
        prev: prev ?? this.prev,
        last: last ?? this.last);
  }

  PageLink copyWithWrapped(
      {Wrapped<String>? self,
      Wrapped<String>? first,
      Wrapped<String>? next,
      Wrapped<String>? prev,
      Wrapped<String>? last}) {
    return PageLink(
        self: (self != null ? self.value : this.self),
        first: (first != null ? first.value : this.first),
        next: (next != null ? next.value : this.next),
        prev: (prev != null ? prev.value : this.prev),
        last: (last != null ? last.value : this.last));
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction {
  const Transaction({
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.groupTitle,
    required this.transactions,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  static const toJsonFactory = _$TransactionToJson;
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', includeIfNull: false)
  final DateTime updatedAt;
  @JsonKey(name: 'user', includeIfNull: false)
  final String user;
  @JsonKey(name: 'group_title', includeIfNull: false)
  final String? groupTitle;
  @JsonKey(
      name: 'transactions',
      includeIfNull: false,
      defaultValue: <TransactionSplit>[])
  final List<TransactionSplit> transactions;
  static const fromJsonFactory = _$TransactionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionExtension on Transaction {
  Transaction copyWith(
      {DateTime? createdAt,
      DateTime? updatedAt,
      String? user,
      String? groupTitle,
      List<TransactionSplit>? transactions}) {
    return Transaction(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        groupTitle: groupTitle ?? this.groupTitle,
        transactions: transactions ?? this.transactions);
  }

  Transaction copyWithWrapped(
      {Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<String>? user,
      Wrapped<String?>? groupTitle,
      Wrapped<List<TransactionSplit>>? transactions}) {
    return Transaction(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        user: (user != null ? user.value : this.user),
        groupTitle: (groupTitle != null ? groupTitle.value : this.groupTitle),
        transactions:
            (transactions != null ? transactions.value : this.transactions));
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionSplit {
  const TransactionSplit({
    required this.user,
    required this.transactionJournalId,
    required this.type,
    required this.date,
    this.order,
    this.currencyId,
    this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyDecimalPlaces,
    this.foreignCurrencyId,
    this.foreignCurrencyCode,
    this.foreignCurrencySymbol,
    this.foreignCurrencyDecimalPlaces,
    required this.amount,
    this.foreignAmount,
    required this.description,
    required this.sourceId,
    this.sourceName,
    this.sourceIban,
    required this.sourceType,
    required this.destinationId,
    this.destinationName,
    this.destinationIban,
    required this.destinationType,
    this.budgetId,
    this.budgetName,
    this.categoryId,
    this.categoryName,
    this.billId,
    this.billName,
    required this.reconciled,
    this.notes,
    this.tags,
    this.internalReference,
    this.externalId,
    this.externalUrl,
    this.originalSource,
    this.recurrenceId,
    this.recurrenceTotal,
    this.recurrenceCount,
    this.bunqPaymentId,
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
    required this.hasAttachments,
  });

  factory TransactionSplit.fromJson(Map<String, dynamic> json) =>
      _$TransactionSplitFromJson(json);

  static const toJsonFactory = _$TransactionSplitToJson;
  Map<String, dynamic> toJson() => _$TransactionSplitToJson(this);

  @JsonKey(name: 'user', includeIfNull: false)
  final String user;
  @JsonKey(name: 'transaction_journal_id', includeIfNull: false)
  final String transactionJournalId;
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
  @JsonKey(name: 'currency_id', includeIfNull: false)
  final String? currencyId;
  @JsonKey(name: 'currency_code', includeIfNull: false)
  final String? currencyCode;
  @JsonKey(name: 'currency_symbol', includeIfNull: false)
  final String currencySymbol;
  @JsonKey(name: 'currency_name', includeIfNull: false)
  final String currencyName;
  @JsonKey(name: 'currency_decimal_places', includeIfNull: false)
  final int currencyDecimalPlaces;
  @JsonKey(name: 'foreign_currency_id', includeIfNull: false)
  final String? foreignCurrencyId;
  @JsonKey(name: 'foreign_currency_code', includeIfNull: false)
  final String? foreignCurrencyCode;
  @JsonKey(name: 'foreign_currency_symbol', includeIfNull: false)
  final String? foreignCurrencySymbol;
  @JsonKey(name: 'foreign_currency_decimal_places', includeIfNull: false)
  final int? foreignCurrencyDecimalPlaces;
  @JsonKey(name: 'amount', includeIfNull: false)
  final String amount;
  @JsonKey(name: 'foreign_amount', includeIfNull: false)
  final String? foreignAmount;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'source_id', includeIfNull: false)
  final String sourceId;
  @JsonKey(name: 'source_name', includeIfNull: false)
  final String? sourceName;
  @JsonKey(name: 'source_iban', includeIfNull: false)
  final String? sourceIban;
  @JsonKey(
    name: 'source_type',
    includeIfNull: false,
    toJson: accountTypePropertyToJson,
    fromJson: accountTypePropertyFromJson,
  )
  final enums.AccountTypeProperty sourceType;
  @JsonKey(name: 'destination_id', includeIfNull: false)
  final String destinationId;
  @JsonKey(name: 'destination_name', includeIfNull: false)
  final String? destinationName;
  @JsonKey(name: 'destination_iban', includeIfNull: false)
  final String? destinationIban;
  @JsonKey(
    name: 'destination_type',
    includeIfNull: false,
    toJson: accountTypePropertyToJson,
    fromJson: accountTypePropertyFromJson,
  )
  final enums.AccountTypeProperty destinationType;
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
  final bool reconciled;
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
  final int? recurrenceId;
  @JsonKey(name: 'recurrence_total', includeIfNull: false)
  final int? recurrenceTotal;
  @JsonKey(name: 'recurrence_count', includeIfNull: false)
  final int? recurrenceCount;
  @JsonKey(name: 'bunq_payment_id', includeIfNull: false)
  final String? bunqPaymentId;
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
  final bool hasAttachments;
  static const fromJsonFactory = _$TransactionSplitFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $TransactionSplitExtension on TransactionSplit {
  TransactionSplit copyWith(
      {String? user,
      String? transactionJournalId,
      enums.TransactionTypeProperty? type,
      DateTime? date,
      int? order,
      String? currencyId,
      String? currencyCode,
      String? currencySymbol,
      String? currencyName,
      int? currencyDecimalPlaces,
      String? foreignCurrencyId,
      String? foreignCurrencyCode,
      String? foreignCurrencySymbol,
      int? foreignCurrencyDecimalPlaces,
      String? amount,
      String? foreignAmount,
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
      int? recurrenceId,
      int? recurrenceTotal,
      int? recurrenceCount,
      String? bunqPaymentId,
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
      bool? hasAttachments}) {
    return TransactionSplit(
        user: user ?? this.user,
        transactionJournalId: transactionJournalId ?? this.transactionJournalId,
        type: type ?? this.type,
        date: date ?? this.date,
        order: order ?? this.order,
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
        amount: amount ?? this.amount,
        foreignAmount: foreignAmount ?? this.foreignAmount,
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
        bunqPaymentId: bunqPaymentId ?? this.bunqPaymentId,
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
        hasAttachments: hasAttachments ?? this.hasAttachments);
  }

  TransactionSplit copyWithWrapped(
      {Wrapped<String>? user,
      Wrapped<String>? transactionJournalId,
      Wrapped<enums.TransactionTypeProperty>? type,
      Wrapped<DateTime>? date,
      Wrapped<int?>? order,
      Wrapped<String?>? currencyId,
      Wrapped<String?>? currencyCode,
      Wrapped<String>? currencySymbol,
      Wrapped<String>? currencyName,
      Wrapped<int>? currencyDecimalPlaces,
      Wrapped<String?>? foreignCurrencyId,
      Wrapped<String?>? foreignCurrencyCode,
      Wrapped<String?>? foreignCurrencySymbol,
      Wrapped<int?>? foreignCurrencyDecimalPlaces,
      Wrapped<String>? amount,
      Wrapped<String?>? foreignAmount,
      Wrapped<String>? description,
      Wrapped<String>? sourceId,
      Wrapped<String?>? sourceName,
      Wrapped<String?>? sourceIban,
      Wrapped<enums.AccountTypeProperty>? sourceType,
      Wrapped<String>? destinationId,
      Wrapped<String?>? destinationName,
      Wrapped<String?>? destinationIban,
      Wrapped<enums.AccountTypeProperty>? destinationType,
      Wrapped<String?>? budgetId,
      Wrapped<String?>? budgetName,
      Wrapped<String?>? categoryId,
      Wrapped<String?>? categoryName,
      Wrapped<String?>? billId,
      Wrapped<String?>? billName,
      Wrapped<bool>? reconciled,
      Wrapped<String?>? notes,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? internalReference,
      Wrapped<String?>? externalId,
      Wrapped<String?>? externalUrl,
      Wrapped<String?>? originalSource,
      Wrapped<int?>? recurrenceId,
      Wrapped<int?>? recurrenceTotal,
      Wrapped<int?>? recurrenceCount,
      Wrapped<String?>? bunqPaymentId,
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
      Wrapped<bool>? hasAttachments}) {
    return TransactionSplit(
        user: (user != null ? user.value : this.user),
        transactionJournalId: (transactionJournalId != null
            ? transactionJournalId.value
            : this.transactionJournalId),
        type: (type != null ? type.value : this.type),
        date: (date != null ? date.value : this.date),
        order: (order != null ? order.value : this.order),
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
        amount: (amount != null ? amount.value : this.amount),
        foreignAmount:
            (foreignAmount != null ? foreignAmount.value : this.foreignAmount),
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
        bunqPaymentId:
            (bunqPaymentId != null ? bunqPaymentId.value : this.bunqPaymentId),
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
            (invoiceDate != null ? invoiceDate.value : this.invoiceDate),
        latitude: (latitude != null ? latitude.value : this.latitude),
        longitude: (longitude != null ? longitude.value : this.longitude),
        zoomLevel: (zoomLevel != null ? zoomLevel.value : this.zoomLevel),
        hasAttachments: (hasAttachments != null
            ? hasAttachments.value
            : this.hasAttachments));
  }
}

@JsonSerializable(explicitToJson: true)
class BadRequest {
  const BadRequest({
    required this.message,
    required this.exception,
  });

  factory BadRequest.fromJson(Map<String, dynamic> json) =>
      _$BadRequestFromJson(json);

  static const toJsonFactory = _$BadRequestToJson;
  Map<String, dynamic> toJson() => _$BadRequestToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String exception;
  static const fromJsonFactory = _$BadRequestFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $BadRequestExtension on BadRequest {
  BadRequest copyWith({String? message, String? exception}) {
    return BadRequest(
        message: message ?? this.message,
        exception: exception ?? this.exception);
  }

  BadRequest copyWithWrapped(
      {Wrapped<String>? message, Wrapped<String>? exception}) {
    return BadRequest(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class InternalException {
  const InternalException({
    required this.message,
    required this.exception,
  });

  factory InternalException.fromJson(Map<String, dynamic> json) =>
      _$InternalExceptionFromJson(json);

  static const toJsonFactory = _$InternalExceptionToJson;
  Map<String, dynamic> toJson() => _$InternalExceptionToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String exception;
  static const fromJsonFactory = _$InternalExceptionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $InternalExceptionExtension on InternalException {
  InternalException copyWith({String? message, String? exception}) {
    return InternalException(
        message: message ?? this.message,
        exception: exception ?? this.exception);
  }

  InternalException copyWithWrapped(
      {Wrapped<String>? message, Wrapped<String>? exception}) {
    return InternalException(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class NotFound {
  const NotFound({
    required this.message,
    required this.exception,
  });

  factory NotFound.fromJson(Map<String, dynamic> json) =>
      _$NotFoundFromJson(json);

  static const toJsonFactory = _$NotFoundToJson;
  Map<String, dynamic> toJson() => _$NotFoundToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String exception;
  static const fromJsonFactory = _$NotFoundFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $NotFoundExtension on NotFound {
  NotFound copyWith({String? message, String? exception}) {
    return NotFound(
        message: message ?? this.message,
        exception: exception ?? this.exception);
  }

  NotFound copyWithWrapped(
      {Wrapped<String>? message, Wrapped<String>? exception}) {
    return NotFound(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class Unauthenticated {
  const Unauthenticated({
    required this.message,
    required this.exception,
  });

  factory Unauthenticated.fromJson(Map<String, dynamic> json) =>
      _$UnauthenticatedFromJson(json);

  static const toJsonFactory = _$UnauthenticatedToJson;
  Map<String, dynamic> toJson() => _$UnauthenticatedToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String exception;
  static const fromJsonFactory = _$UnauthenticatedFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $UnauthenticatedExtension on Unauthenticated {
  Unauthenticated copyWith({String? message, String? exception}) {
    return Unauthenticated(
        message: message ?? this.message,
        exception: exception ?? this.exception);
  }

  Unauthenticated copyWithWrapped(
      {Wrapped<String>? message, Wrapped<String>? exception}) {
    return Unauthenticated(
        message: (message != null ? message.value : this.message),
        exception: (exception != null ? exception.value : this.exception));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationError {
  const ValidationError({
    required this.message,
    required this.errors,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  static const toJsonFactory = _$ValidationErrorToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'errors', includeIfNull: false)
  final ValidationError$Errors errors;
  static const fromJsonFactory = _$ValidationErrorFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ValidationErrorExtension on ValidationError {
  ValidationError copyWith({String? message, ValidationError$Errors? errors}) {
    return ValidationError(
        message: message ?? this.message, errors: errors ?? this.errors);
  }

  ValidationError copyWithWrapped(
      {Wrapped<String>? message, Wrapped<ValidationError$Errors>? errors}) {
    return ValidationError(
        message: (message != null ? message.value : this.message),
        errors: (errors != null ? errors.value : this.errors));
  }
}

@JsonSerializable(explicitToJson: true)
class Meta$Pagination {
  const Meta$Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Meta$Pagination.fromJson(Map<String, dynamic> json) =>
      _$Meta$PaginationFromJson(json);

  static const toJsonFactory = _$Meta$PaginationToJson;
  Map<String, dynamic> toJson() => _$Meta$PaginationToJson(this);

  @JsonKey(name: 'total', includeIfNull: false)
  final int total;
  @JsonKey(name: 'count', includeIfNull: false)
  final int count;
  @JsonKey(name: 'per_page', includeIfNull: false)
  final int perPage;
  @JsonKey(name: 'current_page', includeIfNull: false)
  final int currentPage;
  @JsonKey(name: 'total_pages', includeIfNull: false)
  final int totalPages;
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
      {Wrapped<int>? total,
      Wrapped<int>? count,
      Wrapped<int>? perPage,
      Wrapped<int>? currentPage,
      Wrapped<int>? totalPages}) {
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
class ValidationError$Errors {
  const ValidationError$Errors({
    required this.email,
    required this.blocked,
    required this.role,
    required this.blockedCode,
    required this.name,
    required this.type,
    required this.iban,
    required this.start,
    required this.end,
    required this.date,
  });

  factory ValidationError$Errors.fromJson(Map<String, dynamic> json) =>
      _$ValidationError$ErrorsFromJson(json);

  static const toJsonFactory = _$ValidationError$ErrorsToJson;
  Map<String, dynamic> toJson() => _$ValidationError$ErrorsToJson(this);

  @JsonKey(name: 'email', includeIfNull: false, defaultValue: <String>[])
  final List<String> email;
  @JsonKey(name: 'blocked', includeIfNull: false, defaultValue: <String>[])
  final List<String> blocked;
  @JsonKey(name: 'role', includeIfNull: false, defaultValue: <String>[])
  final List<String> role;
  @JsonKey(name: 'blocked_code', includeIfNull: false, defaultValue: <String>[])
  final List<String> blockedCode;
  @JsonKey(name: 'name', includeIfNull: false, defaultValue: <String>[])
  final List<String> name;
  @JsonKey(name: 'type', includeIfNull: false, defaultValue: <String>[])
  final List<String> type;
  @JsonKey(name: 'iban', includeIfNull: false, defaultValue: <String>[])
  final List<String> iban;
  @JsonKey(name: 'start', includeIfNull: false, defaultValue: <String>[])
  final List<String> start;
  @JsonKey(name: 'end', includeIfNull: false, defaultValue: <String>[])
  final List<String> end;
  @JsonKey(name: 'date', includeIfNull: false, defaultValue: <String>[])
  final List<String> date;
  static const fromJsonFactory = _$ValidationError$ErrorsFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ValidationError$ErrorsExtension on ValidationError$Errors {
  ValidationError$Errors copyWith(
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
    return ValidationError$Errors(
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

  ValidationError$Errors copyWithWrapped(
      {Wrapped<List<String>>? email,
      Wrapped<List<String>>? blocked,
      Wrapped<List<String>>? role,
      Wrapped<List<String>>? blockedCode,
      Wrapped<List<String>>? name,
      Wrapped<List<String>>? type,
      Wrapped<List<String>>? iban,
      Wrapped<List<String>>? start,
      Wrapped<List<String>>? end,
      Wrapped<List<String>>? date}) {
    return ValidationError$Errors(
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

String? creditCardTypeNullableToJson(enums.CreditCardType? creditCardType) {
  return creditCardType?.value;
}

String? creditCardTypeToJson(enums.CreditCardType creditCardType) {
  return creditCardType.value;
}

enums.CreditCardType creditCardTypeFromJson(
  Object? creditCardType, [
  enums.CreditCardType? defaultValue,
]) {
  return enums.CreditCardType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          creditCardType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.CreditCardType.swaggerGeneratedUnknown;
}

enums.CreditCardType? creditCardTypeNullableFromJson(
  Object? creditCardType, [
  enums.CreditCardType? defaultValue,
]) {
  if (creditCardType == null) {
    return null;
  }
  return enums.CreditCardType.values
          .firstWhereOrNull((e) => e.value == creditCardType) ??
      defaultValue;
}

List<String> creditCardTypeListToJson(
    List<enums.CreditCardType>? creditCardType) {
  if (creditCardType == null) {
    return [];
  }

  return creditCardType.map((e) => e.value!).toList();
}

List<enums.CreditCardType> creditCardTypeListFromJson(
  List? creditCardType, [
  List<enums.CreditCardType>? defaultValue,
]) {
  if (creditCardType == null) {
    return defaultValue ?? [];
  }

  return creditCardType
      .map((e) => creditCardTypeFromJson(e.toString()))
      .toList();
}

List<enums.CreditCardType>? creditCardTypeNullableListFromJson(
  List? creditCardType, [
  List<enums.CreditCardType>? defaultValue,
]) {
  if (creditCardType == null) {
    return defaultValue;
  }

  return creditCardType
      .map((e) => creditCardTypeFromJson(e.toString()))
      .toList();
}

String? interestPeriodNullableToJson(enums.InterestPeriod? interestPeriod) {
  return interestPeriod?.value;
}

String? interestPeriodToJson(enums.InterestPeriod interestPeriod) {
  return interestPeriod.value;
}

enums.InterestPeriod interestPeriodFromJson(
  Object? interestPeriod, [
  enums.InterestPeriod? defaultValue,
]) {
  return enums.InterestPeriod.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          interestPeriod?.toString().toLowerCase()) ??
      defaultValue ??
      enums.InterestPeriod.swaggerGeneratedUnknown;
}

enums.InterestPeriod? interestPeriodNullableFromJson(
  Object? interestPeriod, [
  enums.InterestPeriod? defaultValue,
]) {
  if (interestPeriod == null) {
    return null;
  }
  return enums.InterestPeriod.values
          .firstWhereOrNull((e) => e.value == interestPeriod) ??
      defaultValue;
}

List<String> interestPeriodListToJson(
    List<enums.InterestPeriod>? interestPeriod) {
  if (interestPeriod == null) {
    return [];
  }

  return interestPeriod.map((e) => e.value!).toList();
}

List<enums.InterestPeriod> interestPeriodListFromJson(
  List? interestPeriod, [
  List<enums.InterestPeriod>? defaultValue,
]) {
  if (interestPeriod == null) {
    return defaultValue ?? [];
  }

  return interestPeriod
      .map((e) => interestPeriodFromJson(e.toString()))
      .toList();
}

List<enums.InterestPeriod>? interestPeriodNullableListFromJson(
  List? interestPeriod, [
  List<enums.InterestPeriod>? defaultValue,
]) {
  if (interestPeriod == null) {
    return defaultValue;
  }

  return interestPeriod
      .map((e) => interestPeriodFromJson(e.toString()))
      .toList();
}

String? liabilityDirectionNullableToJson(
    enums.LiabilityDirection? liabilityDirection) {
  return liabilityDirection?.value;
}

String? liabilityDirectionToJson(enums.LiabilityDirection liabilityDirection) {
  return liabilityDirection.value;
}

enums.LiabilityDirection liabilityDirectionFromJson(
  Object? liabilityDirection, [
  enums.LiabilityDirection? defaultValue,
]) {
  return enums.LiabilityDirection.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          liabilityDirection?.toString().toLowerCase()) ??
      defaultValue ??
      enums.LiabilityDirection.swaggerGeneratedUnknown;
}

enums.LiabilityDirection? liabilityDirectionNullableFromJson(
  Object? liabilityDirection, [
  enums.LiabilityDirection? defaultValue,
]) {
  if (liabilityDirection == null) {
    return null;
  }
  return enums.LiabilityDirection.values
          .firstWhereOrNull((e) => e.value == liabilityDirection) ??
      defaultValue;
}

List<String> liabilityDirectionListToJson(
    List<enums.LiabilityDirection>? liabilityDirection) {
  if (liabilityDirection == null) {
    return [];
  }

  return liabilityDirection.map((e) => e.value!).toList();
}

List<enums.LiabilityDirection> liabilityDirectionListFromJson(
  List? liabilityDirection, [
  List<enums.LiabilityDirection>? defaultValue,
]) {
  if (liabilityDirection == null) {
    return defaultValue ?? [];
  }

  return liabilityDirection
      .map((e) => liabilityDirectionFromJson(e.toString()))
      .toList();
}

List<enums.LiabilityDirection>? liabilityDirectionNullableListFromJson(
  List? liabilityDirection, [
  List<enums.LiabilityDirection>? defaultValue,
]) {
  if (liabilityDirection == null) {
    return defaultValue;
  }

  return liabilityDirection
      .map((e) => liabilityDirectionFromJson(e.toString()))
      .toList();
}

String? liabilityTypeNullableToJson(enums.LiabilityType? liabilityType) {
  return liabilityType?.value;
}

String? liabilityTypeToJson(enums.LiabilityType liabilityType) {
  return liabilityType.value;
}

enums.LiabilityType liabilityTypeFromJson(
  Object? liabilityType, [
  enums.LiabilityType? defaultValue,
]) {
  return enums.LiabilityType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          liabilityType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.LiabilityType.swaggerGeneratedUnknown;
}

enums.LiabilityType? liabilityTypeNullableFromJson(
  Object? liabilityType, [
  enums.LiabilityType? defaultValue,
]) {
  if (liabilityType == null) {
    return null;
  }
  return enums.LiabilityType.values
          .firstWhereOrNull((e) => e.value == liabilityType) ??
      defaultValue;
}

List<String> liabilityTypeListToJson(List<enums.LiabilityType>? liabilityType) {
  if (liabilityType == null) {
    return [];
  }

  return liabilityType.map((e) => e.value!).toList();
}

List<enums.LiabilityType> liabilityTypeListFromJson(
  List? liabilityType, [
  List<enums.LiabilityType>? defaultValue,
]) {
  if (liabilityType == null) {
    return defaultValue ?? [];
  }

  return liabilityType.map((e) => liabilityTypeFromJson(e.toString())).toList();
}

List<enums.LiabilityType>? liabilityTypeNullableListFromJson(
  List? liabilityType, [
  List<enums.LiabilityType>? defaultValue,
]) {
  if (liabilityType == null) {
    return defaultValue;
  }

  return liabilityType.map((e) => liabilityTypeFromJson(e.toString())).toList();
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
