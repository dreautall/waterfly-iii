// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/cron_result.dart';
import '../models/system_info.dart';
import '../models/user_single.dart';

part 'about_client.g.dart';

@RestApi()
abstract class AboutClient {
  factory AboutClient(Dio dio, {String? baseUrl}) = _AboutClient;

  /// System information end point.
  ///
  /// Returns general system information and versions of the (supporting) software.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @GET('/v1/about')
  Future<SystemInfo> getAbout({
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Currently authenticated user endpoint.
  ///
  /// Returns the currently authenticated user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @GET('/v1/about/user')
  Future<UserSingle> getCurrentUser({
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Cron job endpoint.
  ///
  /// Firefly III has one endpoint for its various cron related tasks. Send a GET to this endpoint.
  /// to run the cron. The cron requires the CLI token to be present. The cron job will fire for all.
  /// users.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [cliToken] - The CLI token of any user in Firefly III, required to run the cron job.
  ///
  /// [date] - A date formatted YYYY-MM-DD. This can be used to make the cron job pretend it's running.
  /// on another day.
  ///
  ///
  /// [force] - Forces the cron job to fire, regardless of whether it has fired before. This may result.
  /// in double transactions or weird budgets, so be careful.
  @GET('/v1/cron/{cliToken}')
  Future<CronResult> getCron({
    @Path('cliToken') required String cliToken,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') DateTime? date,
    @Query('force') bool? force,
  });
}
