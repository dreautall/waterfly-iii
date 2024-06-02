// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/preference.dart';
import '../models/preference_array.dart';
import '../models/preference_single.dart';
import '../models/preference_update.dart';

part 'preferences_client.g.dart';

@RestApi()
abstract class PreferencesClient {
  factory PreferencesClient(Dio dio, {String? baseUrl}) = _PreferencesClient;

  /// List all users preferences.
  ///
  /// List all of the preferences of the user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/preferences')
  Future<PreferenceArray> listPreference({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new preference for this user.
  ///
  /// This endpoint creates a new preference. The name and data are free-format, and entirely up to you. If the preference is not used in Firefly III itself it may not be configurable through the user interface, but you can use this endpoint to persist custom data for your own app.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/preferences')
  Future<PreferenceSingle> storePreference({
    @Body() required Preference body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Return a single preference.
  ///
  /// Return a single preference and the value.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [name] - The name of the preference.
  @GET('/v1/preferences/{name}')
  Future<PreferenceSingle> getPreference({
    @Path('name') required String name,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update preference.
  ///
  /// Update a user's preference.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [name] - The name of the preference. Will always overwrite. Will be created if it does not exist.
  @FormUrlEncoded()
  @PUT('/v1/preferences/{name}')
  Future<PreferenceSingle> updatePreference({
    @Path('name') required String name,
    @Body() required PreferenceUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
