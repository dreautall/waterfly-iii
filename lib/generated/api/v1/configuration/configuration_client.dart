// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/config_value_filter.dart';
import '../models/config_value_update_filter.dart';
import '../models/configuration.dart';
import '../models/configuration_array.dart';
import '../models/configuration_single.dart';
import '../models/configuration_update.dart';

part 'configuration_client.g.dart';

@RestApi()
abstract class ConfigurationClient {
  factory ConfigurationClient(Dio dio, {String? baseUrl}) =
      _ConfigurationClient;

  /// Get Firefly III system configuration values.
  ///
  /// Returns all editable and not-editable configuration values for this Firefly III installation.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @GET('/v1/configuration')
  Future<ConfigurationArray> getConfiguration({
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single Firefly III system configuration value.
  ///
  /// Returns one configuration variable for this Firefly III installation.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [name] - The name of the configuration value you want to know.
  @GET('/v1/configuration/{name}')
  Future<ConfigurationSingle> getSingleConfiguration({
    @Path('name') required ConfigValueFilter name,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update configuration value.
  ///
  /// Set a single configuration value. Not all configuration values can be updated so the list of accepted configuration variables is small.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [name] - The name of the configuration value you want to update.
  @FormUrlEncoded()
  @PUT('/v1/configuration/{name}')
  Future<ConfigurationSingle> setConfiguration({
    @Path('name') required ConfigValueUpdateFilter name,
    @Body() required ConfigurationUpdate body,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
