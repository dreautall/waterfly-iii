// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/tag_array.dart';
import '../models/tag_model_store.dart';
import '../models/tag_model_update.dart';
import '../models/tag_single.dart';
import '../models/transaction_array.dart';
import '../models/transaction_type_filter.dart';

part 'tags_client.g.dart';

@RestApi()
abstract class TagsClient {
  factory TagsClient(Dio dio, {String? baseUrl}) = _TagsClient;

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
  /// [tag] - Either the tag itself or the tag ID.
  @GET('/v1/tags/{tag}/attachments')
  Future<AttachmentArray> listAttachmentByTag({
    @Path('tag') required String tag,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// List all transactions with this tag.
  ///
  /// List all transactions with this tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [tag] - Either the tag itself or the tag ID.
  ///
  /// [start] - A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///
  ///
  /// [type] - Optional filter on the transaction type(s) returned.
  @GET('/v1/tags/{tag}/transactions')
  Future<TransactionArray> listTransactionByTag({
    @Path('tag') required String tag,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('type') TransactionTypeFilter? type,
  });

  /// List all tags.
  ///
  /// List all of the user's tags.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/tags')
  Future<TagArray> listTag({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new tag.
  ///
  /// Creates a new tag. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/tags')
  Future<TagSingle> storeTag({
    @Body() required TagModelStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single tag.
  ///
  /// Get a single tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [tag] - Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @GET('/v1/tags/{tag}')
  Future<TagSingle> getTag({
    @Path('tag') required String tag,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Update existing tag.
  ///
  /// Update existing tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [tag] - Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @FormUrlEncoded()
  @PUT('/v1/tags/{tag}')
  Future<TagSingle> updateTag({
    @Path('tag') required String tag,
    @Body() required TagModelUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete an tag.
  ///
  /// Delete an tag.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [tag] - Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @DELETE('/v1/tags/{tag}')
  Future<void> deleteTag({
    @Path('tag') required String tag,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
