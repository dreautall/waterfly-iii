// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/budget_array.dart';
import '../models/budget_limit.dart';
import '../models/budget_limit_array.dart';
import '../models/budget_limit_single.dart';
import '../models/budget_limit_store.dart';
import '../models/budget_single.dart';
import '../models/budget_store.dart';
import '../models/budget_update.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'budgets_client.g.dart';

@RestApi()
abstract class BudgetsClient {
  factory BudgetsClient(Dio dio, {String? baseUrl}) = _BudgetsClient;

  /// List all transactions by a budget limit ID.
  ///
  /// List all the transactions within one budget limit. The start and end date are dictated by the budget limit.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///
  /// [limitId] - The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/budgets/{id}/limits/{limitId}/transactions')
  Future<TransactionArray> listTransactionByBudgetLimit({
    @Path('id') required String id,
    @Path('limitId') required String limitId,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('type') TransactionTypeFilter? type,
  });

  /// Get all limits for a budget.
  ///
  /// Get all budget limits for this budget and the money spent, and money left. You can limit the list by submitting a date range as well. The "spent" array for each budget limit is NOT influenced by the start and end date of your query, but by the start and end date of the budget limit itself.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the requested budget.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v1/budgets/{id}/limits')
  Future<BudgetLimitArray> listBudgetLimitByBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Store new budget limit.
  ///
  /// Store a new budget limit under this budget.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget.
  @FormUrlEncoded()
  @POST('/v1/budgets/{id}/limits')
  Future<BudgetLimitSingle> storeBudgetLimit({
    @Path('id') required String id,
    @Body() required BudgetLimitStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get single budget limit.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///
  /// [limitId] - The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @GET('/v1/budgets/{id}/limits/{limitId}')
  Future<BudgetLimitSingle> getBudgetLimit({
    @Path('id') required String id,
    @Path('limitId') required int limitId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing budget limit.
  ///
  /// Update existing budget limit.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///
  /// [limitId] - The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @FormUrlEncoded()
  @PUT('/v1/budgets/{id}/limits/{limitId}')
  Future<BudgetLimitSingle> updateBudgetLimit({
    @Path('id') required String id,
    @Path('limitId') required String limitId,
    @Body() required BudgetLimit body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a budget limit.
  ///
  /// Delete a budget limit.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///
  /// [limitId] - The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @DELETE('/v1/budgets/{id}/limits/{limitId}')
  Future<void> deleteBudgetLimit({
    @Path('id') required String id,
    @Path('limitId') required String limitId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get list of budget limits by date.
  ///
  /// Get all budget limits for for this date range.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v1/budget-limits')
  Future<BudgetLimitArray> listBudgetLimit({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// All transactions to a budget.
  ///
  /// Get all transactions linked to a budget, possibly limited by start and end.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the budget.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/budgets/{id}/transactions')
  Future<TransactionArray> listTransactionByBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// Lists all attachments of a budget.
  ///
  /// Lists all attachments.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the budget.
  @GET('/v1/budgets/{id}/attachments')
  Future<AttachmentArray> listAttachmentByBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all budgets.
  ///
  /// List all the budgets the user has made. If the start date and end date are submitted as well, the "spent" array will be updated accordingly.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  @GET('/v1/budgets')
  Future<BudgetArray> listBudget({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Store a new budget.
  ///
  /// Creates a new budget. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/budgets')
  Future<BudgetSingle> storeBudget({
    @Body() required BudgetStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single budget.
  ///
  /// Get a single budget. If the start date and end date are submitted as well, the "spent" array will be updated accordingly.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the requested budget.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  @GET('/v1/budgets/{id}')
  Future<BudgetSingle> getBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Update existing budget.
  ///
  /// Update existing budget. This endpoint cannot be used to set budget amount limits.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget.
  @FormUrlEncoded()
  @PUT('/v1/budgets/{id}')
  Future<BudgetSingle> updateBudget({
    @Path('id') required String id,
    @Body() required BudgetUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a budget.
  ///
  /// Delete a budget. Transactions will not be deleted.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the budget.
  @DELETE('/v1/budgets/{id}')
  Future<void> deleteBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
