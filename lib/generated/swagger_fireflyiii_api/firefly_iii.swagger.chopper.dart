// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all accounts of the user returned in a basic auto-complete array.',
      operationId: 'getAccountsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'limit': limit,
      'date': date,
      'types': types?.join(","), // WF3 fix
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteAccount>, AutocompleteAccount>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteBill>>> _v1AutocompleteBillsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all bills of the user returned in a basic auto-complete array.',
      operationId: 'getBillsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteBill>, AutocompleteBill>($request);
  }

  @override
  Future<Response<List<AutocompleteBudget>>> _v1AutocompleteBudgetsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all budgets of the user returned in a basic auto-complete array.',
      operationId: 'getBudgetsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteBudget>, AutocompleteBudget>($request);
  }

  @override
  Future<Response<List<AutocompleteCategory>>> _v1AutocompleteCategoriesGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all categories of the user returned in a basic auto-complete array.',
      operationId: 'getCategoriesAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteCategory>, AutocompleteCategory>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteCurrency>>> _v1AutocompleteCurrenciesGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all currencies of the user returned in a basic auto-complete array.',
      operationId: 'getCurrenciesAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteCurrency>, AutocompleteCurrency>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteCurrencyCode>>>
  _v1AutocompleteCurrenciesWithCodeGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.',
      operationId: 'getCurrenciesCodeAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<List<AutocompleteCurrencyCode>, AutocompleteCurrencyCode>(
          $request,
        );
  }

  @override
  Future<Response<List<AutocompleteObjectGroup>>>
  _v1AutocompleteObjectGroupsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all object groups of the user returned in a basic auto-complete array.',
      operationId: 'getObjectGroupsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteObjectGroup>, AutocompleteObjectGroup>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompletePiggy>>> _v1AutocompletePiggyBanksGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all piggy banks of the user returned in a basic auto-complete array.',
      operationId: 'getPiggiesAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompletePiggy>, AutocompletePiggy>($request);
  }

  @override
  Future<Response<List<AutocompletePiggyBalance>>>
  _v1AutocompletePiggyBanksWithBalanceGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all piggy banks of the user returned in a basic auto-complete array.',
      operationId: 'getPiggiesBalanceAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<List<AutocompletePiggyBalance>, AutocompletePiggyBalance>(
          $request,
        );
  }

  @override
  Future<Response<List<AutocompleteRecurrence>>> _v1AutocompleteRecurringGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all recurring transactions of the user returned in a basic auto-complete array.',
      operationId: 'getRecurringAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteRecurrence>, AutocompleteRecurrence>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteRuleGroup>>> _v1AutocompleteRuleGroupsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all rule groups of the user returned in a basic auto-complete array.',
      operationId: 'getRuleGroupsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteRuleGroup>, AutocompleteRuleGroup>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteRule>>> _v1AutocompleteRulesGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all rules of the user returned in a basic auto-complete array.',
      operationId: 'getRulesAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteRule>, AutocompleteRule>($request);
  }

  @override
  Future<Response<List<AutocompleteBill>>> _v1AutocompleteSubscriptionsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all subscriptions of the user returned in a basic auto-complete array.',
      operationId: 'getSubscriptionsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/autocomplete/subscriptions');
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteBill>, AutocompleteBill>($request);
  }

  @override
  Future<Response<List<AutocompleteTag>>> _v1AutocompleteTagsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all tags of the user returned in a basic auto-complete array.',
      operationId: 'getTagAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteTag>, AutocompleteTag>($request);
  }

  @override
  Future<Response<List<AutocompleteTransactionType>>>
  _v1AutocompleteTransactionTypesGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all transaction types returned in a basic auto-complete array. English only.',
      operationId: 'getTransactionTypesAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<List<AutocompleteTransactionType>, AutocompleteTransactionType>(
          $request,
        );
  }

  @override
  Future<Response<List<AutocompleteTransaction>>>
  _v1AutocompleteTransactionsGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all transaction descriptions of the user returned in a basic auto-complete array.',
      operationId: 'getTransactionsAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AutocompleteTransaction>, AutocompleteTransaction>(
      $request,
    );
  }

  @override
  Future<Response<List<AutocompleteTransactionID>>>
  _v1AutocompleteTransactionsWithIdGet({
    String? xTraceId,
    String? query,
    int? limit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.',
      operationId: 'getTransactionsIDAC',
      consumes: [],
      produces: [],
      security: [],
      tags: ["autocomplete"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<List<AutocompleteTransactionID>, AutocompleteTransactionID>(
          $request,
        );
  }

  @override
  Future<Response<List<ChartDataSet>>> _v1ChartAccountOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? period,
    String? preselected,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns the data required to generate a chart with basic asset account balance information. This is used on the dashboard.
''',
      summary: 'Dashboard chart with asset account balance information.',
      operationId: 'getChartAccountOverview',
      consumes: [],
      produces: [],
      security: [],
      tags: ["charts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/chart/account/overview');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'period': period,
      'preselected': preselected,
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
      tag: swaggerMetaData,
    );
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<List<ChartDataSet>>> _v1ChartBalanceBalanceGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? period,
    String? preselected,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns the data required to generate a chart with balance information.
''',
      summary: 'Dashboard chart with balance information.',
      operationId: 'getChartBalance',
      consumes: [],
      produces: [],
      security: [],
      tags: ["charts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/chart/balance/balance');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'period': period,
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
      tag: swaggerMetaData,
    );
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<List<ChartDataSet>>> _v1ChartBudgetOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns the data required to generate a chart with basic budget information.
''',
      summary: 'Dashboard chart with budget information.',
      operationId: 'getChartBudgetOverview',
      consumes: [],
      produces: [],
      security: [],
      tags: ["charts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/chart/budget/overview');
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
      tag: swaggerMetaData,
    );
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<List<ChartDataSet>>> _v1ChartCategoryOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns the data required to generate a chart with basic category information.
''',
      summary: 'Dashboard chart with category information.',
      operationId: 'getChartCategoryOverview',
      consumes: [],
      produces: [],
      security: [],
      tags: ["charts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/chart/category/overview');
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
      tag: swaggerMetaData,
    );
    return client.send<List<ChartDataSet>, ChartDataSet>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataBulkTransactionsPost({
    String? xTraceId,
    required String? query,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Allows you to update transactions in bulk.
''',
      summary:
          'Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/',
      operationId: 'bulkUpdateTransactions',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/data/bulk/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{'query': query};
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataDestroyDelete({
    String? xTraceId,
    required String? objects,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''A call to this endpoint deletes the requested data type. Use it with care and always with user permission.
The demo user is incapable of using this endpoint.
''',
      summary: 'Endpoint to destroy user data',
      operationId: 'destroyData',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _v1DataExportAccountsGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your accounts from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export account data from Firefly III',
      operationId: 'exportAccounts',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportBillsGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your bills from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export bills from Firefly III',
      operationId: 'exportBills',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportBudgetsGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your budgets and associated budget data from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export budgets and budget amount data from Firefly III',
      operationId: 'exportBudgets',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportCategoriesGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your categories from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export category data from Firefly III',
      operationId: 'exportCategories',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportPiggyBanksGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your piggy banks from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export piggy banks from Firefly III',
      operationId: 'exportPiggies',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportRecurringGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your recurring transactions from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export recurring transaction data from Firefly III',
      operationId: 'exportRecurring',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportRulesGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your rules and rule groups from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export rule groups and rule data from Firefly III',
      operationId: 'exportRules',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _v1DataExportTagsGet({
    String? xTraceId,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export your tags from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export tag data from Firefly III',
      operationId: 'exportTags',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to export transactions from Firefly III into a file. Currently supports CSV exports only.
''',
      summary: 'Export transaction data from Firefly III',
      operationId: 'exportTransactions',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _v1DataPurgeDelete({
    String? xTraceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''A call to this endpoint purges all previously deleted data. Use it with care and always with user permission.
The demo user is incapable of using this endpoint.
''',
      summary: 'Endpoint to purge user data',
      operationId: 'purgeData',
      consumes: [],
      produces: [],
      security: [],
      tags: ["data"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/data/purge');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseExpenseGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by expense account.
''',
      summary: 'Insight into expenses, grouped by expense account.',
      operationId: 'insightExpenseExpense',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by asset account.
''',
      summary: 'Insight into expenses, grouped by asset account.',
      operationId: 'insightExpenseAsset',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeRevenueGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, grouped by revenue account.
''',
      summary: 'Insight into income, grouped by revenue account.',
      operationId: 'insightIncomeRevenue',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightIncomeAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, grouped by asset account.
''',
      summary: 'Insight into income, grouped by asset account.',
      operationId: 'insightIncomeAsset',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTransferEntry>>> _v1InsightTransferAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the transfers made by the user, grouped by asset account or lability.
''',
      summary: 'Insight into transfers, grouped by account.',
      operationId: 'insightTransfers',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightTransferEntry>, InsightTransferEntry>(
      $request,
    );
  }

  @override
  Future<Response<List<InsightGroupEntry>>> _v1InsightExpenseBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? bills,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by (any) bill.
''',
      summary: 'Insight into expenses, grouped by bill.',
      operationId: 'insightExpenseBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, including only expenses with no bill.
''',
      summary: 'Insight into expenses, without bill.',
      operationId: 'insightExpenseNoBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by (any) budget.
''',
      summary: 'Insight into expenses, grouped by budget.',
      operationId: 'insightExpenseBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoBudgetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, including only expenses with no budget.
''',
      summary: 'Insight into expenses, without budget.',
      operationId: 'insightExpenseNoBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by (any) category.
''',
      summary: 'Insight into expenses, grouped by category.',
      operationId: 'insightExpenseCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, including only expenses with no category.
''',
      summary: 'Insight into expenses, without category.',
      operationId: 'insightExpenseNoCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, grouped by (any) category.
''',
      summary: 'Insight into income, grouped by category.',
      operationId: 'insightIncomeCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, including only income with no category.
''',
      summary: 'Insight into income, without category.',
      operationId: 'insightIncomeNoCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the transfers made by the user, grouped by (any) category.
''',
      summary: 'Insight into transfers, grouped by category.',
      operationId: 'insightTransferCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the transfers made by the user, including only transfers with no category.
''',
      summary: 'Insight into transfers, without category.',
      operationId: 'insightTransferNoCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, grouped by (any) tag.
''',
      summary: 'Insight into expenses, grouped by tag.',
      operationId: 'insightExpenseTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the expenses made by the user, including only expenses with no tag.
''',
      summary: 'Insight into expenses, without tag.',
      operationId: 'insightExpenseNoTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, grouped by (any) tag.
''',
      summary: 'Insight into income, grouped by tag.',
      operationId: 'insightIncomeTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the income received by the user, including only income with no tag.
''',
      summary: 'Insight into income, without tag.',
      operationId: 'insightIncomeNoTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the transfers created by the user, grouped by (any) tag.
''',
      summary: 'Insight into transfers, grouped by tag.',
      operationId: 'insightTransferTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightGroupEntry>, InsightGroupEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a summary of the transfers made by the user, including only transfers with no tag.
''',
      summary: 'Insight into expenses, without tag.',
      operationId: 'insightTransferNoTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightExpenseTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a sum of the total expenses made by the user.
''',
      summary: 'Insight into total expenses.',
      operationId: 'insightExpenseTotal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightIncomeTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a sum of the total income received by the user.
''',
      summary: 'Insight into total income.',
      operationId: 'insightIncomeTotal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<InsightTotalEntry>, InsightTotalEntry>($request);
  }

  @override
  Future<Response<List<InsightTotalEntry>>> _v1InsightTransferTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint gives a sum of the total amount transfers made by the user.
''',
      summary: 'Insight into total transfers.',
      operationId: 'insightTransferTotal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["insight"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns a list of all the transactions connected to the account.
''',
      summary: 'List all transactions related to the account.',
      operationId: 'listTransactionByAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1AccountsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments.',
      operationId: 'listAttachmentByAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1AccountsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns a list of all the piggy banks connected to the account.
''',
      summary: 'List all piggy banks related to the account.',
      operationId: 'listPiggyBankByAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<AccountArray>> _v1AccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
    String? date,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns a list of all the accounts owned by the authenticated user.
''',
      summary: 'List all accounts.',
      operationId: 'listAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/accounts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'page': page,
      'start': start,
      'end': end,
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
      tag: swaggerMetaData,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsPost({
    String? xTraceId,
    required AccountStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new account. The data required can be submitted as a JSON body or as a list of parameters (in key=value pairs, like a webform).',
      summary: 'Create new account.',
      operationId: 'storeAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsIdGet({
    String? xTraceId,
    String? start,
    String? end,
    required String? id,
    String? date,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Returns a single account by its ID.
''',
      summary: 'Get single account.',
      operationId: 'getAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/accounts/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'date': date,
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
      tag: swaggerMetaData,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<AccountSingle>> _v1AccountsIdPut({
    String? xTraceId,
    required String? id,
    required AccountUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Used to update a single account. All fields that are not submitted will be cleared (set to NULL). The model will tell you which fields are mandatory.
''',
      summary: 'Update existing account.',
      operationId: 'updateAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AccountSingle, AccountSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1AccountsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Will permanently delete an account. Any associated transactions and piggy banks are ALSO deleted. Cannot be recovered from.
''',
      summary: 'Permanently delete account.',
      operationId: 'deleteAccount',
      consumes: [],
      produces: [],
      security: [],
      tags: ["accounts"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1AttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''This endpoint lists all attachments.
''',
      summary: 'List all attachments.',
      operationId: 'listAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsPost({
    String? xTraceId,
    required AttachmentStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Creates a new attachment. The data required can be submitted as a JSON body or as a list of parameters. You cannot use this endpoint to upload the actual file data (see below). This endpoint only creates the attachment object.
''',
      summary: 'Store a new attachment.',
      operationId: 'storeAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a single attachment. This endpoint only returns the available metadata for the attachment. Actual file data is handled in two other endpoints (see below).
''',
      summary: 'Get a single attachment.',
      operationId: 'getAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<AttachmentSingle>> _v1AttachmentsIdPut({
    String? xTraceId,
    required String? id,
    required AttachmentUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update the meta data for an existing attachment. This endpoint does not allow you to upload or download data. For that, see below.
''',
      summary: 'Update existing attachment.',
      operationId: 'updateAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentSingle, AttachmentSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1AttachmentsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''With this endpoint you delete an attachment, including any stored file data.
''',
      summary: 'Delete an attachment.',
      operationId: 'deleteAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _v1AttachmentsIdDownloadGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint allows you to download the binary content of a transaction. It will be sent to you as a download, using the content type "application/octet-stream" and content disposition "attachment; filename=example.pdf".
''',
      summary: 'Download a single attachment.',
      operationId: 'downloadAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _v1AttachmentsIdUploadPost({
    String? xTraceId,
    required String? id,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Use this endpoint to upload (and possible overwrite) the file contents of an attachment. Simply put the entire file in the body as binary data.
''',
      summary: 'Upload an attachment.',
      operationId: 'uploadAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["attachments"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Firefly III calculates the total amount of money budgeted in so-called "available budgets". This endpoint returns all of these amounts and the periods for which they are calculated.
''',
      summary: 'List all available budget amounts.',
      operationId: 'listAvailableBudgets',
      consumes: [],
      produces: [],
      security: [],
      tags: ["available_budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<AvailableBudgetSingle>> _v1AvailableBudgetsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single available budget, by ID.',
      summary: 'Get a single available budget.',
      operationId: 'getAvailableBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["available_budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AvailableBudgetSingle, AvailableBudgetSingle>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1BillsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will list all attachments linked to the bill.',
      summary: 'List all attachments uploaded to the bill.',
      operationId: 'listAttachmentByBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<RuleArray>> _v1BillsIdRulesGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will list all rules that have an action to set the bill to this bill.',
      summary: 'List all rules associated with the bill.',
      operationId: 'listRuleByBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1BillsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    String? type,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will list all transactions linked to this bill.',
      summary: 'List all transactions associated with the  bill.',
      operationId: 'listTransactionByBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'This endpoint will list all the user\'s bills.',
      summary: 'List all bills.',
      operationId: 'listBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsPost({
    String? xTraceId,
    required BillStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new bill. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new bill',
      operationId: 'storeBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single bill.',
      summary: 'Get a single bill.',
      operationId: 'getBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<BillSingle>> _v1BillsIdPut({
    String? xTraceId,
    required String? id,
    required BillUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing bill.',
      summary: 'Update existing bill.',
      operationId: 'updateBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BillSingle, BillSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BillsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a bill. This will not delete any associated rules. Will not remove associated transactions. WILL remove all associated attachments.',
      summary: 'Delete a bill.',
      operationId: 'deleteBill',
      consumes: [],
      produces: [],
      security: [],
      tags: ["bills"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all the transactions within one budget limit. The start and end date are dictated by the budget limit.',
      summary: 'List all transactions by a budget limit ID.',
      operationId: 'listTransactionByBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/budgets/${id}/limits/${limitId}/transactions',
    );
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _v1BudgetsIdLimitsGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get all budget limits for this budget and the money spent, and money left. You can limit the list by submitting a date range as well. The "spent" array for each budget limit is NOT influenced by the start and end date of your query, but by the start and end date of the budget limit itself.
''',
      summary: 'Get all limits for a budget.',
      operationId: 'listBudgetLimitByBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsPost({
    String? xTraceId,
    required String? id,
    required BudgetLimitStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Store a new budget limit under this budget.',
      summary: 'Store new budget limit.',
      operationId: 'storeBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdGet({
    String? xTraceId,
    required String? id,
    required int? limitId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get single budget limit.',
      operationId: 'getBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdPut({
    String? xTraceId,
    required String? id,
    required String? limitId,
    required BudgetLimitUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing budget limit.',
      summary: 'Update existing budget limit.',
      operationId: 'updateBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetLimitSingle, BudgetLimitSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BudgetsIdLimitsLimitIdDelete({
    String? xTraceId,
    required String? id,
    required String? limitId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a budget limit.',
      summary: 'Delete a budget limit.',
      operationId: 'deleteBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BudgetLimitArray>> _v1BudgetLimitsGet({
    String? xTraceId,
    required String? start,
    required String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all budget limits for for this date range.
''',
      summary: 'Get list of budget limits by date',
      operationId: 'listBudgetLimit',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all transactions linked to a budget, possibly limited by start and end',
      summary: 'All transactions to a budget.',
      operationId: 'listTransactionByBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1BudgetsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments of a budget.',
      operationId: 'listAttachmentByBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1BudgetsTransactionsWithoutBudgetGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all transactions NOT linked to a budget, possibly limited by start and end',
      summary: 'All transactions without a budget.',
      operationId: 'listTransactionWithoutBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/budgets/transactions-without-budget');
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<BudgetArray>> _v1BudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all the budgets the user has made. If the start date and end date are submitted as well, the "spent" array will be updated accordingly.',
      summary: 'List all budgets.',
      operationId: 'listBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetArray, BudgetArray>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsPost({
    String? xTraceId,
    required BudgetStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new budget. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new budget',
      operationId: 'storeBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get a single budget. If the start date and end date are submitted as well, the "spent" array will be updated accordingly.',
      summary: 'Get a single budget.',
      operationId: 'getBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<BudgetSingle>> _v1BudgetsIdPut({
    String? xTraceId,
    required String? id,
    required BudgetUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Update existing budget. This endpoint cannot be used to set budget amount limits.',
      summary: 'Update existing budget.',
      operationId: 'updateBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetSingle, BudgetSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1BudgetsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a budget. Transactions will not be deleted.',
      summary: 'Delete a budget.',
      operationId: 'deleteBudget',
      consumes: [],
      produces: [],
      security: [],
      tags: ["budgets"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all transactions in a category, optionally limited to the date ranges specified.',
      summary: 'List all transactions in a category.',
      operationId: 'listTransactionByCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1CategoriesIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments.',
      operationId: 'listAttachmentByCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<CategoryArray>> _v1CategoriesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all categories.',
      summary: 'List all categories.',
      operationId: 'listCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CategoryArray, CategoryArray>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesPost({
    String? xTraceId,
    required CategoryStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new category. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new category',
      operationId: 'storeCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single category.',
      summary: 'Get a single category.',
      operationId: 'getCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<CategorySingle>> _v1CategoriesIdPut({
    String? xTraceId,
    required String? id,
    required CategoryUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing category.',
      summary: 'Update existing category.',
      operationId: 'updateCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CategorySingle, CategorySingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1CategoriesIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a category. Transactions will not be removed.',
      summary: 'Delete a category.',
      operationId: 'deleteCategory',
      consumes: [],
      produces: [],
      security: [],
      tags: ["categories"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencyExchangeRateArray>> _v1ExchangeRatesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List exchange rates that Firefly III knows.',
      summary: 'List all exchange rates that Firefly III knows.',
      operationId: 'listCurrencyExchangeRates',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateArray, CurrencyExchangeRateArray>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesPost({
    String? xTraceId,
    required CurrencyExchangeRateStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Stores a new exchange rate. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new currency exchange rate.',
      operationId: 'storeCurrencyExchangeRate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateSingle, CurrencyExchangeRateSingle>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List a single specific exchange rate by its ID.',
      summary: 'List a single specific exchange rate.',
      operationId: 'listSpecificCurrencyExchangeRate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${id}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateSingle, CurrencyExchangeRateSingle>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _v1ExchangeRatesIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a specific currency exchange rate by its internal ID.',
      summary: 'Delete a specific currency exchange rate.',
      operationId: 'deleteSpecificCurrencyExchangeRate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdPut({
    String? xTraceId,
    required String? id,
    required CurrencyExchangeRateUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Used to update a single currency exchange rate by its ID. Including the from/to currency is optional.
''',
      summary: 'Update existing currency exchange rate.',
      operationId: 'updateCurrencyExchangeRate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${id}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateSingle, CurrencyExchangeRateSingle>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyExchangeRateArray>> _v1ExchangeRatesFromToGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? from,
    required String? to,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all exchange rates from/to the mentioned currencies.',
      summary: 'List all exchange rates from/to the mentioned currencies.',
      operationId: 'listSpecificCurrencyExchangeRates',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${from}/${to}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateArray, CurrencyExchangeRateArray>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _v1ExchangeRatesFromToDelete({
    String? xTraceId,
    required String? from,
    required String? to,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Deletes ALL currency exchange rates from \'from\' to \'to\'. It\'s important to know that the reverse exchange rates (from \'to\' to \'from\') will not be deleted and Firefly III will still be able to infer the correct exchange rate from the reverse one.',
      summary: 'Deletes ALL currency exchange rates from \'from\' to \'to\'.',
      operationId: 'deleteSpecificCurrencyExchangeRates',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${from}/${to}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencyExchangeRateArray>> _v1ExchangeRatesFromToDateGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? from,
    required String? to,
    required String? date,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List the exchange rate for the from and to-currency on the requested date.',
      summary:
          'List the exchange rate for the from and to-currency on the requested date.',
      operationId: 'listSpecificCurrencyExchangeRateOnDate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${from}/${to}/${date}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateArray, CurrencyExchangeRateArray>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _v1ExchangeRatesFromToDateDelete({
    String? xTraceId,
    required String? from,
    required String? to,
    required String? date,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete the currency exchange rate from \'from\' to \'to\' on the specified date.  It\'s important to know that the reverse exchange rate (from \'to\' to \'from\') will not be deleted and Firefly III will still be able to infer the correct exchange rate from the reverse one.',
      summary:
          'Delete the currency exchange rate from \'from\' to \'to\' on the specified date.',
      operationId: 'deleteSpecificCurrencyExchangeRateOnDate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${from}/${to}/${date}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesFromToDatePut({
    String? xTraceId,
    required String? from,
    required String? to,
    required String? date,
    required CurrencyExchangeRateUpdateNoDate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Used to update a single currency exchange rate by its currency codes and date
''',
      summary: 'Update existing currency exchange rate.',
      operationId: 'updateCurrencyExchangeRateByDate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/${from}/${to}/${date}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateSingle, CurrencyExchangeRateSingle>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyExchangeRateArray>> _v1ExchangeRatesByDateDatePost({
    String? xTraceId,
    required String? date,
    required CurrencyExchangeRateStoreByDate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Stores a new set of exchange rates. The date is fixed (in the URL parameter) and the data required can be submitted as a JSON body.',
      summary: 'Store new currency exchange rates under this date',
      operationId: 'storeCurrencyExchangeRatesByDate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/exchange-rates/by-date/${date}');
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateArray, CurrencyExchangeRateArray>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesByCurrenciesFromToPost({
    String? xTraceId,
    required String? from,
    required String? to,
    required CurrencyExchangeRateStoreByPair? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Stores a new set of exchange rates for this pair. The date is variable, and the data required can be submitted as a JSON body.',
      summary: 'Store new currency exchange rates under this from/to pair.',
      operationId: 'storeCurrencyExchangeRatesByPair',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currency_exchange_rates"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/exchange-rates/by-currencies/${from}/${to}',
    );
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyExchangeRateArray, CurrencyExchangeRateArray>(
      $request,
    );
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''List all transactions under this link type, both the inward and outward transactions.
''',
      summary: 'List all transactions under this link type.',
      operationId: 'listTransactionByLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<LinkTypeArray>> _v1LinkTypesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''List all the link types the system has. These include the default ones as well as any new ones.
''',
      summary: 'List all types of links.',
      operationId: 'listLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<LinkTypeArray, LinkTypeArray>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesPost({
    String? xTraceId,
    required LinkType? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new link type. The data required can be submitted as a JSON body or as a list of parameters (in key=value pairs, like a webform).',
      summary: 'Create a new link type',
      operationId: 'storeLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Returns a single link type by its ID.
''',
      summary: 'Get single a link type.',
      operationId: 'getLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<LinkTypeSingle>> _v1LinkTypesIdPut({
    String? xTraceId,
    required String? id,
    required LinkTypeUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Used to update a single link type. All fields that are not submitted will be cleared (set to NULL). The model will tell you which fields are mandatory. You cannot update some of the system provided link types, indicated by the editable=false flag when you list it.
''',
      summary: 'Update existing link type.',
      operationId: 'updateLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<LinkTypeSingle, LinkTypeSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1LinkTypesIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Will permanently delete a link type. The links between transactions will be removed. The transactions themselves remain. You cannot delete some of the system provided link types, indicated by the editable=false flag when you list it.
''',
      summary: 'Permanently delete link type.',
      operationId: 'deleteLinkType',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _v1TransactionLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''List all the transaction links.
''',
      summary: 'List all transaction links.',
      operationId: 'listTransactionLink',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksPost({
    String? xTraceId,
    required TransactionLinkStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Store a new link between two transactions. For this end point you need the journal_id from a transaction.',
      summary: 'Create a new link between transactions',
      operationId: 'storeTransactionLink',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Returns a single link by its ID.
''',
      summary: 'Get a single link.',
      operationId: 'getTransactionLink',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionLinksIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Will permanently delete link. Transactions remain.
''',
      summary: 'Permanently delete link between transactions.',
      operationId: 'deleteTransactionLink',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionLinkSingle>> _v1TransactionLinksIdPut({
    String? xTraceId,
    required String? id,
    required TransactionLinkUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Used to update a single existing link.
''',
      summary: 'Update an existing link between transactions.',
      operationId: 'updateTransactionLink',
      consumes: [],
      produces: [],
      security: [],
      tags: ["links"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionLinkSingle, TransactionLinkSingle>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1ObjectGroupsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint returns a list of all the piggy banks connected to the object group.
''',
      summary: 'List all piggy banks related to the object group.',
      operationId: 'listPiggyBankByObjectGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<BillArray>> _v1ObjectGroupsIdBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all bills with this object group.',
      summary: 'List all bills with this object group.',
      operationId: 'listBillByObjectGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BillArray, BillArray>($request);
  }

  @override
  Future<Response<ObjectGroupArray>> _v1ObjectGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all object groups.',
      summary: 'List all object groups.',
      operationId: 'listObjectGroups',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ObjectGroupArray, ObjectGroupArray>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _v1ObjectGroupsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single object group.',
      summary: 'Get a single object group.',
      operationId: 'getObjectGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<ObjectGroupSingle>> _v1ObjectGroupsIdPut({
    String? xTraceId,
    required String? id,
    required ObjectGroupUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing object group.',
      summary: 'Update existing object group.',
      operationId: 'updateObjectGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ObjectGroupSingle, ObjectGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1ObjectGroupsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a object group.',
      summary: 'Delete a object group.',
      operationId: 'deleteObjectGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["object_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _v1PiggyBanksIdEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all events linked to a piggy bank (adding and removing money).',
      summary: 'List all events linked to a piggy bank.',
      operationId: 'listEventByPiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankEventArray, PiggyBankEventArray>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1PiggyBanksIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments.',
      operationId: 'listAttachmentByPiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankArray>> _v1PiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all piggy banks.',
      summary: 'List all piggy banks.',
      operationId: 'listPiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankArray, PiggyBankArray>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksPost({
    String? xTraceId,
    required PiggyBankStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new piggy bank. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new piggy bank',
      operationId: 'storePiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single piggy bank.',
      summary: 'Get a single piggy bank.',
      operationId: 'getPiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<PiggyBankSingle>> _v1PiggyBanksIdPut({
    String? xTraceId,
    required String? id,
    required PiggyBankUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing piggy bank.',
      summary: 'Update existing piggy bank.',
      operationId: 'updatePiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PiggyBankSingle, PiggyBankSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1PiggyBanksIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a piggy bank.',
      summary: 'Delete a piggy bank.',
      operationId: 'deletePiggyBank',
      consumes: [],
      produces: [],
      security: [],
      tags: ["piggy_banks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all transactions created by a recurring transaction, optionally limited to the date ranges specified.',
      summary: 'List all transactions created by a recurring transaction.',
      operationId: 'listTransactionByRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<RecurrenceArray>> _v1RecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all recurring transactions.',
      summary: 'List all recurring transactions.',
      operationId: 'listRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesPost({
    String? xTraceId,
    required RecurrenceStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new recurring transaction. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new recurring transaction',
      operationId: 'storeRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single recurring transaction.',
      summary: 'Get a single recurring transaction.',
      operationId: 'getRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<RecurrenceSingle>> _v1RecurrencesIdPut({
    String? xTraceId,
    required String? id,
    required RecurrenceUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing recurring transaction.',
      summary: 'Update existing recurring transaction.',
      operationId: 'updateRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RecurrenceSingle, RecurrenceSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RecurrencesIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a recurring transaction. Transactions created by the recurring transaction will not be deleted.',
      summary: 'Delete a recurring transaction.',
      operationId: 'deleteRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1RecurrencesIdTriggerPost({
    String? xTraceId,
    required String? id,
    required String? date,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Trigger the creation of a transaction for a specific recurring transaction. All recurrences have a set of future occurrences. For those moments, you can trigger the creation of the transaction. That means the transaction will be created NOW, instead of on the indicated date. The transaction will be dated to _today_.

So, if you recurring transaction that occurs every Monday, you can trigger the creation of a transaction for Monday in two weeks, today. On that Monday two weeks from now, no transaction will be created. Instead, the transaction is created right now, and dated _today_.
''',
      summary:
          'Trigger the creation of a transaction for a specific recurring transaction',
      operationId: 'triggerRecurrenceRecurrence',
      consumes: [],
      produces: [],
      security: [],
      tags: ["recurrences"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/recurrences/${id}/trigger');
    final Map<String, dynamic> $params = <String, dynamic>{'date': date};
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<RuleArray>> _v1RuleGroupsIdRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List rules in this rule group.',
      summary: 'List rules in this rule group.',
      operationId: 'listRuleByGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Test which transactions would be hit by the rule group. No changes will be made. Limit the result if you want to.',
      summary:
          'Test which transactions would be hit by the rule group. No changes will be made.',
      operationId: 'testRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Fire the rule group on your transactions. Changes will be made by the rules in the rule group. Limit the result if you want to.',
      summary: 'Fire the rule group on your transactions.',
      operationId: 'fireRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleGroupArray>> _v1RuleGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all rule groups.',
      summary: 'List all rule groups.',
      operationId: 'listRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleGroupArray, RuleGroupArray>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsPost({
    String? xTraceId,
    required RuleGroupStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new rule group. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new rule group.',
      operationId: 'storeRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get a single rule group. This does not include the rules. For that, see below.',
      summary: 'Get a single rule group.',
      operationId: 'getRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<RuleGroupSingle>> _v1RuleGroupsIdPut({
    String? xTraceId,
    required String? id,
    required RuleGroupUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing rule group.',
      summary: 'Update existing rule group.',
      operationId: 'updateRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleGroupSingle, RuleGroupSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RuleGroupsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a rule group.',
      summary: 'Delete a rule group.',
      operationId: 'deleteRuleGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rule_groups"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Test which transactions would be hit by the rule. No changes will be made. Limit the result if you want to.',
      summary:
          'Test which transactions would be hit by the rule. No changes will be made.',
      operationId: 'testRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Fire the rule group on your transactions. Changes will be made by the rules in the group. Limit the result if you want to.',
      summary: 'Fire the rule on your transactions.',
      operationId: 'fireRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RuleArray>> _v1RulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all rules.',
      summary: 'List all rules.',
      operationId: 'listRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleArray, RuleArray>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesPost({
    String? xTraceId,
    required RuleStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new rule. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new rule',
      operationId: 'storeRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single rule.',
      summary: 'Get a single rule.',
      operationId: 'getRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<RuleSingle>> _v1RulesIdPut({
    String? xTraceId,
    required String? id,
    required RuleUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing rule.',
      summary: 'Update existing rule.',
      operationId: 'updateRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RuleSingle, RuleSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1RulesIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete an rule.',
      summary: 'Delete an rule.',
      operationId: 'deleteRule',
      consumes: [],
      produces: [],
      security: [],
      tags: ["rules"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1TagsTagAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments.',
      operationId: 'listAttachmentByTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all transactions with this tag.',
      summary: 'List all transactions with this tag.',
      operationId: 'listTransactionByTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TagArray>> _v1TagsGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all of the user\'s tags.',
      summary: 'List all tags.',
      operationId: 'listTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TagArray, TagArray>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsPost({
    String? xTraceId,
    required TagModelStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new tag. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new tag',
      operationId: 'storeTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsTagGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single tag.',
      summary: 'Get a single tag.',
      operationId: 'getTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<TagSingle>> _v1TagsTagPut({
    String? xTraceId,
    required String? tag,
    required TagModelUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing tag.',
      summary: 'Update existing tag.',
      operationId: 'updateTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TagSingle, TagSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TagsTagDelete({
    String? xTraceId,
    required String? tag,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete an tag.',
      summary: 'Delete an tag.',
      operationId: 'deleteTag',
      consumes: [],
      produces: [],
      security: [],
      tags: ["tags"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all accounts with this currency.',
      summary: 'List all accounts with this currency.',
      operationId: 'listAccountByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<AvailableBudgetArray>> _v1CurrenciesCodeAvailableBudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all available budgets with this currency.',
      summary: 'List all available budgets with this currency.',
      operationId: 'listAvailableBudgetByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AvailableBudgetArray, AvailableBudgetArray>($request);
  }

  @override
  Future<Response<BillArray>> _v1CurrenciesCodeBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all bills with this currency.',
      summary: 'List all bills with this currency.',
      operationId: 'listBillByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all budget limits with this currency',
      summary: 'List all budget limits with this currency',
      operationId: 'listBudgetLimitByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/budget-limits');
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
      tag: swaggerMetaData,
    );
    return client.send<BudgetLimitArray, BudgetLimitArray>($request);
  }

  @override
  Future<Response<RecurrenceArray>> _v1CurrenciesCodeRecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all recurring transactions with this currency.',
      summary: 'List all recurring transactions with this currency.',
      operationId: 'listRecurrenceByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<RecurrenceArray, RecurrenceArray>($request);
  }

  @override
  Future<Response<RuleArray>> _v1CurrenciesCodeRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all rules with this currency.',
      summary: 'List all rules with this currency.',
      operationId: 'listRuleByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all transactions with this currency.',
      summary: 'List all transactions with this currency.',
      operationId: 'listTransactionByCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<CurrencyArray>> _v1CurrenciesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all currencies.',
      summary: 'List all currencies.',
      operationId: 'listCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencyArray, CurrencyArray>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesPost({
    String? xTraceId,
    required CurrencyStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new currency. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new currency',
      operationId: 'storeCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeEnablePost({
    String? xTraceId,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Enable a single currency.',
      summary: 'Enable a single currency.',
      operationId: 'enableCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeDisablePost({
    String? xTraceId,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Disable a currency.',
      summary: 'Disable a currency.',
      operationId: 'disableCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodePrimaryPost({
    String? xTraceId,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Make this currency the primary currency for the current financial administration. If the currency is not enabled, it will be enabled as well.',
      summary: 'Make currency primary currency.',
      operationId: 'primaryCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/currencies/${code}/primary');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodeGet({
    String? xTraceId,
    required String? code,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single currency.',
      summary: 'Get a single currency.',
      operationId: 'getCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesCodePut({
    String? xTraceId,
    required String? code,
    required Map<String, String> body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing currency.',
      summary: 'Update existing currency.',
      operationId: 'updateCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a currency.',
      summary: 'Delete a currency.',
      operationId: 'deleteCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CurrencySingle>> _v1CurrenciesPrimaryGet({
    String? xTraceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get the primary currency of the current administration. This replaces what was called "the user\'s default currency" although they are essentially the same.',
      summary: 'Get the primary currency of the current administration.',
      operationId: 'getPrimaryCurrency',
      consumes: [],
      produces: [],
      security: [],
      tags: ["currencies"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/currencies/primary');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<CurrencySingle, CurrencySingle>($request);
  }

  @override
  Future<Response<TransactionLinkArray>> _v1TransactionJournalsIdLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Lists all the transaction links for an individual journal (a split). Don\'t use the group ID, you need the actual underlying journal (the split).',
      summary:
          'Lists all the transaction links for an individual journal (individual split).',
      operationId: 'listLinksByJournal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionLinkArray, TransactionLinkArray>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionJournalsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single transaction by underlying journal (split).',
      summary:
          'Get a single transaction, based on one of the underlying transaction journals (transaction splits).',
      operationId: 'getTransactionByJournal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionJournalsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete an individual journal (split) from a transaction.',
      summary: 'Delete split from transaction',
      operationId: 'deleteTransactionJournal',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AttachmentArray>> _v1TransactionsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all attachments.',
      summary: 'Lists all attachments.',
      operationId: 'listAttachmentByTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AttachmentArray, AttachmentArray>($request);
  }

  @override
  Future<Response<PiggyBankEventArray>> _v1TransactionsIdPiggyBankEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Lists all piggy bank events.',
      summary: 'Lists all piggy bank events.',
      operationId: 'listEventByTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all the user\'s transactions.',
      summary: '''List all the user\'s transactions.
''',
      operationId: 'listTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionsPost({
    String? xTraceId,
    required TransactionStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Creates a new transaction. The data required can be submitted as a JSON body or as a list of parameters.',
      summary: 'Store a new transaction',
      operationId: 'storeTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a single transaction.',
      summary: 'Get a single transaction.',
      operationId: 'getTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<TransactionSingle>> _v1TransactionsIdPut({
    String? xTraceId,
    required String? id,
    required TransactionUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update an existing transaction.',
      summary:
          'Update existing transaction. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/',
      operationId: 'updateTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionSingle, TransactionSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1TransactionsIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a transaction.',
      summary: 'Delete a transaction.',
      operationId: 'deleteTransaction',
      consumes: [],
      produces: [],
      security: [],
      tags: ["transactions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserGroupArray>> _v1UserGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'List all the user groups available to this user. These are essentially the \'financial administrations\' that Firefly III supports.',
      summary: '''List all the user groups available to this user.
''',
      operationId: 'listUserGroups',
      consumes: [],
      produces: [],
      security: [],
      tags: ["user_groups"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/user-groups');
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
      tag: swaggerMetaData,
    );
    return client.send<UserGroupArray, UserGroupArray>($request);
  }

  @override
  Future<Response<UserGroupSingle>> _v1UserGroupsIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Returns a single user group by its ID.
''',
      summary: 'Get a single user group.',
      operationId: 'getUserGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["user_groups"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/user-groups/${id}');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<UserGroupSingle, UserGroupSingle>($request);
  }

  @override
  Future<Response<UserGroupSingle>> _v1UserGroupsIdPut({
    String? xTraceId,
    required String? id,
    required UserGroupUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Used to update a single user group. The available fields are still limited.
''',
      summary: 'Update an existing user group.',
      operationId: 'updateUserGroup',
      consumes: [],
      produces: [],
      security: [],
      tags: ["user_groups"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/user-groups/${id}');
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
      tag: swaggerMetaData,
    );
    return client.send<UserGroupSingle, UserGroupSingle>($request);
  }

  @override
  Future<Response<AccountArray>> _v1SearchAccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
    String? type,
    required String? field,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Search for accounts',
      summary: 'Search for accounts',
      operationId: 'searchAccounts',
      consumes: [],
      produces: [],
      security: [],
      tags: ["search"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AccountArray, AccountArray>($request);
  }

  @override
  Future<Response<TransactionArray>> _v1SearchTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Searches through the users transactions.',
      summary: 'Search for transactions',
      operationId: 'searchTransactions',
      consumes: [],
      produces: [],
      security: [],
      tags: ["search"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TransactionArray, TransactionArray>($request);
  }

  @override
  Future<Response<BasicSummary>> _v1SummaryBasicGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? currencyCode,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Returns basic sums of the users data, like the net worth, spent and earned amounts. It is multi-currency, and is used in Firefly III to populate the dashboard.
''',
      summary: 'Returns basic sums of the users data.',
      operationId: 'getBasicSummary',
      consumes: [],
      produces: [],
      security: [],
      tags: ["summary"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<BasicSummary, BasicSummary>($request);
  }

  @override
  Future<Response<SystemInfo>> _v1AboutGet({
    String? xTraceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Returns general system information and versions of the (supporting) software.
''',
      summary: 'System information end point.',
      operationId: 'getAbout',
      consumes: [],
      produces: [],
      security: [],
      tags: ["about"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/about');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<SystemInfo, SystemInfo>($request);
  }

  @override
  Future<Response<UserSingle>> _v1AboutUserGet({
    String? xTraceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Returns the currently authenticated user.
''',
      summary: 'Currently authenticated user endpoint.',
      operationId: 'getCurrentUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["about"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/about/user');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<List<Configuration>>> _v1ConfigurationGet({
    String? xTraceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Returns all editable and not-editable configuration values for this Firefly III installation',
      summary: 'Get Firefly III system configuration values.',
      operationId: 'getConfiguration',
      consumes: [],
      produces: [],
      security: [],
      tags: ["configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/v1/configuration');
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<List<Configuration>, Configuration>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _v1ConfigurationNameGet({
    String? xTraceId,
    required String? name,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Returns one configuration variable for this Firefly III installation',
      summary: 'Get a single Firefly III system configuration value',
      operationId: 'getSingleConfiguration',
      consumes: [],
      produces: [],
      security: [],
      tags: ["configuration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<ConfigurationSingle>> _v1ConfigurationNamePut({
    String? xTraceId,
    required String? name,
    required ConfigurationUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Set a single configuration value. Not all configuration values can be updated so the list of accepted configuration variables is small.',
      summary: 'Update configuration value',
      operationId: 'setConfiguration',
      consumes: [],
      produces: [],
      security: [],
      tags: ["configuration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ConfigurationSingle, ConfigurationSingle>($request);
  }

  @override
  Future<Response<CronResult>> _v1CronCliTokenGet({
    String? xTraceId,
    required String? cliToken,
    String? date,
    bool? force,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Firefly III has one endpoint for its various cron related tasks. Send a GET to this endpoint
to run the cron. The cron requires the CLI token to be present. The cron job will fire for all
users.
''',
      summary: 'Cron job endpoint',
      operationId: 'getCron',
      consumes: [],
      produces: [],
      security: [],
      tags: ["about"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<CronResult, CronResult>($request);
  }

  @override
  Future<Response<UserArray>> _v1UsersGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all the users in this instance of Firefly III.',
      summary: 'List all users.',
      operationId: 'listUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserArray, UserArray>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersPost({
    String? xTraceId,
    required User? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Creates a new user. The data required can be submitted as a JSON body or as a list of parameters. The user will be given a random password, which they can reset using the "forgot password" function.
''',
      summary: 'Store a new user',
      operationId: 'storeUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Gets all info of a single user.',
      summary: 'Get a single user.',
      operationId: 'getUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<UserSingle>> _v1UsersIdPut({
    String? xTraceId,
    required String? id,
    required User? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update existing user.',
      summary: 'Update an existing user\'s information.',
      operationId: 'updateUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserSingle, UserSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1UsersIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a user. You cannot delete the user you\'re authenticated with. This cannot be undone. Be careful.',
      summary: 'Delete a user.',
      operationId: 'deleteUser',
      consumes: [],
      produces: [],
      security: [],
      tags: ["users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PreferenceArray>> _v1PreferencesGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all of the preferences of the user.',
      summary: 'List all users preferences.',
      operationId: 'listPreference',
      consumes: [],
      produces: [],
      security: [],
      tags: ["preferences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PreferenceArray, PreferenceArray>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v1PreferencesPost({
    String? xTraceId,
    required Preference? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint creates a new preference. The name and data are free-format, and entirely up to you. If the preference is not used in Firefly III itself it may not be configurable through the user interface, but you can use this endpoint to persist custom data for your own app.',
      summary: 'Store a new preference for this user.',
      operationId: 'storePreference',
      consumes: [],
      produces: [],
      security: [],
      tags: ["preferences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v1PreferencesNameGet({
    String? xTraceId,
    required String? name,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return a single preference and the value.',
      summary: 'Return a single preference.',
      operationId: 'getPreference',
      consumes: [],
      produces: [],
      security: [],
      tags: ["preferences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<PreferenceSingle>> _v1PreferencesNamePut({
    String? xTraceId,
    required String? name,
    required PreferenceUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update a user\'s preference.',
      summary: 'Update preference',
      operationId: 'updatePreference',
      consumes: [],
      produces: [],
      security: [],
      tags: ["preferences"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PreferenceSingle, PreferenceSingle>($request);
  }

  @override
  Future<Response<WebhookMessageArray>> _v1WebhooksIdMessagesGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'When a webhook is triggered the actual message that will be send is stored in a "message". You can view and analyse these messages.',
      summary: 'Get all the messages of a single webhook.',
      operationId: 'getWebhookMessages',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookMessageArray, WebhookMessageArray>($request);
  }

  @override
  Future<Response<WebhookMessageSingle>> _v1WebhooksIdMessagesMessageIdGet({
    String? xTraceId,
    required String? id,
    required int? messageId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'When a webhook is triggered it will store the actual content of the webhook in a webhook message. You can view and analyse a single one using this endpoint.',
      summary: 'Get a single message from a webhook.',
      operationId: 'getSingleWebhookMessage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookMessageSingle, WebhookMessageSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdMessagesMessageIdDelete({
    String? xTraceId,
    required String? id,
    required int? messageId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a webhook message. Any time a webhook is triggered the message is stored before it\'s sent. You can delete them before or after sending.',
      summary: 'Delete a webhook message.',
      operationId: 'deleteWebhookMessage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'When a webhook message fails to send it will store the failure in an "attempt". You can view and analyse these. Webhook messages that receive too many attempts (failures) will not be sent again. You must first clear out old attempts before the message can go out again.',
      summary: 'Get all the failed attempts of a single webhook message.',
      operationId: 'getWebhookMessageAttempts',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/webhooks/${id}/messages/${messageId}/attempts',
    );
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'When a webhook message fails to send it will store the failure in an "attempt". You can view and analyse these. Webhooks messages that receive too many attempts (failures) will not be fired. You must first clear out old attempts and try again. This endpoint shows you the details of a single attempt. The ID of the attempt must match the corresponding webhook and webhook message.',
      summary: 'Get a single failed attempt from a single webhook message.',
      operationId: 'getSingleWebhookMessageAttempt',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}',
    );
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete a webhook message attempt. If you delete all attempts for a webhook message, Firefly III will (once again) assume all is well with the webhook message and will try to send it again.',
      summary: 'Delete a webhook attempt.',
      operationId: 'deleteWebhookMessageAttempt',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/webhooks/${id}/messages/${messageId}/attempts/${attemptId}',
    );
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdSubmitPost({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will submit any open messages for this webhook. This is an asynchronous operation, so you can\'t see the result. Refresh the webhook message and/or the webhook message attempts to see the results. This may take some time if the webhook receiver is slow.',
      summary: 'Submit messages for a webhook.',
      operationId: 'submitWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdTriggerTransactionTransactionIdPost({
    String? xTraceId,
    required String? id,
    required String? transactionId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will execute this webhook for a given transaction ID. This is an asynchronous operation, so you can\'t see the result. Refresh the webhook message and/or the webhook message attempts to see the results. This may take some time if the webhook receiver is slow.',
      summary: 'Trigger webhook for a given transaction.',
      operationId: 'triggerTransactionWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/v1/webhooks/${id}/trigger-transaction/${transactionId}',
    );
    final Map<String, String> $headers = {
      if (xTraceId != null) 'X-Trace-Id': xTraceId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<WebhookArray>> _v1WebhooksGet({
    String? xTraceId,
    int? limit,
    int? page,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List all the user\'s webhooks.',
      summary: 'List all webhooks.',
      operationId: 'listWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookArray, WebhookArray>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksPost({
    String? xTraceId,
    required WebhookStore? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Creates a new webhook. The data required can be submitted as a JSON body or as a list of parameters. The webhook will be given a random secret.
''',
      summary: 'Store a new webhook',
      operationId: 'storeWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksIdGet({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Gets all info of a single webhook.',
      summary: 'Get a single webhook.',
      operationId: 'getWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<WebhookSingle>> _v1WebhooksIdPut({
    String? xTraceId,
    required String? id,
    required WebhookUpdate? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Update an existing webhook\'s information. If you wish to reset the secret, submit any value as the "secret". Firefly III will take this as a hint and reset the secret of the webhook.',
      summary: 'Update existing webhook.',
      operationId: 'updateWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<WebhookSingle, WebhookSingle>($request);
  }

  @override
  Future<Response<dynamic>> _v1WebhooksIdDelete({
    String? xTraceId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a webhook.',
      summary: 'Delete a webhook.',
      operationId: 'deleteWebhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["webhooks"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
