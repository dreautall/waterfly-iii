// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/subscription_array.dart';
import '../models/subscription_single.dart';

part 'bills_client.g.dart';

@RestApi()
abstract class BillsClient {
  factory BillsClient(Dio dio, {String? baseUrl}) = _BillsClient;

  /// List all subscriptions.
  ///
  /// List all the subscriptions the user has made.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v2/subscriptions')
  Future<SubscriptionArray> listSubscriptions({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Get single subscription.
  ///
  /// Returns a single subscription by its ID.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD. Must be before "end". Can not be the same as "end". If this is included, "end" must also be included.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". If this field is included, "start" must also be included.
  ///
  ///
  /// [id] - The ID of the subscription.
  @GET('/v2/subscriptions/{id}')
  Future<SubscriptionSingle> getSubscription({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });
}
