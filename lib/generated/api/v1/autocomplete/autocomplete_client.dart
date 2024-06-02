// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_type_filter.dart';
import '../models/autocomplete_account_array.dart';
import '../models/autocomplete_bill_array.dart';
import '../models/autocomplete_budget_array.dart';
import '../models/autocomplete_category_array.dart';
import '../models/autocomplete_currency_array.dart';
import '../models/autocomplete_currency_code_array.dart';
import '../models/autocomplete_object_group_array.dart';
import '../models/autocomplete_piggy_array.dart';
import '../models/autocomplete_piggy_balance_array.dart';
import '../models/autocomplete_recurrence_array.dart';
import '../models/autocomplete_rule_array.dart';
import '../models/autocomplete_rule_group_array.dart';
import '../models/autocomplete_tag_array.dart';
import '../models/autocomplete_transaction_array.dart';
import '../models/autocomplete_transaction_id_array.dart';
import '../models/autocomplete_transaction_type_array.dart';

part 'autocomplete_client.g.dart';

@RestApi()
abstract class AutocompleteClient {
  factory AutocompleteClient(Dio dio, {String? baseUrl}) = _AutocompleteClient;

  /// Returns all accounts of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  ///
  /// [date] - If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///
  /// [types] - Optional filter on the account type(s) used in the autocomplete.
  @GET('/v1/autocomplete/accounts')
  Future<AutocompleteAccountArray> getAccountsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<AccountTypeFilter>? types,
  });

  /// Returns all bills of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/bills')
  Future<AutocompleteBillArray> getBillsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all budgets of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/budgets')
  Future<AutocompleteBudgetArray> getBudgetsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all categories of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/categories')
  Future<AutocompleteCategoryArray> getCategoriesAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all currencies of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/currencies')
  Future<AutocompleteCurrencyArray> getCurrenciesAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/currencies-with-code')
  Future<AutocompleteCurrencyCodeArray> getCurrenciesCodeAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all object groups of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/object-groups')
  Future<AutocompleteObjectGroupArray> getObjectGroupsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all piggy banks of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/piggy-banks')
  Future<AutocompletePiggyArray> getPiggiesAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all piggy banks of the user returned in a basic auto-complete array complemented with balance information.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/piggy-banks-with-balance')
  Future<AutocompletePiggyBalanceArray> getPiggiesBalanceAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all recurring transactions of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/recurring')
  Future<AutocompleteRecurrenceArray> getRecurringAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all rule groups of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/rule-groups')
  Future<AutocompleteRuleGroupArray> getRuleGroupsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all rules of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/rules')
  Future<AutocompleteRuleArray> getRulesAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all tags of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/tags')
  Future<AutocompleteTagArray> getTagAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all transaction types returned in a basic auto-complete array. English only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/transaction-types')
  Future<AutocompleteTransactionTypeArray> getTransactionTypesAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all transaction descriptions of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/transactions')
  Future<AutocompleteTransactionArray> getTransactionsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  /// Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v1/autocomplete/transactions-with-id')
  Future<AutocompleteTransactionIDArray> getTransactionsIdac({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });
}
