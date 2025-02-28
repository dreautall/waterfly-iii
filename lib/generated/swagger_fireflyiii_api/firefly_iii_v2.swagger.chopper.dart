// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii_v2.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FireflyIiiV2 extends FireflyIiiV2 {
  _$FireflyIiiV2([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FireflyIiiV2;

  @override
  Future<Response<List<AutocompleteAccountV2>>> _v2AutocompleteAccountsGet({
    String? xTraceId,
    String? query,
    int? limit,
    String? date,
    List<Object?>? types,
  }) {
    final Uri $url = Uri.parse('/v2/autocomplete/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
      'date': date,
      'types': types,
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
    return client.send<List<AutocompleteAccountV2>, AutocompleteAccountV2>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteTD>>>
  _v2AutocompleteTransactionDescriptionsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v2/autocomplete/transaction-descriptions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
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
    return client.send<List<AutocompleteTD>, AutocompleteTD>($request);
  }

  @override
  Future<Response<List<ChartDataSetV2>>> _v2ChartAccountDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? preselected,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v2/chart/account/dashboard');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'preselected': preselected,
      'accounts[]': accounts,
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
  Future<Response<List<ChartDataSetV2>>> _v2ChartBudgetDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/chart/budget/dashboard');
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
  Future<Response<List<ChartDataSetV2>>> _v2ChartCategoryDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/chart/category/dashboard');
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
  Future<Response<AccountV2Single>> _v2AccountsIdGet({
    String? xTraceId,
    String? date,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/accounts/${id}');
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
    return client.send<AccountV2Single, AccountV2Single>($request);
  }

  @override
  Future<Response<TransactionV2Array>> _v2AccountsIdTransactionsGet({
    String? xTraceId,
    int? page,
    int? limit,
    String? start,
    String? end,
    required String? id,
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
    return client.send<TransactionV2Array, TransactionV2Array>($request);
  }

  @override
  Future<Response<BudgetV2Array>> _v2BudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v2/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
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
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/${id}/budgeted');
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
  Future<Response<List<TransactionSum>>> _v2BudgetsIdSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/${id}/spent');
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
  Future<Response<List<TransactionSum>>> _v2BudgetsSumBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/sum/budgeted');
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
  Future<Response<List<TransactionSum>>> _v2BudgetsSumSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/budgets/sum/spent');
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
  Future<Response<CurrencyV2Array>> _v2CurrenciesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v2/currencies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
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
    return client.send<CurrencyV2Array, CurrencyV2Array>($request);
  }

  @override
  Future<Response<PiggyBankV2Array>> _v2PiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v2/piggy-banks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
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
    return client.send<PiggyBankV2Array, PiggyBankV2Array>($request);
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
  Future<Response<SubscriptionArray>> _v2SubscriptionsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v2/subscriptions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
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
    return client.send<SubscriptionArray, SubscriptionArray>($request);
  }

  @override
  Future<Response<SubscriptionSingle>> _v2SubscriptionsIdGet({
    String? xTraceId,
    String? start,
    String? end,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v2/subscriptions/${id}');
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
    return client.send<SubscriptionSingle, SubscriptionSingle>($request);
  }

  @override
  Future<Response<List<TransactionSum>>> _v2SubscriptionsSumPaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/subscriptions/sum/paid');
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
  Future<Response<List<TransactionSum>>> _v2SubscriptionsSumUnpaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/subscriptions/sum/unpaid');
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
  Future<Response<TransactionV2Array>> _v2TransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v2/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
    return client.send<TransactionV2Array, TransactionV2Array>($request);
  }

  @override
  Future<Response<TransactionV2Single>> _v2TransactionsPost({
    String? xTraceId,
    required TransactionV2Store? body,
  }) {
    final Uri $url = Uri.parse('/v2/transactions');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TransactionV2Single, TransactionV2Single>($request);
  }

  @override
  Future<Response<NetWorthArray>> _v2NetWorthGet({
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
    return client.send<NetWorthArray, NetWorthArray>($request);
  }

  @override
  Future<Response<BasicSummaryV2>> _v2SummaryBasicGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v2/summary/basic');
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
    return client.send<BasicSummaryV2, BasicSummaryV2>($request);
  }
}
