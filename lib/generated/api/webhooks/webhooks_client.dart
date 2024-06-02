// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/webhook_array.dart';
import '../models/webhook_attempt_array.dart';
import '../models/webhook_attempt_single.dart';
import '../models/webhook_message_array.dart';
import '../models/webhook_message_single.dart';
import '../models/webhook_single.dart';
import '../models/webhook_store.dart';
import '../models/webhook_update.dart';

part 'webhooks_client.g.dart';

@RestApi()
abstract class WebhooksClient {
  factory WebhooksClient(Dio dio, {String? baseUrl}) = _WebhooksClient;

  /// Get all the messages of a single webhook.
  ///
  /// When a webhook is triggered the actual message that will be send is stored in a "message". You can view and analyse these messages.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  @GET('/v1/webhooks/{id}/messages')
  Future<WebhookMessageArray> getWebhookMessages({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single message from a webhook.
  ///
  /// When a webhook is triggered it will store the actual content of the webhook in a webhook message. You can view and analyse a single one using this endpoint.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  ///
  /// [messageId] - The webhook message ID.
  @GET('/v1/webhooks/{id}/messages/{messageId}')
  Future<WebhookMessageSingle> getSingleWebhookMessage({
    @Path('id') required String id,
    @Path('messageId') required int messageId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a webhook message.
  ///
  /// Delete a webhook message. Any time a webhook is triggered the message is stored before it's sent. You can delete them before or after sending.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  ///
  /// [messageId] - The webhook message ID.
  @DELETE('/v1/webhooks/{id}/messages/{messageId}')
  Future<void> deleteWebhookMessage({
    @Path('id') required String id,
    @Path('messageId') required int messageId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get all the failed attempts of a single webhook message.
  ///
  /// When a webhook message fails to send it will store the failure in an "attempt". You can view and analyse these. Webhook messages that receive too many attempts (failures) will not be sent again. You must first clear out old attempts before the message can go out again.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The webhook ID.
  ///
  /// [messageId] - The webhook message ID.
  @GET('/v1/webhooks/{id}/messages/{messageId}/attempts')
  Future<WebhookAttemptArray> getWebhookMessageAttempts({
    @Path('id') required String id,
    @Path('messageId') required int messageId,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Get a single failed attempt from a single webhook message.
  ///
  /// When a webhook message fails to send it will store the failure in an "attempt". You can view and analyse these. Webhooks messages that receive too many attempts (failures) will not be fired. You must first clear out old attempts and try again. This endpoint shows you the details of a single attempt. The ID of the attempt must match the corresponding webhook and webhook message.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  ///
  /// [messageId] - The webhook message ID.
  ///
  /// [attemptId] - The webhook attempt ID.
  @GET('/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<WebhookAttemptSingle> getSingleWebhookMessageAttempt({
    @Path('id') required String id,
    @Path('messageId') required int messageId,
    @Path('attemptId') required int attemptId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a webhook attempt.
  ///
  /// Delete a webhook message attempt. If you delete all attempts for a webhook message, Firefly III will (once again) assume all is well with the webhook message and will try to send it again.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  ///
  /// [messageId] - The webhook message ID.
  ///
  /// [attemptId] - The webhook message attempt ID.
  @DELETE('/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<void> deleteWebhookMessageAttempt({
    @Path('id') required String id,
    @Path('messageId') required int messageId,
    @Path('attemptId') required int attemptId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Submit messages for a webhook.
  ///
  /// This endpoint will submit any open messages for this webhook. This is an asynchronous operation, so you can't see the result. Refresh the webhook message and/or the webhook message attempts to see the results. This may take some time if the webhook receiver is slow.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  @POST('/v1/webhooks/{id}/submit')
  Future<void> submitWebook({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Trigger webhook for a given transaction.
  ///
  /// This endpoint will execute this webhook for a given transaction ID. This is an asynchronous operation, so you can't see the result. Refresh the webhook message and/or the webhook message attempts to see the results. This may take some time if the webhook receiver is slow.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  ///
  /// [transactionId] - The transaction ID.
  @POST('/v1/webhooks/{id}/trigger-transaction/{transactionId}')
  Future<void> triggerTransactionWebhook({
    @Path('id') required String id,
    @Path('transactionId') required String transactionId,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// List all webhooks.
  ///
  /// List all the user's webhooks.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/webhooks')
  Future<WebhookArray> listWebhook({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new webhook.
  ///
  /// Creates a new webhook. The data required can be submitted as a JSON body or as a list of parameters. The webhook will be given a random secret.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/webhooks')
  Future<WebhookSingle> storeWebhook({
    @Body() required WebhookStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single webhook.
  ///
  /// Gets all info of a single webhook.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  @GET('/v1/webhooks/{id}')
  Future<WebhookSingle> getWebhook({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing webhook.
  ///
  /// Update an existing webhook's information. If you wish to reset the secret, submit any value as the "secret". Firefly III will take this as a hint and reset the secret of the webhook.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  @FormUrlEncoded()
  @PUT('/v1/webhooks/{id}')
  Future<WebhookSingle> updateWebhook({
    @Path('id') required String id,
    @Body() required WebhookUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a webhook.
  ///
  /// Delete a webhook.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The webhook ID.
  @DELETE('/v1/webhooks/{id}')
  Future<void> deleteWebhook({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
