// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/link_type.dart';
import '../models/link_type_array.dart';
import '../models/link_type_single.dart';
import '../models/link_type_update.dart';
import '../models/transaction_array.dart';
import '../models/transaction_link_array.dart';
import '../models/transaction_link_single.dart';
import '../models/transaction_link_store.dart';
import '../models/transaction_link_update.dart';
import '../models/transaction_type_filter.dart';

part 'links_client.g.dart';

@RestApi()
abstract class LinksClient {
  factory LinksClient(Dio dio, {String? baseUrl}) = _LinksClient;

  /// List all transactions under this link type.
  ///
  /// List all transactions under this link type, both the inward and outward transactions.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the link type.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the results.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the results.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/link-types/{id}/transactions')
  Future<TransactionArray> listTransactionByLinkType({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// List all types of links.
  ///
  /// List all the link types the system has. These include the default ones as well as any new ones.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/link-types')
  Future<LinkTypeArray> listLinkType({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Create a new link type.
  ///
  /// Creates a new link type. The data required can be submitted as a JSON body or as a list of parameters (in key=value pairs, like a webform).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/link-types')
  Future<LinkTypeSingle> storeLinkType({
    @Body() required LinkType body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get single a link type.
  ///
  /// Returns a single link type by its ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the link type.
  @GET('/v1/link-types/{id}')
  Future<LinkTypeSingle> getLinkType({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing link type.
  ///
  /// Used to update a single link type. All fields that are not submitted will be cleared (set to NULL). The model will tell you which fields are mandatory. You cannot update some of the system provided link types, indicated by the editable=false flag when you list it.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the link type.
  @FormUrlEncoded()
  @PUT('/v1/link-types/{id}')
  Future<LinkTypeSingle> updateLinkType({
    @Path('id') required String id,
    @Body() required LinkTypeUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Permanently delete link type.
  ///
  /// Will permanently delete a link type. The links between transactions will be removed. The transactions themselves remain. You cannot delete some of the system provided link types, indicated by the editable=false flag when you list it.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the link type.
  @DELETE('/v1/link-types/{id}')
  Future<void> deleteLinkType({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// List all transaction links.
  ///
  /// List all the transaction links.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/transaction-links')
  Future<TransactionLinkArray> listTransactionLink({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Create a new link between transactions.
  ///
  /// Store a new link between two transactions. For this end point you need the journal_id from a transaction.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/transaction-links')
  Future<TransactionLinkSingle> storeTransactionLink({
    @Body() required TransactionLinkStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single link.
  ///
  /// Returns a single link by its ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction link.
  @GET('/v1/transaction-links/{id}')
  Future<TransactionLinkSingle> getTransactionLink({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Permanently delete link between transactions.
  ///
  /// Will permanently delete link. Transactions remain.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction link.
  @DELETE('/v1/transaction-links/{id}')
  Future<void> deleteTransactionLink({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update an existing link between transactions.
  ///
  /// Used to update a single existing link.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the transaction link.
  @FormUrlEncoded()
  @PUT('/v1/transaction-links/{id}')
  Future<TransactionLinkSingle> updateTransactionLink({
    @Path('id') required String id,
    @Body() required TransactionLinkUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
