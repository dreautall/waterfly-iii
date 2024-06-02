// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/bill_array.dart';
import '../models/object_group_array.dart';
import '../models/object_group_single.dart';
import '../models/object_group_update.dart';
import '../models/piggy_bank_array.dart';

part 'object_groups_client.g.dart';

@RestApi()
abstract class ObjectGroupsClient {
  factory ObjectGroupsClient(Dio dio, {String? baseUrl}) = _ObjectGroupsClient;

  /// List all piggy banks related to the object group.
  ///
  /// This endpoint returns a list of all the piggy banks connected to the object group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the account.
  @GET('/v1/object-groups/{id}/piggy-banks')
  Future<PiggyBankArray> listPiggyBankByObjectGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all bills with this object group.
  ///
  /// List all bills with this object group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the account.
  @GET('/v1/object-groups/{id}/bills')
  Future<BillArray> listBillByObjectGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all oject groups.
  ///
  /// List all oject groups.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/object-groups')
  Future<ObjectGroupArray> listObjectGroups({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Get a single object group.
  ///
  /// Get a single object group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the object group.
  @GET('/v1/object-groups/{id}')
  Future<ObjectGroupSingle> getObjectGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing object group.
  ///
  /// Update existing object group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the object group.
  @FormUrlEncoded()
  @PUT('/v1/object-groups/{id}')
  Future<ObjectGroupSingle> updateObjectGroup({
    @Path('id') required String id,
    @Body() required ObjectGroupUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a object group.
  ///
  /// Delete a object group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the object group.
  @DELETE('/v1/object-groups/{id}')
  Future<void> deleteObjectGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
