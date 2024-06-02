// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _InsightClient implements InsightClient {
  _InsightClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<InsightGroupEntry>> insightExpenseExpense({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object1,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object1,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/expense',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightExpenseAsset({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object3,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object3,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/asset',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightIncomeRevenue({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object5,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object5,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/revenue',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightIncomeAsset({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object7,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object7,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/asset',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTransferEntry>> insightTransfers({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object9,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object9,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<InsightTransferEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/asset',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTransferEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightExpenseBill({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object11,
    List<int>? object13,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'bills[]': object11,
      r'accounts[]': object13,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/bill',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightExpenseNoBill({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object15,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object15,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/no-bill',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightExpenseBudget({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object17,
    List<int>? object19,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'budgets[]': object17,
      r'accounts[]': object19,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/budget',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightExpenseNoBudget({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object21,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object21,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/no-budget',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightExpenseCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object23,
    List<int>? object25,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'categories[]': object23,
      r'accounts[]': object25,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightExpenseNoCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object27,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object27,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/no-category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightIncomeCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object29,
    List<int>? object31,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'categories[]': object29,
      r'accounts[]': object31,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightIncomeNoCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object33,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object33,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/no-category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightTransferCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object35,
    List<int>? object37,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'categories[]': object35,
      r'accounts[]': object37,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightTransferNoCategory({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object39,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object39,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/no-category',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightExpenseTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object41,
    List<int>? object43,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'tags[]': object41,
      r'accounts[]': object43,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightExpenseNoTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object45,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object45,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/no-tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightIncomeTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object47,
    List<int>? object49,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'tags[]': object47,
      r'accounts[]': object49,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightIncomeNoTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object51,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object51,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/no-tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightGroupEntry>> insightTransferTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object53,
    List<int>? object55,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'tags[]': object53,
      r'accounts[]': object55,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightGroupEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightGroupEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightTransferNoTag({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object57,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object57,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/no-tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightExpenseTotal({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object59,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object59,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/expense/total',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightIncomeTotal({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object61,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object61,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/income/total',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InsightTotalEntry>> insightTransferTotal({
    required DateTime start,
    required DateTime end,
    String? xTraceId,
    List<int>? object63,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start.toIso8601String(),
      r'end': end.toIso8601String(),
      r'accounts[]': object63,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-Trace-Id': xTraceId};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<InsightTotalEntry>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/insight/transfer/total',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            InsightTotalEntry.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
