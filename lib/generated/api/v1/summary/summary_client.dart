// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/basic_summary.dart';
import '../models/basic_summary_entry.dart';

part 'summary_client.g.dart';

@RestApi()
abstract class SummaryClient {
  factory SummaryClient(Dio dio, {String? baseUrl}) = _SummaryClient;

  /// Returns basic sums of the users data.
  ///
  /// Returns basic sums of the users data, like the net worth, spent and earned amounts. It is multi-currency, and is used in Firefly III to populate the dashboard.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [currencyCode] - A currency code like EUR or USD, to filter the result.
  @GET('/v1/summary/basic')
  Future<BasicSummary> getBasicSummary({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('currency_code') String? currencyCode,
  });
}
