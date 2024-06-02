// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/preference_single.dart';

part 'preferences_client.g.dart';

@RestApi()
abstract class PreferencesClient {
  factory PreferencesClient(Dio dio, {String? baseUrl}) = _PreferencesClient;

  /// Return a single preference.
  ///
  /// Return a single preference and the value.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [name] - The name of the preference.
  @GET('/v2/preferences/{name}')
  Future<PreferenceSingle> getPreference({
    @Path('name') required String name,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
