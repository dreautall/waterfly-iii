// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/category.dart';
import '../models/category_array.dart';
import '../models/category_single.dart';
import '../models/category_update.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'categories_client.g.dart';

@RestApi()
abstract class CategoriesClient {
  factory CategoriesClient(Dio dio, {String? baseUrl}) = _CategoriesClient;

  /// List all transactions in a category.
  ///
  /// List all transactions in a category, optionally limited to the date ranges specified.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the category.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the result list.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the result list.
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/categories/{id}/transactions')
  Future<TransactionArray> listTransactionByCategory({
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
  /// [id] - The ID of the category.
  @GET('/v1/categories/{id}/attachments')
  Future<AttachmentArray> listAttachmentByCategory({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all categories.
  ///
  /// List all categories.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/categories')
  Future<CategoryArray> listCategory({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new category.
  ///
  /// Creates a new category. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/categories')
  Future<CategorySingle> storeCategory({
    @Body() required Category body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single category.
  ///
  /// Get a single category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the category.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to show spent and earned info.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to show spent and earned info.
  @GET('/v1/categories/{id}')
  Future<CategorySingle> getCategory({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });

  /// Update existing category.
  ///
  /// Update existing category.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the category.
  @FormUrlEncoded()
  @PUT('/v1/categories/{id}')
  Future<CategorySingle> updateCategory({
    @Path('id') required String id,
    @Body() required CategoryUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a category.
  ///
  /// Delete a category. Transactions will not be removed.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the category.
  @DELETE('/v1/categories/{id}')
  Future<void> deleteCategory({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
