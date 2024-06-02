// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/net_worth_array.dart';

part 'networth_client.g.dart';

@RestApi()
abstract class NetworthClient {
  factory NetworthClient(Dio dio, {String? baseUrl}) = _NetworthClient;

  /// Shows the net worth.
  ///
  /// Shows a multi-currency overview of the user's net worth.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [date] - A date formatted YYYY-MM-DD.
  @GET('/v2/net-worth')
  Future<NetWorthArray> getNetWorth({
    @Query('date') required DateTime date,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
