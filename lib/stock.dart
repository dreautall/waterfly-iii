import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:stock/stock.dart';

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.enums.swagger.dart'
    as enums show TransactionTypeFilter;
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
      fetcher: Fetcher.ofFuture<String, List<String>>(
        (String id) {
          final _getOptions query = _getOptions.fromJson(jsonDecode(id));
          return api
              .v1TransactionsGet(
                xTraceId: query.xTraceId,
                page: query.page,
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
        },
      ),
      sourceOfTruth: _listSoT,
    );
    _getSearchStock = Stock<String, List<String>>(
      fetcher: Fetcher.ofFuture<String, List<String>>(
        (String id) {
          final _getOptions query = _getOptions.fromJson(jsonDecode(id));
          return api
              .v1SearchTransactionsGet(
                xTraceId: query.xTraceId,
                query: query.query,
                page: query.page,
              )
              .then<List<String>>(_onAPIValue);
        },
      ),
      sourceOfTruth: _listSoT,
    );
  }

  FutureOr<List<String>> _onAPIValue(Response<TransactionArray> response) {
    if (!response.isSuccessful || response.body == null) {
      throw Exception(response.error ?? "empty body");
    }
    for (TransactionRead element in response.body!.data) {
      _singleSoT.write(element.id, element);
    }
    return response.body!.data.map((TransactionRead e) => e.id).toList();
  }

  Future<List<TransactionRead>> get({
    String? xTraceId,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) async {
    return _getStock
        .get(jsonEncode(_getOptions(
          xTraceId: xTraceId,
          page: page,
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
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
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
  }) async {
    return _getSearchStock
        .get(jsonEncode(_getOptions(
          xTraceId: xTraceId,
          query: query,
          page: page,
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
  final String? start; // get, getAccount
  final String? end; // get, getAccount
  final enums.TransactionTypeFilter? type; // get, getAccount
  final String? id; // getAccount
  final int? limit; // getAccount
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
