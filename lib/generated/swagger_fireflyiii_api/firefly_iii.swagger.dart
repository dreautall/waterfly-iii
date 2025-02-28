// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'firefly_iii.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'firefly_iii.enums.swagger.dart' as enums;
export 'firefly_iii.enums.swagger.dart';
export 'firefly_iii.models.swagger.dart';

part 'firefly_iii.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class FireflyIii extends ChopperService {
  static FireflyIii create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$FireflyIii(client);
    }

    final newClient = ChopperClient(
      services: [_$FireflyIii()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$FireflyIii(newClient);
  }

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param types Optional filter on the account type(s) used in the autocomplete.
  Future<chopper.Response<AutocompleteAccountArray>> v1AutocompleteAccountsGet({
    String? xTraceId,
    String? query,
    int? limit,
    String? date,
    List<enums.AccountTypeFilter>? types,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteAccount,
      () => AutocompleteAccount.fromJsonFactory,
    );

    return _v1AutocompleteAccountsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
      date: date,
      types: accountTypeFilterListToJson(types),
    );
  }

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param types Optional filter on the account type(s) used in the autocomplete.
  @Get(path: '/v1/autocomplete/accounts')
  Future<chopper.Response<AutocompleteAccountArray>>
  _v1AutocompleteAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<Object?>? types,
  });

  ///Returns all bills of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteBillArray>> v1AutocompleteBillsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteBill,
      () => AutocompleteBill.fromJsonFactory,
    );

    return _v1AutocompleteBillsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all bills of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/bills')
  Future<chopper.Response<AutocompleteBillArray>> _v1AutocompleteBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all budgets of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteBudgetArray>> v1AutocompleteBudgetsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteBudget,
      () => AutocompleteBudget.fromJsonFactory,
    );

    return _v1AutocompleteBudgetsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all budgets of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/budgets')
  Future<chopper.Response<AutocompleteBudgetArray>> _v1AutocompleteBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all categories of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCategoryArray>>
  v1AutocompleteCategoriesGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteCategory,
      () => AutocompleteCategory.fromJsonFactory,
    );

    return _v1AutocompleteCategoriesGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all categories of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/categories')
  Future<chopper.Response<AutocompleteCategoryArray>>
  _v1AutocompleteCategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all currencies of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCurrencyArray>>
  v1AutocompleteCurrenciesGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteCurrency,
      () => AutocompleteCurrency.fromJsonFactory,
    );

    return _v1AutocompleteCurrenciesGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all currencies of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/currencies')
  Future<chopper.Response<AutocompleteCurrencyArray>>
  _v1AutocompleteCurrenciesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCurrencyCodeArray>>
  v1AutocompleteCurrenciesWithCodeGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteCurrencyCode,
      () => AutocompleteCurrencyCode.fromJsonFactory,
    );

    return _v1AutocompleteCurrenciesWithCodeGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/currencies-with-code')
  Future<chopper.Response<AutocompleteCurrencyCodeArray>>
  _v1AutocompleteCurrenciesWithCodeGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all object groups of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteObjectGroupArray>>
  v1AutocompleteObjectGroupsGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteObjectGroup,
      () => AutocompleteObjectGroup.fromJsonFactory,
    );

    return _v1AutocompleteObjectGroupsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all object groups of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/object-groups')
  Future<chopper.Response<AutocompleteObjectGroupArray>>
  _v1AutocompleteObjectGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompletePiggyArray>> v1AutocompletePiggyBanksGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompletePiggy,
      () => AutocompletePiggy.fromJsonFactory,
    );

    return _v1AutocompletePiggyBanksGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/piggy-banks')
  Future<chopper.Response<AutocompletePiggyArray>>
  _v1AutocompletePiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompletePiggyBalanceArray>>
  v1AutocompletePiggyBanksWithBalanceGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompletePiggyBalance,
      () => AutocompletePiggyBalance.fromJsonFactory,
    );

    return _v1AutocompletePiggyBanksWithBalanceGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/piggy-banks-with-balance')
  Future<chopper.Response<AutocompletePiggyBalanceArray>>
  _v1AutocompletePiggyBanksWithBalanceGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all recurring transactions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRecurrenceArray>>
  v1AutocompleteRecurringGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteRecurrence,
      () => AutocompleteRecurrence.fromJsonFactory,
    );

    return _v1AutocompleteRecurringGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all recurring transactions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/recurring')
  Future<chopper.Response<AutocompleteRecurrenceArray>>
  _v1AutocompleteRecurringGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all rule groups of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRuleGroupArray>>
  v1AutocompleteRuleGroupsGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteRuleGroup,
      () => AutocompleteRuleGroup.fromJsonFactory,
    );

    return _v1AutocompleteRuleGroupsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all rule groups of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/rule-groups')
  Future<chopper.Response<AutocompleteRuleGroupArray>>
  _v1AutocompleteRuleGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all rules of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRuleArray>> v1AutocompleteRulesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteRule,
      () => AutocompleteRule.fromJsonFactory,
    );

    return _v1AutocompleteRulesGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all rules of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/rules')
  Future<chopper.Response<AutocompleteRuleArray>> _v1AutocompleteRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all tags of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTagArray>> v1AutocompleteTagsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteTag,
      () => AutocompleteTag.fromJsonFactory,
    );

    return _v1AutocompleteTagsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all tags of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/tags')
  Future<chopper.Response<AutocompleteTagArray>> _v1AutocompleteTagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transaction types returned in a basic auto-complete array. English only.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionTypeArray>>
  v1AutocompleteTransactionTypesGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteTransactionType,
      () => AutocompleteTransactionType.fromJsonFactory,
    );

    return _v1AutocompleteTransactionTypesGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all transaction types returned in a basic auto-complete array. English only.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/transaction-types')
  Future<chopper.Response<AutocompleteTransactionTypeArray>>
  _v1AutocompleteTransactionTypesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transaction descriptions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionArray>>
  v1AutocompleteTransactionsGet({String? xTraceId, String? query, int? limit}) {
    generatedMapping.putIfAbsent(
      AutocompleteTransaction,
      () => AutocompleteTransaction.fromJsonFactory,
    );

    return _v1AutocompleteTransactionsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all transaction descriptions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/transactions')
  Future<chopper.Response<AutocompleteTransactionArray>>
  _v1AutocompleteTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionIDArray>>
  v1AutocompleteTransactionsWithIdGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteTransactionID,
      () => AutocompleteTransactionID.fromJsonFactory,
    );

    return _v1AutocompleteTransactionsWithIdGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v1/autocomplete/transactions-with-id')
  Future<chopper.Response<AutocompleteTransactionIDArray>>
  _v1AutocompleteTransactionsWithIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLine>> v1ChartAccountOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
      ChartDataSet,
      () => ChartDataSet.fromJsonFactory,
    );

    return _v1ChartAccountOverviewGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
    );
  }

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v1/chart/account/overview')
  Future<chopper.Response<ChartLine>> _v1ChartAccountOverviewGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The JSON query.
  Future<chopper.Response> v1DataBulkTransactionsPost({
    String? xTraceId,
    required String? query,
  }) {
    return _v1DataBulkTransactionsPost(
      xTraceId: xTraceId?.toString(),
      query: query,
    );
  }

  ///Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The JSON query.
  @Post(path: '/v1/data/bulk/transactions', optionalBody: true)
  Future<chopper.Response> _v1DataBulkTransactionsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') required String? query,
  });

  ///Endpoint to destroy user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param objects The type of data that you wish to destroy. You can only use one at a time.
  Future<chopper.Response> v1DataDestroyDelete({
    String? xTraceId,
    required enums.DataDestroyObject? objects,
  }) {
    return _v1DataDestroyDelete(
      xTraceId: xTraceId?.toString(),
      objects: objects?.value?.toString(),
    );
  }

  ///Endpoint to destroy user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param objects The type of data that you wish to destroy. You can only use one at a time.
  @Delete(path: '/v1/data/destroy')
  Future<chopper.Response> _v1DataDestroyDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('objects') required String? objects,
  });

  ///Export account data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportAccountsGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportAccountsGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export account data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/accounts')
  Future<chopper.Response<String>> _v1DataExportAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export bills from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportBillsGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportBillsGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export bills from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/bills')
  Future<chopper.Response<String>> _v1DataExportBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export budgets and budget amount data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportBudgetsGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportBudgetsGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export budgets and budget amount data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/budgets')
  Future<chopper.Response<String>> _v1DataExportBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export category data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportCategoriesGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportCategoriesGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export category data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/categories')
  Future<chopper.Response<String>> _v1DataExportCategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export piggy banks from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportPiggyBanksGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportPiggyBanksGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export piggy banks from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/piggy-banks')
  Future<chopper.Response<String>> _v1DataExportPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export recurring transaction data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportRecurringGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportRecurringGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export recurring transaction data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/recurring')
  Future<chopper.Response<String>> _v1DataExportRecurringGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export rule groups and rule data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportRulesGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportRulesGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export rule groups and rule data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/rules')
  Future<chopper.Response<String>> _v1DataExportRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export tag data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportTagsGet({
    String? xTraceId,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportTagsGet(
      xTraceId: xTraceId?.toString(),
      type: type?.value?.toString(),
    );
  }

  ///Export tag data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/tags')
  Future<chopper.Response<String>> _v1DataExportTagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
  });

  ///Export transaction data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts Limit the export of transactions to these accounts only. Only asset accounts will be accepted. Other types will be silently dropped.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> v1DataExportTransactionsGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? accounts,
    enums.ExportFileFilter? type,
  }) {
    return _v1DataExportTransactionsGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
      type: type?.value?.toString(),
    );
  }

  ///Export transaction data from Firefly III
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts Limit the export of transactions to these accounts only. Only asset accounts will be accepted. Other types will be silently dropped.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/v1/data/export/transactions')
  Future<chopper.Response<String>> _v1DataExportTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts') String? accounts,
    @Query('type') String? type,
  });

  ///Endpoint to purge user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response> v1DataPurgeDelete({String? xTraceId}) {
    return _v1DataPurgeDelete(xTraceId: xTraceId?.toString());
  }

  ///Endpoint to purge user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Delete(path: '/v1/data/purge')
  Future<chopper.Response> _v1DataPurgeDelete({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Insight into expenses, grouped by expense account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of expense accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. You can combine both asset / liability and expense account ID's. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseExpenseGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseExpenseGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by expense account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of expense accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. You can combine both asset / liability and expense account ID's. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/expense')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseExpenseGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by asset account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseAssetGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by asset account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/asset')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by revenue account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of revenue accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. You can combine both asset / liability and deposit account ID's. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightIncomeRevenueGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightIncomeRevenueGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into income, grouped by revenue account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of revenue accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. You can combine both asset / liability and deposit account ID's. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/revenue')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeRevenueGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by asset account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightIncomeAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightIncomeAssetGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into income, grouped by asset account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/asset')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTransfer>> v1InsightTransferAssetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTransferEntry,
      () => InsightTransferEntry.fromJsonFactory,
    );

    return _v1InsightTransferAssetGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into transfers, grouped by account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/asset')
  Future<chopper.Response<InsightTransfer>> _v1InsightTransferAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param bills[] The bills to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? bills,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseBillGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      bills: bills,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param bills[] The bills to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/bill')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseBillGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('bills[]') List<int>? bills,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightExpenseNoBillGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightExpenseNoBillGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, without bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/no-bill')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoBillGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param budgets[] The budgets to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseBudgetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? budgets,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseBudgetGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      budgets: budgets,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param budgets[] The budgets to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/budget')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('budgets[]') List<int>? budgets,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightExpenseNoBudgetGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightExpenseNoBudgetGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, without budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/no-budget')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      categories: categories,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/category')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightExpenseNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightExpenseNoCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightIncomeCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightIncomeCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      categories: categories,
      accounts: accounts,
    );
  }

  ///Insight into income, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/category')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightIncomeNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightIncomeNoCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into income, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightTransferCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightTransferCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      categories: categories,
      accounts: accounts,
    );
  }

  ///Insight into transfers, grouped by category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/category')
  Future<chopper.Response<InsightGroup>> _v1InsightTransferCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightTransferNoCategoryGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightTransferNoCategoryGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into transfers, without category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightExpenseTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightExpenseTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      tags: tags,
      accounts: accounts,
    );
  }

  ///Insight into expenses, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightExpenseNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightExpenseNoTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightIncomeTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightIncomeTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      tags: tags,
      accounts: accounts,
    );
  }

  ///Insight into income, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightIncomeNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightIncomeNoTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into income, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> v1InsightTransferTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightGroupEntry,
      () => InsightGroupEntry.fromJsonFactory,
    );

    return _v1InsightTransferTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      tags: tags,
      accounts: accounts,
    );
  }

  ///Insight into transfers, grouped by tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightTransferTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightTransferNoTagGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightTransferNoTagGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into expenses, without tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total expenses.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightExpenseTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightExpenseTotalGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into total expenses.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/expense/total')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total income.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightIncomeTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightIncomeTotalGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into total income.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/income/total')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total transfers.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> v1InsightTransferTotalGet({
    String? xTraceId,
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      InsightTotalEntry,
      () => InsightTotalEntry.fromJsonFactory,
    );

    return _v1InsightTransferTotalGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Insight into total transfers.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/v1/insight/transfer/total')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> v1AccountsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1AccountsIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v1/accounts/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1AccountsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  Future<chopper.Response<AttachmentArray>> v1AccountsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1AccountsIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  @Get(path: '/v1/accounts/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1AccountsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all piggy banks related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  Future<chopper.Response<PiggyBankArray>> v1AccountsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankArray,
      () => PiggyBankArray.fromJsonFactory,
    );

    return _v1AccountsIdPiggyBanksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List all piggy banks related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  @Get(path: '/v1/accounts/{id}/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1AccountsIdPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all accounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  Future<chopper.Response<AccountArray>> v1AccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? date,
    enums.AccountTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      AccountArray,
      () => AccountArray.fromJsonFactory,
    );

    return _v1AccountsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      date: date,
      type: type?.value?.toString(),
    );
  }

  ///List all accounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  @Get(path: '/v1/accounts')
  Future<chopper.Response<AccountArray>> _v1AccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('date') String? date,
    @Query('type') String? type,
  });

  ///Create new account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<AccountSingle>> v1AccountsPost({
    String? xTraceId,
    required AccountStore? body,
  }) {
    generatedMapping.putIfAbsent(
      AccountSingle,
      () => AccountSingle.fromJsonFactory,
    );

    return _v1AccountsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Create new account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/accounts', optionalBody: true)
  Future<chopper.Response<AccountSingle>> _v1AccountsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required AccountStore? body,
  });

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  Future<chopper.Response<AccountSingle>> v1AccountsIdGet({
    String? xTraceId,
    required String? id,
    String? date,
  }) {
    generatedMapping.putIfAbsent(
      AccountSingle,
      () => AccountSingle.fromJsonFactory,
    );

    return _v1AccountsIdGet(xTraceId: xTraceId?.toString(), id: id, date: date);
  }

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  @Get(path: '/v1/accounts/{id}')
  Future<chopper.Response<AccountSingle>> _v1AccountsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('date') String? date,
  });

  ///Update existing account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  Future<chopper.Response<AccountSingle>> v1AccountsIdPut({
    String? xTraceId,
    required String? id,
    required AccountUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      AccountSingle,
      () => AccountSingle.fromJsonFactory,
    );

    return _v1AccountsIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update existing account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  @Put(path: '/v1/accounts/{id}', optionalBody: true)
  Future<chopper.Response<AccountSingle>> _v1AccountsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required AccountUpdate? body,
  });

  ///Permanently delete account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  Future<chopper.Response> v1AccountsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1AccountsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Permanently delete account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  @Delete(path: '/v1/accounts/{id}')
  Future<chopper.Response> _v1AccountsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<AttachmentArray>> v1AttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1AttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/attachments')
  Future<chopper.Response<AttachmentArray>> _v1AttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<AttachmentSingle>> v1AttachmentsPost({
    String? xTraceId,
    required AttachmentStore? body,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentSingle,
      () => AttachmentSingle.fromJsonFactory,
    );

    return _v1AttachmentsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/attachments', optionalBody: true)
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required AttachmentStore? body,
  });

  ///Get a single attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  Future<chopper.Response<AttachmentSingle>> v1AttachmentsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentSingle,
      () => AttachmentSingle.fromJsonFactory,
    );

    return _v1AttachmentsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  @Get(path: '/v1/attachments/{id}')
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  Future<chopper.Response<AttachmentSingle>> v1AttachmentsIdPut({
    String? xTraceId,
    required String? id,
    required AttachmentUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentSingle,
      () => AttachmentSingle.fromJsonFactory,
    );

    return _v1AttachmentsIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  @Put(path: '/v1/attachments/{id}', optionalBody: true)
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required AttachmentUpdate? body,
  });

  ///Delete an attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the single attachment.
  Future<chopper.Response> v1AttachmentsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1AttachmentsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete an attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the single attachment.
  @Delete(path: '/v1/attachments/{id}')
  Future<chopper.Response> _v1AttachmentsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Download a single attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  Future<chopper.Response<String>> v1AttachmentsIdDownloadGet({
    String? xTraceId,
    required String? id,
  }) {
    return _v1AttachmentsIdDownloadGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Download a single attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  @Get(path: '/v1/attachments/{id}/download')
  Future<chopper.Response<String>> _v1AttachmentsIdDownloadGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Upload an attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  Future<chopper.Response> v1AttachmentsIdUploadPost({
    String? xTraceId,
    required String? id,
    required Object? body,
  }) {
    return _v1AttachmentsIdUploadPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Upload an attachment.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the attachment.
  @Post(path: '/v1/attachments/{id}/upload', optionalBody: true)
  Future<chopper.Response> _v1AttachmentsIdUploadPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required Object? body,
  });

  ///List all available budget amounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<AvailableBudgetArray>> v1AvailableBudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      AvailableBudgetArray,
      () => AvailableBudgetArray.fromJsonFactory,
    );

    return _v1AvailableBudgetsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      start: start,
      end: end,
    );
  }

  ///List all available budget amounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v1/available-budgets')
  Future<chopper.Response<AvailableBudgetArray>> _v1AvailableBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Get a single available budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the available budget.
  Future<chopper.Response<AvailableBudgetSingle>> v1AvailableBudgetsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AvailableBudgetSingle,
      () => AvailableBudgetSingle.fromJsonFactory,
    );

    return _v1AvailableBudgetsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single available budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the available budget.
  @Get(path: '/v1/available-budgets/{id}')
  Future<chopper.Response<AvailableBudgetSingle>> _v1AvailableBudgetsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all attachments uploaded to the bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the bill.
  Future<chopper.Response<AttachmentArray>> v1BillsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1BillsIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List all attachments uploaded to the bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the bill.
  @Get(path: '/v1/bills/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1BillsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all rules associated with the bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  Future<chopper.Response<RuleArray>> v1BillsIdRulesGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _v1BillsIdRulesGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///List all rules associated with the bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  @Get(path: '/v1/bills/{id}/rules')
  Future<chopper.Response<RuleArray>> _v1BillsIdRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all transactions associated with the  bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> v1BillsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1BillsIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions associated with the  bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/bills/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1BillsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all bills.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  Future<chopper.Response<BillArray>> v1BillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _v1BillsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      start: start,
      end: end,
    );
  }

  ///List all bills.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @Get(path: '/v1/bills')
  Future<chopper.Response<BillArray>> _v1BillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new bill
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<BillSingle>> v1BillsPost({
    String? xTraceId,
    required BillStore? body,
  }) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _v1BillsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new bill
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/bills', optionalBody: true)
  Future<chopper.Response<BillSingle>> _v1BillsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required BillStore? body,
  });

  ///Get a single bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  Future<chopper.Response<BillSingle>> v1BillsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _v1BillsIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
    );
  }

  ///Get a single bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @Get(path: '/v1/bills/{id}')
  Future<chopper.Response<BillSingle>> _v1BillsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  Future<chopper.Response<BillSingle>> v1BillsIdPut({
    String? xTraceId,
    required String? id,
    required BillUpdate? body,
  }) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _v1BillsIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update existing bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  @Put(path: '/v1/bills/{id}', optionalBody: true)
  Future<chopper.Response<BillSingle>> _v1BillsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BillUpdate? body,
  });

  ///Delete a bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  Future<chopper.Response> v1BillsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1BillsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a bill.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the bill.
  @Delete(path: '/v1/bills/{id}')
  Future<chopper.Response> _v1BillsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all transactions by a budget limit ID.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>>
  v1BudgetsIdLimitsLimitIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    required String? limitId,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1BudgetsIdLimitsLimitIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      limitId: limitId,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions by a budget limit ID.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/budgets/{id}/limits/{limitId}/transactions')
  Future<chopper.Response<TransactionArray>>
  _v1BudgetsIdLimitsLimitIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Query('type') String? type,
  });

  ///Get all limits for a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<BudgetLimitArray>> v1BudgetsIdLimitsGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitArray,
      () => BudgetLimitArray.fromJsonFactory,
    );

    return _v1BudgetsIdLimitsGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
    );
  }

  ///Get all limits for a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v1/budgets/{id}/limits')
  Future<chopper.Response<BudgetLimitArray>> _v1BudgetsIdLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store new budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  Future<chopper.Response<BudgetLimitSingle>> v1BudgetsIdLimitsPost({
    String? xTraceId,
    required String? id,
    required BudgetLimitStore? body,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitSingle,
      () => BudgetLimitSingle.fromJsonFactory,
    );

    return _v1BudgetsIdLimitsPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Store new budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  @Post(path: '/v1/budgets/{id}/limits', optionalBody: true)
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BudgetLimitStore? body,
  });

  ///Get single budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response<BudgetLimitSingle>> v1BudgetsIdLimitsLimitIdGet({
    String? xTraceId,
    required String? id,
    required int? limitId,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitSingle,
      () => BudgetLimitSingle.fromJsonFactory,
    );

    return _v1BudgetsIdLimitsLimitIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      limitId: limitId,
    );
  }

  ///Get single budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Get(path: '/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required int? limitId,
  });

  ///Update existing budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response<BudgetLimitSingle>> v1BudgetsIdLimitsLimitIdPut({
    String? xTraceId,
    required String? id,
    required String? limitId,
    required BudgetLimit? body,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitSingle,
      () => BudgetLimitSingle.fromJsonFactory,
    );

    return _v1BudgetsIdLimitsLimitIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      limitId: limitId,
      body: body,
    );
  }

  ///Update existing budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Put(path: '/v1/budgets/{id}/limits/{limitId}', optionalBody: true)
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Body() required BudgetLimit? body,
  });

  ///Delete a budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response> v1BudgetsIdLimitsLimitIdDelete({
    String? xTraceId,
    required String? id,
    required String? limitId,
  }) {
    return _v1BudgetsIdLimitsLimitIdDelete(
      xTraceId: xTraceId?.toString(),
      id: id,
      limitId: limitId,
    );
  }

  ///Delete a budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Delete(path: '/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response> _v1BudgetsIdLimitsLimitIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
  });

  ///Get list of budget limits by date
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<BudgetLimitArray>> v1BudgetLimitsGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitArray,
      () => BudgetLimitArray.fromJsonFactory,
    );

    return _v1BudgetLimitsGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
    );
  }

  ///Get list of budget limits by date
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v1/budget-limits')
  Future<chopper.Response<BudgetLimitArray>> _v1BudgetLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///All transactions to a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> v1BudgetsIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1BudgetsIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///All transactions to a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/budgets/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1BudgetsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments of a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget.
  Future<chopper.Response<AttachmentArray>> v1BudgetsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1BudgetsIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all attachments of a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the budget.
  @Get(path: '/v1/budgets/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1BudgetsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///All transactions without a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionArray>>
  v1BudgetsTransactionsWithoutBudgetGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1BudgetsTransactionsWithoutBudgetGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      start: start,
      end: end,
    );
  }

  ///All transactions without a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v1/budgets//transactions-without-budget')
  Future<chopper.Response<TransactionArray>>
  _v1BudgetsTransactionsWithoutBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///List all budgets.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  Future<chopper.Response<BudgetArray>> v1BudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      BudgetArray,
      () => BudgetArray.fromJsonFactory,
    );

    return _v1BudgetsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      start: start,
      end: end,
    );
  }

  ///List all budgets.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  @Get(path: '/v1/budgets')
  Future<chopper.Response<BudgetArray>> _v1BudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new budget
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<BudgetSingle>> v1BudgetsPost({
    String? xTraceId,
    required BudgetStore? body,
  }) {
    generatedMapping.putIfAbsent(
      BudgetSingle,
      () => BudgetSingle.fromJsonFactory,
    );

    return _v1BudgetsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new budget
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/budgets', optionalBody: true)
  Future<chopper.Response<BudgetSingle>> _v1BudgetsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required BudgetStore? body,
  });

  ///Get a single budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  Future<chopper.Response<BudgetSingle>> v1BudgetsIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      BudgetSingle,
      () => BudgetSingle.fromJsonFactory,
    );

    return _v1BudgetsIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
    );
  }

  ///Get a single budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  @Get(path: '/v1/budgets/{id}')
  Future<chopper.Response<BudgetSingle>> _v1BudgetsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  Future<chopper.Response<BudgetSingle>> v1BudgetsIdPut({
    String? xTraceId,
    required String? id,
    required BudgetUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      BudgetSingle,
      () => BudgetSingle.fromJsonFactory,
    );

    return _v1BudgetsIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update existing budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  @Put(path: '/v1/budgets/{id}', optionalBody: true)
  Future<chopper.Response<BudgetSingle>> _v1BudgetsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BudgetUpdate? body,
  });

  ///Delete a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  Future<chopper.Response> v1BudgetsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1BudgetsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget.
  @Delete(path: '/v1/budgets/{id}')
  Future<chopper.Response> _v1BudgetsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all transactions in a category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to limit the result list.
  ///@param end A date formatted YYYY-MM-DD, to limit the result list.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> v1CategoriesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1CategoriesIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions in a category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to limit the result list.
  ///@param end A date formatted YYYY-MM-DD, to limit the result list.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/categories/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1CategoriesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the category.
  Future<chopper.Response<AttachmentArray>> v1CategoriesIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1CategoriesIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the category.
  @Get(path: '/v1/categories/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1CategoriesIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all categories.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<CategoryArray>> v1CategoriesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      CategoryArray,
      () => CategoryArray.fromJsonFactory,
    );

    return _v1CategoriesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all categories.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/categories')
  Future<chopper.Response<CategoryArray>> _v1CategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new category
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CategorySingle>> v1CategoriesPost({
    String? xTraceId,
    required Category? body,
  }) {
    generatedMapping.putIfAbsent(
      CategorySingle,
      () => CategorySingle.fromJsonFactory,
    );

    return _v1CategoriesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new category
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/categories', optionalBody: true)
  Future<chopper.Response<CategorySingle>> _v1CategoriesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required Category? body,
  });

  ///Get a single category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to show spent and earned info.
  ///@param end A date formatted YYYY-MM-DD, to show spent and earned info.
  Future<chopper.Response<CategorySingle>> v1CategoriesIdGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      CategorySingle,
      () => CategorySingle.fromJsonFactory,
    );

    return _v1CategoriesIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
    );
  }

  ///Get a single category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to show spent and earned info.
  ///@param end A date formatted YYYY-MM-DD, to show spent and earned info.
  @Get(path: '/v1/categories/{id}')
  Future<chopper.Response<CategorySingle>> _v1CategoriesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  Future<chopper.Response<CategorySingle>> v1CategoriesIdPut({
    String? xTraceId,
    required String? id,
    required CategoryUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      CategorySingle,
      () => CategorySingle.fromJsonFactory,
    );

    return _v1CategoriesIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  @Put(path: '/v1/categories/{id}', optionalBody: true)
  Future<chopper.Response<CategorySingle>> _v1CategoriesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required CategoryUpdate? body,
  });

  ///Delete a category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  Future<chopper.Response> v1CategoriesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1CategoriesIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a category.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the category.
  @Delete(path: '/v1/categories/{id}')
  Future<chopper.Response> _v1CategoriesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all exchange rates.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<CurrencyExchangeRateArray>> v1ExchangeRatesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateArray,
      () => CurrencyExchangeRateArray.fromJsonFactory,
    );

    return _v1ExchangeRatesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all exchange rates.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/exchange-rates')
  Future<chopper.Response<CurrencyExchangeRateArray>> _v1ExchangeRatesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///List a single specific exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the requested currency exchange rate.
  Future<chopper.Response<CurrencyExchangeRateSingle>> v1ExchangeRatesIdGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateSingle,
      () => CurrencyExchangeRateSingle.fromJsonFactory,
    );

    return _v1ExchangeRatesIdGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List a single specific exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the requested currency exchange rate.
  @Get(path: '/v1/exchange-rates/{id}')
  Future<chopper.Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///Delete a specific currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested currency exchange rate.
  Future<chopper.Response> v1ExchangeRatesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1ExchangeRatesIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a specific currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the requested currency exchange rate.
  @Delete(path: '/v1/exchange-rates/{id}')
  Future<chopper.Response> _v1ExchangeRatesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the currency exchange rate.
  Future<chopper.Response<CurrencyExchangeRateSingle>> v1ExchangeRatesIdPut({
    String? xTraceId,
    required String? id,
    required CurrencyExchangeRateUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateSingle,
      () => CurrencyExchangeRateSingle.fromJsonFactory,
    );

    return _v1ExchangeRatesIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the currency exchange rate.
  @Put(path: '/v1/exchange-rates/{id}', optionalBody: true)
  Future<chopper.Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required CurrencyExchangeRateUpdate? body,
  });

  ///List all exchange rate from/to the mentioned currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  Future<chopper.Response<CurrencyExchangeRateArray>>
  v1ExchangeRatesRatesFromToGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? from,
    required String? to,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateArray,
      () => CurrencyExchangeRateArray.fromJsonFactory,
    );

    return _v1ExchangeRatesRatesFromToGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      from: from,
      to: to,
    );
  }

  ///List all exchange rate from/to the mentioned currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  @Get(path: '/v1/exchange-rates/rates/{from}/{to}')
  Future<chopper.Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesRatesFromToGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('from') required String? from,
    @Path('to') required String? to,
  });

  ///Delete all currency exchange rates from 'from' to 'to'.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date A date formatted YYYY-MM-DD. Defaults to today.
  Future<chopper.Response> v1ExchangeRatesRatesFromToDelete({
    String? xTraceId,
    required String? from,
    required String? to,
    String? date,
  }) {
    return _v1ExchangeRatesRatesFromToDelete(
      xTraceId: xTraceId?.toString(),
      from: from,
      to: to,
      date: date,
    );
  }

  ///Delete all currency exchange rates from 'from' to 'to'.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date A date formatted YYYY-MM-DD. Defaults to today.
  @Delete(path: '/v1/exchange-rates/rates/{from}/{to}')
  Future<chopper.Response> _v1ExchangeRatesRatesFromToDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @Query('date') String? date,
  });

  ///List all transactions under this link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the link type.
  ///@param start A date formatted YYYY-MM-DD, to limit the results.
  ///@param end A date formatted YYYY-MM-DD, to limit the results.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> v1LinkTypesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1LinkTypesIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions under this link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the link type.
  ///@param start A date formatted YYYY-MM-DD, to limit the results.
  ///@param end A date formatted YYYY-MM-DD, to limit the results.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v1/link-types/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1LinkTypesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all types of links.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<LinkTypeArray>> v1LinkTypesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      LinkTypeArray,
      () => LinkTypeArray.fromJsonFactory,
    );

    return _v1LinkTypesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all types of links.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/link-types')
  Future<chopper.Response<LinkTypeArray>> _v1LinkTypesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Create a new link type
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<LinkTypeSingle>> v1LinkTypesPost({
    String? xTraceId,
    required LinkType? body,
  }) {
    generatedMapping.putIfAbsent(
      LinkTypeSingle,
      () => LinkTypeSingle.fromJsonFactory,
    );

    return _v1LinkTypesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Create a new link type
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/link-types', optionalBody: true)
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required LinkType? body,
  });

  ///Get single a link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  Future<chopper.Response<LinkTypeSingle>> v1LinkTypesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      LinkTypeSingle,
      () => LinkTypeSingle.fromJsonFactory,
    );

    return _v1LinkTypesIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get single a link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  @Get(path: '/v1/link-types/{id}')
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  Future<chopper.Response<LinkTypeSingle>> v1LinkTypesIdPut({
    String? xTraceId,
    required String? id,
    required LinkTypeUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      LinkTypeSingle,
      () => LinkTypeSingle.fromJsonFactory,
    );

    return _v1LinkTypesIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  @Put(path: '/v1/link-types/{id}', optionalBody: true)
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required LinkTypeUpdate? body,
  });

  ///Permanently delete link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  Future<chopper.Response> v1LinkTypesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1LinkTypesIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Permanently delete link type.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the link type.
  @Delete(path: '/v1/link-types/{id}')
  Future<chopper.Response> _v1LinkTypesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all transaction links.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<TransactionLinkArray>> v1TransactionLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      TransactionLinkArray,
      () => TransactionLinkArray.fromJsonFactory,
    );

    return _v1TransactionLinksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all transaction links.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/transaction-links')
  Future<chopper.Response<TransactionLinkArray>> _v1TransactionLinksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Create a new link between transactions
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<TransactionLinkSingle>> v1TransactionLinksPost({
    String? xTraceId,
    required TransactionLinkStore? body,
  }) {
    generatedMapping.putIfAbsent(
      TransactionLinkSingle,
      () => TransactionLinkSingle.fromJsonFactory,
    );

    return _v1TransactionLinksPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Create a new link between transactions
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/transaction-links', optionalBody: true)
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TransactionLinkStore? body,
  });

  ///Get a single link.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  Future<chopper.Response<TransactionLinkSingle>> v1TransactionLinksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      TransactionLinkSingle,
      () => TransactionLinkSingle.fromJsonFactory,
    );

    return _v1TransactionLinksIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single link.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  @Get(path: '/v1/transaction-links/{id}')
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Permanently delete link between transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  Future<chopper.Response> v1TransactionLinksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1TransactionLinksIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Permanently delete link between transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  @Delete(path: '/v1/transaction-links/{id}')
  Future<chopper.Response> _v1TransactionLinksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update an existing link between transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  Future<chopper.Response<TransactionLinkSingle>> v1TransactionLinksIdPut({
    String? xTraceId,
    required String? id,
    required TransactionLinkUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      TransactionLinkSingle,
      () => TransactionLinkSingle.fromJsonFactory,
    );

    return _v1TransactionLinksIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update an existing link between transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction link.
  @Put(path: '/v1/transaction-links/{id}', optionalBody: true)
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required TransactionLinkUpdate? body,
  });

  ///List all piggy banks related to the object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  Future<chopper.Response<PiggyBankArray>> v1ObjectGroupsIdPiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankArray,
      () => PiggyBankArray.fromJsonFactory,
    );

    return _v1ObjectGroupsIdPiggyBanksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List all piggy banks related to the object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  @Get(path: '/v1/object-groups/{id}/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1ObjectGroupsIdPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all bills with this object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  Future<chopper.Response<BillArray>> v1ObjectGroupsIdBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _v1ObjectGroupsIdBillsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List all bills with this object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the account.
  @Get(path: '/v1/object-groups/{id}/bills')
  Future<chopper.Response<BillArray>> _v1ObjectGroupsIdBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all oject groups.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<ObjectGroupArray>> v1ObjectGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      ObjectGroupArray,
      () => ObjectGroupArray.fromJsonFactory,
    );

    return _v1ObjectGroupsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all oject groups.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/object-groups')
  Future<chopper.Response<ObjectGroupArray>> _v1ObjectGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Get a single object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group.
  Future<chopper.Response<ObjectGroupSingle>> v1ObjectGroupsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      ObjectGroupSingle,
      () => ObjectGroupSingle.fromJsonFactory,
    );

    return _v1ObjectGroupsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group.
  @Get(path: '/v1/object-groups/{id}')
  Future<chopper.Response<ObjectGroupSingle>> _v1ObjectGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group
  Future<chopper.Response<ObjectGroupSingle>> v1ObjectGroupsIdPut({
    String? xTraceId,
    required String? id,
    required ObjectGroupUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      ObjectGroupSingle,
      () => ObjectGroupSingle.fromJsonFactory,
    );

    return _v1ObjectGroupsIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group
  @Put(path: '/v1/object-groups/{id}', optionalBody: true)
  Future<chopper.Response<ObjectGroupSingle>> _v1ObjectGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required ObjectGroupUpdate? body,
  });

  ///Delete a object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group.
  Future<chopper.Response> v1ObjectGroupsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1ObjectGroupsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a object group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object group.
  @Delete(path: '/v1/object-groups/{id}')
  Future<chopper.Response> _v1ObjectGroupsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all events linked to a piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the piggy bank
  Future<chopper.Response<PiggyBankEventArray>> v1PiggyBanksIdEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankEventArray,
      () => PiggyBankEventArray.fromJsonFactory,
    );

    return _v1PiggyBanksIdEventsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List all events linked to a piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the piggy bank
  @Get(path: '/v1/piggy-banks/{id}/events')
  Future<chopper.Response<PiggyBankEventArray>> _v1PiggyBanksIdEventsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the piggy bank.
  Future<chopper.Response<AttachmentArray>> v1PiggyBanksIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1PiggyBanksIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the piggy bank.
  @Get(path: '/v1/piggy-banks/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1PiggyBanksIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all piggy banks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<PiggyBankArray>> v1PiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankArray,
      () => PiggyBankArray.fromJsonFactory,
    );

    return _v1PiggyBanksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all piggy banks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1PiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new piggy bank
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<PiggyBankSingle>> v1PiggyBanksPost({
    String? xTraceId,
    required PiggyBankStore? body,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankSingle,
      () => PiggyBankSingle.fromJsonFactory,
    );

    return _v1PiggyBanksPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new piggy bank
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/piggy-banks', optionalBody: true)
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required PiggyBankStore? body,
  });

  ///Get a single piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank.
  Future<chopper.Response<PiggyBankSingle>> v1PiggyBanksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankSingle,
      () => PiggyBankSingle.fromJsonFactory,
    );

    return _v1PiggyBanksIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank.
  @Get(path: '/v1/piggy-banks/{id}')
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank
  Future<chopper.Response<PiggyBankSingle>> v1PiggyBanksIdPut({
    String? xTraceId,
    required String? id,
    required PiggyBankUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankSingle,
      () => PiggyBankSingle.fromJsonFactory,
    );

    return _v1PiggyBanksIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank
  @Put(path: '/v1/piggy-banks/{id}', optionalBody: true)
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required PiggyBankUpdate? body,
  });

  ///Delete a piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank.
  Future<chopper.Response> v1PiggyBanksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1PiggyBanksIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a piggy bank.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the piggy bank.
  @Delete(path: '/v1/piggy-banks/{id}')
  Future<chopper.Response> _v1PiggyBanksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all transactions created by a recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the recurring transaction.
  ///@param start A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param end A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> v1RecurrencesIdTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1RecurrencesIdTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions created by a recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the recurring transaction.
  ///@param start A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param end A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/recurrences/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1RecurrencesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all recurring transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<RecurrenceArray>> v1RecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      RecurrenceArray,
      () => RecurrenceArray.fromJsonFactory,
    );

    return _v1RecurrencesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all recurring transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/recurrences')
  Future<chopper.Response<RecurrenceArray>> _v1RecurrencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new recurring transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<RecurrenceSingle>> v1RecurrencesPost({
    String? xTraceId,
    required RecurrenceStore? body,
  }) {
    generatedMapping.putIfAbsent(
      RecurrenceSingle,
      () => RecurrenceSingle.fromJsonFactory,
    );

    return _v1RecurrencesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new recurring transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/recurrences', optionalBody: true)
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RecurrenceStore? body,
  });

  ///Get a single recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response<RecurrenceSingle>> v1RecurrencesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      RecurrenceSingle,
      () => RecurrenceSingle.fromJsonFactory,
    );

    return _v1RecurrencesIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  @Get(path: '/v1/recurrences/{id}')
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response<RecurrenceSingle>> v1RecurrencesIdPut({
    String? xTraceId,
    required String? id,
    required RecurrenceUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      RecurrenceSingle,
      () => RecurrenceSingle.fromJsonFactory,
    );

    return _v1RecurrencesIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  @Put(path: '/v1/recurrences/{id}', optionalBody: true)
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RecurrenceUpdate? body,
  });

  ///Delete a recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response> v1RecurrencesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1RecurrencesIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a recurring transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  @Delete(path: '/v1/recurrences/{id}')
  Future<chopper.Response> _v1RecurrencesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List rules in this rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the rule group.
  Future<chopper.Response<RuleArray>> v1RuleGroupsIdRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _v1RuleGroupsIdRulesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///List rules in this rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the rule group.
  @Get(path: '/v1/rule-groups/{id}/rules')
  Future<chopper.Response<RuleArray>> _v1RuleGroupsIdRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///Test which transactions would be hit by the rule group. No changes will be made.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param search_limit Maximum number of transactions Firefly III will try. Don't set this too high, or it will take Firefly III very long to run the test. I suggest a max of 200.
  ///@param triggered_limit Maximum number of transactions the rule group can actually trigger on, before Firefly III stops. I would suggest setting this to 10 or 15. Don't go above the user's page size, because browsing to page 2 or 3 of a test result would fire the test again, making any navigation efforts very slow.
  ///@param accounts[] Limit the testing of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response<TransactionArray>> v1RuleGroupsIdTestGet({
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
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1RuleGroupsIdTestGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      start: start,
      end: end,
      searchLimit: searchLimit,
      triggeredLimit: triggeredLimit,
      accounts: accounts,
    );
  }

  ///Test which transactions would be hit by the rule group. No changes will be made.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param search_limit Maximum number of transactions Firefly III will try. Don't set this too high, or it will take Firefly III very long to run the test. I suggest a max of 200.
  ///@param triggered_limit Maximum number of transactions the rule group can actually trigger on, before Firefly III stops. I would suggest setting this to 10 or 15. Don't go above the user's page size, because browsing to page 2 or 3 of a test result would fire the test again, making any navigation efforts very slow.
  ///@param accounts[] Limit the testing of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Get(path: '/v1/rule-groups/{id}/test')
  Future<chopper.Response<TransactionArray>> _v1RuleGroupsIdTestGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('search_limit') int? searchLimit,
    @Query('triggered_limit') int? triggeredLimit,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Fire the rule group on your transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response> v1RuleGroupsIdTriggerPost({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    return _v1RuleGroupsIdTriggerPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Fire the rule group on your transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Post(path: '/v1/rule-groups/{id}/trigger', optionalBody: true)
  Future<chopper.Response> _v1RuleGroupsIdTriggerPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///List all rule groups.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<RuleGroupArray>> v1RuleGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      RuleGroupArray,
      () => RuleGroupArray.fromJsonFactory,
    );

    return _v1RuleGroupsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all rule groups.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/rule-groups')
  Future<chopper.Response<RuleGroupArray>> _v1RuleGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<RuleGroupSingle>> v1RuleGroupsPost({
    String? xTraceId,
    required RuleGroupStore? body,
  }) {
    generatedMapping.putIfAbsent(
      RuleGroupSingle,
      () => RuleGroupSingle.fromJsonFactory,
    );

    return _v1RuleGroupsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/rule-groups', optionalBody: true)
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RuleGroupStore? body,
  });

  ///Get a single rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  Future<chopper.Response<RuleGroupSingle>> v1RuleGroupsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      RuleGroupSingle,
      () => RuleGroupSingle.fromJsonFactory,
    );

    return _v1RuleGroupsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  @Get(path: '/v1/rule-groups/{id}')
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  Future<chopper.Response<RuleGroupSingle>> v1RuleGroupsIdPut({
    String? xTraceId,
    required String? id,
    required RuleGroupUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      RuleGroupSingle,
      () => RuleGroupSingle.fromJsonFactory,
    );

    return _v1RuleGroupsIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  @Put(path: '/v1/rule-groups/{id}', optionalBody: true)
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RuleGroupUpdate? body,
  });

  ///Delete a rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  Future<chopper.Response> v1RuleGroupsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1RuleGroupsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a rule group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule group.
  @Delete(path: '/v1/rule-groups/{id}')
  Future<chopper.Response> _v1RuleGroupsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Test which transactions would be hit by the rule. No changes will be made.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the testing of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response<TransactionArray>> v1RulesIdTestGet({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1RulesIdTestGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Test which transactions would be hit by the rule. No changes will be made.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the testing of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Get(path: '/v1/rules/{id}/test')
  Future<chopper.Response<TransactionArray>> _v1RulesIdTestGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Fire the rule on your transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the start date is not present, it will be set to one year ago. If you use this field, both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the end date is not present, it will be set to today. If you use this field, both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response> v1RulesIdTriggerPost({
    String? xTraceId,
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    return _v1RulesIdTriggerPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      start: start,
      end: end,
      accounts: accounts,
    );
  }

  ///Fire the rule on your transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the start date is not present, it will be set to one year ago. If you use this field, both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the end date is not present, it will be set to today. If you use this field, both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Post(path: '/v1/rules/{id}/trigger', optionalBody: true)
  Future<chopper.Response> _v1RulesIdTriggerPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///List all rules.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<RuleArray>> v1RulesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _v1RulesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all rules.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/rules')
  Future<chopper.Response<RuleArray>> _v1RulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new rule
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<RuleSingle>> v1RulesPost({
    String? xTraceId,
    required RuleStore? body,
  }) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _v1RulesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new rule
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/rules', optionalBody: true)
  Future<chopper.Response<RuleSingle>> _v1RulesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RuleStore? body,
  });

  ///Get a single rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object.
  Future<chopper.Response<RuleSingle>> v1RulesIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _v1RulesIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object.
  @Get(path: '/v1/rules/{id}')
  Future<chopper.Response<RuleSingle>> _v1RulesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object.
  Future<chopper.Response<RuleSingle>> v1RulesIdPut({
    String? xTraceId,
    required String? id,
    required RuleUpdate? body,
  }) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _v1RulesIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update existing rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the object.
  @Put(path: '/v1/rules/{id}', optionalBody: true)
  Future<chopper.Response<RuleSingle>> _v1RulesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RuleUpdate? body,
  });

  ///Delete an rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  Future<chopper.Response> v1RulesIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1RulesIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete an rule.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the rule.
  @Delete(path: '/v1/rules/{id}')
  Future<chopper.Response> _v1RulesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID.
  Future<chopper.Response<AttachmentArray>> v1TagsTagAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1TagsTagAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      tag: tag,
    );
  }

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID.
  @Get(path: '/v1/tags/{tag}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1TagsTagAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
  });

  ///List all transactions with this tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> v1TagsTagTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1TagsTagTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      tag: tag,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions with this tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v1/tags/{tag}/transactions')
  Future<chopper.Response<TransactionArray>> _v1TagsTagTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all tags.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<TagArray>> v1TagsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(TagArray, () => TagArray.fromJsonFactory);

    return _v1TagsGet(xTraceId: xTraceId?.toString(), limit: limit, page: page);
  }

  ///List all tags.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/tags')
  Future<chopper.Response<TagArray>> _v1TagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new tag
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<TagSingle>> v1TagsPost({
    String? xTraceId,
    required TagModelStore? body,
  }) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _v1TagsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new tag
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/tags', optionalBody: true)
  Future<chopper.Response<TagSingle>> _v1TagsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TagModelStore? body,
  });

  ///Get a single tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  Future<chopper.Response<TagSingle>> v1TagsTagGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? tag,
  }) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _v1TagsTagGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      tag: tag,
    );
  }

  ///Get a single tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @Get(path: '/v1/tags/{tag}')
  Future<chopper.Response<TagSingle>> _v1TagsTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
  });

  ///Update existing tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  Future<chopper.Response<TagSingle>> v1TagsTagPut({
    String? xTraceId,
    required String? tag,
    required TagModelUpdate? body,
  }) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _v1TagsTagPut(xTraceId: xTraceId?.toString(), tag: tag, body: body);
  }

  ///Update existing tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @Put(path: '/v1/tags/{tag}', optionalBody: true)
  Future<chopper.Response<TagSingle>> _v1TagsTagPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('tag') required String? tag,
    @Body() required TagModelUpdate? body,
  });

  ///Delete an tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  Future<chopper.Response> v1TagsTagDelete({
    String? xTraceId,
    required String? tag,
  }) {
    return _v1TagsTagDelete(xTraceId: xTraceId?.toString(), tag: tag);
  }

  ///Delete an tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @Delete(path: '/v1/tags/{tag}')
  Future<chopper.Response> _v1TagsTagDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('tag') required String? tag,
  });

  ///List all accounts with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  Future<chopper.Response<AccountArray>> v1CurrenciesCodeAccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? date,
    enums.AccountTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      AccountArray,
      () => AccountArray.fromJsonFactory,
    );

    return _v1CurrenciesCodeAccountsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
      date: date,
      type: type?.value?.toString(),
    );
  }

  ///List all accounts with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  @Get(path: '/v1/currencies/{code}/accounts')
  Future<chopper.Response<AccountArray>> _v1CurrenciesCodeAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('date') String? date,
    @Query('type') String? type,
  });

  ///List all available budgets with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  Future<chopper.Response<AvailableBudgetArray>>
  v1CurrenciesCodeAvailableBudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      AvailableBudgetArray,
      () => AvailableBudgetArray.fromJsonFactory,
    );

    return _v1CurrenciesCodeAvailableBudgetsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
    );
  }

  ///List all available budgets with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  @Get(path: '/v1/currencies/{code}/available-budgets')
  Future<chopper.Response<AvailableBudgetArray>>
  _v1CurrenciesCodeAvailableBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
  });

  ///List all bills with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  Future<chopper.Response<BillArray>> v1CurrenciesCodeBillsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _v1CurrenciesCodeBillsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
    );
  }

  ///List all bills with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  @Get(path: '/v1/currencies/{code}/bills')
  Future<chopper.Response<BillArray>> _v1CurrenciesCodeBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
  });

  ///List all budget limits with this currency
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param start Start date for the budget limit list.
  ///@param end End date for the budget limit list.
  Future<chopper.Response<BudgetLimitArray>> v1CurrenciesCodeBudgetLimitsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
      BudgetLimitArray,
      () => BudgetLimitArray.fromJsonFactory,
    );

    return _v1CurrenciesCodeBudgetLimitsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
      start: start,
      end: end,
    );
  }

  ///List all budget limits with this currency
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param start Start date for the budget limit list.
  ///@param end End date for the budget limit list.
  @Get(path: '/v1/currencies/{code}/budget-limits')
  Future<chopper.Response<BudgetLimitArray>> _v1CurrenciesCodeBudgetLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///List all recurring transactions with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  Future<chopper.Response<RecurrenceArray>> v1CurrenciesCodeRecurrencesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      RecurrenceArray,
      () => RecurrenceArray.fromJsonFactory,
    );

    return _v1CurrenciesCodeRecurrencesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
    );
  }

  ///List all recurring transactions with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  @Get(path: '/v1/currencies/{code}/recurrences')
  Future<chopper.Response<RecurrenceArray>> _v1CurrenciesCodeRecurrencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
  });

  ///List all rules with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  Future<chopper.Response<RuleArray>> v1CurrenciesCodeRulesGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _v1CurrenciesCodeRulesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
    );
  }

  ///List all rules with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  @Get(path: '/v1/currencies/{code}/rules')
  Future<chopper.Response<RuleArray>> _v1CurrenciesCodeRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
  });

  ///List all transactions with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param start A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param end A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> v1CurrenciesCodeTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? code,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1CurrenciesCodeTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      code: code,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all transactions with this currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param code The currency code.
  ///@param start A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param end A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/v1/currencies/{code}/transactions')
  Future<chopper.Response<TransactionArray>> _v1CurrenciesCodeTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<CurrencyArray>> v1CurrenciesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyArray,
      () => CurrencyArray.fromJsonFactory,
    );

    return _v1CurrenciesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/currencies')
  Future<chopper.Response<CurrencyArray>> _v1CurrenciesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new currency
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesPost({
    String? xTraceId,
    required CurrencyStore? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new currency
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/currencies', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required CurrencyStore? body,
  });

  ///Enable a single currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodeEnablePost({
    String? xTraceId,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodeEnablePost(
      xTraceId: xTraceId?.toString(),
      code: code,
    );
  }

  ///Enable a single currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Post(path: '/v1/currencies/{code}/enable', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeEnablePost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
  });

  ///Disable a currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodeDisablePost({
    String? xTraceId,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodeDisablePost(
      xTraceId: xTraceId?.toString(),
      code: code,
    );
  }

  ///Disable a currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Post(path: '/v1/currencies/{code}/disable', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeDisablePost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
  });

  ///Make currency default currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodeDefaultPost({
    String? xTraceId,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodeDefaultPost(
      xTraceId: xTraceId?.toString(),
      code: code,
    );
  }

  ///Make currency default currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Post(path: '/v1/currencies/{code}/default', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeDefaultPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
  });

  ///Get a single currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodeGet({
    String? xTraceId,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodeGet(xTraceId: xTraceId?.toString(), code: code);
  }

  ///Get a single currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Get(path: '/v1/currencies/{code}')
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
  });

  ///Update existing currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodePut({
    String? xTraceId,
    required String? code,
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodePut(
      xTraceId: xTraceId?.toString(),
      code: code,
      body: body,
    );
  }

  ///Update existing currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Put(
    path: '/v1/currencies/{code}',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @Body() required Map<String, String> body,
  });

  ///Delete a currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response> v1CurrenciesCodeDelete({
    String? xTraceId,
    required String? code,
  }) {
    return _v1CurrenciesCodeDelete(xTraceId: xTraceId?.toString(), code: code);
  }

  ///Delete a currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @Delete(path: '/v1/currencies/{code}')
  Future<chopper.Response> _v1CurrenciesCodeDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
  });

  ///Get the user's default currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesDefaultGet({
    String? xTraceId,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesDefaultGet(xTraceId: xTraceId?.toString());
  }

  ///Get the user's default currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Get(path: '/v1/currencies/default')
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesDefaultGet({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Get the native currency of the current administration.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesNativeGet({
    String? xTraceId,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesNativeGet(xTraceId: xTraceId?.toString());
  }

  ///Get the native currency of the current administration.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Get(path: '/v1/currencies/native')
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesNativeGet({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Lists all the transaction links for an individual journal (individual split).
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction journal / the split.
  Future<chopper.Response<TransactionLinkArray>>
  v1TransactionJournalsIdLinksGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      TransactionLinkArray,
      () => TransactionLinkArray.fromJsonFactory,
    );

    return _v1TransactionJournalsIdLinksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all the transaction links for an individual journal (individual split).
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction journal / the split.
  @Get(path: '/v1/transaction-journals/{id}/links')
  Future<chopper.Response<TransactionLinkArray>>
  _v1TransactionJournalsIdLinksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///Get a single transaction, based on one of the underlying transaction journals (transaction splits).
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction journal (split).
  Future<chopper.Response<TransactionSingle>> v1TransactionJournalsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      TransactionSingle,
      () => TransactionSingle.fromJsonFactory,
    );

    return _v1TransactionJournalsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single transaction, based on one of the underlying transaction journals (transaction splits).
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction journal (split).
  @Get(path: '/v1/transaction-journals/{id}')
  Future<chopper.Response<TransactionSingle>> _v1TransactionJournalsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Delete split from transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction journal (the split) you wish to delete.
  Future<chopper.Response> v1TransactionJournalsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1TransactionJournalsIdDelete(
      xTraceId: xTraceId?.toString(),
      id: id,
    );
  }

  ///Delete split from transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction journal (the split) you wish to delete.
  @Delete(path: '/v1/transaction-journals/{id}')
  Future<chopper.Response> _v1TransactionJournalsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction.
  Future<chopper.Response<AttachmentArray>> v1TransactionsIdAttachmentsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AttachmentArray,
      () => AttachmentArray.fromJsonFactory,
    );

    return _v1TransactionsIdAttachmentsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all attachments.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction.
  @Get(path: '/v1/transactions/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1TransactionsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///Lists all piggy bank events.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction.
  Future<chopper.Response<PiggyBankEventArray>>
  v1TransactionsIdPiggyBankEventsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PiggyBankEventArray,
      () => PiggyBankEventArray.fromJsonFactory,
    );

    return _v1TransactionsIdPiggyBankEventsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
    );
  }

  ///Lists all piggy bank events.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The ID of the transaction.
  @Get(path: '/v1/transactions/{id}/piggy-bank-events')
  Future<chopper.Response<PiggyBankEventArray>>
  _v1TransactionsIdPiggyBankEventsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
  });

  ///List all the user's transactions.
  ///
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> v1TransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1TransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      start: start,
      end: end,
      type: type?.value?.toString(),
    );
  }

  ///List all the user's transactions.
  ///
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v1/transactions')
  Future<chopper.Response<TransactionArray>> _v1TransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Store a new transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<TransactionSingle>> v1TransactionsPost({
    String? xTraceId,
    required TransactionStore? body,
  }) {
    generatedMapping.putIfAbsent(
      TransactionSingle,
      () => TransactionSingle.fromJsonFactory,
    );

    return _v1TransactionsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/transactions', optionalBody: true)
  Future<chopper.Response<TransactionSingle>> _v1TransactionsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TransactionStore? body,
  });

  ///Get a single transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  Future<chopper.Response<TransactionSingle>> v1TransactionsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      TransactionSingle,
      () => TransactionSingle.fromJsonFactory,
    );

    return _v1TransactionsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  @Get(path: '/v1/transactions/{id}')
  Future<chopper.Response<TransactionSingle>> _v1TransactionsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing transaction. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  Future<chopper.Response<TransactionSingle>> v1TransactionsIdPut({
    String? xTraceId,
    required String? id,
    required TransactionUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      TransactionSingle,
      () => TransactionSingle.fromJsonFactory,
    );

    return _v1TransactionsIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update existing transaction. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  @Put(path: '/v1/transactions/{id}', optionalBody: true)
  Future<chopper.Response<TransactionSingle>> _v1TransactionsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required TransactionUpdate? body,
  });

  ///Delete a transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  Future<chopper.Response> v1TransactionsIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1TransactionsIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the transaction.
  @Delete(path: '/v1/transactions/{id}')
  Future<chopper.Response> _v1TransactionsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all the user groups available to this user.
  ///
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<UserGroupArray>> v1UserGroupsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      UserGroupArray,
      () => UserGroupArray.fromJsonFactory,
    );

    return _v1UserGroupsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all the user groups available to this user.
  ///
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/user-groups')
  Future<chopper.Response<UserGroupArray>> _v1UserGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Get a single user group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the user group.
  Future<chopper.Response<UserGroupSingle>> v1UserGroupsIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      UserGroupSingle,
      () => UserGroupSingle.fromJsonFactory,
    );

    return _v1UserGroupsIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single user group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the user group.
  @Get(path: '/v1/user-groups/{id}')
  Future<chopper.Response<UserGroupSingle>> _v1UserGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update an existing user group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  Future<chopper.Response<UserGroupSingle>> v1UserGroupsIdPut({
    String? xTraceId,
    required String? id,
    required UserGroupUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      UserGroupSingle,
      () => UserGroupSingle.fromJsonFactory,
    );

    return _v1UserGroupsIdPut(
      xTraceId: xTraceId?.toString(),
      id: id,
      body: body,
    );
  }

  ///Update an existing user group.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the account.
  @Put(path: '/v1/user-groups/{id}', optionalBody: true)
  Future<chopper.Response<UserGroupSingle>> _v1UserGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required UserGroupUpdate? body,
  });

  ///Search for accounts
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param query The query you wish to search for.
  ///@param type The type of accounts you wish to limit the search to.
  ///@param field The account field(s) you want to search in.
  Future<chopper.Response<AccountArray>> v1SearchAccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
    enums.AccountTypeFilter? type,
    required enums.AccountSearchFieldFilter? field,
  }) {
    generatedMapping.putIfAbsent(
      AccountArray,
      () => AccountArray.fromJsonFactory,
    );

    return _v1SearchAccountsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      query: query,
      type: type?.value?.toString(),
      field: field?.value?.toString(),
    );
  }

  ///Search for accounts
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param query The query you wish to search for.
  ///@param type The type of accounts you wish to limit the search to.
  ///@param field The account field(s) you want to search in.
  @Get(path: '/v1/search/accounts')
  Future<chopper.Response<AccountArray>> _v1SearchAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('query') required String? query,
    @Query('type') String? type,
    @Query('field') required String? field,
  });

  ///Search for transactions
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param query The query you wish to search for.
  Future<chopper.Response<TransactionArray>> v1SearchTransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? query,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1SearchTransactionsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      query: query,
    );
  }

  ///Search for transactions
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param query The query you wish to search for.
  @Get(path: '/v1/search/transactions')
  Future<chopper.Response<TransactionArray>> _v1SearchTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('query') required String? query,
  });

  ///Returns basic sums of the users data.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param currency_code A currency code like EUR or USD, to filter the result.
  Future<chopper.Response<BasicSummary>> v1SummaryBasicGet({
    String? xTraceId,
    required String? start,
    required String? end,
    String? currencyCode,
  }) {
    generatedMapping.putIfAbsent(
      BasicSummary,
      () => BasicSummary.fromJsonFactory,
    );

    return _v1SummaryBasicGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      currencyCode: currencyCode,
    );
  }

  ///Returns basic sums of the users data.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param currency_code A currency code like EUR or USD, to filter the result.
  @Get(path: '/v1/summary/basic')
  Future<chopper.Response<BasicSummary>> _v1SummaryBasicGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('currency_code') String? currencyCode,
  });

  ///System information end point.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<SystemInfo>> v1AboutGet({String? xTraceId}) {
    generatedMapping.putIfAbsent(SystemInfo, () => SystemInfo.fromJsonFactory);

    return _v1AboutGet(xTraceId: xTraceId?.toString());
  }

  ///System information end point.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Get(path: '/v1/about')
  Future<chopper.Response<SystemInfo>> _v1AboutGet({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Currently authenticated user endpoint.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<UserSingle>> v1AboutUserGet({String? xTraceId}) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _v1AboutUserGet(xTraceId: xTraceId?.toString());
  }

  ///Currently authenticated user endpoint.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Get(path: '/v1/about/user')
  Future<chopper.Response<UserSingle>> _v1AboutUserGet({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Get Firefly III system configuration values.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<ConfigurationArray>> v1ConfigurationGet({
    String? xTraceId,
  }) {
    generatedMapping.putIfAbsent(
      Configuration,
      () => Configuration.fromJsonFactory,
    );

    return _v1ConfigurationGet(xTraceId: xTraceId?.toString());
  }

  ///Get Firefly III system configuration values.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Get(path: '/v1/configuration')
  Future<chopper.Response<ConfigurationArray>> _v1ConfigurationGet({
    @Header('X-Trace-Id') String? xTraceId,
  });

  ///Get a single Firefly III system configuration value
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the configuration value you want to know.
  Future<chopper.Response<ConfigurationSingle>> v1ConfigurationNameGet({
    String? xTraceId,
    required enums.ConfigValueFilter? name,
  }) {
    generatedMapping.putIfAbsent(
      ConfigurationSingle,
      () => ConfigurationSingle.fromJsonFactory,
    );

    return _v1ConfigurationNameGet(
      xTraceId: xTraceId?.toString(),
      name: name?.value?.toString(),
    );
  }

  ///Get a single Firefly III system configuration value
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the configuration value you want to know.
  @Get(path: '/v1/configuration/{name}')
  Future<chopper.Response<ConfigurationSingle>> _v1ConfigurationNameGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
  });

  ///Update configuration value
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the configuration value you want to update.
  Future<chopper.Response<ConfigurationSingle>> v1ConfigurationNamePut({
    String? xTraceId,
    required enums.ConfigValueUpdateFilter? name,
    required ConfigurationUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      ConfigurationSingle,
      () => ConfigurationSingle.fromJsonFactory,
    );

    return _v1ConfigurationNamePut(
      xTraceId: xTraceId?.toString(),
      name: name?.value?.toString(),
      body: body,
    );
  }

  ///Update configuration value
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the configuration value you want to update.
  @Put(path: '/v1/configuration/{name}', optionalBody: true)
  Future<chopper.Response<ConfigurationSingle>> _v1ConfigurationNamePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @Body() required ConfigurationUpdate? body,
  });

  ///Cron job endpoint
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param cliToken The CLI token of any user in Firefly III, required to run the cron job.
  ///@param date A date formatted YYYY-MM-DD. This can be used to make the cron job pretend it's running on another day.
  ///@param force Forces the cron job to fire, regardless of whether it has fired before. This may result in double transactions or weird budgets, so be careful.
  Future<chopper.Response<CronResult>> v1CronCliTokenGet({
    String? xTraceId,
    required String? cliToken,
    String? date,
    bool? force,
  }) {
    generatedMapping.putIfAbsent(CronResult, () => CronResult.fromJsonFactory);

    return _v1CronCliTokenGet(
      xTraceId: xTraceId?.toString(),
      cliToken: cliToken,
      date: date,
      force: force,
    );
  }

  ///Cron job endpoint
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param cliToken The CLI token of any user in Firefly III, required to run the cron job.
  ///@param date A date formatted YYYY-MM-DD. This can be used to make the cron job pretend it's running on another day.
  ///@param force Forces the cron job to fire, regardless of whether it has fired before. This may result in double transactions or weird budgets, so be careful.
  @Get(path: '/v1/cron/{cliToken}')
  Future<chopper.Response<CronResult>> _v1CronCliTokenGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('cliToken') required String? cliToken,
    @Query('date') String? date,
    @Query('force') bool? force,
  });

  ///List all users.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<UserArray>> v1UsersGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(UserArray, () => UserArray.fromJsonFactory);

    return _v1UsersGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all users.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/users')
  Future<chopper.Response<UserArray>> _v1UsersGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new user
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<UserSingle>> v1UsersPost({
    String? xTraceId,
    required User? body,
  }) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _v1UsersPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new user
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/users', optionalBody: true)
  Future<chopper.Response<UserSingle>> _v1UsersPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required User? body,
  });

  ///Get a single user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  Future<chopper.Response<UserSingle>> v1UsersIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _v1UsersIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  @Get(path: '/v1/users/{id}')
  Future<chopper.Response<UserSingle>> _v1UsersIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update an existing user's information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  Future<chopper.Response<UserSingle>> v1UsersIdPut({
    String? xTraceId,
    required String? id,
    required User? body,
  }) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _v1UsersIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update an existing user's information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  @Put(path: '/v1/users/{id}', optionalBody: true)
  Future<chopper.Response<UserSingle>> _v1UsersIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required User? body,
  });

  ///Delete a user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  Future<chopper.Response> v1UsersIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1UsersIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The user ID.
  @Delete(path: '/v1/users/{id}')
  Future<chopper.Response> _v1UsersIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///List all users preferences.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<PreferenceArray>> v1PreferencesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      PreferenceArray,
      () => PreferenceArray.fromJsonFactory,
    );

    return _v1PreferencesGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all users preferences.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/preferences')
  Future<chopper.Response<PreferenceArray>> _v1PreferencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new preference for this user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<PreferenceSingle>> v1PreferencesPost({
    String? xTraceId,
    required Preference? body,
  }) {
    generatedMapping.putIfAbsent(
      PreferenceSingle,
      () => PreferenceSingle.fromJsonFactory,
    );

    return _v1PreferencesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new preference for this user.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/preferences', optionalBody: true)
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required Preference? body,
  });

  ///Return a single preference.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference.
  Future<chopper.Response<PreferenceSingle>> v1PreferencesNameGet({
    String? xTraceId,
    required String? name,
  }) {
    generatedMapping.putIfAbsent(
      PreferenceSingle,
      () => PreferenceSingle.fromJsonFactory,
    );

    return _v1PreferencesNameGet(xTraceId: xTraceId?.toString(), name: name);
  }

  ///Return a single preference.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference.
  @Get(path: '/v1/preferences/{name}')
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesNameGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
  });

  ///Update preference
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference. Will always overwrite. Will be created if it does not exist.
  Future<chopper.Response<PreferenceSingle>> v1PreferencesNamePut({
    String? xTraceId,
    required String? name,
    required PreferenceUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      PreferenceSingle,
      () => PreferenceSingle.fromJsonFactory,
    );

    return _v1PreferencesNamePut(
      xTraceId: xTraceId?.toString(),
      name: name,
      body: body,
    );
  }

  ///Update preference
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference. Will always overwrite. Will be created if it does not exist.
  @Put(path: '/v1/preferences/{name}', optionalBody: true)
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesNamePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @Body() required PreferenceUpdate? body,
  });

  ///Get all the messages of a single webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookMessageArray>> v1WebhooksIdMessagesGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      WebhookMessageArray,
      () => WebhookMessageArray.fromJsonFactory,
    );

    return _v1WebhooksIdMessagesGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get all the messages of a single webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  @Get(path: '/v1/webhooks/{id}/messages')
  Future<chopper.Response<WebhookMessageArray>> _v1WebhooksIdMessagesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Get a single message from a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  Future<chopper.Response<WebhookMessageSingle>>
  v1WebhooksIdMessagesMessageIdGet({
    String? xTraceId,
    required String? id,
    required int? messageId,
  }) {
    generatedMapping.putIfAbsent(
      WebhookMessageSingle,
      () => WebhookMessageSingle.fromJsonFactory,
    );

    return _v1WebhooksIdMessagesMessageIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      messageId: messageId,
    );
  }

  ///Get a single message from a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  @Get(path: '/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response<WebhookMessageSingle>>
  _v1WebhooksIdMessagesMessageIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
  });

  ///Delete a webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  Future<chopper.Response> v1WebhooksIdMessagesMessageIdDelete({
    String? xTraceId,
    required String? id,
    required int? messageId,
  }) {
    return _v1WebhooksIdMessagesMessageIdDelete(
      xTraceId: xTraceId?.toString(),
      id: id,
      messageId: messageId,
    );
  }

  ///Delete a webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  @Delete(path: '/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response> _v1WebhooksIdMessagesMessageIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
  });

  ///Get all the failed attempts of a single webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  Future<chopper.Response<WebhookAttemptArray>>
  v1WebhooksIdMessagesMessageIdAttemptsGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? id,
    required int? messageId,
  }) {
    generatedMapping.putIfAbsent(
      WebhookAttemptArray,
      () => WebhookAttemptArray.fromJsonFactory,
    );

    return _v1WebhooksIdMessagesMessageIdAttemptsGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      id: id,
      messageId: messageId,
    );
  }

  ///Get all the failed attempts of a single webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  @Get(path: '/v1/webhooks/{id}/messages/{messageId}/attempts')
  Future<chopper.Response<WebhookAttemptArray>>
  _v1WebhooksIdMessagesMessageIdAttemptsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
  });

  ///Get a single failed attempt from a single webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook attempt ID.
  Future<chopper.Response<WebhookAttemptSingle>>
  v1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    String? xTraceId,
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    generatedMapping.putIfAbsent(
      WebhookAttemptSingle,
      () => WebhookAttemptSingle.fromJsonFactory,
    );

    return _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet(
      xTraceId: xTraceId?.toString(),
      id: id,
      messageId: messageId,
      attemptId: attemptId,
    );
  }

  ///Get a single failed attempt from a single webhook message.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook attempt ID.
  @Get(path: '/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response<WebhookAttemptSingle>>
  _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
  });

  ///Delete a webhook attempt.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook message attempt ID.
  Future<chopper.Response>
  v1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    String? xTraceId,
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    return _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete(
      xTraceId: xTraceId?.toString(),
      id: id,
      messageId: messageId,
      attemptId: attemptId,
    );
  }

  ///Delete a webhook attempt.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook message attempt ID.
  @Delete(path: '/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response>
  _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
  });

  ///Submit messages for a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  Future<chopper.Response> v1WebhooksIdSubmitPost({
    String? xTraceId,
    required String? id,
  }) {
    return _v1WebhooksIdSubmitPost(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Submit messages for a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  @Post(path: '/v1/webhooks/{id}/submit', optionalBody: true)
  Future<chopper.Response> _v1WebhooksIdSubmitPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Trigger webhook for a given transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param transactionId The transaction ID.
  Future<chopper.Response> v1WebhooksIdTriggerTransactionTransactionIdPost({
    String? xTraceId,
    required String? id,
    required String? transactionId,
  }) {
    return _v1WebhooksIdTriggerTransactionTransactionIdPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      transactionId: transactionId,
    );
  }

  ///Trigger webhook for a given transaction.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  ///@param transactionId The transaction ID.
  @Post(
    path: '/v1/webhooks/{id}/trigger-transaction/{transactionId}',
    optionalBody: true,
  )
  Future<chopper.Response> _v1WebhooksIdTriggerTransactionTransactionIdPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('transactionId') required String? transactionId,
  });

  ///List all webhooks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<WebhookArray>> v1WebhooksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
      WebhookArray,
      () => WebhookArray.fromJsonFactory,
    );

    return _v1WebhooksGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
    );
  }

  ///List all webhooks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v1/webhooks')
  Future<chopper.Response<WebhookArray>> _v1WebhooksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Store a new webhook
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<WebhookSingle>> v1WebhooksPost({
    String? xTraceId,
    required WebhookStore? body,
  }) {
    generatedMapping.putIfAbsent(
      WebhookSingle,
      () => WebhookSingle.fromJsonFactory,
    );

    return _v1WebhooksPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new webhook
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(path: '/v1/webhooks', optionalBody: true)
  Future<chopper.Response<WebhookSingle>> _v1WebhooksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required WebhookStore? body,
  });

  ///Get a single webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookSingle>> v1WebhooksIdGet({
    String? xTraceId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      WebhookSingle,
      () => WebhookSingle.fromJsonFactory,
    );

    return _v1WebhooksIdGet(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Get a single webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  @Get(path: '/v1/webhooks/{id}')
  Future<chopper.Response<WebhookSingle>> _v1WebhooksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });

  ///Update existing webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookSingle>> v1WebhooksIdPut({
    String? xTraceId,
    required String? id,
    required WebhookUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
      WebhookSingle,
      () => WebhookSingle.fromJsonFactory,
    );

    return _v1WebhooksIdPut(xTraceId: xTraceId?.toString(), id: id, body: body);
  }

  ///Update existing webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  @Put(path: '/v1/webhooks/{id}', optionalBody: true)
  Future<chopper.Response<WebhookSingle>> _v1WebhooksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required WebhookUpdate? body,
  });

  ///Delete a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  Future<chopper.Response> v1WebhooksIdDelete({
    String? xTraceId,
    required String? id,
  }) {
    return _v1WebhooksIdDelete(xTraceId: xTraceId?.toString(), id: id);
  }

  ///Delete a webhook.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The webhook ID.
  @Delete(path: '/v1/webhooks/{id}')
  Future<chopper.Response> _v1WebhooksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
