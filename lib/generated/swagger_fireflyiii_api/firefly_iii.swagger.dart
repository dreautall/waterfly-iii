// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element_parameter

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
import 'firefly_iii.metadata.swagger.dart';
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
  @GET(path: '/v1/autocomplete/accounts')
  Future<chopper.Response<AutocompleteAccountArray>>
  _v1AutocompleteAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<Object?>? types,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/bills')
  Future<chopper.Response<AutocompleteBillArray>> _v1AutocompleteBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/budgets')
  Future<chopper.Response<AutocompleteBudgetArray>> _v1AutocompleteBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/categories')
  Future<chopper.Response<AutocompleteCategoryArray>>
  _v1AutocompleteCategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/currencies')
  Future<chopper.Response<AutocompleteCurrencyArray>>
  _v1AutocompleteCurrenciesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/currencies-with-code')
  Future<chopper.Response<AutocompleteCurrencyCodeArray>>
  _v1AutocompleteCurrenciesWithCodeGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/object-groups')
  Future<chopper.Response<AutocompleteObjectGroupArray>>
  _v1AutocompleteObjectGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/piggy-banks')
  Future<chopper.Response<AutocompletePiggyArray>>
  _v1AutocompletePiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/piggy-banks-with-balance')
  Future<chopper.Response<AutocompletePiggyBalanceArray>>
  _v1AutocompletePiggyBanksWithBalanceGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/recurring')
  Future<chopper.Response<AutocompleteRecurrenceArray>>
  _v1AutocompleteRecurringGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/rule-groups')
  Future<chopper.Response<AutocompleteRuleGroupArray>>
  _v1AutocompleteRuleGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/rules')
  Future<chopper.Response<AutocompleteRuleArray>> _v1AutocompleteRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  });

  ///Returns all subscriptions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteBillArray>>
  v1AutocompleteSubscriptionsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
      AutocompleteBill,
      () => AutocompleteBill.fromJsonFactory,
    );

    return _v1AutocompleteSubscriptionsGet(
      xTraceId: xTraceId?.toString(),
      query: query,
      limit: limit,
    );
  }

  ///Returns all subscriptions of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @GET(path: '/v1/autocomplete/subscriptions')
  Future<chopper.Response<AutocompleteBillArray>>
  _v1AutocompleteSubscriptionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/tags')
  Future<chopper.Response<AutocompleteTagArray>> _v1AutocompleteTagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/transaction-types')
  Future<chopper.Response<AutocompleteTransactionTypeArray>>
  _v1AutocompleteTransactionTypesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/transactions')
  Future<chopper.Response<AutocompleteTransactionArray>>
  _v1AutocompleteTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  @GET(path: '/v1/autocomplete/transactions-with-id')
  Future<chopper.Response<AutocompleteTransactionIDArray>>
  _v1AutocompleteTransactionsWithIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @chopper.Tag()
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
  });

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param period Optional period to group the data by. If not provided, it will default to '1M' or whatever is deemed relevant for the range provided.  If you want to know which periods are available, see the enums or get the configuration value: `GET /api/v1/configuration/firefly.valid_view_ranges`
  ///@param preselected Optional set of preselected accounts to limit the chart to. This may be easier than submitting all asset accounts manually, for example. If you want to know which selection are available, see the enums here or get the configuration value: `GET /api/v1/configuration/firefly.preselected_accounts`  - `empty`: do not do a pre-selection - `all`: select all asset and all liability accounts - `assets`: select all asset accounts - `liabilities`: select all liability accounts  If no accounts are found, the user's "frontpage accounts" preference will be used. If that is empty, all asset accounts will be used.
  Future<chopper.Response<ChartLine>> v1ChartAccountOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
    enums.V1ChartAccountOverviewGetPeriod? period,
    enums.V1ChartAccountOverviewGetPreselected? preselected,
  }) {
    generatedMapping.putIfAbsent(
      ChartDataSet,
      () => ChartDataSet.fromJsonFactory,
    );

    return _v1ChartAccountOverviewGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      period: period?.value?.toString(),
      preselected: preselected?.value?.toString(),
    );
  }

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param period Optional period to group the data by. If not provided, it will default to '1M' or whatever is deemed relevant for the range provided.  If you want to know which periods are available, see the enums or get the configuration value: `GET /api/v1/configuration/firefly.valid_view_ranges`
  ///@param preselected Optional set of preselected accounts to limit the chart to. This may be easier than submitting all asset accounts manually, for example. If you want to know which selection are available, see the enums here or get the configuration value: `GET /api/v1/configuration/firefly.preselected_accounts`  - `empty`: do not do a pre-selection - `all`: select all asset and all liability accounts - `assets`: select all asset accounts - `liabilities`: select all liability accounts  If no accounts are found, the user's "frontpage accounts" preference will be used. If that is empty, all asset accounts will be used.
  @GET(path: '/v1/chart/account/overview')
  Future<chopper.Response<ChartLine>> _v1ChartAccountOverviewGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('period') String? period,
    @Query('preselected') String? preselected,
    @chopper.Tag()
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
  });

  ///Dashboard chart with balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param period Optional period to group the data by. If not provided, it will default to '1M' or whatever is deemed relevant for the range provided.  If you want to know which periods are available, see the enums or get the configuration value: `GET /api/v1/configuration/firefly.valid_view_ranges`
  ///@param preselected Optional set of preselected accounts to limit the chart to. This may be easier than submitting all asset accounts manually, for example. If you want to know which selection are available, see the enums here or get the configuration value: `GET /api/v1/configuration/firefly.preselected_accounts`  - `empty`: do not do a pre-selection - `all`: select all asset and all liability accounts - `assets`: select all asset accounts - `liabilities`: select all liability accounts  If no accounts are found, the user's "frontpage accounts" preference will be used. If that is empty, all asset accounts will be used.
  ///@param accounts[] Limit the chart to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.  This list of accounts will be OVERRULED by the `preselected` parameter.
  Future<chopper.Response<ChartLine>> v1ChartBalanceBalanceGet({
    String? xTraceId,
    required String? start,
    required String? end,
    enums.V1ChartBalanceBalanceGetPeriod? period,
    enums.V1ChartBalanceBalanceGetPreselected? preselected,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
      ChartDataSet,
      () => ChartDataSet.fromJsonFactory,
    );

    return _v1ChartBalanceBalanceGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      period: period?.value?.toString(),
      preselected: preselected?.value?.toString(),
      accounts: accounts,
    );
  }

  ///Dashboard chart with balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param period Optional period to group the data by. If not provided, it will default to '1M' or whatever is deemed relevant for the range provided.  If you want to know which periods are available, see the enums or get the configuration value: `GET /api/v1/configuration/firefly.valid_view_ranges`
  ///@param preselected Optional set of preselected accounts to limit the chart to. This may be easier than submitting all asset accounts manually, for example. If you want to know which selection are available, see the enums here or get the configuration value: `GET /api/v1/configuration/firefly.preselected_accounts`  - `empty`: do not do a pre-selection - `all`: select all asset and all liability accounts - `assets`: select all asset accounts - `liabilities`: select all liability accounts  If no accounts are found, the user's "frontpage accounts" preference will be used. If that is empty, all asset accounts will be used.
  ///@param accounts[] Limit the chart to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.  This list of accounts will be OVERRULED by the `preselected` parameter.
  @GET(path: '/v1/chart/balance/balance')
  Future<chopper.Response<ChartLine>> _v1ChartBalanceBalanceGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('period') String? period,
    @Query('preselected') String? preselected,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  });

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLine>> v1ChartBudgetOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
      ChartDataSet,
      () => ChartDataSet.fromJsonFactory,
    );

    return _v1ChartBudgetOverviewGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
    );
  }

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @GET(path: '/v1/chart/budget/overview')
  Future<chopper.Response<ChartLine>> _v1ChartBudgetOverviewGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @chopper.Tag()
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
  });

  ///Dashboard chart with category information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLine>> v1ChartCategoryOverviewGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
      ChartDataSet,
      () => ChartDataSet.fromJsonFactory,
    );

    return _v1ChartCategoryOverviewGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
    );
  }

  ///Dashboard chart with category information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @GET(path: '/v1/chart/category/overview')
  Future<chopper.Response<ChartLine>> _v1ChartCategoryOverviewGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @chopper.Tag()
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
  @POST(path: '/v1/data/bulk/transactions', optionalBody: true)
  Future<chopper.Response> _v1DataBulkTransactionsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') required String? query,
    @chopper.Tag()
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
  @DELETE(path: '/v1/data/destroy')
  Future<chopper.Response> _v1DataDestroyDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('objects') required String? objects,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/accounts')
  Future<chopper.Response<String>> _v1DataExportAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/bills')
  Future<chopper.Response<String>> _v1DataExportBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/budgets')
  Future<chopper.Response<String>> _v1DataExportBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/categories')
  Future<chopper.Response<String>> _v1DataExportCategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/piggy-banks')
  Future<chopper.Response<String>> _v1DataExportPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/recurring')
  Future<chopper.Response<String>> _v1DataExportRecurringGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/rules')
  Future<chopper.Response<String>> _v1DataExportRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/tags')
  Future<chopper.Response<String>> _v1DataExportTagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/data/export/transactions')
  Future<chopper.Response<String>> _v1DataExportTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts') String? accounts,
    @Query('type') String? type,
    @chopper.Tag()
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
  });

  ///Endpoint to purge user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response> v1DataPurgeDelete({String? xTraceId}) {
    return _v1DataPurgeDelete(xTraceId: xTraceId?.toString());
  }

  ///Endpoint to purge user data
  ///@param X-Trace-Id Unique identifier associated with this request.
  @DELETE(path: '/v1/data/purge')
  Future<chopper.Response> _v1DataPurgeDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/expense')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseExpenseGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/asset')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/revenue')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeRevenueGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/asset')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/asset')
  Future<chopper.Response<InsightTransfer>> _v1InsightTransferAssetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/bill')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseBillGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('bills[]') List<int>? bills,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/no-bill')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoBillGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/budget')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('budgets[]') List<int>? budgets,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/no-budget')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/category')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/category')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/category')
  Future<chopper.Response<InsightGroup>> _v1InsightTransferCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/no-category')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferNoCategoryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightExpenseTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightIncomeTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/tag')
  Future<chopper.Response<InsightGroup>> _v1InsightTransferTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/no-tag')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferNoTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/expense/total')
  Future<chopper.Response<InsightTotal>> _v1InsightExpenseTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/income/total')
  Future<chopper.Response<InsightTotal>> _v1InsightIncomeTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/insight/transfer/total')
  Future<chopper.Response<InsightTotal>> _v1InsightTransferTotalGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/accounts/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1AccountsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/accounts/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1AccountsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/accounts/{id}/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1AccountsIdPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///List all accounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  Future<chopper.Response<AccountArray>> v1AccountsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
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
      start: start,
      end: end,
      date: date,
      type: type?.value?.toString(),
    );
  }

  ///List all accounts.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  @GET(path: '/v1/accounts')
  Future<chopper.Response<AccountArray>> _v1AccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('date') String? date,
    @Query('type') String? type,
    @chopper.Tag()
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
  @POST(path: '/v1/accounts', optionalBody: true)
  Future<chopper.Response<AccountSingle>> _v1AccountsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required AccountStore? body,
    @chopper.Tag()
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
  });

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  Future<chopper.Response<AccountSingle>> v1AccountsIdGet({
    String? xTraceId,
    String? start,
    String? end,
    required String? id,
    String? date,
  }) {
    generatedMapping.putIfAbsent(
      AccountSingle,
      () => AccountSingle.fromJsonFactory,
    );

    return _v1AccountsIdGet(
      xTraceId: xTraceId?.toString(),
      start: start,
      end: end,
      id: id,
      date: date,
    );
  }

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  @GET(path: '/v1/accounts/{id}')
  Future<chopper.Response<AccountSingle>> _v1AccountsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') String? start,
    @Query('end') String? end,
    @Path('id') required String? id,
    @Query('date') String? date,
    @chopper.Tag()
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
  @PUT(path: '/v1/accounts/{id}', optionalBody: true)
  Future<chopper.Response<AccountSingle>> _v1AccountsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required AccountUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/accounts/{id}')
  Future<chopper.Response> _v1AccountsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/attachments')
  Future<chopper.Response<AttachmentArray>> _v1AttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/attachments', optionalBody: true)
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required AttachmentStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/attachments/{id}')
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/attachments/{id}', optionalBody: true)
  Future<chopper.Response<AttachmentSingle>> _v1AttachmentsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required AttachmentUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/attachments/{id}')
  Future<chopper.Response> _v1AttachmentsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/attachments/{id}/download')
  Future<chopper.Response<String>> _v1AttachmentsIdDownloadGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @POST(path: '/v1/attachments/{id}/upload', optionalBody: true)
  Future<chopper.Response> _v1AttachmentsIdUploadPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required Object? body,
    @chopper.Tag()
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
  @GET(path: '/v1/available-budgets')
  Future<chopper.Response<AvailableBudgetArray>> _v1AvailableBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @GET(path: '/v1/available-budgets/{id}')
  Future<chopper.Response<AvailableBudgetSingle>> _v1AvailableBudgetsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/bills/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1BillsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/bills/{id}/rules')
  Future<chopper.Response<RuleArray>> _v1BillsIdRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/bills/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1BillsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/bills')
  Future<chopper.Response<BillArray>> _v1BillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @POST(path: '/v1/bills', optionalBody: true)
  Future<chopper.Response<BillSingle>> _v1BillsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required BillStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/bills/{id}')
  Future<chopper.Response<BillSingle>> _v1BillsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @PUT(path: '/v1/bills/{id}', optionalBody: true)
  Future<chopper.Response<BillSingle>> _v1BillsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BillUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/bills/{id}')
  Future<chopper.Response> _v1BillsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}/limits/{limitId}/transactions')
  Future<chopper.Response<TransactionArray>>
  _v1BudgetsIdLimitsLimitIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}/limits')
  Future<chopper.Response<BudgetLimitArray>> _v1BudgetsIdLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @POST(path: '/v1/budgets/{id}/limits', optionalBody: true)
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BudgetLimitStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required int? limitId,
    @chopper.Tag()
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
  });

  ///Update existing budget limit.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response<BudgetLimitSingle>> v1BudgetsIdLimitsLimitIdPut({
    String? xTraceId,
    required String? id,
    required String? limitId,
    required BudgetLimitUpdate? body,
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
  @PUT(path: '/v1/budgets/{id}/limits/{limitId}', optionalBody: true)
  Future<chopper.Response<BudgetLimitSingle>> _v1BudgetsIdLimitsLimitIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Body() required BudgetLimitUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response> _v1BudgetsIdLimitsLimitIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @chopper.Tag()
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
  @GET(path: '/v1/budget-limits')
  Future<chopper.Response<BudgetLimitArray>> _v1BudgetLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1BudgetsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1BudgetsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/transactions-without-budget')
  Future<chopper.Response<TransactionArray>>
  _v1BudgetsTransactionsWithoutBudgetGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets')
  Future<chopper.Response<BudgetArray>> _v1BudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @POST(path: '/v1/budgets', optionalBody: true)
  Future<chopper.Response<BudgetSingle>> _v1BudgetsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required BudgetStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/budgets/{id}')
  Future<chopper.Response<BudgetSingle>> _v1BudgetsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @PUT(path: '/v1/budgets/{id}', optionalBody: true)
  Future<chopper.Response<BudgetSingle>> _v1BudgetsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required BudgetUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/budgets/{id}')
  Future<chopper.Response> _v1BudgetsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/categories/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1CategoriesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/categories/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1CategoriesIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/categories')
  Future<chopper.Response<CategoryArray>> _v1CategoriesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  });

  ///Store a new category
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CategorySingle>> v1CategoriesPost({
    String? xTraceId,
    required CategoryStore? body,
  }) {
    generatedMapping.putIfAbsent(
      CategorySingle,
      () => CategorySingle.fromJsonFactory,
    );

    return _v1CategoriesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new category
  ///@param X-Trace-Id Unique identifier associated with this request.
  @POST(path: '/v1/categories', optionalBody: true)
  Future<chopper.Response<CategorySingle>> _v1CategoriesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required CategoryStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/categories/{id}')
  Future<chopper.Response<CategorySingle>> _v1CategoriesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @PUT(path: '/v1/categories/{id}', optionalBody: true)
  Future<chopper.Response<CategorySingle>> _v1CategoriesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required CategoryUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/categories/{id}')
  Future<chopper.Response> _v1CategoriesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///List all exchange rates that Firefly III knows.
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

  ///List all exchange rates that Firefly III knows.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @GET(path: '/v1/exchange-rates')
  Future<chopper.Response<CurrencyExchangeRateArray>> _v1ExchangeRatesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  });

  ///Store a new currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CurrencyExchangeRateSingle>> v1ExchangeRatesPost({
    String? xTraceId,
    required CurrencyExchangeRateStore? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateSingle,
      () => CurrencyExchangeRateSingle.fromJsonFactory,
    );

    return _v1ExchangeRatesPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @POST(path: '/v1/exchange-rates', optionalBody: true)
  Future<chopper.Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required CurrencyExchangeRateStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/exchange-rates/{id}')
  Future<chopper.Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @DELETE(path: '/v1/exchange-rates/{id}')
  Future<chopper.Response> _v1ExchangeRatesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/exchange-rates/{id}', optionalBody: true)
  Future<chopper.Response<CurrencyExchangeRateSingle>> _v1ExchangeRatesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required CurrencyExchangeRateUpdate? body,
    @chopper.Tag()
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
  });

  ///List all exchange rates from/to the mentioned currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  Future<chopper.Response<CurrencyExchangeRateArray>> v1ExchangeRatesFromToGet({
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

    return _v1ExchangeRatesFromToGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      from: from,
      to: to,
    );
  }

  ///List all exchange rates from/to the mentioned currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  @GET(path: '/v1/exchange-rates/{from}/{to}')
  Future<chopper.Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesFromToGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @chopper.Tag()
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
  });

  ///Deletes ALL currency exchange rates from 'from' to 'to'.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  Future<chopper.Response> v1ExchangeRatesFromToDelete({
    String? xTraceId,
    required String? from,
    required String? to,
  }) {
    return _v1ExchangeRatesFromToDelete(
      xTraceId: xTraceId?.toString(),
      from: from,
      to: to,
    );
  }

  ///Deletes ALL currency exchange rates from 'from' to 'to'.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  @DELETE(path: '/v1/exchange-rates/{from}/{to}')
  Future<chopper.Response> _v1ExchangeRatesFromToDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @chopper.Tag()
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
  });

  ///List the exchange rate for the from and to-currency on the requested date.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  Future<chopper.Response<CurrencyExchangeRateArray>>
  v1ExchangeRatesFromToDateGet({
    String? xTraceId,
    int? limit,
    int? page,
    required String? from,
    required String? to,
    required String? date,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateArray,
      () => CurrencyExchangeRateArray.fromJsonFactory,
    );

    return _v1ExchangeRatesFromToDateGet(
      xTraceId: xTraceId?.toString(),
      limit: limit,
      page: page,
      from: from,
      to: to,
      date: date,
    );
  }

  ///List the exchange rate for the from and to-currency on the requested date.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  @GET(path: '/v1/exchange-rates/{from}/{to}/{date}')
  Future<chopper.Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesFromToDateGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @Path('date') required String? date,
    @chopper.Tag()
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
  });

  ///Delete the currency exchange rate from 'from' to 'to' on the specified date.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  Future<chopper.Response> v1ExchangeRatesFromToDateDelete({
    String? xTraceId,
    required String? from,
    required String? to,
    required String? date,
  }) {
    return _v1ExchangeRatesFromToDateDelete(
      xTraceId: xTraceId?.toString(),
      from: from,
      to: to,
      date: date,
    );
  }

  ///Delete the currency exchange rate from 'from' to 'to' on the specified date.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  @DELETE(path: '/v1/exchange-rates/{from}/{to}/{date}')
  Future<chopper.Response> _v1ExchangeRatesFromToDateDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @Path('date') required String? date,
    @chopper.Tag()
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
  });

  ///Update existing currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  Future<chopper.Response<CurrencyExchangeRateSingle>>
  v1ExchangeRatesFromToDatePut({
    String? xTraceId,
    required String? from,
    required String? to,
    required String? date,
    required CurrencyExchangeRateUpdateNoDate? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateSingle,
      () => CurrencyExchangeRateSingle.fromJsonFactory,
    );

    return _v1ExchangeRatesFromToDatePut(
      xTraceId: xTraceId?.toString(),
      from: from,
      to: to,
      date: date,
      body: body,
    );
  }

  ///Update existing currency exchange rate.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  ///@param date
  @PUT(path: '/v1/exchange-rates/{from}/{to}/{date}', optionalBody: true)
  Future<chopper.Response<CurrencyExchangeRateSingle>>
  _v1ExchangeRatesFromToDatePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @Path('date') required String? date,
    @Body() required CurrencyExchangeRateUpdateNoDate? body,
    @chopper.Tag()
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
  });

  ///Store new currency exchange rates under this date
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date
  Future<chopper.Response<CurrencyExchangeRateArray>>
  v1ExchangeRatesByDateDatePost({
    String? xTraceId,
    required String? date,
    required CurrencyExchangeRateStoreByDate? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateArray,
      () => CurrencyExchangeRateArray.fromJsonFactory,
    );

    return _v1ExchangeRatesByDateDatePost(
      xTraceId: xTraceId?.toString(),
      date: date,
      body: body,
    );
  }

  ///Store new currency exchange rates under this date
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date
  @POST(path: '/v1/exchange-rates/by-date/{date}', optionalBody: true)
  Future<chopper.Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesByDateDatePost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('date') required String? date,
    @Body() required CurrencyExchangeRateStoreByDate? body,
    @chopper.Tag()
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
  });

  ///Store new currency exchange rates under this from/to pair.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  Future<chopper.Response<CurrencyExchangeRateArray>>
  v1ExchangeRatesByCurrenciesFromToPost({
    String? xTraceId,
    required String? from,
    required String? to,
    required CurrencyExchangeRateStoreByPair? body,
  }) {
    generatedMapping.putIfAbsent(
      CurrencyExchangeRateArray,
      () => CurrencyExchangeRateArray.fromJsonFactory,
    );

    return _v1ExchangeRatesByCurrenciesFromToPost(
      xTraceId: xTraceId?.toString(),
      from: from,
      to: to,
      body: body,
    );
  }

  ///Store new currency exchange rates under this from/to pair.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param from The currency code of the 'from' currency.
  ///@param to The currency code of the 'to' currency.
  @POST(
    path: '/v1/exchange-rates/by-currencies/{from}/{to}',
    optionalBody: true,
  )
  Future<chopper.Response<CurrencyExchangeRateArray>>
  _v1ExchangeRatesByCurrenciesFromToPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('from') required String? from,
    @Path('to') required String? to,
    @Body() required CurrencyExchangeRateStoreByPair? body,
    @chopper.Tag()
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
  @GET(path: '/v1/link-types/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1LinkTypesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/link-types')
  Future<chopper.Response<LinkTypeArray>> _v1LinkTypesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/link-types', optionalBody: true)
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required LinkType? body,
    @chopper.Tag()
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
  @GET(path: '/v1/link-types/{id}')
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/link-types/{id}', optionalBody: true)
  Future<chopper.Response<LinkTypeSingle>> _v1LinkTypesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required LinkTypeUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/link-types/{id}')
  Future<chopper.Response> _v1LinkTypesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/transaction-links')
  Future<chopper.Response<TransactionLinkArray>> _v1TransactionLinksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/transaction-links', optionalBody: true)
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TransactionLinkStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/transaction-links/{id}')
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @DELETE(path: '/v1/transaction-links/{id}')
  Future<chopper.Response> _v1TransactionLinksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/transaction-links/{id}', optionalBody: true)
  Future<chopper.Response<TransactionLinkSingle>> _v1TransactionLinksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required TransactionLinkUpdate? body,
    @chopper.Tag()
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
  @GET(path: '/v1/object-groups/{id}/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1ObjectGroupsIdPiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/object-groups/{id}/bills')
  Future<chopper.Response<BillArray>> _v1ObjectGroupsIdBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///List all object groups.
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

  ///List all object groups.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @GET(path: '/v1/object-groups')
  Future<chopper.Response<ObjectGroupArray>> _v1ObjectGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @GET(path: '/v1/object-groups/{id}')
  Future<chopper.Response<ObjectGroupSingle>> _v1ObjectGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/object-groups/{id}', optionalBody: true)
  Future<chopper.Response<ObjectGroupSingle>> _v1ObjectGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required ObjectGroupUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/object-groups/{id}')
  Future<chopper.Response> _v1ObjectGroupsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/piggy-banks/{id}/events')
  Future<chopper.Response<PiggyBankEventArray>> _v1PiggyBanksIdEventsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/piggy-banks/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1PiggyBanksIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _v1PiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/piggy-banks', optionalBody: true)
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required PiggyBankStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/piggy-banks/{id}')
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/piggy-banks/{id}', optionalBody: true)
  Future<chopper.Response<PiggyBankSingle>> _v1PiggyBanksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required PiggyBankUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/piggy-banks/{id}')
  Future<chopper.Response> _v1PiggyBanksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/recurrences/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v1RecurrencesIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/recurrences')
  Future<chopper.Response<RecurrenceArray>> _v1RecurrencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/recurrences', optionalBody: true)
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RecurrenceStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/recurrences/{id}')
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/recurrences/{id}', optionalBody: true)
  Future<chopper.Response<RecurrenceSingle>> _v1RecurrencesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RecurrenceUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/recurrences/{id}')
  Future<chopper.Response> _v1RecurrencesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Trigger the creation of a transaction for a specific recurring transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  ///@param date A date formatted YYYY-MM-DD. This is the date for which you want the recurrence to fire. You can take the date from the list of occurrences in the recurring transaction.
  Future<chopper.Response<TransactionArray>> v1RecurrencesIdTriggerPost({
    String? xTraceId,
    required String? id,
    required String? date,
  }) {
    generatedMapping.putIfAbsent(
      TransactionArray,
      () => TransactionArray.fromJsonFactory,
    );

    return _v1RecurrencesIdTriggerPost(
      xTraceId: xTraceId?.toString(),
      id: id,
      date: date,
    );
  }

  ///Trigger the creation of a transaction for a specific recurring transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param id The ID of the recurring transaction.
  ///@param date A date formatted YYYY-MM-DD. This is the date for which you want the recurrence to fire. You can take the date from the list of occurrences in the recurring transaction.
  @POST(path: '/v1/recurrences/{id}/trigger', optionalBody: true)
  Future<chopper.Response<TransactionArray>> _v1RecurrencesIdTriggerPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('date') required String? date,
    @chopper.Tag()
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
  @GET(path: '/v1/rule-groups/{id}/rules')
  Future<chopper.Response<RuleArray>> _v1RuleGroupsIdRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/rule-groups/{id}/test')
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
    @chopper.Tag()
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
  @POST(path: '/v1/rule-groups/{id}/trigger', optionalBody: true)
  Future<chopper.Response> _v1RuleGroupsIdTriggerPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/rule-groups')
  Future<chopper.Response<RuleGroupArray>> _v1RuleGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/rule-groups', optionalBody: true)
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RuleGroupStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/rule-groups/{id}')
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/rule-groups/{id}', optionalBody: true)
  Future<chopper.Response<RuleGroupSingle>> _v1RuleGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RuleGroupUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/rule-groups/{id}')
  Future<chopper.Response> _v1RuleGroupsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/rules/{id}/test')
  Future<chopper.Response<TransactionArray>> _v1RulesIdTestGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @POST(path: '/v1/rules/{id}/trigger', optionalBody: true)
  Future<chopper.Response> _v1RulesIdTriggerPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
    @chopper.Tag()
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
  @GET(path: '/v1/rules')
  Future<chopper.Response<RuleArray>> _v1RulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/rules', optionalBody: true)
  Future<chopper.Response<RuleSingle>> _v1RulesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required RuleStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/rules/{id}')
  Future<chopper.Response<RuleSingle>> _v1RulesIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/rules/{id}', optionalBody: true)
  Future<chopper.Response<RuleSingle>> _v1RulesIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required RuleUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/rules/{id}')
  Future<chopper.Response> _v1RulesIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/tags/{tag}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1TagsTagAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
    @chopper.Tag()
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
  @GET(path: '/v1/tags/{tag}/transactions')
  Future<chopper.Response<TransactionArray>> _v1TagsTagTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/tags')
  Future<chopper.Response<TagArray>> _v1TagsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/tags', optionalBody: true)
  Future<chopper.Response<TagSingle>> _v1TagsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TagModelStore? body,
    @chopper.Tag()
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
  });

  ///Get a single tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
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
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
  @GET(path: '/v1/tags/{tag}')
  Future<chopper.Response<TagSingle>> _v1TagsTagGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('tag') required String? tag,
    @chopper.Tag()
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
  });

  ///Update existing tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
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
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
  @PUT(path: '/v1/tags/{tag}', optionalBody: true)
  Future<chopper.Response<TagSingle>> _v1TagsTagPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('tag') required String? tag,
    @Body() required TagModelUpdate? body,
    @chopper.Tag()
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
  });

  ///Delete an tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
  Future<chopper.Response> v1TagsTagDelete({
    String? xTraceId,
    required String? tag,
  }) {
    return _v1TagsTagDelete(xTraceId: xTraceId?.toString(), tag: tag);
  }

  ///Delete an tag.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your mileage may vary.
  @DELETE(path: '/v1/tags/{tag}')
  Future<chopper.Response> _v1TagsTagDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('tag') required String? tag,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/accounts')
  Future<chopper.Response<AccountArray>> _v1CurrenciesCodeAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('date') String? date,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/available-budgets')
  Future<chopper.Response<AvailableBudgetArray>>
  _v1CurrenciesCodeAvailableBudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/bills')
  Future<chopper.Response<BillArray>> _v1CurrenciesCodeBillsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/budget-limits')
  Future<chopper.Response<BudgetLimitArray>> _v1CurrenciesCodeBudgetLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('start') String? start,
    @Query('end') String? end,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/recurrences')
  Future<chopper.Response<RecurrenceArray>> _v1CurrenciesCodeRecurrencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/rules')
  Future<chopper.Response<RuleArray>> _v1CurrenciesCodeRulesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}/transactions')
  Future<chopper.Response<TransactionArray>> _v1CurrenciesCodeTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('code') required String? code,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies')
  Future<chopper.Response<CurrencyArray>> _v1CurrenciesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/currencies', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required CurrencyStore? body,
    @chopper.Tag()
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
  @POST(path: '/v1/currencies/{code}/enable', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeEnablePost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @POST(path: '/v1/currencies/{code}/disable', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeDisablePost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @chopper.Tag()
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
  });

  ///Make currency primary currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesCodePrimaryPost({
    String? xTraceId,
    required String? code,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesCodePrimaryPost(
      xTraceId: xTraceId?.toString(),
      code: code,
    );
  }

  ///Make currency primary currency.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param code The currency code.
  @POST(path: '/v1/currencies/{code}/primary', optionalBody: true)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodePrimaryPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @GET(path: '/v1/currencies/{code}')
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodeGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @chopper.Tag()
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
  @PUT(
    path: '/v1/currencies/{code}',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesCodePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @Body() required Map<String, String> body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/currencies/{code}')
  Future<chopper.Response> _v1CurrenciesCodeDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('code') required String? code,
    @chopper.Tag()
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
  });

  ///Get the primary currency of the current administration.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<CurrencySingle>> v1CurrenciesPrimaryGet({
    String? xTraceId,
  }) {
    generatedMapping.putIfAbsent(
      CurrencySingle,
      () => CurrencySingle.fromJsonFactory,
    );

    return _v1CurrenciesPrimaryGet(xTraceId: xTraceId?.toString());
  }

  ///Get the primary currency of the current administration.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @GET(path: '/v1/currencies/primary')
  Future<chopper.Response<CurrencySingle>> _v1CurrenciesPrimaryGet({
    @Header('X-Trace-Id') String? xTraceId,
    @chopper.Tag()
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
  @GET(path: '/v1/transaction-journals/{id}/links')
  Future<chopper.Response<TransactionLinkArray>>
  _v1TransactionJournalsIdLinksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/transaction-journals/{id}')
  Future<chopper.Response<TransactionSingle>> _v1TransactionJournalsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @DELETE(path: '/v1/transaction-journals/{id}')
  Future<chopper.Response> _v1TransactionJournalsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/transactions/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _v1TransactionsIdAttachmentsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/transactions/{id}/piggy-bank-events')
  Future<chopper.Response<PiggyBankEventArray>>
  _v1TransactionsIdPiggyBankEventsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/transactions')
  Future<chopper.Response<TransactionArray>> _v1TransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
    @chopper.Tag()
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
  @POST(path: '/v1/transactions', optionalBody: true)
  Future<chopper.Response<TransactionSingle>> _v1TransactionsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TransactionStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/transactions/{id}')
  Future<chopper.Response<TransactionSingle>> _v1TransactionsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/transactions/{id}', optionalBody: true)
  Future<chopper.Response<TransactionSingle>> _v1TransactionsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required TransactionUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/transactions/{id}')
  Future<chopper.Response> _v1TransactionsIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/user-groups')
  Future<chopper.Response<UserGroupArray>> _v1UserGroupsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @GET(path: '/v1/user-groups/{id}')
  Future<chopper.Response<UserGroupSingle>> _v1UserGroupsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/user-groups/{id}', optionalBody: true)
  Future<chopper.Response<UserGroupSingle>> _v1UserGroupsIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required UserGroupUpdate? body,
    @chopper.Tag()
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
  @GET(path: '/v1/search/accounts')
  Future<chopper.Response<AccountArray>> _v1SearchAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('query') required String? query,
    @Query('type') String? type,
    @Query('field') required String? field,
    @chopper.Tag()
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
  @GET(path: '/v1/search/transactions')
  Future<chopper.Response<TransactionArray>> _v1SearchTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('query') required String? query,
    @chopper.Tag()
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
  @GET(path: '/v1/summary/basic')
  Future<chopper.Response<BasicSummary>> _v1SummaryBasicGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('currency_code') String? currencyCode,
    @chopper.Tag()
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
  });

  ///System information end point.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<SystemInfo>> v1AboutGet({String? xTraceId}) {
    generatedMapping.putIfAbsent(SystemInfo, () => SystemInfo.fromJsonFactory);

    return _v1AboutGet(xTraceId: xTraceId?.toString());
  }

  ///System information end point.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @GET(path: '/v1/about')
  Future<chopper.Response<SystemInfo>> _v1AboutGet({
    @Header('X-Trace-Id') String? xTraceId,
    @chopper.Tag()
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
  });

  ///Currently authenticated user endpoint.
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<UserSingle>> v1AboutUserGet({String? xTraceId}) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _v1AboutUserGet(xTraceId: xTraceId?.toString());
  }

  ///Currently authenticated user endpoint.
  ///@param X-Trace-Id Unique identifier associated with this request.
  @GET(path: '/v1/about/user')
  Future<chopper.Response<UserSingle>> _v1AboutUserGet({
    @Header('X-Trace-Id') String? xTraceId,
    @chopper.Tag()
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
  @GET(path: '/v1/configuration')
  Future<chopper.Response<ConfigurationArray>> _v1ConfigurationGet({
    @Header('X-Trace-Id') String? xTraceId,
    @chopper.Tag()
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
  @GET(path: '/v1/configuration/{name}')
  Future<chopper.Response<ConfigurationSingle>> _v1ConfigurationNameGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @chopper.Tag()
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
  @PUT(path: '/v1/configuration/{name}', optionalBody: true)
  Future<chopper.Response<ConfigurationSingle>> _v1ConfigurationNamePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @Body() required ConfigurationUpdate? body,
    @chopper.Tag()
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
  @GET(path: '/v1/cron/{cliToken}')
  Future<chopper.Response<CronResult>> _v1CronCliTokenGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('cliToken') required String? cliToken,
    @Query('date') String? date,
    @Query('force') bool? force,
    @chopper.Tag()
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
  @GET(path: '/v1/users')
  Future<chopper.Response<UserArray>> _v1UsersGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/users', optionalBody: true)
  Future<chopper.Response<UserSingle>> _v1UsersPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required User? body,
    @chopper.Tag()
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
  @GET(path: '/v1/users/{id}')
  Future<chopper.Response<UserSingle>> _v1UsersIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/users/{id}', optionalBody: true)
  Future<chopper.Response<UserSingle>> _v1UsersIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required User? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/users/{id}')
  Future<chopper.Response> _v1UsersIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/preferences')
  Future<chopper.Response<PreferenceArray>> _v1PreferencesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/preferences', optionalBody: true)
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required Preference? body,
    @chopper.Tag()
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
  @GET(path: '/v1/preferences/{name}')
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesNameGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @chopper.Tag()
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
  @PUT(path: '/v1/preferences/{name}', optionalBody: true)
  Future<chopper.Response<PreferenceSingle>> _v1PreferencesNamePut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
    @Body() required PreferenceUpdate? body,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks/{id}/messages')
  Future<chopper.Response<WebhookMessageArray>> _v1WebhooksIdMessagesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response<WebhookMessageSingle>>
  _v1WebhooksIdMessagesMessageIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @chopper.Tag()
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
  @DELETE(path: '/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response> _v1WebhooksIdMessagesMessageIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks/{id}/messages/{messageId}/attempts')
  Future<chopper.Response<WebhookAttemptArray>>
  _v1WebhooksIdMessagesMessageIdAttemptsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response<WebhookAttemptSingle>>
  _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
    @chopper.Tag()
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
  @DELETE(path: '/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response>
  _v1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
    @chopper.Tag()
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
  @POST(path: '/v1/webhooks/{id}/submit', optionalBody: true)
  Future<chopper.Response> _v1WebhooksIdSubmitPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @POST(
    path: '/v1/webhooks/{id}/trigger-transaction/{transactionId}',
    optionalBody: true,
  )
  Future<chopper.Response> _v1WebhooksIdTriggerTransactionTransactionIdPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Path('transactionId') required String? transactionId,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks')
  Future<chopper.Response<WebhookArray>> _v1WebhooksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @chopper.Tag()
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
  @POST(path: '/v1/webhooks', optionalBody: true)
  Future<chopper.Response<WebhookSingle>> _v1WebhooksPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required WebhookStore? body,
    @chopper.Tag()
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
  @GET(path: '/v1/webhooks/{id}')
  Future<chopper.Response<WebhookSingle>> _v1WebhooksIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  @PUT(path: '/v1/webhooks/{id}', optionalBody: true)
  Future<chopper.Response<WebhookSingle>> _v1WebhooksIdPut({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @Body() required WebhookUpdate? body,
    @chopper.Tag()
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
  @DELETE(path: '/v1/webhooks/{id}')
  Future<chopper.Response> _v1WebhooksIdDelete({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('id') required String? id,
    @chopper.Tag()
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
