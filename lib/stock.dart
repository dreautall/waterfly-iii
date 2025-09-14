import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/stock.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.enums.swagger.dart'
    as enums
    show TransactionTypeFilter;
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class TransStock with ChangeNotifier {
  final FireflyIii api;

  late Stock<String, TransactionRead> _singleStock;

  late Stock<String, List<String>> _getStock;
  late Stock<String, List<String>> _getAccountStock;
  late Stock<String, List<String>> _getSearchStock;

  final CachedSourceOfTruth<String, TransactionRead> _singleSoT =
      CachedSourceOfTruth<String, TransactionRead>();
  final CachedSourceOfTruth<String, List<String>> _listSoT =
      CachedSourceOfTruth<String, List<String>>();

  TransStock(this.api) {
    _singleStock = Stock<String, TransactionRead>(
      fetcher: Fetcher.ofFuture<String, TransactionRead>(
        (String id) => api
            .v1TransactionsIdGet(id: id)
            .then((Response<TransactionSingle> value) => value.body!.data),
      ),
      sourceOfTruth: _singleSoT,
    );
    _getStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>((String id) {
        final _getOptions query = _getOptions.fromJson(jsonDecode(id));
        return api
            .v1TransactionsGet(
              xTraceId: query.xTraceId,
              page: query.page,
              limit: query.limit,
              start: query.start,
              end: query.end,
              type: query.type,
            )
            .then<List<String>>(_onAPIValue);
      }),
      sourceOfTruth: _listSoT,
    );
    _getAccountStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>((String id) {
        final _getOptions query = _getOptions.fromJson(jsonDecode(id));
        return api
            .v1AccountsIdTransactionsGet(
              xTraceId: query.xTraceId,
              id: query.id,
              page: query.page,
              limit: query.limit,
              start: query.start,
              end: query.end,
              type: query.type,
            )
            .then<List<String>>(_onAPIValue);
      }),
      sourceOfTruth: _listSoT,
    );
    _getSearchStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>((String id) {
        final _getOptions query = _getOptions.fromJson(jsonDecode(id));
        return api
            .v1SearchTransactionsGet(
              xTraceId: query.xTraceId,
              query: query.query,
              page: query.page,
              limit: query.limit,
            )
            .then<List<String>>(_onAPIValue);
      }),
      sourceOfTruth: _listSoT,
    );
  }

  FutureOr<List<String>> _onAPIValue(Response<TransactionArray> response) {
    if (!response.isSuccessful || response.body == null) {
      if (response.error != null && response.error.toString().isNotEmpty) {
        throw Exception("_onAPIValue() call not successful: ${response.error}");
      } else {
        throw Exception("_onAPIValue() call not successful: empty body/error");
      }
    }
    for (TransactionRead element in response.body!.data) {
      _singleSoT.write(element.id, element);
    }
    return response.body!.data.map((TransactionRead e) => e.id).toList();
  }

  Future<List<TransactionRead>> get({
    String? xTraceId,
    int? page,
    int? limit,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) async {
    return _getStock
        .get(
          jsonEncode(
            _getOptions(
              xTraceId: xTraceId,
              page: page,
              limit: limit,
              start: start,
              end: end,
              type: type,
            ),
          ),
        )
        .then(_onGetValue);
  }

  Future<List<TransactionRead>> getAccount({
    String? xTraceId,
    required String id,
    int? page,
    int? limit,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) async {
    return _getAccountStock
        .get(
          jsonEncode(
            _getOptions(
              xTraceId: xTraceId,
              id: id,
              page: page,
              limit: limit,
              start: start,
              end: end,
              type: type,
            ),
          ),
        )
        .then(_onGetValue);
  }

  Future<List<TransactionRead>> getSearch({
    String? xTraceId,
    required String? query,
    int? page,
    int? limit,
  }) async {
    return _getSearchStock
        .get(
          jsonEncode(
            _getOptions(
              xTraceId: xTraceId,
              query: query,
              page: page,
              limit: limit,
            ),
          ),
        )
        .then(_onGetValue);
  }

  FutureOr<List<TransactionRead>> _onGetValue(List<String> list) async {
    final List<TransactionRead> result = <TransactionRead>[];
    for (String element in list) {
      result.add(await _singleStock.get(element));
    }
    return result;
  }

  void clear() {
    _getStock.clearAll();
    _getAccountStock.clearAll();
    _getSearchStock.clearAll();
    notifyListeners();
  }

  Future<void> setTransaction(TransactionRead transaction) async {
    final TransactionRead? oldTransaction =
        await _singleSoT.reader(transaction.id).first;
    // if no old transaction (= new one) or date has changed, clear cache
    if (oldTransaction == null ||
        oldTransaction.attributes.transactions.first.date !=
            transaction.attributes.transactions.first.date) {
      clear();
    }

    return _singleSoT.write(transaction.id, transaction);
  }
}

// ignore: camel_case_types
class _getOptions {
  final String? xTraceId; // get, getAccount, getSearch
  final int? page; // get, getAccount, getSearch
  final String? start; // get, getAccount
  final String? end; // get, getAccount
  final enums.TransactionTypeFilter? type; // get, getAccount
  final String? id; // getAccount
  final int? limit; // get, getAccount, getSearch
  final String? query; // getSearch

  _getOptions({
    this.xTraceId,
    this.page,
    this.start,
    this.end,
    this.type,
    this.id,
    this.limit,
    this.query,
  });

  _getOptions.fromJson(Map<String, dynamic> json)
    : xTraceId = json['xTraceId'],
      page = json['page'],
      start = json['start'],
      end = json['end'],
      type = enums.TransactionTypeFilter.values.firstWhereOrNull(
        (enums.TransactionTypeFilter e) => e.name == json['type'],
      ),
      id = json['id'],
      limit = json['limit'],
      query = json['query'];

  Map<String, dynamic> toJson() => <String, dynamic>{
    'xTraceId': xTraceId,
    'page': page,
    'start': start,
    'end': end,
    'type': type?.name,
    'id': id,
    'limit': limit,
    'query': query,
  };
}

class CatStock {
  final FireflyIii api;
  final CurrencyRead defaultCurrency;

  late Stock<DateTime, CategoryArray> _stock;
  final CachedSourceOfTruth<DateTime, CategoryArray> _sot =
      CachedSourceOfTruth<DateTime, CategoryArray>();

  CatStock(this.api, this.defaultCurrency) {
    _stock = Stock<DateTime, CategoryArray>(
      fetcher: Fetcher.ofFuture<DateTime, CategoryArray>((DateTime t) async {
        final String startDate = DateFormat(
          'yyyy-MM-dd',
          'en_US',
        ).format(t.copyWith(day: 1));
        final String endDate = DateFormat('yyyy-MM-dd', 'en_US').format(t);

        final Response<InsightGroup> respIncomeCat = await api
            .v1InsightIncomeCategoryGet(start: startDate, end: endDate);
        if (!respIncomeCat.isSuccessful || respIncomeCat.body == null) {
          throw Exception(
            "[stock] Invalid v1InsightIncomeCategoryGet response: ${respIncomeCat.error}",
          );
        }
        final Response<InsightTotal> respIncomeNoCat = await api
            .v1InsightIncomeNoCategoryGet(start: startDate, end: endDate);
        if (!respIncomeNoCat.isSuccessful || respIncomeNoCat.body == null) {
          throw Exception(
            "[stock] Invalid v1InsightIncomeNoCategoryGet response: ${respIncomeNoCat.error}",
          );
        }
        final Response<InsightGroup> respExpenseCat = await api
            .v1InsightExpenseCategoryGet(start: startDate, end: endDate);
        if (!respExpenseCat.isSuccessful || respExpenseCat.body == null) {
          throw Exception(
            "[stock] Invalid v1InsightExpenseCategoryGet response: ${respExpenseCat.error}",
          );
        }
        final Response<InsightTotal> respExpenseNoCat = await api
            .v1InsightExpenseNoCategoryGet(start: startDate, end: endDate);
        if (!respExpenseNoCat.isSuccessful || respExpenseNoCat.body == null) {
          throw Exception(
            "[stock] Invalid v1InsightExpenseNoCategoryGet response: ${respExpenseNoCat.error}",
          );
        }

        final Map<String, CategoryRead> categories = <String, CategoryRead>{};
        for (InsightGroupEntry cat in respIncomeCat.body!) {
          if ((cat.id?.isEmpty ?? true) || (cat.name?.isEmpty ?? true)) {
            continue;
          }

          if (cat.currencyId != defaultCurrency.id) {
            continue;
          }
          if (!categories.containsKey(cat.id)) {
            categories[cat.id!] = CategoryRead(
              id: cat.id!,
              type: "categories",
              attributes: CategoryWithSum(
                name: cat.name!,
                spent: <ArrayEntryWithCurrencyAndSum>[],
                earned: <ArrayEntryWithCurrencyAndSum>[],
              ),
            );
          }
          categories[cat.id!]!.attributes.earned!.add(
            ArrayEntryWithCurrencyAndSum(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
        }
        for (InsightGroupEntry cat in respExpenseCat.body!) {
          if ((cat.id?.isEmpty ?? true) || (cat.name?.isEmpty ?? true)) {
            continue;
          }

          if (cat.currencyId != defaultCurrency.id) {
            continue;
          }
          if (!categories.containsKey(cat.id)) {
            categories[cat.id!] = CategoryRead(
              id: cat.id!,
              type: "categories",
              attributes: CategoryWithSum(
                name: cat.name!,
                spent: <ArrayEntryWithCurrencyAndSum>[],
                earned: <ArrayEntryWithCurrencyAndSum>[],
              ),
            );
          }
          categories[cat.id!]!.attributes.spent!.add(
            ArrayEntryWithCurrencyAndSum(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
        }
        for (InsightTotalEntry cat in respIncomeNoCat.body!) {
          if (cat.currencyId != defaultCurrency.id) {
            continue;
          }
          if (!categories.containsKey("-1")) {
            categories["-1"] = CategoryRead(
              id: "-1",
              type: "no-category",
              attributes: CategoryWithSum(
                name: "L10NNONE",
                spent: <ArrayEntryWithCurrencyAndSum>[],
                earned: <ArrayEntryWithCurrencyAndSum>[],
              ),
            );
          }
          categories["-1"]!.attributes.earned!.add(
            ArrayEntryWithCurrencyAndSum(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
        }
        for (InsightTotalEntry cat in respExpenseNoCat.body!) {
          if (cat.currencyId != defaultCurrency.id) {
            continue;
          }
          if (!categories.containsKey("-1")) {
            categories["-1"] = CategoryRead(
              id: "-1",
              type: "no-category",
              attributes: CategoryWithSum(
                name: "L10NNONE",
                spent: <ArrayEntryWithCurrencyAndSum>[],
                earned: <ArrayEntryWithCurrencyAndSum>[],
              ),
            );
          }
          categories["-1"]!.attributes.spent!.add(
            ArrayEntryWithCurrencyAndSum(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
        }

        categories.forEach((_, CategoryRead c) {
          final CategoryWithSum cs = c.attributes as CategoryWithSum;
          cs.sumEarned = c.attributes.earned!.fold<double>(
            0,
            (double p, ArrayEntryWithCurrencyAndSum e) =>
                p += double.parse(e.sum ?? "0"),
          );
          cs.sumSpent = c.attributes.spent!.fold<double>(
            0,
            (double p, ArrayEntryWithCurrencyAndSum e) =>
                p += double.parse(e.sum ?? "0"),
          );
        });

        return CategoryArray(
          data: categories.values.toList(growable: false),
          meta: const Meta(),
        );
      }),
      sourceOfTruth: _sot,
    );
  }

  Future<CategoryArray> get(DateTime t) => _stock.get(t);
  Future<void> reset() => _stock.clearAll();
}
