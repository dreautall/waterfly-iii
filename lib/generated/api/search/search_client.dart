// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_array.dart';
import '../models/account_search_field_filter.dart';
import '../models/account_type_filter.dart';
import '../models/transaction_array.dart';

part 'search_client.g.dart';

@RestApi()
abstract class SearchClient {
  factory SearchClient(Dio dio, {String? baseUrl}) = _SearchClient;

  /// Search for accounts.
  ///
  /// Search for accounts.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [query] - The query you wish to search for.
  ///
  /// [type] - The type of accounts you wish to limit the search to.
  ///
  /// [field] - The account field(s) you want to search in.
  @GET('/v1/search/accounts')
  Future<AccountArray> searchAccounts({
    @Query('query') required String query,
    @Query('field') required AccountSearchFieldFilter field,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('type') AccountTypeFilter? type,
  });

  /// Search for transactions.
  ///
  /// Searches through the users transactions.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [query] - The query you wish to search for.
  @GET('/v1/search/transactions')
  Future<TransactionArray> searchTransactions({
    @Query('query') required String query,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });
}
