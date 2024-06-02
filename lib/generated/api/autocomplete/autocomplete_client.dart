// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_type_filter.dart';
import '../models/autocomplete_account_v2_array.dart';
import '../models/autocomplete_td_array.dart';

part 'autocomplete_client.g.dart';

@RestApi()
abstract class AutocompleteClient {
  factory AutocompleteClient(Dio dio, {String? baseUrl}) = _AutocompleteClient;

  /// Returns all accounts of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  ///
  /// [date] - If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///
  /// [types] - Optional filter on the account type(s) used in the autocomplete.
  @GET('/v2/autocomplete/accounts')
  Future<AutocompleteAccountV2Array> getAccountsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<AccountTypeFilter>? types,
  });

  /// Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [query] - The autocomplete search query.
  ///
  /// [limit] - The number of items returned.
  @GET('/v2/autocomplete/transaction-descriptions')
  Future<AutocompleteTDArray> getTransactionDescriptionsAC({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });
}
