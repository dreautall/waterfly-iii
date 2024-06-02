// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/piggy_bank_event_array.dart';
import '../models/transaction_array.dart';
import '../models/transaction_link_array.dart';
import '../models/transaction_single.dart';
import '../models/transaction_store.dart';
import '../models/transaction_type_filter.dart';
import '../models/transaction_update.dart';

part 'transactions_client.g.dart';

@RestApi()
abstract class TransactionsClient {
  factory TransactionsClient(Dio dio, {String? baseUrl}) = _TransactionsClient;

  /// Lists all the transaction links for an individual journal (individual split).
  ///
  /// Lists all the transaction links for an individual journal (a split). Don't use the group ID, you need the actual underlying journal (the split).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the transaction journal / the split.
  @GET('/v1/transaction-journals/{id}/links')
  Future<TransactionLinkArray> listLinksByJournal({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Get a single transaction, based on one of the underlying transaction journals (transaction splits).
  ///
  /// Get a single transaction by underlying journal (split).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction journal (split).
  @GET('/v1/transaction-journals/{id}')
  Future<TransactionSingle> getTransactionByJournal({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete split from transaction.
  ///
  /// Delete an individual journal (split) from a transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction journal (the split) you wish to delete.
  @DELETE('/v1/transaction-journals/{id}')
  Future<void> deleteTransactionJournal({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Lists all attachments.
  ///
  /// Lists all attachments.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the transaction.
  @GET('/v1/transactions/{id}/attachments')
  Future<AttachmentArray> listAttachmentByTransaction({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Lists all piggy bank events.
  ///
  /// Lists all piggy bank events.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the transaction.
  @GET('/v1/transactions/{id}/piggy-bank-events')
  Future<PiggyBankEventArray> listEventByTransaction({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all the user's transactions.
  ///
  /// List all the user's transactions.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/transactions')
  Future<TransactionArray> listTransaction({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// Store a new transaction.
  ///
  /// Creates a new transaction. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/transactions')
  Future<TransactionSingle> storeTransaction({
    @Body() required TransactionStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single transaction.
  ///
  /// Get a single transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction.
  @GET('/v1/transactions/{id}')
  Future<TransactionSingle> getTransaction({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing transaction. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/.
  ///
  /// Update an existing transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction.
  @FormUrlEncoded()
  @PUT('/v1/transactions/{id}')
  Future<TransactionSingle> updateTransaction({
    @Path('id') required String id,
    @Body() required TransactionUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a transaction.
  ///
  /// Delete a transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction.
  @DELETE('/v1/transactions/{id}')
  Future<void> deleteTransaction({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
