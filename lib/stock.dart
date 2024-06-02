import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock/stock.dart';
import 'package:waterflyiii/extensions.dart';

import 'package:waterflyiii/generated/api/v1/export.dart';

class TransStock with ChangeNotifier {
  final APIv1 api;

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
        (String id) => api.transactions
            .getTransaction(id: id)
            .then((TransactionSingle value) => value.data),
      ),
      sourceOfTruth: _singleSoT,
    );
    _getStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>(
        (String id) {
          final _getOptions query = _getOptions.fromJson(jsonDecode(id));
          return api.transactions
              .listTransaction(
                xTraceId: query.xTraceId,
                page: query.page,
                limit: query.limit,
                start: query.start,
                end: query.end,
                type: query.type,
              )
              .then<List<String>>(_onAPIValue);
        },
      ),
      sourceOfTruth: _listSoT,
    );
    _getAccountStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>(
        (String id) {
          final _getOptions query = _getOptions.fromJson(jsonDecode(id));
          return api.accounts
              .listTransactionByAccount(
                xTraceId: query.xTraceId,
                id: query.id!,
                page: query.page,
                limit: query.limit,
                start: query.start,
                end: query.end,
                type: query.type,
              )
              .then<List<String>>(_onAPIValue);
        },
      ),
      sourceOfTruth: _listSoT,
    );
    _getSearchStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>(
        (String id) {
          final _getOptions query = _getOptions.fromJson(jsonDecode(id));
          return api.search
              .searchTransactions(
                xTraceId: query.xTraceId,
                query: query.query!,
                page: query.page,
                limit: query.limit,
              )
              .then<List<String>>(_onAPIValue);
        },
      ),
      sourceOfTruth: _listSoT,
    );
  }

  FutureOr<List<String>> _onAPIValue(TransactionArray response) {
    /*
    if (!response.isSuccessful || response.body == null) {
      throw Exception(response.error ?? "empty body");
    }
    for (TransactionRead element in response.body!.data) {
      _singleSoT.write(element.id, element);
    }
    return response.body!.data.map((TransactionRead e) => e.id).toList();*/
    return response.data.map((TransactionRead e) => e.id).toList();
  }

  Future<List<TransactionRead>> get({
    String? xTraceId,
    int? page,
    int? limit,
    DateTime? start,
    DateTime? end,
    TransactionTypeFilter? type,
  }) async {
    return _getStock
        .get(jsonEncode(_getOptions(
          xTraceId: xTraceId,
          page: page,
          limit: limit,
          start: start,
          end: end,
          type: type,
        )))
        .then(_onGetValue);
  }

  Future<List<TransactionRead>> getAccount({
    String? xTraceId,
    required String id,
    int? page,
    int? limit,
    DateTime? start,
    DateTime? end,
    TransactionTypeFilter? type,
  }) async {
    return _getAccountStock
        .get(jsonEncode(_getOptions(
          xTraceId: xTraceId,
          id: id,
          page: page,
          limit: limit,
          start: start,
          end: end,
          type: type,
        )))
        .then(_onGetValue);
  }

  Future<List<TransactionRead>> getSearch({
    String? xTraceId,
    required String? query,
    int? page,
    int? limit,
  }) async {
    return _getSearchStock
        .get(jsonEncode(_getOptions(
          xTraceId: xTraceId,
          query: query,
          page: page,
          limit: limit,
        )))
        .then(_onGetValue);
  }

  FutureOr<List<TransactionRead>> _onGetValue(List<String> list) async {
    List<TransactionRead> result = <TransactionRead>[];
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
    TransactionRead? oldTransaction =
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
  final DateTime? start; // get, getAccount
  final DateTime? end; // get, getAccount
  final TransactionTypeFilter? type; // get, getAccount
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
        type = json['type'],
        id = json['id'],
        limit = json['limit'],
        query = json['query'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'xTraceId': xTraceId,
        'page': page,
        'start': start,
        'end': end,
        'type': type,
        'id': id,
        'limit': limit,
        'query': query,
      };
}

class CatStock {
  final APIv1 api;
  final CurrencyRead defaultCurrency;

  late Stock<DateTime, CategoryArray> _stock;
  final CachedSourceOfTruth<DateTime, CategoryArray> _sot =
      CachedSourceOfTruth<DateTime, CategoryArray>();

  CatStock(this.api, this.defaultCurrency) {
    _stock = Stock<DateTime, CategoryArray>(
      fetcher: Fetcher.ofFuture<DateTime, CategoryArray>(
        (DateTime t) async {
          final DateTime startDate = t.copyWith(day: 1);
          final DateTime endDate = t;

          final InsightGroup respIncomeCat =
              await api.insight.insightIncomeCategory(
            start: startDate,
            end: endDate,
          );
          /* if (!respIncomeCat.isSuccessful || respIncomeCat.body == null) {
            throw Exception(
              "[stock] Invalid API response: ${respIncomeCat.error}",
            );
          }*/
          final InsightTotal respIncomeNoCat =
              await api.insight.insightIncomeNoCategory(
            start: startDate,
            end: endDate,
          );
          /*
          if (!respIncomeNoCat.isSuccessful || respIncomeNoCat.body == null) {
            throw Exception(
              "[stock] Invalid API response: ${respIncomeNoCat.error}",
            );
          }
          */
          final InsightGroup respExpenseCat =
              await api.insight.insightExpenseCategory(
            start: startDate,
            end: endDate,
          );
          /*
          if (!respExpenseCat.isSuccessful || respExpenseCat.body == null) {
            throw Exception(
              "[stock] Invalid API response: ${respExpenseCat.error}",
            );
          }*/
          final InsightTotal respExpenseNoCat =
              await api.insight.insightExpenseNoCategory(
            start: startDate,
            end: endDate,
          );
          /*
          if (!respExpenseNoCat.isSuccessful || respExpenseNoCat.body == null) {
            throw Exception(
              "[stock] Invalid API response: ${respExpenseNoCat.error}",
            );
          }*/

          final Map<String, CategoryRead> categories = <String, CategoryRead>{};
          for (InsightGroupEntry cat in respIncomeCat) {
            if ((cat.id.isEmpty) || (cat.name.isEmpty)) {
              continue;
            }

            if (cat.currencyId != defaultCurrency.id) {
              continue;
            }
            if (!categories.containsKey(cat.id)) {
              categories[cat.id] = CategoryRead(
                id: cat.id,
                type: "categories",
                attributes: CategoryWithSum(
                  name: cat.name,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  spent: <CategorySpent>[],
                  earned: <CategoryEarned>[],
                ),
              );
            }
            categories[cat.id]!.attributes.earned.add(
                  CategoryEarned(
                    currencyId: cat.currencyId,
                    currencyCode: cat.currencyCode,
                    currencyDecimalPlaces:
                        defaultCurrency.attributes.decimalPlaces,
                    currencySymbol: defaultCurrency.attributes.symbol,
                    sum: cat.difference,
                  ),
                );
          }
          for (InsightGroupEntry cat in respExpenseCat) {
            if ((cat.id.isEmpty) || (cat.name.isEmpty)) {
              continue;
            }

            if (cat.currencyId != defaultCurrency.id) {
              continue;
            }
            if (!categories.containsKey(cat.id)) {
              categories[cat.id] = CategoryRead(
                id: cat.id,
                type: "categories",
                attributes: CategoryWithSum(
                  name: cat.name,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  spent: <CategorySpent>[],
                  earned: <CategoryEarned>[],
                ),
              );
            }
            categories[cat.id]!.attributes.spent.add(
                  CategorySpent(
                    currencyId: cat.currencyId,
                    currencyCode: cat.currencyCode,
                    currencyDecimalPlaces:
                        defaultCurrency.attributes.decimalPlaces,
                    currencySymbol: defaultCurrency.attributes.symbol,
                    sum: cat.difference,
                  ),
                );
          }
          for (InsightTotalEntry cat in respIncomeNoCat) {
            if (cat.currencyId != defaultCurrency.id) {
              continue;
            }
            if (!categories.containsKey("-1")) {
              categories["-1"] = CategoryRead(
                id: "-1",
                type: "no-category",
                attributes: CategoryWithSum(
                  name: "L10NNONE",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  spent: <CategorySpent>[],
                  earned: <CategoryEarned>[],
                ),
              );
            }
            categories["-1"]!.attributes.earned.add(
                  CategoryEarned(
                    currencyId: cat.currencyId,
                    currencyCode: cat.currencyCode,
                    currencyDecimalPlaces:
                        defaultCurrency.attributes.decimalPlaces,
                    currencySymbol: defaultCurrency.attributes.symbol,
                    sum: cat.difference,
                  ),
                );
          }
          for (InsightTotalEntry cat in respExpenseNoCat) {
            if (cat.currencyId != defaultCurrency.id) {
              continue;
            }
            if (!categories.containsKey("-1")) {
              categories["-1"] = CategoryRead(
                id: "-1",
                type: "no-category",
                attributes: CategoryWithSum(
                  name: "L10NNONE",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  spent: <CategorySpent>[],
                  earned: <CategoryEarned>[],
                ),
              );
            }
            categories["-1"]!.attributes.spent.add(
                  CategorySpent(
                    currencyId: cat.currencyId,
                    currencyCode: cat.currencyCode,
                    currencyDecimalPlaces:
                        defaultCurrency.attributes.decimalPlaces,
                    currencySymbol: defaultCurrency.attributes.symbol,
                    sum: cat.difference,
                  ),
                );
          }

          categories.forEach((_, CategoryRead c) {
            CategoryWithSum cs = c.attributes as CategoryWithSum;
            cs.sumEarned = c.attributes.earned.fold<double>(
                0, (double p, CategoryEarned e) => p += double.parse(e.sum));
            cs.sumSpent = c.attributes.spent.fold<double>(
                0, (double p, CategorySpent e) => p += double.parse(e.sum));
          });

          return CategoryArray(
            data: categories.values.toList(growable: false),
            meta: const Meta(
                pagination: Pagination(
              total: 0,
              count: 0,
              perPage: 0,
              currentPage: 0,
              totalPages: 0,
            )),
          );
        },
      ),
      sourceOfTruth: _sot,
    );
  }

  Future<CategoryArray> get(DateTime t) => _stock.get(t);
  Future<void> reset() => _stock.clearAll();
}
