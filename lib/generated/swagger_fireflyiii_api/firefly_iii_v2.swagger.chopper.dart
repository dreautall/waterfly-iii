// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii_v2.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
final class _$FireflyIiiV2 extends FireflyIiiV2 {
  _$FireflyIiiV2([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FireflyIiiV2;

  @override
  Future<Response<List<ChartDataSetV2>>> _v2ChartAccountDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/chart/account/dashboard');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<ChartDataSetV2>, ChartDataSetV2>($request);
  }

  @override
  Future<Response<List<ChartDataSetV2>>> _v2ChartBalanceBalanceGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required List<int>? accounts,
    required String? period,
  }) {
    final Uri $url = Uri.parse('/v2/chart/balance/balance');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
      'period': period,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<ChartDataSetV2>, ChartDataSetV2>($request);
  }

  @override
  Future<Response<TransactionArray>> _v2AccountsIdTransactionsGet({
    String? xTraceId,
    int? page,
    required String? id,
    int? limit,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v2/accounts/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'start': start,
      'end': end,
      'type': type,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BillsSumPaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/bills/sum/paid');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BillsSumUnpaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/bills/sum/unpaid');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<BudgetV2Array>> _v2BudgetsGet({
    String? xTraceId,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v2/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BudgetV2Array, BudgetV2Array>($request);
  }

  @override
  Future<Response<BudgetLimitV2Array>> _v2BudgetsIdLimitsGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/${id}/limits');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BudgetLimitV2Array, BudgetLimitV2Array>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BudgetsIdBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/${id}/budgeted');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'page': page,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BudgetsIdSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/${id}/spent');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'page': page,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BudgetsSumBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/sum/budgeted');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'page': page,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2BudgetsSumSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/sum/spent');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'page': page,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v2PreferencesNameGet({
    String? xTraceId,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/v2/preferences/${name}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2NetWorthGet({
    String? xTraceId,
    required String? date,
  }) {
    final Uri $url = Uri.parse('/v2/net-worth');
    final Map<String, dynamic> $params = <String, dynamic>{'date': date};
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<TransactionSum>, TransactionSum>($request);
  }
}
