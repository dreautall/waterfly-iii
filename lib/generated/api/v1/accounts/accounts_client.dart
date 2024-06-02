// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_array.dart';
import '../models/account_single.dart';
import '../models/account_store.dart';
import '../models/account_type_filter.dart';
import '../models/account_update.dart';
import '../models/attachment_array.dart';
import '../models/piggy_bank_array.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'accounts_client.g.dart';

@RestApi()
abstract class AccountsClient {
  factory AccountsClient(Dio dio, {String? baseUrl}) = _AccountsClient;

  /// List all transactions related to the account.
  ///
  /// This endpoint returns a list of all the transactions connected to the account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the account.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/accounts/{id}/transactions')
  Future<TransactionArray> listTransactionByAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
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
  /// [id] - The ID of the account.
  @GET('/v1/accounts/{id}/attachments')
  Future<AttachmentArray> listAttachmentByAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all piggy banks related to the account.
  ///
  /// This endpoint returns a list of all the piggy banks connected to the account.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the account.
  @GET('/v1/accounts/{id}/piggy-banks')
  Future<PiggyBankArray> listPiggyBankByAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all accounts.
  ///
  /// This endpoint returns a list of all the accounts owned by the authenticated user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [date] - A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///
  ///
  /// [type] - Optional filter on the account type(s) returned.
  @GET('/v1/accounts')
  Future<AccountArray> listAccount({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('date') DateTime? date,
    @Query('type') AccountTypeFilter? type,
  });

  /// Create new account.
  ///
  /// Creates a new account. The data required can be submitted as a JSON body or as a list of parameters (in key=value pairs, like a webform).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/accounts')
  Future<AccountSingle> storeAccount({
    @Body() required AccountStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get single account.
  ///
  /// Returns a single account by its ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the account.
  ///
  /// [date] - A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  @GET('/v1/accounts/{id}')
  Future<AccountSingle> getAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') DateTime? date,
  });

  /// Update existing account.
  ///
  /// Used to update a single account. All fields that are not submitted will be cleared (set to NULL). The model will tell you which fields are mandatory.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the account.
  @FormUrlEncoded()
  @PUT('/v1/accounts/{id}')
  Future<AccountSingle> updateAccount({
    @Path('id') required String id,
    @Body() required AccountUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Permanently delete account.
  ///
  /// Will permanently delete an account. Any associated transactions and piggy banks are ALSO deleted. Cannot be recovered from.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the account.
  @DELETE('/v1/accounts/{id}')
  Future<void> deleteAccount({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
