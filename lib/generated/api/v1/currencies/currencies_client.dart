// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_array.dart';
import '../models/account_type_filter.dart';
import '../models/available_budget_array.dart';
import '../models/bill_array.dart';
import '../models/budget_limit_array.dart';
import '../models/currency_array.dart';
import '../models/currency_single.dart';
import '../models/currency_store.dart';
import '../models/currency_update.dart';
import '../models/recurrence_array.dart';
import '../models/rule_array.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'currencies_client.g.dart';

@RestApi()
abstract class CurrenciesClient {
  factory CurrenciesClient(Dio dio, {String? baseUrl}) = _CurrenciesClient;

  /// List all accounts with this currency.
  ///
  /// List all accounts with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  ///
  /// [date] - A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///
  ///
  /// [type] - Optional filter on the account type(s) returned.
  @GET('/v1/currencies/{code}/accounts')
  Future<AccountArray> listAccountByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('date') DateTime? date,
    @Query('type') AccountTypeFilter? type,
  });

  /// List all available budgets with this currency.
  ///
  /// List all available budgets with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  @GET('/v1/currencies/{code}/available-budgets')
  Future<AvailableBudgetArray> listAvailableBudgetByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all bills with this currency.
  ///
  /// List all bills with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  @GET('/v1/currencies/{code}/bills')
  Future<BillArray> listBillByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all budget limits with this currency.
  ///
  /// List all budget limits with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  ///
  /// [start] - Start date for the budget limit list.
  ///
  /// [end] - End date for the budget limit list.
  @GET('/v1/currencies/{code}/budget_limits')
  Future<BudgetLimitArray> listBudgetLimitByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// List all recurring transactions with this currency.
  ///
  /// List all recurring transactions with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  @GET('/v1/currencies/{code}/recurrences')
  Future<RecurrenceArray> listRecurrenceByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all rules with this currency.
  ///
  /// List all rules with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  @GET('/v1/currencies/{code}/rules')
  Future<RuleArray> listRuleByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all transactions with this currency.
  ///
  /// List all transactions with this currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [code] - The currency code.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/currencies/{code}/transactions')
  Future<TransactionArray> listTransactionByCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// List all currencies.
  ///
  /// List all currencies.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/currencies')
  Future<CurrencyArray> listCurrency({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new currency.
  ///
  /// Creates a new currency. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/currencies')
  Future<CurrencySingle> storeCurrency({
    @Body() required CurrencyStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Enable a single currency.
  ///
  /// Enable a single currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @POST('/v1/currencies/{code}/enable')
  Future<CurrencySingle> enableCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Disable a currency.
  ///
  /// Disable a currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @POST('/v1/currencies/{code}/disable')
  Future<CurrencySingle> disableCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Make currency default currency.
  ///
  /// Make this currency the default currency for the user. If the currency is not enabled, it will be enabled as well.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @POST('/v1/currencies/{code}/default')
  Future<CurrencySingle> defaultCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single currency.
  ///
  /// Get a single currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @GET('/v1/currencies/{code}')
  Future<CurrencySingle> getCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing currency.
  ///
  /// Update existing currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @FormUrlEncoded()
  @PUT('/v1/currencies/{code}')
  Future<CurrencySingle> updateCurrency({
    @Path('code') required String code,
    @Body() required CurrencyUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a currency.
  ///
  /// Delete a currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [code] - The currency code.
  @DELETE('/v1/currencies/{code}')
  Future<void> deleteCurrency({
    @Path('code') required String code,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get the user's default currency.
  ///
  /// Get the user's default currency.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @GET('/v1/currencies/default')
  Future<CurrencySingle> getDefaultCurrency({
    @Header('X-Trace-Id') String? xTraceId,
  });
}
