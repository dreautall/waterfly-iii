// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/budget_limit_v2.dart';
import '../models/budget_limit_v2_array.dart';
import '../models/budget_v2.dart';
import '../models/budget_v2_array.dart';
import '../models/transaction_sum.dart';
import '../models/transaction_sum_array.dart';

part 'budgets_client.g.dart';

@RestApi()
abstract class BudgetsClient {
  factory BudgetsClient(Dio dio, {String? baseUrl}) = _BudgetsClient;

  /// List all budgets.
  ///
  /// List all the budgets the user has made.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v2/budgets')
  Future<BudgetV2Array> listBudgets({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Get all limits for a budget.
  ///
  /// Get all budget limits for this budget.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [id] - The ID of the requested budget.
  @GET('/v2/budgets/{id}/limits')
  Future<BudgetLimitV2Array> listBudgetLimitByBudget({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Returns the budgeted amount for the given budget in the given period.
  ///
  /// Returns the budgeted amount for the given budget in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [id] - The ID of the budget.
  @GET('/v2/budgets/{id}/budgeted')
  Future<TransactionSumArray> getBudgetedForBudget({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Returns the spent amount for the given budget in the given period.
  ///
  /// Returns the spent amount for the given budget in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [id] - The ID of the budget.
  @GET('/v2/budgets/{id}/spent')
  Future<TransactionSumArray> getSpentForBudget({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Returns the budgeted amount for all budgets in the given period.
  ///
  /// Returns the budgeted amount for all budgets in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/budgets/sum/budgeted')
  Future<TransactionSumArray> getBudgetedForBudgets({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Returns the spent amount for all budgets in the given period.
  ///
  /// Returns the spent amount for all budgets in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/budgets/sum/spent')
  Future<TransactionSumArray> getSpentForBudgets({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
