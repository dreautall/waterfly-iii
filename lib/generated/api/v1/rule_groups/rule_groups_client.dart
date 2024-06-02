// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/rule_array.dart';
import '../models/rule_group_array.dart';
import '../models/rule_group_single.dart';
import '../models/rule_group_store.dart';
import '../models/rule_group_update.dart';
import '../models/transaction_array.dart';

part 'rule_groups_client.g.dart';

@RestApi()
abstract class RuleGroupsClient {
  factory RuleGroupsClient(Dio dio, {String? baseUrl}) = _RuleGroupsClient;

  /// List rules in this rule group.
  ///
  /// List rules in this rule group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the rule group.
  @GET('/v1/rule-groups/{id}/rules')
  Future<RuleArray> listRuleByGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Test which transactions would be hit by the rule group. No changes will be made.
  ///
  /// Test which transactions would be hit by the rule group. No changes will be made. Limit the result if you want to.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  ///
  /// [id] - The ID of the rule group.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [searchLimit] - Maximum number of transactions Firefly III will try. Don't set this too high, or it will take Firefly III very long to run the test. I suggest a max of 200.
  ///
  ///
  /// [triggeredLimit] - Maximum number of transactions the rule group can actually trigger on, before Firefly III stops. I would suggest setting this to 10 or 15. Don't go above the user's page size, because browsing to page 2 or 3 of a test result would fire the test again, making any navigation efforts very slow.
  ///
  ///
  /// [accounts] - Limit the testing of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @GET('/v1/rule-groups/{id}/test')
  Future<TransactionArray> testRuleGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('search_limit') int? searchLimit,
    @Query('triggered_limit') int? triggeredLimit,
    @Query('accounts[]') List<int>? object65,
  });

  /// Fire the rule group on your transactions.
  ///
  /// Fire the rule group on your transactions. Changes will be made by the rules in the rule group! Limit the result if you want to.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule group.
  ///
  /// [start] - A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///
  ///
  /// [accounts] - Limit the triggering of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @POST('/v1/rule-groups/{id}/trigger')
  Future<void> fireRuleGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('accounts[]') List<int>? object67,
  });

  /// List all rule groups.
  ///
  /// List all rule groups.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/rule-groups')
  Future<RuleGroupArray> listRuleGroup({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new rule group.
  ///
  /// Creates a new rule group. The data required can be submitted as a JSON body or as a list of parameters.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/rule-groups')
  Future<RuleGroupSingle> storeRuleGroup({
    @Body() required RuleGroupStore body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single rule group.
  ///
  /// Get a single rule group. This does not include the rules. For that, see below.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule group.
  @GET('/v1/rule-groups/{id}')
  Future<RuleGroupSingle> getRuleGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update existing rule group.
  ///
  /// Update existing rule group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule group.
  @FormUrlEncoded()
  @PUT('/v1/rule-groups/{id}')
  Future<RuleGroupSingle> updateRuleGroup({
    @Path('id') required String id,
    @Body() required RuleGroupUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a rule group.
  ///
  /// Delete a rule group.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The ID of the rule group.
  @DELETE('/v1/rule-groups/{id}')
  Future<void> deleteRuleGroup({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
