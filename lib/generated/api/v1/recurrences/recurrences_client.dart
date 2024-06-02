// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/recurrence_array.dart';
import '../models/recurrence_single.dart';
import '../models/recurrence_store.dart';
import '../models/recurrence_update.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'recurrences_client.g.dart';

@RestApi()
abstract class RecurrencesClient {
  factory RecurrencesClient(Dio dio, {String? baseUrl}) = _RecurrencesClient;

  /// List all transactions created by a recurring transaction.
  ///
  /// List all transactions created by a recurring transaction, optionally limited to the date ranges specified.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the recurring transaction.
  ///
  /// [start] - A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/recurrences/{id}/transactions')
  Future<TransactionArray> listTransactionByRecurrence({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// List all recurring transactions.
  ///
  /// List all recurring transactions.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/recurrences')
  Future<RecurrenceArray> listRecurrence({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new recurring transaction.
  ///
  /// Creates a new recurring transaction. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/recurrences')
  Future<RecurrenceSingle> storeRecurrence({
    @Body() required RecurrenceStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single recurring transaction.
  ///
  /// Get a single recurring transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the recurring transaction.
  @GET('/v1/recurrences/{id}')
  Future<RecurrenceSingle> getRecurrence({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing recurring transaction.
  ///
  /// Update existing recurring transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the recurring transaction.
  @FormUrlEncoded()
  @PUT('/v1/recurrences/{id}')
  Future<RecurrenceSingle> updateRecurrence({
    @Path('id') required String id,
    @Body() required RecurrenceUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a recurring transaction.
  ///
  /// Delete a recurring transaction. Transactions created by the recurring transaction will not be deleted.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the recurring transaction.
  @DELETE('/v1/recurrences/{id}')
  Future<void> deleteRecurrence({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
