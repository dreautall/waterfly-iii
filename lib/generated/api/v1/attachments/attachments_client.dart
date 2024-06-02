// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/attachment_array.dart';
import '../models/attachment_single.dart';
import '../models/attachment_store.dart';
import '../models/attachment_update.dart';

part 'attachments_client.g.dart';

@RestApi()
abstract class AttachmentsClient {
  factory AttachmentsClient(Dio dio, {String? baseUrl}) = _AttachmentsClient;

  /// List all attachments.
  ///
  /// This endpoint lists all attachments.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/attachments')
  Future<AttachmentArray> listAttachment({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new attachment.
  ///
  /// Creates a new attachment. The data required can be submitted as a JSON body or as a list of parameters. You cannot use this endpoint to upload the actual file data (see below). This endpoint only creates the attachment object.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/attachments')
  Future<AttachmentSingle> storeAttachment({
    @Body() required AttachmentStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single attachment.
  ///
  /// Get a single attachment. This endpoint only returns the available metadata for the attachment. Actual file data is handled in two other endpoints (see below).
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the attachment.
  @GET('/v1/attachments/{id}')
  Future<AttachmentSingle> getAttachment({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing attachment.
  ///
  /// Update the meta data for an existing attachment. This endpoint does not allow you to upload or download data. For that, see below.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the attachment.
  @FormUrlEncoded()
  @PUT('/v1/attachments/{id}')
  Future<AttachmentSingle> updateAttachment({
    @Path('id') required String id,
    @Body() required AttachmentUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete an attachment.
  ///
  /// With this endpoint you delete an attachment, including any stored file data.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the single attachment.
  @DELETE('/v1/attachments/{id}')
  Future<void> deleteAttachment({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Download a single attachment.
  ///
  /// This endpoint allows you to download the binary content of a transaction. It will be sent to you as a download, using the content type "application/octet-stream" and content disposition "attachment; filename=example.pdf".
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the attachment.
  @GET('/v1/attachments/{id}/download')
  Future<String> downloadAttachment({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Upload an attachment.
  ///
  /// Use this endpoint to upload (and possible overwrite) the file contents of an attachment. Simply put the entire file in the body as binary data.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the attachment.
  @POST('/v1/attachments/{id}/upload')
  Future<void> uploadAttachment({
    @Path('id') required String id,
    @Body() required File body,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
