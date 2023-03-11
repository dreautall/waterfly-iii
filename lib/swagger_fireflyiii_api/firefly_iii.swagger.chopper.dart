// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$FireflyIii extends FireflyIii {
  _$FireflyIii([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FireflyIii;

  @override
  Future<Response<List<AutocompleteRuleGroup>>>
      _apiV1AutocompleteRuleGroupsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/rule-groups');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteRuleGroup>, AutocompleteRuleGroup>($request);
  }

  @override
  Future<Response<List<AutocompleteCategory>>> _apiV1AutocompleteCategoriesGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/categories');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteCategory>, AutocompleteCategory>($request);
  }

  @override
  Future<Response<List<AutocompleteTransactionType>>>
      _apiV1AutocompleteTransactionTypesGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/transaction-types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteTransactionType>,
        AutocompleteTransactionType>($request);
  }

  @override
  Future<Response<List<AutocompleteObjectGroup>>>
      _apiV1AutocompleteObjectGroupsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/object-groups');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteObjectGroup>, AutocompleteObjectGroup>($request);
  }

  @override
  Future<Response<List<AutocompleteRule>>> _apiV1AutocompleteRulesGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/rules');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteRule>, AutocompleteRule>($request);
  }

  @override
  Future<Response<List<AutocompleteTransaction>>>
      _apiV1AutocompleteTransactionsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteTransaction>, AutocompleteTransaction>($request);
  }

  @override
  Future<Response<List<AutocompleteTransactionID>>>
      _apiV1AutocompleteTransactionsWithIdGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/transactions-with-id');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteTransactionID>,
        AutocompleteTransactionID>($request);
  }

  @override
  Future<Response<List<AutocompleteBudget>>> _apiV1AutocompleteBudgetsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteBudget>, AutocompleteBudget>($request);
  }

  @override
  Future<Response<List<AutocompletePiggy>>> _apiV1AutocompletePiggyBanksGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/piggy-banks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompletePiggy>, AutocompletePiggy>($request);
  }

  @override
  Future<Response<List<AutocompletePiggyBalance>>>
      _apiV1AutocompletePiggyBanksWithBalanceGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/piggy-banks-with-balance');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompletePiggyBalance>,
        AutocompletePiggyBalance>($request);
  }

  @override
  Future<Response<List<AutocompleteCurrency>>> _apiV1AutocompleteCurrenciesGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/currencies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteCurrency>, AutocompleteCurrency>($request);
  }

  @override
  Future<Response<List<AutocompleteCurrencyCode>>>
      _apiV1AutocompleteCurrenciesWithCodeGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/currencies-with-code');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteCurrencyCode>,
        AutocompleteCurrencyCode>($request);
  }

  @override
  Future<Response<List<AutocompleteAccount>>> _apiV1AutocompleteAccountsGet({
    String? query,
    int? limit,
    String? date,
    List<enums.AccountTypeFilter>? types,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
      'date': date,
      'types': types?.map((e) => e.value).join(','),
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteAccount>, AutocompleteAccount>($request);
  }

  @override
  Future<Response<List<AutocompleteTag>>> _apiV1AutocompleteTagsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/tags');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteTag>, AutocompleteTag>($request);
  }

  @override
  Future<Response<List<AutocompleteBill>>> _apiV1AutocompleteBillsGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/bills');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AutocompleteBill>, AutocompleteBill>($request);
  }

  @override
  Future<Response<List<AutocompleteRecurrence>>>
      _apiV1AutocompleteRecurringGet({
    String? query,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/autocomplete/recurring');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AutocompleteRecurrence>, AutocompleteRecurrence>($request);
  }

  @override
  Future<Response<List<ChartDataSet>>> _apiV1ChartAccountOverviewGet({
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/chart/account/overview');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportAccountsGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportBillsGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/bills');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportBudgetsGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportCategoriesGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/categories');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportPiggyBanksGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/piggy-banks');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportRecurringGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/recurring');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportRulesGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/rules');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportTagsGet({String? type}) {
    final Uri $url = Uri.parse('/api/v1/data/export/tags');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _apiV1DataExportTransactionsGet({
    required String? start,
    required String? end,
    String? accounts,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/data/export/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts': accounts,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1DataDestroyDelete(
      {required String? objects}) {
    final Uri $url = Uri.parse('/api/v1/data/destroy');
    final Map<String, dynamic> $params = <String, dynamic>{'objects': objects};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1DataBulkTransactionsPost(
      {required String? query}) {
    final Uri $url = Uri.parse('/api/v1/data/bulk/transactions');
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
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseBillGet({
    required String? start,
    required String? end,
    List<int>? bills,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/bill');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'bills[]': bills,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightExpenseNoBillGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/no-bill');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightExpenseTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightIncomeTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightTransferTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/total');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightExpenseNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightIncomeCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightIncomeNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightTransferCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'categories[]': categories,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightTransferNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/no-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseExpenseGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/expense');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightIncomeRevenueGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/revenue');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightIncomeAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTransferEntry>>> _apiV1InsightTransferAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/asset');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<InsightTransferEntry>, InsightTransferEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseBudgetGet({
    required String? start,
    required String? end,
    List<int>? budgets,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/budget');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'budgets[]': budgets,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightExpenseNoBudgetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/no-budget');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightExpenseTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightExpenseNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/expense/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightIncomeTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightIncomeNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/income/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _apiV1InsightTransferTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'tags[]': tags,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _apiV1InsightTransferNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/insight/transfer/no-tag');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<BasicSummary>> _apiV1SummaryBasicGet({
    required String? start,
    required String? end,
    String? currencyCode,
  }) {
    final Uri $url = Uri.parse('/api/v1/summary/basic');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'currency_code': currencyCode,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BasicSummary, BasicSummary>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1AttachmentsGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _apiV1AttachmentsPost(
      {required AttachmentStore? body}) {
    final Uri $url = Uri.parse('/api/v1/attachments');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _apiV1AttachmentsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/attachments/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _apiV1AttachmentsIdPut({
    required String? id,
    required AttachmentUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/attachments/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AttachmentsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/attachments/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _apiV1AttachmentsIdDownloadGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/attachments/${id}/download');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AttachmentsIdUploadPost({
    required String? id,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/attachments/${id}/upload');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1RulesIdTestGet({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/rules/${id}/test');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RulesIdTriggerPost({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/rules/${id}/trigger');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1BillsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<RuleArray>> _apiV1BillsIdRulesGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}/rules');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1BillsIdTransactionsGet({
    required String? id,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<BillArray>> _apiV1BillsGet({
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/bills');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<BillSingle>> _apiV1BillsPost({required BillStore? body}) {
    final Uri $url = Uri.parse('/api/v1/bills');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _apiV1BillsIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _apiV1BillsIdPut({
    required String? id,
    required BillUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BillsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/bills/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleArray>> _apiV1RulesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/rules');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<RuleSingle>> _apiV1RulesPost({required RuleStore? body}) {
    final Uri $url = Uri.parse('/api/v1/rules');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _apiV1RulesIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/rules/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _apiV1RulesIdPut({
    required String? id,
    required RuleUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/rules/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RulesIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/rules/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1TransactionsGet({
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TransactionSingle>> _apiV1TransactionsPost(
      {required TransactionStore? body}) {
    final Uri $url = Uri.parse('/api/v1/transactions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _apiV1TransactionsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transactions/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _apiV1TransactionsIdPut({
    required String? id,
    required TransactionUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/transactions/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1TransactionsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transactions/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ObjectGroupArray>> _apiV1ObjectGroupsGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/object_groups');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ObjectGroupArray, ObjectGroupArray>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _apiV1ObjectGroupsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/object_groups/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _apiV1ObjectGroupsIdPut({
    required String? id,
    required ObjectGroupUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/object_groups/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1ObjectGroupsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/object_groups/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1CategoriesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/categories/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TransactionArray>>
      _apiV1CategoriesTransactionsWithoutCategoryGet({
    int? limit,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/categories/transactions-without-category');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1CategoriesIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/categories/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<RecurrenceArray>> _apiV1RecurrencesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/recurrences');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _apiV1RecurrencesPost(
      {required RecurrenceStore? body}) {
    final Uri $url = Uri.parse('/api/v1/recurrences');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _apiV1RecurrencesIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/recurrences/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _apiV1RecurrencesIdPut({
    required String? id,
    required RecurrenceUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/recurrences/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RecurrencesIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/recurrences/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1TransactionsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/transactions/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _apiV1TransactionsIdPiggyBankEventsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/transactions/${id}/piggy_bank_events');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PiggyBankEventArray, PiggyBankEventArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1RecurrencesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/recurrences/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _apiV1PiggyBanksGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _apiV1PiggyBanksPost(
      {required PiggyBankStore? body}) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _apiV1PiggyBanksIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _apiV1PiggyBanksIdPut({
    required String? id,
    required PiggyBankUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1PiggyBanksIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencyArray>> _apiV1CurrenciesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/currencies');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CurrencyArray, CurrencyArray>($request);
  }

  @override
  Future<Response<CurrencySingle>> _apiV1CurrenciesPost(
      {required CurrencyStore? body}) {
    final Uri $url = Uri.parse('/api/v1/currencies');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1CurrenciesCodeEnablePost(
      {required String? code}) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/enable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1CurrenciesCodeDisablePost(
      {required int? code}) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/disable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1CurrenciesCodeDefaultPost(
      {required String? code}) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/default');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencySingle>> _apiV1CurrenciesCodeGet(
      {required String? code}) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _apiV1CurrenciesCodePut({
    required String? code,
    required CurrencyUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1CurrenciesCodeDelete(
      {required String? code}) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencySingle>> _apiV1CurrenciesDefaultGet() {
    final Uri $url = Uri.parse('/api/v1/currencies/default');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CategoryArray>> _apiV1CategoriesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/categories');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CategoryArray, CategoryArray>($request);
  }

  @override
  Future<Response<CategorySingle>> _apiV1CategoriesPost(
      {required Category? body}) {
    final Uri $url = Uri.parse('/api/v1/categories');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _apiV1CategoriesIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/categories/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _apiV1CategoriesIdPut({
    required String? id,
    required CategoryUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/categories/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1CategoriesIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/categories/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TagArray>> _apiV1TagsGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/tags');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TagArray, TagArray>($request);
  }

  @override
  Future<Response<TagSingle>> _apiV1TagsPost({required TagModelStore? body}) {
    final Uri $url = Uri.parse('/api/v1/tags');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _apiV1TagsTagGet({
    required String? tag,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/tags/${tag}');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _apiV1TagsTagPut({
    required String? tag,
    required TagModelUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/tags/${tag}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1TagsTagDelete({required String? tag}) {
    final Uri $url = Uri.parse('/api/v1/tags/${tag}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _apiV1TransactionJournalsIdLinksGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/transaction-journals/${id}/links');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionSingle>> _apiV1TransactionJournalsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transaction-journals/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1TransactionJournalsIdDelete(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transaction-journals/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccountArray>> _apiV1AccountsGet({
    int? page,
    String? date,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'date': date,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AccountSingle>> _apiV1AccountsPost(
      {required AccountStore? body}) {
    final Uri $url = Uri.parse('/api/v1/accounts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _apiV1AccountsIdGet({
    required String? id,
    String? date,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{'date': date};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _apiV1AccountsIdPut({
    required String? id,
    required AccountUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AccountsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccountArray>> _apiV1CurrenciesCodeAccountsGet({
    required String? code,
    int? page,
    String? date,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'date': date,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AvailableBudgetArray>>
      _apiV1CurrenciesCodeAvailableBudgetsGet({
    required String? code,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/available_budgets');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<BillArray>> _apiV1CurrenciesCodeBillsGet({
    required String? code,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/bills');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _apiV1CurrenciesCodeBudgetLimitsGet({
    required String? code,
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/budget_limits');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<RecurrenceArray>> _apiV1CurrenciesCodeRecurrencesGet({
    required String? code,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/recurrences');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RuleArray>> _apiV1CurrenciesCodeRulesGet({
    required String? code,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/rules');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1CurrenciesCodeTransactionsGet({
    required String? code,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/currencies/${code}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _apiV1BudgetsIdLimitsGet({
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/limits');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsPost({
    required String? id,
    required BudgetLimitStore? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/limits');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsLimitIdGet({
    required String? id,
    required int? limitId,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/limits/${limitId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsLimitIdPut({
    required String? id,
    required String? limitId,
    required BudgetLimit? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/limits/${limitId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BudgetsIdLimitsLimitIdDelete({
    required String? id,
    required String? limitId,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/limits/${limitId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _apiV1BudgetLimitsGet({
    required String? start,
    required String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/budget-limits');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<BudgetArray>> _apiV1BudgetsGet({
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BudgetArray, BudgetArray>($request);
  }

  @override
  Future<Response<BudgetSingle>> _apiV1BudgetsPost(
      {required BudgetStore? body}) {
    final Uri $url = Uri.parse('/api/v1/budgets');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _apiV1BudgetsIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _apiV1BudgetsIdPut({
    required String? id,
    required BudgetUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BudgetsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _apiV1PiggyBanksIdEventsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks/${id}/events');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PiggyBankEventArray, PiggyBankEventArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1PiggyBanksIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/piggy-banks/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<RuleArray>> _apiV1RuleGroupsIdRulesGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}/rules');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<RuleGroupArray>> _apiV1RuleGroupsGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/rule_groups');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RuleGroupArray, RuleGroupArray>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _apiV1RuleGroupsPost(
      {required RuleGroupStore? body}) {
    final Uri $url = Uri.parse('/api/v1/rule_groups');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _apiV1RuleGroupsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _apiV1RuleGroupsIdPut({
    required String? id,
    required RuleGroupUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RuleGroupsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1LinkTypesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/link_types/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AvailableBudgetArray>> _apiV1AvailableBudgetsGet({
    int? page,
    String? start,
    String? end,
  }) {
    final Uri $url = Uri.parse('/api/v1/available_budgets');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsPost(
      {required AvailableBudgetStore? body}) {
    final Uri $url = Uri.parse('/api/v1/available_budgets');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AvailableBudgetSingle, AvailableBudgetSingle>($request);
  }

  @override
  Future<Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/available_budgets/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AvailableBudgetSingle, AvailableBudgetSingle>($request);
  }

  @override
  Future<Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsIdPut({
    required String? id,
    required AvailableBudgetUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/available_budgets/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AvailableBudgetSingle, AvailableBudgetSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AvailableBudgetsIdDelete(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/available_budgets/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>>
      _apiV1BudgetsIdLimitsLimitIdTransactionsGet({
    required String? id,
    required String? limitId,
    int? page,
    String? type,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/budgets/${id}/limits/${limitId}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1TagsTagAttachmentsGet({
    required String? tag,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/tags/${tag}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1TagsTagTransactionsGet({
    required String? tag,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/tags/${tag}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1BudgetsIdTransactionsGet({
    required String? id,
    int? limit,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1BudgetsTransactionsWithoutBudgetGet({
    int? limit,
    int? page,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/transactions-without-budget');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1BudgetsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/budgets/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _apiV1ObjectGroupsIdPiggyBanksGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/object_groups/${id}/piggy_banks');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<BillArray>> _apiV1ObjectGroupsIdBillsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/object_groups/${id}/bills');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _apiV1TransactionLinksGet(
      {int? page}) {
    final Uri $url = Uri.parse('/api/v1/transaction_links');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _apiV1TransactionLinksPost(
      {required TransactionLinkStore? body}) {
    final Uri $url = Uri.parse('/api/v1/transaction_links');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _apiV1TransactionLinksIdGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transaction_links/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1TransactionLinksIdDelete(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/transaction_links/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _apiV1TransactionLinksIdPut({
    required String? id,
    required TransactionLinkUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/transaction_links/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<LinkTypeArray>> _apiV1LinkTypesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/link_types');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<LinkTypeArray, LinkTypeArray>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _apiV1LinkTypesPost(
      {required LinkType? body}) {
    final Uri $url = Uri.parse('/api/v1/link_types');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _apiV1LinkTypesIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/link_types/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _apiV1LinkTypesIdPut({
    required String? id,
    required LinkTypeUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/link_types/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1LinkTypesIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/link_types/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1RuleGroupsIdTestGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    int? searchLimit,
    int? triggeredLimit,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}/test');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'start': start,
      'end': end,
      'search_limit': searchLimit,
      'triggered_limit': triggeredLimit,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RuleGroupsIdTriggerPost({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    final Uri $url = Uri.parse('/api/v1/rule_groups/${id}/trigger');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'accounts[]': accounts,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1AccountsIdTransactionsGet({
    required String? id,
    int? page,
    int? limit,
    String? start,
    String? end,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'start': start,
      'end': end,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _apiV1AccountsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}/attachments');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _apiV1AccountsIdPiggyBanksGet({
    required String? id,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/accounts/${id}/piggy_banks');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<AccountArray>> _apiV1SearchAccountsGet({
    int? page,
    required String? query,
    String? type,
    required String? field,
  }) {
    final Uri $url = Uri.parse('/api/v1/search/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'query': query,
      'type': type,
      'field': field,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _apiV1SearchTransactionsGet({
    required String? query,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/search/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<CronResult>> _apiV1CronCliTokenGet({
    required String? cliToken,
    String? date,
    bool? force,
  }) {
    final Uri $url = Uri.parse('/api/v1/cron/${cliToken}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'date': date,
      'force': force,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CronResult, CronResult>($request);
  }

  @override
  Future<Response<List<Configuration>>> _apiV1ConfigurationGet() {
    final Uri $url = Uri.parse('/api/v1/configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Configuration>, Configuration>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _apiV1ConfigurationNameGet(
      {required String? name}) {
    final Uri $url = Uri.parse('/api/v1/configuration/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _apiV1ConfigurationNamePut({
    required String? name,
    required ConfigurationUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/configuration/${name}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<UserArray>> _apiV1UsersGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/users');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserArray, UserArray>($request);
  }

  @override
  Future<Response<UserSingle>> _apiV1UsersPost({required User? body}) {
    final Uri $url = Uri.parse('/api/v1/users');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _apiV1UsersIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _apiV1UsersIdPut({
    required String? id,
    required User? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SystemInfo>> _apiV1AboutGet() {
    final Uri $url = Uri.parse('/api/v1/about');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SystemInfo, SystemInfo>($request);
  }

  @override
  Future<Response<UserSingle>> _apiV1AboutUserGet() {
    final Uri $url = Uri.parse('/api/v1/about/user');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<WebhookArray>> _apiV1WebhooksGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/webhooks');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<WebhookArray, WebhookArray>($request);
  }

  @override
  Future<Response<WebhookSingle>> _apiV1WebhooksPost(
      {required WebhookStore? body}) {
    final Uri $url = Uri.parse('/api/v1/webhooks');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _apiV1WebhooksIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _apiV1WebhooksIdPut({
    required String? id,
    required WebhookUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1WebhooksIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1WebhooksIdSubmitPost({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}/submit');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<WebhookMessageArray>> _apiV1WebhooksIdMessagesGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}/messages');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebhookMessageArray, WebhookMessageArray>($request);
  }

  @override
  Future<Response<WebhookMessageSingle>> _apiV1WebhooksIdMessagesMessageIdGet({
    required String? id,
    required int? messageId,
  }) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}/messages/${messageId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebhookMessageSingle, WebhookMessageSingle>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1WebhooksIdMessagesMessageIdDelete({
    required String? id,
    required int? messageId,
  }) {
    final Uri $url = Uri.parse('/api/v1/webhooks/${id}/messages/${messageId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<WebhookAttemptArray>>
      _apiV1WebhooksIdMessagesMessageIdAttemptsGet({
    required String? id,
    required int? messageId,
    int? page,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/webhooks/${id}/messages/${messageId}/attempts');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<WebhookAttemptArray, WebhookAttemptArray>($request);
  }

  @override
  Future<Response<WebhookAttemptSingle>>
      _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    final Uri $url = Uri.parse(
        '/api/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebhookAttemptSingle, WebhookAttemptSingle>($request);
  }

  @override
  Future<Response<dynamic>>
      _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    final Uri $url = Uri.parse(
        '/api/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PreferenceArray>> _apiV1PreferencesGet({int? page}) {
    final Uri $url = Uri.parse('/api/v1/preferences');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PreferenceArray, PreferenceArray>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _apiV1PreferencesPost(
      {required Preference? body}) {
    final Uri $url = Uri.parse('/api/v1/preferences');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _apiV1PreferencesNameGet(
      {required String? name}) {
    final Uri $url = Uri.parse('/api/v1/preferences/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _apiV1PreferencesNamePut({
    required String? name,
    required PreferenceUpdate? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/preferences/${name}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }
}
