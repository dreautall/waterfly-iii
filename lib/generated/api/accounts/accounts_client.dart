// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_v2_single.dart';
import '../models/transaction_type_filter.dart';
import '../models/transaction_v2_array.dart';

part 'accounts_client.g.dart';

@RestApi()
abstract class AccountsClient {
  factory AccountsClient(Dio dio, {String? baseUrl}) = _AccountsClient;

  /// Get single account.
  ///
  /// Returns a single account by its ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [date] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [id] - The ID of the account.
  @GET('/v2/accounts/{id}')
  Future<AccountV2Single> getAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') DateTime? date,
  });

  /// List all transactions related to the account.
  ///
  /// This endpoint returns a list of all the transactions connected to the account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD. May be omitted.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///
  ///
  /// [id] - The ID of the account.
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v2/accounts/{id}/transactions')
  Future<TransactionV2Array> listTransactionByAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });
}
