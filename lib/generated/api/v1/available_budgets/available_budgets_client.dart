// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/available_budget_array.dart';
import '../models/available_budget_single.dart';

part 'available_budgets_client.g.dart';

@RestApi()
abstract class AvailableBudgetsClient {
  factory AvailableBudgetsClient(Dio dio, {String? baseUrl}) = _AvailableBudgetsClient;

  /// List all available budget amounts.
  ///
  /// Firefly III allows users to set the amount that is available to be budgeted in so-called "available budgets". For example, the user could have 1200,- available to be divided during the coming month. This amount is used on the /budgets page. This endpoint returns all of these amounts and the periods for which they are set.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v1/available-budgets')
  Future<AvailableBudgetArray> listAvailableBudget({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Get a single available budget.
  ///
  /// Get a single available budget, by ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the available budget.
  @GET('/v1/available-budgets/{id}')
  Future<AvailableBudgetSingle> getAvailableBudget({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
