// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/insight_group.dart';
import '../models/insight_total.dart';
import '../models/insight_transfer.dart';

part 'insight_client.g.dart';

@RestApi()
abstract class InsightClient {
  factory InsightClient(Dio dio, {String? baseUrl}) = _InsightClient;

  /// Insight into expenses, grouped by expense account.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by expense account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you add the accounts ID's of expense accounts, only those accounts.
  /// are included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. You can combine both asset / liability and expense account ID's.
  /// Other account ID's will be ignored.
  @GET('/v1/insight/expense/expense')
  Future<InsightGroup> insightExpenseExpense({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object1,
  });

  /// Insight into expenses, grouped by asset account.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by asset account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/asset')
  Future<InsightGroup> insightExpenseAsset({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object3,
  });

  /// Insight into income, grouped by revenue account.
  ///
  /// This endpoint gives a summary of the income received by the user, grouped by revenue account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you add the accounts ID's of revenue accounts, only those accounts.
  /// are included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. You can combine both asset / liability and deposit account ID's.
  /// Other account ID's will be ignored.
  @GET('/v1/insight/income/revenue')
  Future<InsightGroup> insightIncomeRevenue({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object5,
  });

  /// Insight into income, grouped by asset account.
  ///
  /// This endpoint gives a summary of the income received by the user, grouped by asset account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/asset')
  Future<InsightGroup> insightIncomeAsset({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object7,
  });

  /// Insight into transfers, grouped by account.
  ///
  /// This endpoint gives a summary of the transfers made by the user, grouped by asset account or lability.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/asset')
  Future<InsightTransfer> insightTransfers({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object9,
  });

  /// Insight into expenses, grouped by bill.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by (any) bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [bills] - The bills to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/bill')
  Future<InsightGroup> insightExpenseBill({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('bills[]') List<int>? object11,
    @Query('accounts[]') List<int>? object13,
  });

  /// Insight into expenses, without bill.
  ///
  /// This endpoint gives a summary of the expenses made by the user, including only expenses with no bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/no-bill')
  Future<InsightTotal> insightExpenseNoBill({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object15,
  });

  /// Insight into expenses, grouped by budget.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by (any) budget.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [budgets] - The budgets to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/budget')
  Future<InsightGroup> insightExpenseBudget({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('budgets[]') List<int>? object17,
    @Query('accounts[]') List<int>? object19,
  });

  /// Insight into expenses, without budget.
  ///
  /// This endpoint gives a summary of the expenses made by the user, including only expenses with no budget.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/no-budget')
  Future<InsightTotal> insightExpenseNoBudget({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object21,
  });

  /// Insight into expenses, grouped by category.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by (any) category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [categories] - The categories to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/category')
  Future<InsightGroup> insightExpenseCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('categories[]') List<int>? object23,
    @Query('accounts[]') List<int>? object25,
  });

  /// Insight into expenses, without category.
  ///
  /// This endpoint gives a summary of the expenses made by the user, including only expenses with no category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/no-category')
  Future<InsightTotal> insightExpenseNoCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object27,
  });

  /// Insight into income, grouped by category.
  ///
  /// This endpoint gives a summary of the income received by the user, grouped by (any) category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [categories] - The categories to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/category')
  Future<InsightGroup> insightIncomeCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('categories[]') List<int>? object29,
    @Query('accounts[]') List<int>? object31,
  });

  /// Insight into income, without category.
  ///
  /// This endpoint gives a summary of the income received by the user, including only income with no category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/no-category')
  Future<InsightTotal> insightIncomeNoCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object33,
  });

  /// Insight into transfers, grouped by category.
  ///
  /// This endpoint gives a summary of the transfers made by the user, grouped by (any) category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [categories] - The categories to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/category')
  Future<InsightGroup> insightTransferCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('categories[]') List<int>? object35,
    @Query('accounts[]') List<int>? object37,
  });

  /// Insight into transfers, without category.
  ///
  /// This endpoint gives a summary of the transfers made by the user, including only transfers with no category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/no-category')
  Future<InsightTotal> insightTransferNoCategory({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object39,
  });

  /// Insight into expenses, grouped by tag.
  ///
  /// This endpoint gives a summary of the expenses made by the user, grouped by (any) tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [tags] - The tags to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/tag')
  Future<InsightGroup> insightExpenseTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('tags[]') List<int>? object41,
    @Query('accounts[]') List<int>? object43,
  });

  /// Insight into expenses, without tag.
  ///
  /// This endpoint gives a summary of the expenses made by the user, including only expenses with no tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/no-tag')
  Future<InsightTotal> insightExpenseNoTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object45,
  });

  /// Insight into income, grouped by tag.
  ///
  /// This endpoint gives a summary of the income received by the user, grouped by (any) tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [tags] - The tags to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/tag')
  Future<InsightGroup> insightIncomeTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('tags[]') List<int>? object47,
    @Query('accounts[]') List<int>? object49,
  });

  /// Insight into income, without tag.
  ///
  /// This endpoint gives a summary of the income received by the user, including only income with no tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/no-tag')
  Future<InsightTotal> insightIncomeNoTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object51,
  });

  /// Insight into transfers, grouped by tag.
  ///
  /// This endpoint gives a summary of the transfers created by the user, grouped by (any) tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [tags] - The tags to be included in the results.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/tag')
  Future<InsightGroup> insightTransferTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('tags[]') List<int>? object53,
    @Query('accounts[]') List<int>? object55,
  });

  /// Insight into expenses, without tag.
  ///
  /// This endpoint gives a summary of the transfers made by the user, including only transfers with no tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/no-tag')
  Future<InsightTotal> insightTransferNoTag({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object57,
  });

  /// Insight into total expenses.
  ///
  /// This endpoint gives a sum of the total expenses made by the user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/expense/total')
  Future<InsightTotal> insightExpenseTotal({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object59,
  });

  /// Insight into total income.
  ///
  /// This endpoint gives a sum of the total income received by the user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/income/total')
  Future<InsightTotal> insightIncomeTotal({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object61,
  });

  /// Insight into total transfers.
  ///
  /// This endpoint gives a sum of the total amount transfers made by the user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those.
  /// asset accounts / liabilities will be included. Other account ID's will be ignored.
  @GET('/v1/insight/transfer/total')
  Future<InsightTotal> insightTransferTotal({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts[]') List<int>? object63,
  });
}
