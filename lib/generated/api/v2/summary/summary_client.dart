// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/basic_summary_v2.dart';
import '../models/basic_summary_v2_entry.dart';

part 'summary_client.g.dart';

@RestApi()
abstract class SummaryClient {
  factory SummaryClient(Dio dio, {String? baseUrl}) = _SummaryClient;

  /// Returns basic sums of the users data.
  ///
  /// Returns basic sums of the users data, like the net worth, spent and earned amounts. It is multi-currency, and is used in Firefly III to populate the dashboard. Used on the dashboard.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/summary/basic')
  Future<BasicSummaryV2> getBasicSummary({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
