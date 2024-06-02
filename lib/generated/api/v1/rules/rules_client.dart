// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/rule_array.dart';
import '../models/rule_single.dart';
import '../models/rule_store.dart';
import '../models/rule_update.dart';
import '../models/transaction_array.dart';

part 'rules_client.g.dart';

@RestApi()
abstract class RulesClient {
  factory RulesClient(Dio dio, {String? baseUrl}) = _RulesClient;

  /// Test which transactions would be hit by the rule. No changes will be made.
  ///
  /// Test which transactions would be hit by the rule. No changes will be made. Limit the result if you want to.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [accounts] - Limit the testing of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @GET('/v1/rules/{id}/test')
  Future<TransactionArray> testRule({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('accounts[]') List<int>? object69,
  });

  /// Fire the rule on your transactions.
  ///
  /// Fire the rule group on your transactions. Changes will be made by the rules in the group! Limit the result if you want to.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the start date is not present, it will be set to one year ago. If you use this field, both the start date and the end date must be present.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the end date is not present, it will be set to today. If you use this field, both the start date and the end date must be present.
  ///
  ///
  /// [accounts] - Limit the triggering of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @POST('/v1/rules/{id}/trigger')
  Future<void> fireRule({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('accounts[]') List<int>? object71,
  });

  /// List all rules.
  ///
  /// List all rules.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/rules')
  Future<RuleArray> listRule({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new rule.
  ///
  /// Creates a new rule. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/rules')
  Future<RuleSingle> storeRule({
    @Body() required RuleStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single rule.
  ///
  /// Get a single rule.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the object.
  @GET('/v1/rules/{id}')
  Future<RuleSingle> getRule({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing rule.
  ///
  /// Update existing rule.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the object.
  @FormUrlEncoded()
  @PUT('/v1/rules/{id}')
  Future<RuleSingle> updateRule({
    @Path('id') required String id,
    @Body() required RuleUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete an rule.
  ///
  /// Delete an rule.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule.
  @DELETE('/v1/rules/{id}')
  Future<void> deleteRule({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
