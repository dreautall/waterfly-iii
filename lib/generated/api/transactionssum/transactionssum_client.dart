// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/transaction_sum_array.dart';

part 'transactionssum_client.g.dart';

@RestApi()
abstract class TransactionssumClient {
  factory TransactionssumClient(Dio dio, {String? baseUrl}) = _TransactionssumClient;

  /// Returns the sum of the bills already paid in the period indicated.
  ///
  /// This endpoint sums up (by currency) the transactions linked to subscriptions paid in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/subscriptions/sum/paid')
  Future<TransactionSumArray> getSubscriptionsPaidTrSum({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Returns the sum of the subscriptions not yet paid in the period indicated.
  ///
  /// This endpoint sums up (by currency) the transactions linked to subscriptions unpaid in the given period.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  @GET('/v2/subscriptions/sum/unpaid')
  Future<TransactionSumArray> getSubscriptionsUnpaidTrSum({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
