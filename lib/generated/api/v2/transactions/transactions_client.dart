// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/transaction_v2_array.dart';
import '../models/transaction_v2_single.dart';
import '../models/transaction_v2_store.dart';

part 'transactions_client.g.dart';

@RestApi()
abstract class TransactionsClient {
  factory TransactionsClient(Dio dio, {String? baseUrl}) = _TransactionsClient;

  /// List all transactions.
  ///
  /// List all the transactions the user has made.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD. May be omitted.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  @GET('/v2/transactions')
  Future<TransactionV2Array> listTransactions({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Store a new transaction.
  ///
  /// Creates a new transaction. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v2/transactions')
  Future<TransactionV2Single> storeTransaction({
    @Body() required TransactionV2Store body,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
