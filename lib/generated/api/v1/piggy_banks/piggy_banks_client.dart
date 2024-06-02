// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/piggy_bank_array.dart';
import '../models/piggy_bank_event_array.dart';
import '../models/piggy_bank_single.dart';
import '../models/piggy_bank_store.dart';
import '../models/piggy_bank_update.dart';

part 'piggy_banks_client.g.dart';

@RestApi()
abstract class PiggyBanksClient {
  factory PiggyBanksClient(Dio dio, {String? baseUrl}) = _PiggyBanksClient;

  /// List all events linked to a piggy bank.
  ///
  /// List all events linked to a piggy bank (adding and removing money).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the piggy bank.
  @GET('/v1/piggy-banks/{id}/events')
  Future<PiggyBankEventArray> listEventByPiggyBank({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
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
  /// [id] - The ID of the piggy bank.
  @GET('/v1/piggy-banks/{id}/attachments')
  Future<AttachmentArray> listAttachmentByPiggyBank({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all piggy banks.
  ///
  /// List all piggy banks.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/piggy-banks')
  Future<PiggyBankArray> listPiggyBank({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new piggy bank.
  ///
  /// Creates a new piggy bank. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/piggy-banks')
  Future<PiggyBankSingle> storePiggyBank({
    @Body() required PiggyBankStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single piggy bank.
  ///
  /// Get a single piggy bank.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the piggy bank.
  @GET('/v1/piggy-banks/{id}')
  Future<PiggyBankSingle> getPiggyBank({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing piggy bank.
  ///
  /// Update existing piggy bank.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the piggy bank.
  @FormUrlEncoded()
  @PUT('/v1/piggy-banks/{id}')
  Future<PiggyBankSingle> updatePiggyBank({
    @Path('id') required String id,
    @Body() required PiggyBankUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a piggy bank.
  ///
  /// Delete a piggy bank.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the piggy bank.
  @DELETE('/v1/piggy-banks/{id}')
  Future<void> deletePiggyBank({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
