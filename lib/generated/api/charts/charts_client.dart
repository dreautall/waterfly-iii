// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/chart_line_v2.dart';
import '../models/period_property.dart';
import '../models/preselected_account_property.dart';

part 'charts_client.g.dart';

@RestApi()
abstract class ChartsClient {
  factory ChartsClient(Dio dio, {String? baseUrl}) = _ChartsClient;

  /// Dashboard chart with asset account balance information.
  ///
  /// This endpoint returns the data required to generate a chart with basic asset account balance information. By default it contains the users frontpage accounts OR all the user's asset accounts if this preference is empty.
  /// You can also submit an array of account ID's to be used to generate the chart. Or, use the "preselected" argument to have Firefly III make a specific selection.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [preselected] - The accounts Firefly III must include in this chart.
  ///
  /// [accounts] - An array of accounts that should be included. Example: accounts[]=1&accounts[]=2.
  @GET('/v2/chart/account/dashboard')
  Future<ChartLineV2> getChartAccountOverview({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('preselected') PreselectedAccountProperty? preselected,
    @Query('accounts[]') List<int>? object1,
  });

  /// A chart that contains spent/earned amounts.
  ///
  /// The chart contains spent/earned amounts for the given date range, grouped by the given period, and collected for the given accounts.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - An array of accounts that should be included. Example: accounts[]=1&accounts[]=2.
  ///
  ///
  /// [period] - The period by which the results must be grouped.
  @GET('/v2/chart/balance/balance')
  Future<ChartLineV2> getBalanceChart({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Query('accounts[]') required List<int> object3,
    @Query('period') required PeriodProperty period,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Dashboard chart with budget information.
  ///
  /// This endpoint returns the data required to generate a chart with a budget overview of the current period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/chart/budget/dashboard')
  Future<ChartLineV2> getChartBudgetOverview({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Dashboard chart with budget information.
  ///
  /// This endpoint returns the data required to generate a chart with a budget overview of the current period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/chart/category/dashboard')
  Future<ChartLineV2> getChartCategoryOverview({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
