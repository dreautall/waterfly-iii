// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FireflyIii extends FireflyIii {
  _$FireflyIii([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FireflyIii;

  @override
  Future<Response<List<AutocompleteAccount>>> _v1AutocompleteAccountsGet({
    String? xTraceId,
    String? query,
    int? limit,
    String? date,
    List<Object?>? types,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
      'date': date,
      'types': types?.join(","),
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
    return client
        .send<List<AutocompleteAccount>, AutocompleteAccount>($request);
  }

  @override
  Future<Response<List<AutocompleteBill>>> _v1AutocompleteBillsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/bills');
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
    return client.send<List<AutocompleteBill>, AutocompleteBill>($request);
  }

  @override
  Future<Response<List<AutocompleteBudget>>> _v1AutocompleteBudgetsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/budgets');
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
    return client.send<List<AutocompleteBudget>, AutocompleteBudget>($request);
  }

  @override
  Future<Response<List<AutocompleteCategory>>> _v1AutocompleteCategoriesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/categories');
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
    return client
        .send<List<AutocompleteCategory>, AutocompleteCategory>($request);
  }

  @override
  Future<Response<List<AutocompleteCurrency>>> _v1AutocompleteCurrenciesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/currencies');
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
    return client
        .send<List<AutocompleteCurrency>, AutocompleteCurrency>($request);
  }

  @override
  Future<Response<List<AutocompleteCurrencyCode>>>
      _v1AutocompleteCurrenciesWithCodeGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/currencies-with-code');
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
    return client.send<List<AutocompleteCurrencyCode>,
        AutocompleteCurrencyCode>($request);
  }

  @override
  Future<Response<List<AutocompleteObjectGroup>>>
      _v1AutocompleteObjectGroupsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/object-groups');
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
    return client
        .send<List<AutocompleteObjectGroup>, AutocompleteObjectGroup>($request);
  }

  @override
  Future<Response<List<AutocompletePiggy>>> _v1AutocompletePiggyBanksGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/piggy-banks');
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
    return client.send<List<AutocompletePiggy>, AutocompletePiggy>($request);
  }

  @override
  Future<Response<List<AutocompletePiggyBalance>>>
      _v1AutocompletePiggyBanksWithBalanceGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/piggy-banks-with-balance');
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
    return client.send<List<AutocompletePiggyBalance>,
        AutocompletePiggyBalance>($request);
  }

  @override
  Future<Response<List<AutocompleteRecurrence>>> _v1AutocompleteRecurringGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/recurring');
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
    return client
        .send<List<AutocompleteRecurrence>, AutocompleteRecurrence>($request);
  }

  @override
  Future<Response<List<AutocompleteRuleGroup>>> _v1AutocompleteRuleGroupsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/rule-groups');
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
    return client
        .send<List<AutocompleteRuleGroup>, AutocompleteRuleGroup>($request);
  }

  @override
  Future<Response<List<AutocompleteRule>>> _v1AutocompleteRulesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/rules');
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
    return client.send<List<AutocompleteRule>, AutocompleteRule>($request);
  }

  @override
  Future<Response<List<AutocompleteTag>>> _v1AutocompleteTagsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/tags');
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
    return client.send<List<AutocompleteTag>, AutocompleteTag>($request);
  }

  @override
  Future<Response<List<AutocompleteTransactionType>>>
      _v1AutocompleteTransactionTypesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/transaction-types');
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
    return client.send<List<AutocompleteTransactionType>,
        AutocompleteTransactionType>($request);
  }

  @override
  Future<Response<List<AutocompleteTransaction>>>
      _v1AutocompleteTransactionsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/transactions');
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
    return client
        .send<List<AutocompleteTransaction>, AutocompleteTransaction>($request);
  }

  @override
  Future<Response<List<AutocompleteTransactionID>>>
      _v1AutocompleteTransactionsWithIdGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/transactions-with-id');
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
    return client.send<List<AutocompleteTransactionID>,
        AutocompleteTransactionID>($request);
  }

  @override
  Future<Response<List<ChartDataSet>>> _v1ChartAccountOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v1/chart/account/overview');
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
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataBulkTransactionsPost(
      {required String? query}) {
    final Uri $url = Uri.parse('/v1/data/bulk/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{'query': query};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataDestroyDelete({
    String? xTraceId,
    required String? objects,
  }) {
    final Uri $url = Uri.parse('/v1/data/destroy');
    final Map<String, dynamic> $params = <String, dynamic>{'objects': objects};
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _v1DataExportAccountsGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportBillsGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/bills');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportBudgetsGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportCategoriesGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/categories');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportPiggyBanksGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/piggy-banks');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportRecurringGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/recurring');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportRulesGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/rules');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportTagsGet({
    String? xTraceId,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/tags');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportTransactionsGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? accounts,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/data/export/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts': accounts,
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
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataPurgeDelete({String? xTraceId}) {
    final Uri $url = Uri.parse('/v1/data/purge');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseExpenseGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/expense');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeRevenueGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/revenue');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTransferEntry>>> _v1InsightTransferAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client
        .send<List<InsightTransferEntry>, InsightTransferEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? bills,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/bill');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'bills[]': bills,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/no-bill');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseBudgetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? budgets,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/budget');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'budgets[]': budgets,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoBudgetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/no-budget');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightTransferCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightTransferTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
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
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/expense/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/income/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/insight/transfer/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1AccountsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<AttachmentArray>> _v1AccountsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1AccountsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}/piggy-banks');
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
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<AccountArray>> _v1AccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? date,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'date': date,
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
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsPost({
    String? xTraceId,
    required AccountStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/accounts');
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
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsIdGet({
    String? xTraceId,
    required String? id,
    String? date,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}');
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
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsIdPut({
    String? xTraceId,
    required String? id,
    required AccountUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1AccountsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1AttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsPost({
    String? xTraceId,
    required AttachmentStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/attachments');
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
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/attachments/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsIdPut({
    String? xTraceId,
    required String? id,
    required AttachmentUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/attachments/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1AttachmentsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/attachments/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _v1AttachmentsIdDownloadGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/attachments/${id}/download');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _v1AttachmentsIdUploadPost({
    String? xTraceId,
    required String? id,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/v1/attachments/${id}/upload');
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
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AvailableBudgetArray>> _v1AvailableBudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/available-budgets');
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
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<AvailableBudgetSingle>> _v1AvailableBudgetsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/available-budgets/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AvailableBudgetSingle, AvailableBudgetSingle>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1BillsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<RuleArray>> _v1BillsIdRulesGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}/rules');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1BillsIdTransactionsGet({
    String? xTraceId,
    required String? id,
    int? limit,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<BillArray>> _v1BillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/bills');
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
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsPost({
    String? xTraceId,
    required BillStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/bills');
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
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}');
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
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsIdPut({
    String? xTraceId,
    required String? id,
    required BillUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BillsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/bills/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1BudgetsIdLimitsLimitIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    required String? limitId,
    String? type,
  }) {
    final Uri $url =
        Uri.parse('/v1/budgets/${id}/limits/${limitId}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<BudgetLimitArray>> _v1BudgetsIdLimitsGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/limits');
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
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsPost({
    String? xTraceId,
    required String? id,
    required BudgetLimitStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/limits');
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
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdGet({
    String? xTraceId,
    required String? id,
    required int? limitId,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/limits/${limitId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdPut({
    String? xTraceId,
    required String? id,
    required String? limitId,
    required BudgetLimit? body,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/limits/${limitId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BudgetsIdLimitsLimitIdDelete({
    String? xTraceId,
    required String? id,
    required String? limitId,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/limits/${limitId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _v1BudgetLimitsGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/v1/budget-limits');
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
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1BudgetsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<AttachmentArray>> _v1BudgetsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<BudgetArray>> _v1BudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/budgets');
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
    return client.send<BudgetArray, BudgetArray>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsPost({
    String? xTraceId,
    required BudgetStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/budgets');
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
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}');
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
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsIdPut({
    String? xTraceId,
    required String? id,
    required BudgetUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BudgetsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/budgets/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1CategoriesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/categories/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<AttachmentArray>> _v1CategoriesIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/categories/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<CategoryArray>> _v1CategoriesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/categories');
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
    return client.send<CategoryArray, CategoryArray>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesPost({
    String? xTraceId,
    required Category? body,
  }) {
    final Uri $url = Uri.parse('/v1/categories');
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
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/categories/${id}');
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
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesIdPut({
    String? xTraceId,
    required String? id,
    required CategoryUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/categories/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1CategoriesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/categories/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1LinkTypesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/link-types/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<LinkTypeArray>> _v1LinkTypesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/link-types');
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
    return client.send<LinkTypeArray, LinkTypeArray>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesPost({
    String? xTraceId,
    required LinkType? body,
  }) {
    final Uri $url = Uri.parse('/v1/link-types');
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
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/link-types/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesIdPut({
    String? xTraceId,
    required String? id,
    required LinkTypeUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/link-types/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1LinkTypesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/link-types/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _v1TransactionLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-links');
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
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksPost({
    String? xTraceId,
    required TransactionLinkStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-links');
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
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-links/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionLinksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-links/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksIdPut({
    String? xTraceId,
    required String? id,
    required TransactionLinkUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-links/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1ObjectGroupsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups/${id}/piggy-banks');
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
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<BillArray>> _v1ObjectGroupsIdBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups/${id}/bills');
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
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<ObjectGroupArray>> _v1ObjectGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups');
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
    return client.send<ObjectGroupArray, ObjectGroupArray>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _v1ObjectGroupsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _v1ObjectGroupsIdPut({
    String? xTraceId,
    required String? id,
    required ObjectGroupUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1ObjectGroupsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/object-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _v1PiggyBanksIdEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks/${id}/events');
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
    return client.send<PiggyBankEventArray, PiggyBankEventArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1PiggyBanksIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1PiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks');
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
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksPost({
    String? xTraceId,
    required PiggyBankStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks');
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
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksIdPut({
    String? xTraceId,
    required String? id,
    required PiggyBankUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1PiggyBanksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/piggy-banks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1RecurrencesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<RecurrenceArray>> _v1RecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences');
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
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesPost({
    String? xTraceId,
    required RecurrenceStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences');
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
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesIdPut({
    String? xTraceId,
    required String? id,
    required RecurrenceUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RecurrencesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/recurrences/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleArray>> _v1RuleGroupsIdRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}/rules');
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
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1RuleGroupsIdTestGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    int? searchLimit,
    int? triggeredLimit,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}/test');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'start': start,
      'end': end,
      'search_limit': searchLimit,
      'triggered_limit': triggeredLimit,
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
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<dynamic>> _v1RuleGroupsIdTriggerPost({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}/trigger');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleGroupArray>> _v1RuleGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups');
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
    return client.send<RuleGroupArray, RuleGroupArray>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsPost({
    String? xTraceId,
    required RuleGroupStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups');
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
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsIdPut({
    String? xTraceId,
    required String? id,
    required RuleGroupUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RuleGroupsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/rule-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1RulesIdTestGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/rules/${id}/test');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
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
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<dynamic>> _v1RulesIdTriggerPost({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/v1/rules/${id}/trigger');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleArray>> _v1RulesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/rules');
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
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesPost({
    String? xTraceId,
    required RuleStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/rules');
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
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/rules/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesIdPut({
    String? xTraceId,
    required String? id,
    required RuleUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/rules/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RulesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/rules/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1TagsTagAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
  }) {
    final Uri $url = Uri.parse('/v1/tags/${tag}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1TagsTagTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/tags/${tag}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<TagArray>> _v1TagsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/tags');
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
    return client.send<TagArray, TagArray>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsPost({
    String? xTraceId,
    required TagModelStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/tags');
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
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsTagGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
  }) {
    final Uri $url = Uri.parse('/v1/tags/${tag}');
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
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsTagPut({
    String? xTraceId,
    required String? tag,
    required TagModelUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/tags/${tag}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TagsTagDelete({
    String? xTraceId,
    required String? tag,
  }) {
    final Uri $url = Uri.parse('/v1/tags/${tag}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccountArray>> _v1CurrenciesCodeAccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? date,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'date': date,
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
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AvailableBudgetArray>> _v1CurrenciesCodeAvailableBudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/available-budgets');
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
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<BillArray>> _v1CurrenciesCodeBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/bills');
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
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _v1CurrenciesCodeBudgetLimitsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/budget_limits');
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
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<RecurrenceArray>> _v1CurrenciesCodeRecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/recurrences');
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
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RuleArray>> _v1CurrenciesCodeRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/rules');
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
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1CurrenciesCodeTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<CurrencyArray>> _v1CurrenciesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/currencies');
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
    return client.send<CurrencyArray, CurrencyArray>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesPost({
    String? xTraceId,
    required CurrencyStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/currencies');
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
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeEnablePost({
    String? xTraceId,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/enable');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeDisablePost({
    String? xTraceId,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/disable');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeDefaultPost({
    String? xTraceId,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/default');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeGet({
    String? xTraceId,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodePut({
    String? xTraceId,
    required String? code,
    required Map<String, String> body,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _v1CurrenciesCodeDelete({
    String? xTraceId,
    required String? code,
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesDefaultGet({String? xTraceId}) {
    final Uri $url = Uri.parse('/v1/currencies/default');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _v1TransactionJournalsIdLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-journals/${id}/links');
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
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionJournalsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-journals/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionJournalsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transaction-journals/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1TransactionsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transactions/${id}/attachments');
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
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _v1TransactionsIdPiggyBankEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transactions/${id}/piggy-bank-events');
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
    return client.send<PiggyBankEventArray, PiggyBankEventArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1TransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/v1/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
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
  Future<Response<TransactionSingle>> _v1TransactionsPost({
    String? xTraceId,
    required TransactionStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/transactions');
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
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transactions/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionsIdPut({
    String? xTraceId,
    required String? id,
    required TransactionUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/transactions/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/transactions/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccountArray>> _v1SearchAccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
    String? type,
    required String? field,
  }) {
    final Uri $url = Uri.parse('/v1/search/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'query': query,
      'type': type,
      'field': field,
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
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1SearchTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
  }) {
    final Uri $url = Uri.parse('/v1/search/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'query': query,
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
  Future<Response<BasicSummary>> _v1SummaryBasicGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? currencyCode,
  }) {
    final Uri $url = Uri.parse('/v1/summary/basic');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'currency_code': currencyCode,
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
    return client.send<BasicSummary, BasicSummary>($request);
  }

  @override
  Future<Response<SystemInfo>> _v1AboutGet({String? xTraceId}) {
    final Uri $url = Uri.parse('/v1/about');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SystemInfo, SystemInfo>($request);
  }

  @override
  Future<Response<UserSingle>> _v1AboutUserGet({String? xTraceId}) {
    final Uri $url = Uri.parse('/v1/about/user');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<List<Configuration>>> _v1ConfigurationGet(
      {String? xTraceId}) {
    final Uri $url = Uri.parse('/v1/configuration');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<Configuration>, Configuration>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _v1ConfigurationNameGet({
    String? xTraceId,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/v1/configuration/${name}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _v1ConfigurationNamePut({
    String? xTraceId,
    required String? name,
    required ConfigurationUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/configuration/${name}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<CronResult>> _v1CronCliTokenGet({
    String? xTraceId,
    required String? cliToken,
    String? date,
    bool? force,
  }) {
    final Uri $url = Uri.parse('/v1/cron/${cliToken}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'date': date,
      'force': force,
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
    return client.send<CronResult, CronResult>($request);
  }

  @override
  Future<Response<UserArray>> _v1UsersGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/users');
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
    return client.send<UserArray, UserArray>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersPost({
    String? xTraceId,
    required User? body,
  }) {
    final Uri $url = Uri.parse('/v1/users');
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
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/users/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersIdPut({
    String? xTraceId,
    required String? id,
    required User? body,
  }) {
    final Uri $url = Uri.parse('/v1/users/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1UsersIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/users/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PreferenceArray>> _v1PreferencesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/preferences');
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
    return client.send<PreferenceArray, PreferenceArray>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v1PreferencesPost({
    String? xTraceId,
    required Preference? body,
  }) {
    final Uri $url = Uri.parse('/v1/preferences');
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
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v1PreferencesNameGet({
    String? xTraceId,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/v1/preferences/${name}');
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
  Future<Response<PreferenceSingle>> _v1PreferencesNamePut({
    String? xTraceId,
    required String? name,
    required PreferenceUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/preferences/${name}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<WebhookMessageArray>> _v1WebhooksIdMessagesGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}/messages');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<WebhookMessageArray, WebhookMessageArray>($request);
  }

  @override
  Future<Response<WebhookMessageSingle>> _v1WebhooksIdMessagesMessageIdGet({
    String? xTraceId,
    required String? id,
    required int? messageId,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}/messages/${messageId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<WebhookMessageSingle, WebhookMessageSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdMessagesMessageIdDelete({
    String? xTraceId,
    required String? id,
    required int? messageId,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}/messages/${messageId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<WebhookAttemptArray>>
      _v1WebhooksIdMessagesMessageIdAttemptsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    required int? messageId,
  }) {
    final Uri $url =
        Uri.parse('/v1/webhooks/${id}/messages/${messageId}/attempts');
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
    return client.send<WebhookAttemptArray, WebhookAttemptArray>($request);
  }

  @override
  Future<Response<WebhookAttemptSingle>>
      _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    String? xTraceId,
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    final Uri $url = Uri.parse(
        '/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<WebhookAttemptSingle, WebhookAttemptSingle>($request);
  }

  @override
  Future<Response<dynamic>>
      _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    String? xTraceId,
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    final Uri $url = Uri.parse(
        '/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdSubmitPost({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}/submit');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdTriggerTransactionTransactionIdPost({
    String? xTraceId,
    required String? id,
    required String? transactionId,
  }) {
    final Uri $url =
        Uri.parse('/v1/webhooks/${id}/trigger-transaction/${transactionId}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<WebhookArray>> _v1WebhooksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks');
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
    return client.send<WebhookArray, WebhookArray>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksPost({
    String? xTraceId,
    required WebhookStore? body,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks');
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
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksIdPut({
    String? xTraceId,
    required String? id,
    required WebhookUpdate? body,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/v1/webhooks/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
