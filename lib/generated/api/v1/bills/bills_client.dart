// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/bill_array.dart';
import '../models/bill_single.dart';
import '../models/bill_store.dart';
import '../models/bill_update.dart';
import '../models/rule_array.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'bills_client.g.dart';

@RestApi()
abstract class BillsClient {
  factory BillsClient(Dio dio, {String? baseUrl}) = _BillsClient;

  /// List all attachments uploaded to the bill.
  ///
  /// This endpoint will list all attachments linked to the bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the bill.
  @GET('/v1/bills/{id}/attachments')
  Future<AttachmentArray> listAttachmentByBill({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all rules associated with the bill.
  ///
  /// This endpoint will list all rules that have an action to set the bill to this bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the bill.
  @GET('/v1/bills/{id}/rules')
  Future<RuleArray> listRuleByBill({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// List all transactions associated with the  bill.
  ///
  /// This endpoint will list all transactions linked to this bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the bill.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/bills/{id}/transactions')
  Future<TransactionArray> listTransactionByBill({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// List all bills.
  ///
  /// This endpoint will list all the user's bills.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [start] - A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @GET('/v1/bills')
  Future<BillArray> listBill({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Store a new bill.
  ///
  /// Creates a new bill. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/bills')
  Future<BillSingle> storeBill({
    @Body() required BillStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single bill.
  ///
  /// Get a single bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the bill.
  ///
  /// [start] - A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @GET('/v1/bills/{id}')
  Future<BillSingle> getBill({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Update existing bill.
  ///
  /// Update existing bill.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the bill.
  @FormUrlEncoded()
  @PUT('/v1/bills/{id}')
  Future<BillSingle> updateBill({
    @Path('id') required String id,
    @Body() required BillUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a bill.
  ///
  /// Delete a bill. This will not delete any associated rules. Will not remove associated transactions. WILL remove all associated attachments.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the bill.
  @DELETE('/v1/bills/{id}')
  Future<void> deleteBill({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
