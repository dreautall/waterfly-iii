// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/chart_line.dart';
import '../models/chart_data_set.dart';

part 'charts_client.g.dart';

@RestApi()
abstract class ChartsClient {
  factory ChartsClient(Dio dio, {String? baseUrl}) = _ChartsClient;

  /// Dashboard chart with asset account balance information.
  ///
  /// This endpoint returns the data required to generate a chart with basic asset account balance information.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v1/chart/account/overview')
  Future<ChartLine> getChartAccountOverview({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
